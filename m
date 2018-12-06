Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF4FC07E85
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4DA214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Ih1HPhyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4DA214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeLFCc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:32:28 -0500
Received: from ozlabs.org ([203.11.71.1]:50977 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbeLFCcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:32:25 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 439KPd0lcbz9s0n;
        Thu,  6 Dec 2018 13:32:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1544063542;
        bh=gBHdGFQ7kcDb+2pkpsA1H+wwVVcOiCTMXi69jzqwvBU=;
        h=Date:From:To:Cc:Subject:From;
        b=Ih1HPhyHLSoshr9f8eLXpKS1a9QB74IqorV290nklXbGYWNX0BsPUHrM1KxUqaVub
         K0JGDIYip5PszWphaPyDt6sSMJTtvBnikBCWl/YicsUzitOZete/Q4wpL0w00WvaC6
         ATeVFE9N37cIJw1XYBvO/Y38j+C8z/o6z+TdbNJGSbo1dZ/hCj4vQzsL3JN86aksgs
         FHzGDDeAvt0rN6zKKiARrgqWyNLf4Fe/fpueqJtzU3mVRDHZeQIUW/ujnvzvPK8/jG
         aVyvf8oMFuax6AIl8Owe/kgaU2S3ldLj2ysg5hlQwnyC57Qp+okPno7rpEfyqhMfWI
         Hk5I5Ivi6WkuA==
Date:   Thu, 6 Dec 2018 13:32:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Eric Anholt <eric@anholt.net>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20181206133219.38831da4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/N/bz7Y.YD8Jkk/pYlHSFz8u"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N/bz7Y.YD8Jkk/pYlHSFz8u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/v3d/v3d_gem.c: In function 'v3d_submit_tfu_ioctl':
drivers/gpu/drm/v3d/v3d_gem.c:719:3: error: too many arguments to function =
'drm_syncobj_replace_fence'
   drm_syncobj_replace_fence(sync_out, 0, sched_done_fence);
   ^~~~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/v3d/v3d_gem.c:5:
include/drm/drm_syncobj.h:134:6: note: declared here
 void drm_syncobj_replace_fence(struct drm_syncobj *syncobj,
      ^~~~~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  0b258ed1a219 ("drm: revert "expand replace_fence to support timeline poin=
t v2"")

interacting with commit

  1584f16ca96e ("drm/v3d: Add support for submitting jobs to the TFU")

I have used the drm-misc tree from next-20181205 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/N/bz7Y.YD8Jkk/pYlHSFz8u
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwIijMACgkQAVBC80lX
0GwVDQgAmAs8Nz/iBd6O/d7XiFYV240NSdOX/IUrgvghucx6+TSzsB1gvsjGSqhY
bY1ZGF7QP+ZseMXfrUupTBXgTXjMoT5Eolp2YUUttnFj9Fpud1LdtDEvER+/Wldd
P4UgtRXCKm0l+5K5xfaawp5/SPs+VfP19hSMApkLLrqqrOu/c1V8haM71DaqpdcF
ERWuhzyqlm6AmNK6jJpGOrjkTDq7/pS4vxxfT1rZPWJQRBTw7P0vwowHbbaTkxSE
JpF5PEmrl+Bo/0W/V1PyZ5xysLEENEBkTjlEBtMs1+2R5ERPgWVB8L6zfqam9Frs
lp+Ohs9cx3+4ejHlz2ZfTuhc/yGzEg==
=+1Y2
-----END PGP SIGNATURE-----

--Sig_/N/bz7Y.YD8Jkk/pYlHSFz8u--
