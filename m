Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DFBC4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 00:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5219F21BF7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 00:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5219F21BF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbeHIDU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 23:20:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52970 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727530AbeHIDU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 23:20:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2DCAEAEE4;
        Thu,  9 Aug 2018 00:58:47 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>
Date:   Thu, 09 Aug 2018 10:58:38 +1000
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Wilck <mwilck@suse.de>
Subject: Re: [PATCH 0/4] locks: avoid thundering-herd wake-ups
In-Reply-To: <20180808182959.GB23873@fieldses.org>
References: <153369219467.12605.13472423449508444601.stgit@noble> <ea503e6a6f26dfb344fda02c765ae87de65ed025.camel@kernel.org> <20180808182959.GB23873@fieldses.org>
Message-ID: <878t5gtkxt.fsf@notabene.neil.brown.name>
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

> On Wed, Aug 08, 2018 at 12:47:22PM -0400, Jeff Layton wrote:
>> On Wed, 2018-08-08 at 11:51 +1000, NeilBrown wrote:
>> > If you have a many-core machine, and have many threads all wanting to
>> > briefly lock a give file (udev is known to do this), you can get quite
>> > poor performance.
>> >=20
>> > When one thread releases a lock, it wakes up all other threads that
>> > are waiting (classic thundering-herd) - one will get the lock and the
>> > others go to sleep.
>> > When you have few cores, this is not very noticeable: by the time the
>> > 4th or 5th thread gets enough CPU time to try to claim the lock, the
>> > earlier threads have claimed it, done what was needed, and released.
>> > With 50+ cores, the contention can easily be measured.
>> >=20
>> > This patchset creates a tree of pending lock request in which siblings
>> > don't conflict and each lock request does conflict with its parent.
>> > When a lock is released, only requests which don't conflict with each
>> > other a woken.
>> >=20
>> > Testing shows that lock-acquisitions-per-second is now fairly stable e=
ven
>> > as number of contending process goes to 1000.  Without this patch,
>> > locks-per-second drops off steeply after a few 10s of processes.
>> >=20
>> > There is a small cost to this extra complexity.
>> > At 20 processes running a particular test on 72 cores, the lock
>> > acquisitions per second drops from 1.8 million to 1.4 million with
>> > this patch.  For 100 processes, this patch still provides 1.4 million
>> > while without this patch there are about 700,000.
>> >=20
>> > NeilBrown
>> >=20
>> > ---
>> >=20
>> > NeilBrown (4):
>> >       fs/locks: rename some lists and pointers.
>> >       fs/locks: allow a lock request to block other requests.
>> >       fs/locks: change all *_conflict() functions to return bool.
>> >       fs/locks: create a tree of dependent requests.
>> >=20
>> >=20
>> >  fs/cifs/file.c                  |    2 -
>> >  fs/locks.c                      |  142 +++++++++++++++++++++++++-----=
---------
>> >  include/linux/fs.h              |    5 +
>> >  include/trace/events/filelock.h |   16 ++--
>> >  4 files changed, 103 insertions(+), 62 deletions(-)
>> >=20
>>=20
>> Nice work! I looked over this and I think it looks good.
>>=20
>> I made an attempt to fix this issue several years ago, but my method
>> sucked as it ended up penalizing the unlocking task too much. This is
>> much cleaner and should scale well overall, I think.
>
> I think I also took a crack at this at one point while I was at UM/CITI
> and never got anything I was happy with.  Looks like good work!
>
> I remember one main obstacle that I felt like I never had a good
> benchmark....
>
> How did you choose this workload and hardware?  Was it in fact udev
> (booting a large machine?), or was there some other motivation?

I'm hoping Martin will chime in here - her identified the problem and
did most of the testing...

NeilBrown


>
> Not that I'm likely to do it any time soon, but could you share
> sufficient details for someone else to reproduce your results?
>
> --b.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAltrkb4ACgkQOeye3VZi
gbkbFg/+PmE3D4SFnZfqmsg28wjb44XCUl+jF+oT00xsjfhQ2J1v/sGTqtnnDOk5
pkeo2cyu+CptD0p8OO0UlQV5GQEdp2H1oli1YYmrMX1iDig6zrWzjWXe64k/o/7w
RqhVPFtwOKwHp3wmDdmyIiOLLi/SnOLOjyqMv3qiaXb9cNmJfkYn9HxxYaJ9E6Z6
/D7dDmKORbzQQ3djKEfdelD4AqZeUAZXApECHfngpGCGUFTGc05Szc14odz/hCtb
mcwXARvX5bOd0sIG+8ESmhujJDccyPUo838PmyP5iy5Zku2kG732x7E01B5wZrq0
+MRWetvyVnrEh32gLobSGWUMULflN6+ut0J8pfAirpNbnYV3Y0p1Bs5a7DOORCIN
rrK7w36h8K40icrNKokQeWU9AvsJFUWLI+eXHu8BIH5RWuyYBK3iAoVFfadIDCtf
mHVqTmshXpOP3o8hEIF9bG4rjt4LJy3tlZ+9GR4cQWzR5ewO1rfCxbvnC9sTuACz
/s/jDrv+WM1+kp7ps+XeEb+hytOwATu5WLDNA5CjjRDSGXMA8XaNTtCKg6QaiE1Y
xm0DWXDO9K7XGsPBJIvZAbFeplyxU1TRB2eo0BzHyZhCtP1K71y/1rTbraXk5zfc
Z1mKKYPo2FGAYQfGej8VVtSc7VhpNiv51cQn6ErhBpdamWQNxtk=
=tr71
-----END PGP SIGNATURE-----
--=-=-=--
