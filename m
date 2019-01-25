Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7347C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5CE218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 01:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="Xn1gI7ry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfAYBd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 20:33:56 -0500
Received: from chill.innovation.ch ([216.218.245.220]:51628 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfAYBd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 20:33:56 -0500
Date:   Thu, 24 Jan 2019 17:33:55 -0800
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 6FD6364012B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1548380035;
        bh=t7VbLK5nUYUAbZw8aYrjFWvkOqHS8EogaA5h3CuqTtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xn1gI7ry15fmnw4ewao+y3qfz2csXeybp4GmsgA7h48J16Q+BYyNx879b1WMcpgVD
         FrlGlEQ6llr3Ze+7ni7C+7C9NYKYmmt1EtfzRjEE/Ws5m/CczB2IjbFqZp3kWpIxg+
         4wObECsstyS5VDhMS0GlgaTfj1ot2tLIFPvz0VPefUOISZaf6KH4hn2tez97jms4EG
         tIqfl72RsQBz7H1E1F4kFdx4TARUegvIH26Es1cGa7zi+dKVYR/IfccLb9k6xLBsVk
         wzf1bQ88UJGAI3D9kBE2GonLQbTlf7foupWkJOQzK0Z5V9MoSsYofcgg8F2KM5mNiL
         ZVSe6XIe95BcQ==
From:   Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lukas Wunner <lukas@wunner.de>, dri-devel@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/bridge: sil_sii8620: make remote control optional.
Message-ID: <20190125013355.GA6722@innovation.ch>
Mail-Followup-To: Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, dri-devel@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190124072125.GA28127@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190124072125.GA28127@innovation.ch>
X-Mailer: git-send-email 2.20.1
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d6abe6df706c (drm/bridge: sil_sii8620: do not have a dependency
of RC_CORE) changed the driver to select both RC_CORE and INPUT.
However, this causes problems with other drivers, in particular an input
driver that depends on MFD_INTEL_LPSS_PCI (to be added in a separate
commit):

  drivers/clk/Kconfig:9:error: recursive dependency detected!
  drivers/clk/Kconfig:9:        symbol COMMON_CLK is selected by MFD_INTEL_LPSS
  drivers/mfd/Kconfig:566:      symbol MFD_INTEL_LPSS is selected by MFD_INTEL_LPSS_PCI
  drivers/mfd/Kconfig:580:      symbol MFD_INTEL_LPSS_PCI is implied by KEYBOARD_APPLESPI
  drivers/input/keyboard/Kconfig:73:    symbol KEYBOARD_APPLESPI depends on INPUT
  drivers/input/Kconfig:8:      symbol INPUT is selected by DRM_SIL_SII8620
  drivers/gpu/drm/bridge/Kconfig:83:    symbol DRM_SIL_SII8620 depends on DRM_BRIDGE
  drivers/gpu/drm/bridge/Kconfig:1:     symbol DRM_BRIDGE is selected by DRM_PL111
  drivers/gpu/drm/pl111/Kconfig:1:      symbol DRM_PL111 depends on COMMON_CLK

According to the docs and general consensus, select should only be used
for non user-visible symbols, but both RC_CORE and INPUT are
user-visible. Furthermore almost all other references to INPUT
throughout the kernel config are depends, not selects. For this reason
the first part of this change reverts commit d6abe6df706c.

In order to address the original reason for commit d6abe6df706c, namely
that not all boards use the remote controller functionality and hence
should not need have to deal with RC_CORE, the second part of this
change now makes the remote control support in the driver optional and
contingent on RC_CORE being defined. And with this the hard dependency
on INPUT also goes away as that is only needed if RC_CORE is defined
(which in turn already depends on INPUT).

CC: Inki Dae <inki.dae@samsung.com>
CC: Andrzej Hajda <a.hajda@samsung.com>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
Resending this, as I somehow managed to forget to cc dri-devel.
Apologies for the duplication.

Changes in v2:
 - completely remove dependencies on both RC_CORE and INPUT in Kconfig,
 - make remote control functionality in driver contingent on RC_CORE
   being defined

 drivers/gpu/drm/bridge/Kconfig       |  2 --
 drivers/gpu/drm/bridge/sil-sii8620.c | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 2fee47b0d50b..a11198a36005 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -85,8 +85,6 @@ config DRM_SIL_SII8620
 	depends on OF
 	select DRM_KMS_HELPER
 	imply EXTCON
-	select INPUT
-	select RC_CORE
 	help
 	  Silicon Image SII8620 HDMI/MHL bridge chip driver.
 
diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 0cc293a6ac24..dee47752791e 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -66,7 +66,9 @@ enum sii8620_mt_state {
 struct sii8620 {
 	struct drm_bridge bridge;
 	struct device *dev;
+#if IS_ENABLED(CONFIG_RC_CORE)
 	struct rc_dev *rc_dev;
+#endif
 	struct clk *clk_xtal;
 	struct gpio_desc *gpio_reset;
 	struct gpio_desc *gpio_int;
@@ -1756,6 +1758,7 @@ static void sii8620_send_features(struct sii8620 *ctx)
 	sii8620_write_buf(ctx, REG_MDT_XMIT_WRITE_PORT, buf, ARRAY_SIZE(buf));
 }
 
+#if IS_ENABLED(CONFIG_RC_CORE)
 static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
 {
 	bool pressed = !(scancode & MHL_RCP_KEY_RELEASED_MASK);
@@ -1774,6 +1777,12 @@ static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
 
 	return true;
 }
+#else
+static bool sii8620_rcp_consume(struct sii8620 *ctx, u8 scancode)
+{
+	return false;
+}
+#endif
 
 static void sii8620_msc_mr_set_int(struct sii8620 *ctx)
 {
@@ -2097,6 +2106,7 @@ static void sii8620_cable_in(struct sii8620 *ctx)
 	enable_irq(to_i2c_client(ctx->dev)->irq);
 }
 
+#if IS_ENABLED(CONFIG_RC_CORE)
 static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
 {
 	struct rc_dev *rc_dev;
@@ -2126,6 +2136,11 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
 	}
 	ctx->rc_dev = rc_dev;
 }
+#else
+static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
+{
+}
+#endif
 
 static void sii8620_cable_out(struct sii8620 *ctx)
 {
@@ -2214,9 +2229,11 @@ static int sii8620_attach(struct drm_bridge *bridge)
 
 static void sii8620_detach(struct drm_bridge *bridge)
 {
+#if IS_ENABLED(CONFIG_RC_CORE)
 	struct sii8620 *ctx = bridge_to_sii8620(bridge);
 
 	rc_unregister_device(ctx->rc_dev);
+#endif
 }
 
 static int sii8620_is_packing_required(struct sii8620 *ctx,
-- 
2.20.1

