Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751395AbeEPGxu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 02:53:50 -0400
Received: from ozlabs.org ([203.11.71.1]:42381 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbeEPGxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 02:53:48 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 16 May 2018 16:53:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>
Subject: linux-next: build failure after merge of the drm tree
Message-ID: <20180516165326.47e96000@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4uWz8KvzxHV.9r69gAfwYoI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4uWz8KvzxHV.9r69gAfwYoI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c: In function 'init_user_pa=
ges':
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:632:3: error: implicit dec=
laration of function 'release_pages'; did you mean 'release_task'? [-Werror=
=3Dimplicit-function-declaration]
   release_pages(mem->user_pages, bo->tbo.ttm->num_pages);
   ^~~~~~~~~~~~~
   release_task

Caused by commit

  5ae0283e831a ("drm/amdgpu: Add userptr support for KFD")

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 16 May 2018 16:43:34 +1000
Subject: [PATCH] drm/amdgpu: include pagemap.h for release_pages()

Fixes: 5ae0283e831a ("drm/amdgpu: Add userptr support for KFD"
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 72ab2b1ffe75..ff8fd75f7ca5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -23,6 +23,7 @@
 #define pr_fmt(fmt) "kfd2kgd: " fmt
=20
 #include <linux/list.h>
+#include <linux/pagemap.h>
 #include <linux/sched/mm.h>
 #include <drm/drmP.h>
 #include "amdgpu_object.h"
--=20
2.17.0

--=20
Cheers,
Stephen Rothwell

--Sig_/4uWz8KvzxHV.9r69gAfwYoI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlr71WYACgkQAVBC80lX
0GxilAf+L7waF+pLjSAURRnM7EX5K6l2Qx9L53mqRE48P0/DypNldvHs9/bLYnMv
7TH6sAZEDkJm2lTWFD+3uekc6/WeIuukJZa2STHreqifkgN/CDA8+eMDV6LeOpOD
FApuBg0bjLXpu4fW8rbj/TjdgQ0AwlW9QgaUZO877G+ll+qDMMAwSL6I27lbZsKZ
0znYgc3tu84wCrAkD6Aj64hS8s4qPPsPB/b9FH95hO02SM3ETNwuHZPly0ylPMqG
5NOV1Orr5epilqdqHLBcFGfmXBdr37nzEXcrj4MjxBltdJlUXw18bIR0BEGYEBt0
wppKsu9xdLg+WkIpanMonaxmc/1jMQ==
=RnWL
-----END PGP SIGNATURE-----

--Sig_/4uWz8KvzxHV.9r69gAfwYoI--
