Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B05C43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18172152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18172152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeHXCuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:50:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:57148 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbeHXCuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:50:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB4E3B05D;
        Thu, 23 Aug 2018 23:18:03 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jeff Layton <jlayton@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 24 Aug 2018 09:17:53 +1000
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc\@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [BUG][BISECT] NFSv4 root failures after "fs/locks: allow a lock request to block other requests."
In-Reply-To: <87eferpgj4.fsf@notabene.neil.brown.name>
References: <CAJKOXPc2cb1OK3tmRCO2p+docdXY=PoU1MEBa-VDyEM4mG1eSw@mail.gmail.com> <8acb99be800a1842278f754986a17d6fc93af409.camel@kernel.org> <87o9e2anwg.fsf@notabene.neil.brown.name> <87k1okpam2.fsf@notabene.neil.brown.name> <99fd03d3002d03f86b0d8a5b1ad4a2015383545e.camel@kernel.org> <87eferpgj4.fsf@notabene.neil.brown.name>
Message-ID: <87ftz4oeou.fsf@notabene.neil.brown.name>
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

On Wed, Aug 22 2018, NeilBrown wrote:

>
> Oh dear.
> nfs4_alloc_lockdata contains:
> 	memcpy(&p->fl, fl, sizeof(p->fl));
>
> so any list_heads that are valid in fl will be invalid in p->fl.
>
> Maybe I should initialize the relevant list_heads at the start of wait
> functions.
> I should look more closely at what filesystems do with locks though.
>

I looked .... and .... it's complicated.

Some call posix_lock_file() (which doesn't block, I think).
Some call locks_lock_file_wait() (which can block, if FL_SLEEP is given).
Some call both.

Strangely, vfs_lock_file() either calls posix_lock_file(), which doesn't
block, or filp->f_op->lock() which, I think, can.

I'm confused.  However I think this version of the patch should be
safer.
When I make time to test this, this will be part of what I test.

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

Note that when these locking routines are called without FL_SLEEP set,
the list_head might not be properly initialize.
In that case it is neither safe nor necessary to
call locks_delete_block()

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/locks.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index de38bafb7f7b..2af9c657f81f 100644
=2D-- a/fs/locks.c
+++ b/fs/locks.c
@@ -1276,12 +1276,11 @@ static int posix_lock_inode_wait(struct inode *inod=
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
+	if (fl->fl_flags & FL_SLEEP)
+		locks_delete_block(fl);
 	return error;
 }
=20
@@ -1971,12 +1970,11 @@ static int flock_lock_inode_wait(struct inode *inod=
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
+	if (fl->fl_flags & FL_SLEEP)
+		locks_delete_block(fl);
 	return error;
 }
=20
@@ -2250,12 +2248,11 @@ static int do_lock_file_wait(struct file *filp, uns=
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
+	if (fl->fl_flags & FL_SLEEP)
+		locks_delete_block(fl);
=20
 	return error;
 }
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlt/QKEACgkQOeye3VZi
gbkBGQ/+PKvN1XsblXZeKim2XOAaahH+RjZlrAAPc+KzpFytOxHvlrf+WtOR7Fok
JRgeP5CUCMNnh67Rsr34NJhrhyOG8qAxTSogT83Y1XZcZM8e5tOsVtP60KqU3mtt
CqwzAjCsdtUq+87ZPVDIRbpZ29RVP9HCC/kVjzOiL3pCDCDhX0wrRLaaNkZmJaGw
Ycmf6s1pcSwo6KPAQQG+a9Z08Y7E5JjeiwCMnryE3y2x4mtrTyUvt5kvI/Vkkc0K
y7Wb7TfOaah/1swQhlVrXWCDEhxofnkzTrVXprMxGfDHNZar19yRvsC/JNL4ZnvW
vlWvEkNGgqlUM9DQg0xrGTta0j3uvlNOj79XsmuQGFTzHBIJ00Xhwc4njsRTFB6M
+YsMcykMvHhpJteWimT6Mi3w0dHyh9Iupt6TftR5GpWdB7obmQKm+fVKic1iXMpd
g89t5x1WyYI+hKzXaPXlsZyJuoxvBWgCVmPSPUb3TOtoVgNnthUZW5NC+RfAaSjo
6W/dnLqBw++qltdNB5eTuFjZYlGI6a9v0H2/Ybvb6M/BZKLzwsCydhFpFp9uglxB
Rart+HbqyO3F5IkkANrqgoETGWejLVK63wNXd1KlvmvaplDPE093/ttYsT8ehPt1
Th+uldfD/SFYGuWIT/PGPeQaHZxdURAkliQRuBNd1RkJIMNlvac=
=wDui
-----END PGP SIGNATURE-----
--=-=-=--
