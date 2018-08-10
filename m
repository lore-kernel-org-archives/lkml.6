Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978D7C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52100223AF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52100223AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeHJESn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:18:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:57158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725198AbeHJESn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:18:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5857FADF5;
        Fri, 10 Aug 2018 01:51:05 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Fri, 10 Aug 2018 11:50:58 +1000
Cc:     Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Wilck <mwilck@suse.de>, linux-fsdevel@vger.kernel.org,
        Frank Filz <ffilzlnx@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5 - V2] locks: avoid thundering-herd wake-ups
In-Reply-To: <20180810002922.GA3915@fieldses.org>
References: <153378012255.1220.6754153662007899557.stgit@noble> <20180809173245.GM23873@fieldses.org> <87lg9frxyc.fsf@notabene.neil.brown.name> <20180810002922.GA3915@fieldses.org>
Message-ID: <871sb7rnul.fsf@notabene.neil.brown.name>
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

On Thu, Aug 09 2018, J. Bruce Fields wrote:

> On Fri, Aug 10, 2018 at 08:12:43AM +1000, NeilBrown wrote:
>> On Thu, Aug 09 2018, J. Bruce Fields wrote:
>>=20
>> > I think there's also a problem with multiple tasks sharing the same
>> > lock owner.
>> >
>> > So, all locks are exclusive locks for the same range.  We have four
>> > tasks.  Tasks 1 and 4 share the same owner, the others' owners are
>> > distinct.
>> >
>> > 	- Task 1 gets a lock.
>> > 	- Task 2 gets a conflicting lock.
>> > 	- Task 3 gets another conflicting lock.  So now we the tree is
>> > 		3->2->1.
>> > 	- Task 1's lock is released.
>> > 	- Before task 2 is scheduled, task 4 acquires a new lock.
>> > 	- Task 2 waits on task 4's lock, we now have
>> > 		3->2->4.
>> >
>> > Task 3 shouldn't be waiting--the lock it's requesting has the same own=
er
>> > as the lock task 4 holds--but we fail to wake up task 3.
>>=20
>> So task 1 and task 4 are threads in the one process - OK.
>> Tasks 2 and 3 are threads in two other processes.
>>=20
>> So 2 and 3 conflict with either 1 or 4 equally - why should task 3 be
>> woken?
>>=20
>> I suspect you got the numbers bit mixed up,
>
> Whoops.
>
>> but in any case, the "conflict()" function that is passed around takes
>> ownership into account when assessing if one lock conflicts with
>> another.
>
> Right, I know, but, let me try again:
>
> All locks are exclusive locks for the same range.  Only tasks 3 and 4
> share the the same owner.
>
> 	- Task 1 gets a lock.
> 	- Task 2 requests a conflicting lock, so we have    2->1.
> 	- Task 3 requests a conflicting lock, so we have 3->2->1.
> 	- Task 1 unlocks.  We wake up task 2, but it isn't scheduled yet.
> 	- Task 4 gets a new lock.
> 	- Task 2 runs, discovers the conflict, and waits.  Now we have:
> 		3->2->4.
>
> There is no conflict between the lock 3 requested and the lock 4 holds,
> but 3 is not woken up.
>
> This is another version of the first problem: there's information we
> need (the owners of the waiting locks in the tree) that we can't
> determine just from looking at the root of the tree.
>
> I'm not sure what to do about that.

You're good at this game!

So, because a locker with the same "owner" gets a free pass, you can
*never* say that any lock which conflicts with A also conflicts with B,
as a lock with the same owner as B will never conflict with B, even
though it conflicts with A.

I think there is still value in having the tree, but when a waiter is
attached under a new blocker, we need to walk the whole tree beneath the
waiter and detach/wake anything that is not blocked by the new blocker.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlts74IACgkQOeye3VZi
gblSJxAAwGQ+JxqFSwnyNKDZ/++EmMBpbHrnLsDfxkAxbV+6G18FZ3JSr5OPamQh
cWT08+vh+Uj5yuZS9skciFM8VcO00+Sz2ZbuzZJHXHH8J/QT4NvkIz8p4beFBDYh
804bauYb/oOTFEd9YSA2CZK/kc9/pg29oz2VfknbAFXyt85wbMgMLehVAFZhO/RT
nNejoy2gND8fkOwRTvGvCib5juATh8Z9pWAaU6Qlken9CkJkwLlb29Cty/Wniq7U
Xcu72xsgzfVwInsSycmFHV9e6YY1cwFDVCiu2PCr0g3H20SinZ6EjT0t/t17zUf5
0AgMTaziODEpjb1sX5wdTaqNIZRDhZtWlahB0yraa5Rekt45Xuf76OpF4DqVLmMI
dnORmorS5QlYptJXo7G7K7wJ196n1v9H34wPUKnWNyrCJXPL41mOaCl83tpNjn/9
MMRdvHnhQ6irRCXQX0k5diL5PW77sDeCtVj5AH0Hz357C0mfESELveqltRWzSWPJ
Gqd9CPLXJ7WTSS0Bu1j7TQnThmJ7ONPNjTU59Le0nOArVhtI3ozZc8wvmOk5M8bE
pFk739hFlgVh0/3tSDYwV348bhR+wsTGKfzZkvMdAv4YAhhIXdOvKhaahZZRttuW
nLodIdJacaRFXKfg093doJd6flFd3JCASoOIjsGbIeJbSr1jZbk=
=2wkw
-----END PGP SIGNATURE-----
--=-=-=--
