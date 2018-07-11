Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F13DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E33420C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E33420C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388683AbeGKOue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:50:34 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:43229 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeGKOue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:50:34 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Lapqe-1gNdi42jSy-00kRkN; Wed, 11 Jul 2018 16:44:08 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] drm/sun4i: fix build failure with CONFIG_DRM_SUN8I_MIXER=m
Date:   Wed, 11 Jul 2018 16:43:10 +0200
Message-Id: <20180711144403.1022829-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:Xn9lFVgmsfGt6qSqwJlwu4AzJiaAn9rdd249O1SmDwH4pj/luPm
 e1ciFlK6WXcmnD1ZBjC0wK0udmlKvNOvM9NtIjMvcikohimvll0yG/0N6sfHwA6NWd3WvK7
 iI5AvnraJC3nxes31ZUdokumggAweKlQcoFdcdeH1R1VlZpXswGa9aUWs91BUbTqhXBbGLk
 MHLSuvy3gQsQovKxvP/MQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ykw5blQwfDA=:3lyWPAVyaoPt+9ABtQ+Nqm
 8ZPJFAjhMgocQQqjaawKIS4XWBkFZJFV2TmO964bJzu/ZQZSQ+BM9ftwZLRK11lJxbFyv6Rjw
 7DgLuLSMVfHjfqHQasJPec7ffBE7dnQQWszZffYdKVmTB25ffbLYM8iPDRyZfKu5f+SkROLz9
 Mq3hdnr1VnNvDK2iYhwGCi+ymc1GehnwdWpOtaElj0raXCxw7MBlFBjO9SVmtvM1Ggo2H2tAO
 Bmj07ogdkRTXhrNPOvgVIGud7dtxgnRDODr11yk+BOXddbUi9DxLnCz7MsBhnYhCiUd7aPr9D
 H85OVGhJ1Clp9vBHppOImUHUP3NZ+oW0+ThWsbONMlSagY78VY3Ae6Wf4ia9dAwmF4tTi4UDz
 UjLvVM2pRdPe23/Mx8ePOdl8LikA/mVcOZl0t6qRKHPE18APJWuIRppjMJcGcgptC1IPzMtpH
 NNwnsy339m4H3ljg1t+fOhafrcenBt2yYD4FbRK+GKB9Dz9wz0QX5e7pBxS52IZ3HQ+4NvRXa
 CGcs/R5bZ6wk7meKkUe6F+1WK+tPDPzegYDA1D50sJNhFsjLhMBS1OiqHpZX9B+E4DJrs+GV4
 2IC+YN9hxrZpnzSobkIMQGYQ7O8JitkHgonhGBp83RobIc8UNPn5puuu3XZBahjKFpZ500v29
 IwKplAHd2soBS7Y3/itDgXP/KDQxOyFTclamUrr0zn2NzJvxZfvwN9Iy4BDnXQN3z1Po=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having DRM_SUN4I built-in but DRM_SUN8I_MIXER as a loadable module results in
a link error, as we try to access a symbol from the sun8i_tcon_top.ko module:

ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun8i-drm-hdmi.ko] undefined!
ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-drm.ko] undefined!

This solves the problem by adding a silent symbol for the tcon_top module,
building it as a separate module in exactly the cases that we need it,
but in a way that it is reachable by the other modules.

Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
Fixes: ef0cf6441fbb ("drm/sun4i: Add support for traversing graph with TCON TOP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: link the tcon top module separately instead of into the mixer
v3: rebased on top of the latest git://anongit.freedesktop.org/drm/drm-misc for-linux-next
---
 drivers/gpu/drm/sun4i/Kconfig         | 7 +++++++
 drivers/gpu/drm/sun4i/Makefile        | 3 ++-
 drivers/gpu/drm/sun4i/sun4i_drv.c     | 3 ++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 3 ++-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 156a865c3e6d..c2c042287c19 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -68,4 +68,11 @@ config DRM_SUN8I_MIXER
 	  graphics mixture and feed graphics to TCON, If M is
 	  selected the module will be called sun8i-mixer.
 
+config DRM_SUN8I_TCON_TOP
+	tristate
+	default DRM_SUN4I if DRM_SUN8I_MIXER!=n
+	help
+	  TCON TOP is responsible for configuring display pipeline for
+	  HTMI, TVE and LCD.
+
 endif
diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index cd27d02c94e2..0eb38ac8e86e 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -39,4 +39,5 @@ endif
 obj-$(CONFIG_DRM_SUN4I_HDMI)	+= sun4i-drm-hdmi.o
 obj-$(CONFIG_DRM_SUN6I_DSI)	+= sun6i-dsi.o
 obj-$(CONFIG_DRM_SUN8I_DW_HDMI)	+= sun8i-drm-hdmi.o
-obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o sun8i_tcon_top.o
+obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o
+obj-$(CONFIG_DRM_SUN8I_TCON_TOP) += sun8i_tcon_top.o
diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index a15feb807393..03ffbcc98dd0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -216,7 +216,8 @@ static bool sun4i_drv_node_is_tcon_with_ch0(struct device_node *node)
 
 static bool sun4i_drv_node_is_tcon_top(struct device_node *node)
 {
-	return !!of_match_node(sun8i_tcon_top_of_table, node);
+	return IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
+		!!of_match_node(sun8i_tcon_top_of_table, node);
 }
 
 static int compare_of(struct device *dev, void *data)
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index 21dc9ebad0b4..e184cb17690b 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -44,7 +44,8 @@ sun8i_dw_hdmi_mode_valid(struct drm_connector *connector,
 
 static bool sun8i_dw_hdmi_node_is_tcon_top(struct device_node *node)
 {
-	return !!of_match_node(sun8i_tcon_top_of_table, node);
+	return IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
+		!!of_match_node(sun8i_tcon_top_of_table, node);
 }
 
 static u32 sun8i_dw_hdmi_find_possible_crtcs(struct drm_device *drm,
-- 
2.9.0

