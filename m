Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67ECC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E1A21ADE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E1A21ADE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbeHIAz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:55:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:60088 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731364AbeHIAz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:55:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 300FEACE5;
        Wed,  8 Aug 2018 22:34:13 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Frank Filz <ffilzlnx@mindspring.com>,
        "'J. Bruce Fields'" <bfields@fieldses.org>
Date:   Thu, 09 Aug 2018 08:34:02 +1000
Cc:     'Jeff Layton' <jlayton@kernel.org>,
        'Alexander Viro' <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Martin Wilck' <mwilck@suse.de>
Subject: RE: [PATCH 0/4] locks: avoid thundering-herd wake-ups
In-Reply-To: <01b001d42f5c$ed082e20$c7188a60$@mindspring.com>
References: <153369219467.12605.13472423449508444601.stgit@noble> <20180808195445.GD23873@fieldses.org> <20180808200912.GE23873@fieldses.org> <01b001d42f5c$ed082e20$c7188a60$@mindspring.com>
Message-ID: <87eff8trmt.fsf@notabene.neil.brown.name>
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

On Wed, Aug 08 2018, Frank Filz wrote:

>> On Wed, Aug 08, 2018 at 03:54:45PM -0400, J. Bruce Fields wrote:
>> > On Wed, Aug 08, 2018 at 11:51:07AM +1000, NeilBrown wrote:
>> > > If you have a many-core machine, and have many threads all wanting
>> > > to briefly lock a give file (udev is known to do this), you can get
>> > > quite poor performance.
>> > >
>> > > When one thread releases a lock, it wakes up all other threads that
>> > > are waiting (classic thundering-herd) - one will get the lock and
>> > > the others go to sleep.
>> > > When you have few cores, this is not very noticeable: by the time
>> > > the 4th or 5th thread gets enough CPU time to try to claim the lock,
>> > > the earlier threads have claimed it, done what was needed, and
> released.
>> > > With 50+ cores, the contention can easily be measured.
>> > >
>> > > This patchset creates a tree of pending lock request in which
>> > > siblings don't conflict and each lock request does conflict with its
> parent.
>> > > When a lock is released, only requests which don't conflict with
>> > > each other a woken.
>> >
>> > Are you sure you aren't depending on the (incorrect) assumption that
>> > "X blocks Y" is a transitive relation?
>> >
>> > OK I should be able to answer that question myself, my patience for
>> > code-reading is at a real low this afternoon....
>>=20
>> In other words, is there the possibility of a tree of, say, exclusive
> locks with
>> (offset, length) like:
>>=20
>> 	(0, 2) waiting on (1, 2) waiting on (2, 2) waiting on (0, 4)
>>=20
>> and when waking (0, 4) you could wake up (2, 2) but not (0, 2), leaving a
> process
>> waiting without there being an actual conflict.
>
> That implies that the order the locks were received in was:
>
> (0,4)
> (2,2)
> (1,2)
> (0,2)
>
> But couldn't (0,2) have been made only dependent on (0,4)?

Correct.  (0,2) would be a child if (0,4), but a sibling of (2,2).

>    Of course then
> (1,2) is dependent on BOTH (2,2) and (0,2). Does this tree logic handle t=
hat
> case?

No, there is no support for double dependencies.  It is still possible
for a lock request to be woken up which, which still cannot be
satisfied.
When one block lock is unlocked, a pending request might then be queued
against a different blocking lock.

>
> On the other hand, there might be a fairness reason to make (0,2) wait for
> (1,2) even though it could have been granted concurrently with (2,2) since
> this dependency tree also preserves some of the order of lock requests.

The locking API doesn't promise fairness, and I don't think we should
try too hard to achieve it.  Certainly we shouldn't actively fight it
(so no LIFO queuing) but if we try harder than that I suspect it would
just be needless complexity.

Thanks,
NeilBrown


>
> Frank

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltrb9sACgkQOeye3VZi
gbkhuhAAwEMxEQ7gJ1RYLno+0/RVGyxQx33KedyYRyGF7Z8JbUua+/lgEXp1U++2
AaF31BapQm6R/HseXXSBc6csEZU3Sg8hupkQnyg2vEU7FZ++r5t/w9NDwJLyDKiW
ok3hAz18njcR/PclK3wyp2s1rJmN5gZAO4FiJ+CRSFbfC4fhVUkA8Q/A1GliWXoe
VQuZDQHIIEW5lH93vpeddv5wVKkon9GQ7PcfZmlWvGZnD/JnruiD3NxCB7NsJUI/
/62rUayosykSP1BQA8ohnB9IaYyiOt0nsVKG6NWPxUBaetH12bqQE+AYHU362drF
AEUmFvF7S6Qrik4NAPXg+xmBA2AO9xBrr9qLg9a29l/LGiUNBX2BsY14aijbE8be
BDFI/BVTPRhBb1KZW+xf76W33uQBaf5BOvv87sfIpLx/+wwyooiNztfTA+CR53YM
+s9JWyhlmNo06wqw5fsSrGnuY0kfqKkO5HcgwgyJNj8uWWxery/DN5LU9lzBU2kN
TVarh5s/KDW85kWizRSrPil009qrlPO1zoklPp8wGYHpFNESOUEYUE4eqCKHBugv
dMVNdrKkbxh67cOze2w5CEY6LZzEms9tdHqe987qRAkkIScpKYUoQKsLV+M36t0f
Lw2YgUdXXNnfitYYSb4Grra5VQWgeEW6abygxWXvIJNq549YJpM=
=L7GN
-----END PGP SIGNATURE-----
--=-=-=--
