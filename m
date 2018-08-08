Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765C6C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ABE217A6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20ABE217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbeHIBBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 21:01:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:60866 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731123AbeHIBBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 21:01:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87428ACE5;
        Wed,  8 Aug 2018 22:39:35 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Thu, 09 Aug 2018 08:39:28 +1000
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.de>
Subject: Re: [PATCH 0/4] locks: avoid thundering-herd wake-ups
In-Reply-To: <20180808212832.GF23873@fieldses.org>
References: <153369219467.12605.13472423449508444601.stgit@noble> <20180808195445.GD23873@fieldses.org> <20180808200912.GE23873@fieldses.org> <20180808212832.GF23873@fieldses.org>
Message-ID: <87bmactrdr.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08 2018, J. Bruce Fields wrote:

> On Wed, Aug 08, 2018 at 04:09:12PM -0400, J. Bruce Fields wrote:
>> On Wed, Aug 08, 2018 at 03:54:45PM -0400, J. Bruce Fields wrote:
>> > On Wed, Aug 08, 2018 at 11:51:07AM +1000, NeilBrown wrote:
>> > > If you have a many-core machine, and have many threads all wanting to
>> > > briefly lock a give file (udev is known to do this), you can get qui=
te
>> > > poor performance.
>> > >=20
>> > > When one thread releases a lock, it wakes up all other threads that
>> > > are waiting (classic thundering-herd) - one will get the lock and the
>> > > others go to sleep.
>> > > When you have few cores, this is not very noticeable: by the time the
>> > > 4th or 5th thread gets enough CPU time to try to claim the lock, the
>> > > earlier threads have claimed it, done what was needed, and released.
>> > > With 50+ cores, the contention can easily be measured.
>> > >=20
>> > > This patchset creates a tree of pending lock request in which siblin=
gs
>> > > don't conflict and each lock request does conflict with its parent.
>> > > When a lock is released, only requests which don't conflict with each
>> > > other a woken.
>> >=20
>> > Are you sure you aren't depending on the (incorrect) assumption that "X
>> > blocks Y" is a transitive relation?
>> >=20
>> > OK I should be able to answer that question myself, my patience for
>> > code-reading is at a real low this afternoon....
>>=20
>> In other words, is there the possibility of a tree of, say, exclusive
>> locks with (offset, length) like:
>>=20
>> 	(0, 2) waiting on (1, 2) waiting on (2, 2) waiting on (0, 4)
>>=20
>> and when waking (0, 4) you could wake up (2, 2) but not (0, 2), leaving
>> a process waiting without there being an actual conflict.
>
> After batting it back and forth with Jeff on IRC....  So do I understand
> right that when we wake a waiter, we leave its own tree of waiters
> intact, and when it wakes if it finds a conflict it just adds it lock
> (with tree of waiters) in to the tree of the conflicting lock?
>
> If so then yes I think that depends on the transitivity
> assumption--you're assuming that finding a conflict between the root of
> the tree and a lock proves that all the other members of the tree also
> conflict.

Ahhh... I see what you are getting at.  When lock requests are added
individually, they will always be blocked by all ancestors in the tree.
But when they are added as a group, that might not be the case.
So we might need to re-add every request individually.
In the (common) case where a lock request is blocked across its whole
range, we can just attach the whole tree beneath the blocker.  In other
cases we need a finer grained approach.

I'll have a look and see how to make the code work for this case.

Thanks for the thorough review!

NeilBrown

>
> So maybe this example works.  (All locks are exclusive and written
> (offset, length), X->Y means X is waiting on Y.)
>
> 	process acquires (0,3)
> 	2nd process requests (1,2), is put to sleep.
> 	3rd process requests (0,2), is put to sleep.
>
> 	The tree of waiters now looks like (0,2)->(1,2)->(0,3)
>
> 	(0,3) is unlocked.
> 	A 4th process races in and locks (2,2).
> 	The 2nd process wakes up, sees this new conflict, and waits on
> 	(2,2).  Now the tree looks like (0,2)->(1,2)->(2,2), and (0,2)
> 	is waiting for no reason.
>
> ?
>
> --b.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltrcSAACgkQOeye3VZi
gbmioxAAgc70GY5YYWG5f5IqXMhw1bGm+Zs8LcCDBB6sQWUE9F9HFRps065SEGv0
lHx6v7XNwqx9mQULsgM8jV240DjWo1mxEkROSm1qEvdW/nw0bGGTxBC4MVWOxcdX
XAPQbbhaBWfwBZy52SRwpjXrQ+YFslBfcUfy8Smpdrl5UPX0jBX4mWBKEosyd4L8
IGzsnb12MIH9HwpDO0Hlo/f6c1I8SISz3AEPnw2l+tYShuKuS1AoX4AjyCjobuPW
fouhLYhh5n5VA/gJACJNWKQT63b0rEnrl1+GIoQp6SWSCFOWN8DU6W2POKBigvCw
dcQMkVkJ0yGUNF5m6FrOdtUuI4CHJrKQiwbzaKxGz7QwLNRQE7DC6qTi1N200QkT
Fh9XpqpCUviC+KIOOekro2gvPFEa5Mwxtc3l7CoWnMosIhkBJ9tNU7y6sH4lj6jw
PbR/+1bTX0fIGP4oLPPM3Zpg8iF0uhGjRi7iUTao7T8ihDMryY3jFiPVsQNtLDWz
MmDJW6k8+9hLZdUDyrIrwXvqo6s7t3idwdcNpJywmbueuu4XCs++RZqMZP3uwgp7
baDrp+JEmFgEV1Dphb4xqLl8AQ+p+YFgNG2CvYI1N7PaEkn2lIvyJzkTjIOcn8tP
Y5mxywISGalrNPNKE1z73XbLcBEbPNRuTy+x1kLWqLu6GajGJ+8=
=5xRp
-----END PGP SIGNATURE-----
--=-=-=--
