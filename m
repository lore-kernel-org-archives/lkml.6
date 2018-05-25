Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966997AbeEYPvt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:51:49 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59035 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966527AbeEYPvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:51:47 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] drm/rcar-du: fix merge conflict for state->alpha
Date: Fri, 25 May 2018 17:50:11 +0200
Message-Id: <20180525155030.3667352-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525155030.3667352-1-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de>
X-Provags-ID: V03:K1:qfk7ta7aMUU5lUiyEuDc5IWKERsiJdt/aUVbBE5HdjYR4gX6A6l
 UMJVYSlXedaBgrIzHJKqwiLHj4N846MnGwE4uXeIBS2jp6F4ILsg9URWnWRpDR1BssvdkCD
 ANvUghPks2zeWC1YtuoBKOO4wp8NJLQA0xaiQppnf0/c3JEECO2iMHiBRySd/OnzHMGVtDT
 9tWwrhNmLVkvqFnkjw6xQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:heOmzYMTLIc=:dAGRfhrZQTxAG6lx6Faea0
 +4X2K8kosOda45QYYIaPX6EI2srMSZrG4HM4rHBlJD0vH8yknGK/l87ih41JFdbonNroS5T5e
 lPEg7DBtacupmEG8y3DB3qYjKTb1M53CJYkvhzeAi3OHnKqltVLsPMSxWzXRPk7267auMiccq
 Dzr3scJjAl2KWFnIERaYrM4FYpzrqzMMRXhX40wz5sVudtAtBe+5y7V8aWEpdXHlWrqhL2big
 rTk5oqjFJ+UtTXxsv1DVbCXWAnjJ7ga53DR6cGBP0YLtJ3wTmM3vEKRndkpOz+C2SYJiGoJld
 bhrl3NHQwmCgPFpmkThNVWf8nSDZ9pfbiL9aW4HTVnp9yrCXEchKEEPBl6rHHDe9YVDT0wEZK
 XDJKBJjGVfdVmTpmBMKjseSYZ/epoROjqDoIRWz5NWZlivuR+452RM+DdNX6VnMHPcsVHhnCV
 yB4+a/q9/rC/1w0hwZTRISmmtuUKaZ2rvGugvx+CsEjWe+dYRMeqQ2y+EBWwjyek+cNTnAMJo
 euIO+ZmQQZQtEjcKS8iPnrhyY6SsHkSlZwWlpYC2BjdjQgyYlvbNUNYSPYRsPU2+p/Wna4MEb
 OOY0XXwa82fl9jYVaRgSUcXw10c2y0Oxn8FyyO67U3YENrYfk+qIY2ASYhx5YC0mrEvUVpWDB
 inBlqxZSchQfSNIboJaHt7jEv8o28hHK4gdDJUHKYrofRNDXmcXXUN+6UByzw9OVmfIE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "alpha" struct member was removed in one commit but another user
added in another, leading to a build failure:

drivers/gpu/drm/rcar-du/rcar_du_vsp.c: In function 'rcar_du_vsp_plane_atomic_duplicate_state':
drivers/gpu/drm/rcar-du/rcar_du_vsp.c:325:6: error: 'struct rcar_du_vsp_plane_state' has no member named 'alpha'
  copy->alpha = to_rcar_vsp_plane_state(plane->state)->alpha;

This fixes up the merge by using the correct member.

Fixes: 75a07f399cd4 ("drm: rcar-du: Zero-out sg_tables when duplicating plane state")
Fixes: 301a9b8d5456 ("drm/rcar-du: Convert to the new generic alpha property")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
index 4a98470626d5..d9232e749b6d 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
@@ -322,7 +322,7 @@ rcar_du_vsp_plane_atomic_duplicate_state(struct drm_plane *plane)
 		return NULL;
 
 	__drm_atomic_helper_plane_duplicate_state(plane, &copy->state);
-	copy->alpha = to_rcar_vsp_plane_state(plane->state)->alpha;
+	copy->state.alpha = plane->state->alpha;
 
 	return &copy->state;
 }
-- 
2.9.0
