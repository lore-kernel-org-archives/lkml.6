Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751655AbeCMFr1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 01:47:27 -0400
Received: from ozlabs.org ([103.22.144.67]:55845 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbeCMFr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 01:47:26 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 13 Mar 2018 16:46:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Airlie <airlied@linux.ie>, DRI <dri-devel@lists.freedesktop.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rex Zhu <Rex.Zhu@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: build failure after merge of the drm tree
Message-ID: <20180313164637.781c48d2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/C6fPjAkpIyHxdRTAUqojV=a"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C6fPjAkpIyHxdRTAUqojV=a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_hwmgr.c: In function 'sm=
u7_notify_link_speed_change_after_state_change':
drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu7_hwmgr.c:3830:7: error: i=
mplicit declaration of function 'amdgpu_acpi_pcie_performance_request'; did=
 you mean 'smu7_pcie_performance_request'? [-Werror=3Dimplicit-function-dec=
laration]
   if (amdgpu_acpi_pcie_performance_request(hwmgr->adev, request, false)) {
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       smu7_pcie_performance_request

Caused by commit

  e1deba285156 ("drm/amd/pp: Use amdgpu acpi helper functions in powerplay")

and commit

  37a94791a097 ("drm/amd/pp: Add #ifdef checks for CONFIG_ACPI")

missed this instance.

I added this hack patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 13 Mar 2018 16:24:31 +1100
Subject: [PATCH] drm/amd/pp: add another CONFIG_ACPI check

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu=
/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index d4d1d2e7e233..df2a312ca6c9 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -3827,12 +3827,14 @@ static int smu7_notify_link_speed_change_after_stat=
e_change(
 				smu7_get_current_pcie_speed(hwmgr) > 0)
 			return 0;
=20
+#ifdef CONFIG_ACPI
 		if (amdgpu_acpi_pcie_performance_request(hwmgr->adev, request, false)) {
 			if (PP_PCIEGen2 =3D=3D target_link_speed)
 				pr_info("PSPP request to switch to Gen2 from Gen3 Failed!");
 			else
 				pr_info("PSPP request to switch to Gen1 from Gen2 Failed!");
 		}
+#endif
 	}
=20
 	return 0;
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/C6fPjAkpIyHxdRTAUqojV=a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqnZb0ACgkQAVBC80lX
0Gw95Af+M7XACBLsv3vxMzgs31DJixtQYisjRdlvWSlM8SbLyDIKRKD8GREqwamx
q+BhKjdrXYDLunCHNADXTMO/8sgHLgsA8W1lFAjUMsg6OwRqY3ZMkWs8pajMakqM
hE9HPNn+iNuEI4Ftda9ioAW1h3jkcW/34lTZcwOl094Q/ry6ZZNv60sG/rybELb4
IeoY/zkDxBLhDuy1t+nqFvNVxWShWbiXhWpT9I2PwwZp2xR2MXrX5jZXXnq+C6uZ
EGZMnkweNz34KsVAd/whQKUWqTdmNA2p0IZIOx0C4CaYYamR/LJwrLU5+PP8yi7W
Nlp2Eg8OoQzpeW6zt6KJTzjtQiXrQA==
=PdNe
-----END PGP SIGNATURE-----

--Sig_/C6fPjAkpIyHxdRTAUqojV=a--
