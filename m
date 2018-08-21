Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493A0C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B1721735
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 05:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B1721735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbeHUIaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 04:30:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:48438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbeHUIaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 04:30:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4BD0B027;
        Tue, 21 Aug 2018 05:11:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 21 Aug 2018 15:11:33 +1000
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc\@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [BUG][BISECT] NFSv4 root failures after "fs/locks: allow a lock request to block other requests."
In-Reply-To: <87o9e2anwg.fsf@notabene.neil.brown.name>
References: <CAJKOXPc2cb1OK3tmRCO2p+docdXY=PoU1MEBa-VDyEM4mG1eSw@mail.gmail.com> <8acb99be800a1842278f754986a17d6fc93af409.camel@kernel.org> <87o9e2anwg.fsf@notabene.neil.brown.name>
Message-ID: <87k1okpam2.fsf@notabene.neil.brown.name>
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

On Thu, Aug 16 2018, NeilBrown wrote:

> On Wed, Aug 15 2018, Jeff Layton wrote:
>
>> On Wed, 2018-08-15 at 14:28 +0200, Krzysztof Kozlowski wrote:
>>> Hi,
>>>=20
>>> Bisect pointed commit ce3147990450a68b3f549088b30f087742a08b5d
>>> ("fs/locks: allow a lock request to block other requests.") to failure
>>> boot of NFSv4 with root on several boards.
>>>=20
>>> Log is here:
>>> https://krzk.eu/#/builders/21/builds/836/steps/12/logs/serial0
>>>=20
>>> With several errors:
>>> kernel BUG at ../fs/locks.c:336!
>>> Unable to handle kernel NULL pointer dereference at virtual address 000=
00004
>>>=20
>>> Configuration:
>>> 1. exynos_defconfig
>>> 2. Arch ARM Linux
>>> 3. Boards:
>>> a. Odroid family (ARMv7, octa-core (Cortex-A7+A15), Exynos5422 SoC)
>>> b. Toradex Colibri VF50 (ARMv7, UP, Cortex-A5)
>>> 4. Systemd: v236, 238
>>> 5. All boards boot from TFTP with NFS root (NFSv4)
>>>=20
>>> On Colibri VF50 I got slightly different errors:
>>> [   11.663204] Internal error: Oops - undefined instruction: 0 [#1] ARM
>>> [   12.455273] Unable to handle kernel NULL pointer dereference at
>>> virtual address 00000004
>>> and only with some specific GCC (v6.3) or with other conditions which
>>> I did not bisect yet. Maybe Colibri's failure is unrelated to that
>>> commit.
>>>=20
>>> Best regards,
>>> Krzysztof
>
> Thanks a lot for the report Krzysztof!!
>
>>
>> The BUG is due to a lock being freed when the fl_blocked list wasn't
>> empty (implying that there were still blocked locks waiting on it).
>>
>> There are a number of calls to locks_delete_lock_ctx in posix_lock_inode
>> and I don't think the fl_blocked list is being handled properly with all
>> of them. It only transplants the blocked locks to a new lock when there
>> are surviving locks on the list, and that may not be the case when the
>> whole file is being unlocked.
>
> locks_delete_lock_ctx() calls locks_unlink_lock_ctx() which calls
> locks_wake_up_block() which doesn't only wake_up the blocks, but also
> detached them. When that function completes, ->fl_blocked must be empty.
>
> The trace shows the locks_free_lock() call at the end of fcntl_setlk64()
> as the problematic call.
> This suggests that do_lock_file_wait() exited with ->fl_blocked
> non-empty, which it shouldn't.
>
> I think we need to insert a call to locks_wake_up_block() in
> do_lock_file_wait() before it returns.
> I cannot find a sequence that would make this necessary, but
> it isn't surprising that there might be one.
>
> I'll dig through the code a bit more later and make sure I understand
> what is happening.
>

I think this problem if fixed by the following.  It is probably
triggered when the owner already has a lock for part of the requested
range.  After waiting for some other lock, the pending request gets
merged with the existing lock, and blocked requests aren't moved across
in that case.

I still haven't done more testing, so this is just FYI, not a
submission.

Thanks,
NeilBrown

From: NeilBrown <neilb@suse.com>
Date: Tue, 21 Aug 2018 15:09:06 +1000
Subject: [PATCH] fs/locks: always delete_block after waiting.

Now that requests can block other requests, we
need to be careful to always clean up those blocked
requests.
Any time that we wait for a request, we might have
other requests attached, and when we stop waiting,
we much clean them up.
If the lock was granted, the requests might have been
moved to the new lock, though when merged with a
pre-exiting lock, this might not happen.
No all cases we don't want blocked locks to remain
attached, so we remove them to be safe.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/locks.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index de38bafb7f7b..6b310112cf3b 100644
=2D-- a/fs/locks.c
+++ b/fs/locks.c
@@ -1276,12 +1276,10 @@ static int posix_lock_inode_wait(struct inode *inod=
e, struct file_lock *fl)
 		if (error !=3D FILE_LOCK_DEFERRED)
 			break;
 		error =3D wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
=2D		if (!error)
=2D			continue;
=2D
=2D		locks_delete_block(fl);
=2D		break;
+		if (error)
+			break;
 	}
