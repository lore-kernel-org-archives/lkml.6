Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeCOPhl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:37:41 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43735 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbeCOPhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:37:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        Frank Rowand <frank.rowand@sony.com>, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RFC] drm: rcar-du: keep temporary dtb files around during build
Date: Thu, 15 Mar 2018 16:37:08 +0100
Message-Id: <20180315153730.3798004-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:qEtmfOnqvmjtpQLBMWmKxtMsGEFcUPj/bNLzLfxjiUwbCkKIjjE
 bXkqHY+DdbRS5htn+eQzD2Lrvk0g4WrJ+mJf4JAx9aOrWBVk1FEcIdu2BRHwf05fT4SAmLp
 7gClbJXevL1gikoJ0EPY7olTjNi2qQ8wQpUEoTfGhPF5cbqH3IvpigFHIUn6qEvKmk21tf0
 ImBWNb6dIvru5Glikbp4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:u5wXBL6WzYw=:Waqvkps3M0gVoeLBbceuHL
 STpCMXhWQuMCWIoHcxBGVdMNB7l9w47EeO7/KToy75WDxlANOA2pEbCHtd2tY4wfT4M1egNnC
 2owZ5QyveCHGtz+pEHupxvgdc9L7j95s1R8Ez2sHirmnckYDndYDO+Q1zyhvoz+1MG5EDStYa
 syz7pPnUHJuIH5JoYqqj/Bko+rKEgm6cxNQ4z/WwGAZ9SEwiysk7lJ2V5GUwysNHDKM/u/fi2
 zout41ip2KQ9RQxkODus0ocBXtDKBHjLx2czWq9hBPyeFZ1bwn8Mf5CX1tGbOIV/zmpiX4u4e
 pBpjjuqgE+lo3jzhMjydtHSzHOW53PSJc310q11bXgAOE/ZmNn+aaAl8uv3vOeAmikRe5iOXO
 AGrebgIr8vxUUA4oAO0mrsJ//EjRibmcdACxg23TCTSQtNtw3IEjFJEY+2QiWTAiu0p8F6IKZ
 XyquxanN/2K85U1KiV1LmY1Ot9xCD/9QsZH2PXR+s4+R59PO3pPZFspP/hxzQmpOjbvDqNveV
 1rNRksctz5zA9zwAjHPS1ySCgkiMXMzwExy3QsBXt7PFGpF+X/kqildJiCiMjEKsvl77N2b9j
 5dhwQfUstRmBI3ToUOk4/rXDNSbYmO4eYTCTt0kKdo1lcktnGFVQqxUI8+u/iu2VgXU8AICwp
 T5RlG/foGIC9EV10Ja2loWKzM3yCiIfnJneeBrJRtegaWX2zaXZKiv11Cv9ObvCkEc0yCZ7Xo
 mbap15k2Ud+NVL0LZzjMAvRsGgyDBm4FrAuFng==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The *.dtb and *.dtb.S files get removed by 'make' during the build process,
and later seem to be missed during the 'modpost' stage:

rm drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb.S drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb.S drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb.S drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb.S
WARNING: could not open drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S: No such file or directory

As a workaround, this adds all those files to the 'extra-y' target list,
but that's really ugly. Any ideas for a better fix?

Fixes: 81c0e3dd8292 ("drm: rcar-du: Fix legacy DT to create LVDS encoder nodes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/rcar-du/Makefile | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/Makefile b/drivers/gpu/drm/rcar-du/Makefile
index 3e58ed93d5b1..e5fc6ec0b8cc 100644
--- a/drivers/gpu/drm/rcar-du/Makefile
+++ b/drivers/gpu/drm/rcar-du/Makefile
@@ -12,6 +12,21 @@ rcar-du-drm-$(CONFIG_DRM_RCAR_LVDS)	+= rcar_du_of.o \
 					   rcar_du_of_lvds_r8a7793.dtb.o \
 					   rcar_du_of_lvds_r8a7795.dtb.o \
 					   rcar_du_of_lvds_r8a7796.dtb.o
+
+extra-y					+= rcar_du_of_lvds_r8a7790.dtb \
+					   rcar_du_of_lvds_r8a7790.dtb \
+					   rcar_du_of_lvds_r8a7791.dtb \
+					   rcar_du_of_lvds_r8a7793.dtb \
+					   rcar_du_of_lvds_r8a7795.dtb \
+					   rcar_du_of_lvds_r8a7796.dtb
+
+extra-y					+= rcar_du_of_lvds_r8a7790.dtb.S \
+					   rcar_du_of_lvds_r8a7790.dtb.S \
+					   rcar_du_of_lvds_r8a7791.dtb.S \
+					   rcar_du_of_lvds_r8a7793.dtb.S \
+					   rcar_du_of_lvds_r8a7795.dtb.S \
+					   rcar_du_of_lvds_r8a7796.dtb.S
+
 rcar-du-drm-$(CONFIG_DRM_RCAR_VSP)	+= rcar_du_vsp.o
 
 obj-$(CONFIG_DRM_RCAR_DU)		+= rcar-du-drm.o
-- 
2.9.0
