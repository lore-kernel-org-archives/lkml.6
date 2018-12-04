Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD59C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5C420834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 05:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g4VjQfR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5C420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbeLDFyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 00:54:51 -0500
Received: from ozlabs.org ([203.11.71.1]:53983 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeLDFyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 00:54:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 438B081fmVz9s47;
        Tue,  4 Dec 2018 16:54:48 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543902888;
        bh=+ZQlCMRoI1/5+B6fLis+aWa1921EUB/xaKSQp4awsBs=;
        h=Date:From:To:Cc:Subject:From;
        b=g4VjQfR1Km2XjjWQK/ZXfDFY1RRX61oUsagL1DvneLnV37KIIrjZ0wCFscfLr86nf
         Y/PAIhuyaN74pAOiHaMsszLNepbSETW6ClFKeoXwyLfHsC4x6uZ5HeW1BzWqvQRWch
         ZIHYokE9+zYy/TpEvwrgrPJmmhAGXNF378XxcsCGGBa86mMTwQx4BdNhlkM4MZM5KP
         FGc6TojtOutUZ+JAL25n4yYZpA3Vj6ziyOgujoz4R3IABCifohofqghhwafGHJIDfG
         VGPsTpUVF0EjJyDegDam4+XI12v6Jo/VZSHS06OiU/+1/JcN4l4weEVsLRFXKuClT2
         WCzo0tYtNTuoA==
Date:   Tue, 4 Dec 2018 16:54:47 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: linux-next: manual merge of the akpm tree with the pm tree
Message-ID: <20181204165447.1532b860@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GT2+twQSgi.G9sZxOUmDEpw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GT2+twQSgi.G9sZxOUmDEpw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Today's linux-next merge of the akpm tree got a conflict in:

  fs/exec.c

between commit:

  67fe1224adc5 ("Revert "exec: make de_thread() freezable"")

from the pm tree and patch:

  "fs/: remove caller signal_pending branch predictions"

from the akpm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/exec.c
index ea7d439cf79e,044e296f2381..000000000000
--- a/fs/exec.c
+++ b/fs/exec.c
@@@ -1086,8 -1087,8 +1086,8 @@@ static int de_thread(struct task_struc
  	while (sig->notify_count) {
  		__set_current_state(TASK_KILLABLE);
  		spin_unlock_irq(lock);
 -		freezable_schedule();
 +		schedule();
- 		if (unlikely(__fatal_signal_pending(tsk)))
+ 		if (__fatal_signal_pending(tsk))
  			goto killed;
  		spin_lock_irq(lock);
  	}
@@@ -1114,8 -1115,8 +1114,8 @@@
  			__set_current_state(TASK_KILLABLE);
  			write_unlock_irq(&tasklist_lock);
  			cgroup_threadgroup_change_end(tsk);
 -			freezable_schedule();
 +			schedule();
- 			if (unlikely(__fatal_signal_pending(tsk)))
+ 			if (__fatal_signal_pending(tsk))
  				goto killed;
  		}
 =20

--Sig_/GT2+twQSgi.G9sZxOUmDEpw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwGFqcACgkQAVBC80lX
0GyWmQf8CsB1PNYlnXaVvkA7En1TTJtQOPvobSItAL+bGMskalF0SBuGu2VM2Tm1
flrzBLINQkecNOWLsU0ZYgqGvwBRZKtmrBd5fFeWiO3HAYRq0mejFCCuFDUf1czZ
uXlWhPM9iqCrO4r8o3bdXA9ySThH4EPoVpMLCqQWu1Uexx8aP/d6P2y4Yuxq8XXq
awE7S7lP1kLEmRDZClKYiExa3Nbe3IEP96N7JktVv/TzqvDam2otjfu8w1Ta0tdR
M2Q9QEMrK7A/y3mtzP0tpeurrqO0lCXCYdDlvi0wl8ml5hE9BEZzuaAqCRdLAQcH
utq1/duRhHCmM1CbMDgozrVLLdObfw==
=vFKv
-----END PGP SIGNATURE-----

--Sig_/GT2+twQSgi.G9sZxOUmDEpw--