+	locks_delete_block(fl);
 	return error;
 }
=20
@@ -1971,12 +1969,10 @@ static int flock_lock_inode_wait(struct inode *inod=
e, struct file_lock *fl)
 		if (error !=3D FILE_LOCK_DEFERRED)
 			break;
 		error =3D wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
=2D		if (!error)
=2D			continue;
=2D
=2D		locks_delete_block(fl);
=2D		break;
+		if (error)
+			break;
 	}
+	locks_delete_block(fl);
 	return error;
 }
=20
@@ -2250,12 +2246,10 @@ static int do_lock_file_wait(struct file *filp, uns=
igned int cmd,
 		if (error !=3D FILE_LOCK_DEFERRED)
 			break;
 		error =3D wait_event_interruptible(fl->fl_wait, !fl->fl_blocker);
=2D		if (!error)
=2D			continue;
=2D
=2D		locks_delete_block(fl);
=2D		break;
+		if (error)
+			break;
 	}
+	locks_delete_block(fl);
=20
 	return error;
 }
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlt7nwYACgkQOeye3VZi
gbmI/g//UEFida7uoCVGqDA+D1HiYKaBSfeOGrm608fhX8kYDr7tqputbvyrL5sp
jJ4zW6b686+tZ7HF13WTlOyXWNoQ74RsTrJtFvvkLvYyAKBKHalVSNAVcKD5hzsW
TnAAV4i0GkfGtD2qyggQ84FRkHqSpvBHTyhBYOAqxBvrTA8D9fRrmxdgUfoBbz0p
6fxEtDk3h/rnsge6u/krzoOqQCXbvP0l6Ob3qi+Zo5OqhYhxOZe8GJozTymqC+t9
7ngPfuDKNvk7VoSVCuK0BqtzvQ/FyHy2LG8mnwClVblH5vto2LCycC7ngPJb4MxD
q7zqYvodQc0H8/vkk4nkhglNkqYduyN0JoQZTA7CAuNBqnD1b66UFuGZSd1ba/Ru
VXYgEkl7Za6Src0ivAiRZUzkZLb9YpnCfJCg6ikgYLsie2E/LT+YL8ZLWfg162se
9U+oQUmyM9bsox0OmdC//7eioSpCeGwixo7OlLXziLejrCg5as8J0fXBDUr9mnd0
zam0+w+K4RdgrCclUjImcSKkA3oA+tLgF2VEgtPy9efFr/F6yZWIFUWkaMhln25c
HOwbdvVX+7PeXuEyFFGO6zRzeF5tb12vgW6kKAxF4NlXEgkuCCoyqg09htdQXrr6
YhnnF6CrUGqg+V/qwPqqfniHedNIvFVB3BWZIYTFTRaVYRTb+iI=
=Fog/
-----END PGP SIGNATURE-----
--=-=-=--
