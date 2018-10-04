Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1815DC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBC220877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 06:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nrvpszSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBC220877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeJDNCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 09:02:52 -0400
Received: from ozlabs.org ([203.11.71.1]:45117 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbeJDNCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 09:02:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42QjF91jDWz9s7T;
        Thu,  4 Oct 2018 16:11:08 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538633470;
        bh=rGmJR7NehLx6e6vQnlm/hyXka9BA+QSqFsGdWNZgYbQ=;
        h=Date:From:To:Cc:Subject:From;
        b=nrvpszSf/tudVCDPiUxfiRSUkCbN4rhcLeEmNSqPFdyirFL4/jrIfVHQW8N+5B8Ri
         m+6QXLawaGszZtaEfBYqjiO1p29JXJgMbG94ZXRnp6ULcPVgVUaiNDZIILQ3sweh0V
         dkIrGxod8zEhc5/jWTjxbo5ENPyaGwh3CdkTPAziB/XPHC2yWZ1Tx4nqQJbkw5cxXt
         u8wdRHn2MWkvnZpUyaC2+REiMFrzxfpaqR88mMih5QvpB4OJAtbUea5ZE3mthFf5BF
         kGsoMonKx2ZIWGvFMc9brMbDAmB4g4016WmjHgcBPlAYkM5ldIrOtJ0T+zw3yQFWGN
         YLo2m4Ro5VK8w==
Date:   Thu, 4 Oct 2018 16:11:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the userns tree with the y2038 tree
Message-ID: <20181004161107.77a010e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/NPqEHNtiszlU=iS=46dhNPd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NPqEHNtiszlU=iS=46dhNPd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Today's linux-next merge of the userns tree got a conflict in:

  kernel/signal.c

between commit:

  49c39f8464a9 ("y2038: signal: Change rt_sigtimedwait to use __kernel_time=
spec")

from the y2038 tree and commit:

  ae7795bc6187 ("signal: Distinguish between kernel_siginfo and siginfo")

from the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/signal.c
index 0ff8305a26eb,1c2dd117fee0..000000000000
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@@ -3081,8 -3131,8 +3131,8 @@@ int copy_siginfo_from_user32(struct ker
   *  @info: if non-null, the signal's siginfo is returned here
   *  @ts: upper bound on process time suspension
   */
- static int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
+ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
 -		    const struct timespec *ts)
 +		    const struct timespec64 *ts)
  {
  	ktime_t *to =3D NULL, timeout =3D KTIME_MAX;
  	struct task_struct *tsk =3D current;
@@@ -3145,8 -3194,8 +3195,8 @@@ SYSCALL_DEFINE4(rt_sigtimedwait, const=20
  		size_t, sigsetsize)
  {
  	sigset_t these;
 -	struct timespec ts;
 +	struct timespec64 ts;
- 	siginfo_t info;
+ 	kernel_siginfo_t info;
  	int ret;
 =20
  	/* XXX: Don't preclude handling different sized sigset_t's.  */
@@@ -3174,11 -3223,11 +3224,11 @@@
  #ifdef CONFIG_COMPAT
  COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
  		struct compat_siginfo __user *, uinfo,
 -		struct compat_timespec __user *, uts, compat_size_t, sigsetsize)
 +		struct old_timespec32 __user *, uts, compat_size_t, sigsetsize)
  {
  	sigset_t s;
 -	struct timespec t;
 +	struct timespec64 t;
- 	siginfo_t info;
+ 	kernel_siginfo_t info;
  	long ret;
 =20
  	if (sigsetsize !=3D sizeof(sigset_t))

--Sig_/NPqEHNtiszlU=iS=46dhNPd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlu1rvsACgkQAVBC80lX
0GwZkQf/QPk6jfKbdZtgzLZFIaZU+7sUL9B8QWWxE/q0W7FXd8VFiWcJekxyKio3
g2Z9PN5dtOs1aFfaqocWvEbcqcAFXxcAqCNzoFikcF2Di4moYURoXH1AJTbjjxom
TBBhUG8YbFg3HH5e77nC51S0z6023ItZ/N5FAbBMAe1uSHfJ+6q2cx4tthHwxxi5
+OtRp/zZxy+NjxekGYBgbo4Sk1dOYdtrc72ayTYCkGqjRPxk+dyEzJVABKiI6EkY
I21sQg4CqIEoI/EKFFS3fal8HcoEMUhmrQgFN5m04kAhaoidaIGBawr244gcWCUP
L+P5HEaqJqk5zO98OZ8dn3e4iFjeZg==
=WUI+
-----END PGP SIGNATURE-----

--Sig_/NPqEHNtiszlU=iS=46dhNPd--
