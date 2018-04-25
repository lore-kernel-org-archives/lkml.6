Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756104AbeDYRn6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:43:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32770 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756024AbeDYRnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:43:07 -0400
X-Google-Smtp-Source: AIpwx4+Q8EWJnfG7C/ydnPZpdjXmdA69l5e7fT+q9jX3/TsQbZwyn567nd8Ts8FyE+5VXQVxLjxmYQ==
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 3/6] backlight/pandora: Stop using BL_CORE_DRIVER1
Date: Wed, 25 Apr 2018 19:42:50 +0200
Message-Id: <20180425174253.4616-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leaking driver internal tracking into the already massively confusing
backlight power tracking is really confusing.

Stop that by allocating a tiny driver private data structure instead.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
v2:
- Consistently treating PANDORA_WAS_OFF as a non-bitfield
- Drop the kfree that I left behind after switching to devm_kmalloc
---
 drivers/video/backlight/pandora_bl.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/pandora_bl.c b/drivers/video/backlight/pandora_bl.c
index a186bc677c7d..9618766e3866 100644
--- a/drivers/video/backlight/pandora_bl.c
+++ b/drivers/video/backlight/pandora_bl.c
@@ -35,11 +35,15 @@
 #define MAX_VALUE 63
 #define MAX_USER_VALUE (MAX_VALUE - MIN_VALUE)
 
-#define PANDORABL_WAS_OFF BL_CORE_DRIVER1
+struct pandora_private {
+	unsigned old_state;
+#define PANDORABL_WAS_OFF 1
+};
 
 static int pandora_backlight_update_status(struct backlight_device *bl)
 {
 	int brightness = bl->props.brightness;
+	struct pandora_private *priv = bl_get_data(bl);
 	u8 r;
 
 	if (bl->props.power != FB_BLANK_UNBLANK)
@@ -53,7 +57,7 @@ static int pandora_backlight_update_status(struct backlight_device *bl)
 		brightness = MAX_USER_VALUE;
 
 	if (brightness == 0) {
-		if (bl->props.state & PANDORABL_WAS_OFF)
+		if (priv->old_state == PANDORABL_WAS_OFF)
 			goto done;
 
 		/* first disable PWM0 output, then clock */
@@ -66,7 +70,7 @@ static int pandora_backlight_update_status(struct backlight_device *bl)
 		goto done;
 	}
 
-	if (bl->props.state & PANDORABL_WAS_OFF) {
+	if (priv->old_state == PANDORABL_WAS_OFF) {
 		/*
 		 * set PWM duty cycle to max. TPS61161 seems to use this
 		 * to calibrate it's PWM sensitivity when it starts.
@@ -93,9 +97,9 @@ static int pandora_backlight_update_status(struct backlight_device *bl)
 
 done:
 	if (brightness != 0)
-		bl->props.state &= ~PANDORABL_WAS_OFF;
+		priv->old_state = 0;
 	else
-		bl->props.state |= PANDORABL_WAS_OFF;
+		priv->old_state = PANDORABL_WAS_OFF;
 
 	return 0;
 }
@@ -109,13 +113,20 @@ static int pandora_backlight_probe(struct platform_device *pdev)
 {
 	struct backlight_properties props;
 	struct backlight_device *bl;
+	struct pandora_private *priv;
 	u8 r;
 
+	priv = devm_kmalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(&pdev->dev, "failed to allocate driver private data\n");
+		return -ENOMEM;
+	}
+
 	memset(&props, 0, sizeof(props));
 	props.max_brightness = MAX_USER_VALUE;
 	props.type = BACKLIGHT_RAW;
 	bl = devm_backlight_device_register(&pdev->dev, pdev->name, &pdev->dev,
-					NULL, &pandora_backlight_ops, &props);
+					priv, &pandora_backlight_ops, &props);
 	if (IS_ERR(bl)) {
 		dev_err(&pdev->dev, "failed to register backlight\n");
 		return PTR_ERR(bl);
@@ -126,7 +137,7 @@ static int pandora_backlight_probe(struct platform_device *pdev)
 	/* 64 cycle period, ON position 0 */
 	twl_i2c_write_u8(TWL_MODULE_PWM, 0x80, TWL_PWM0_ON);
 
-	bl->props.state |= PANDORABL_WAS_OFF;
+	priv->old_state = PANDORABL_WAS_OFF;
 	bl->props.brightness = MAX_USER_VALUE;
 	backlight_update_status(bl);
 
-- 
2.17.0
