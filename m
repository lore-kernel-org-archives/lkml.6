Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED50C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AFD25108
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AFD25108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964846AbeGAQUA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:20:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965033AbeGAQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:19:56 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7942792B;
        Sun,  1 Jul 2018 16:19:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.4 077/105] backlight: as3711_bl: Fix Device Tree node lookup
Date:   Sun,  1 Jul 2018 18:02:27 +0200
Message-Id: <20180701153155.002388918@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 4a9c8bb2aca5b5a2a15744333729745dd9903562 upstream.

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent mfd node was also prematurely freed.

Cc: stable <stable@vger.kernel.org>     # 3.10
Fixes: 59eb2b5e57ea ("drivers/video/backlight/as3711_bl.c: add OF support")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/backlight/as3711_bl.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

--- a/drivers/video/backlight/as3711_bl.c
+++ b/drivers/video/backlight/as3711_bl.c
@@ -262,10 +262,10 @@ static int as3711_bl_register(struct pla
 static int as3711_backlight_parse_dt(struct device *dev)
 {
 	struct as3711_bl_pdata *pdata = dev_get_platdata(dev);
-	struct device_node *bl =
-		of_find_node_by_name(dev->parent->of_node, "backlight"), *fb;
+	struct device_node *bl, *fb;
 	int ret;
 
+	bl = of_get_child_by_name(dev->parent->of_node, "backlight");
 	if (!bl) {
 		dev_dbg(dev, "backlight node not found\n");
 		return -ENODEV;
@@ -279,7 +279,7 @@ static int as3711_backlight_parse_dt(str
 		if (pdata->su1_max_uA <= 0)
 			ret = -EINVAL;
 		if (ret < 0)
-			return ret;
+			goto err_put_bl;
 	}
 
 	fb = of_parse_phandle(bl, "su2-dev", 0);
@@ -292,7 +292,7 @@ static int as3711_backlight_parse_dt(str
 		if (pdata->su2_max_uA <= 0)
 			ret = -EINVAL;
 		if (ret < 0)
-			return ret;
+			goto err_put_bl;
 
 		if (of_find_property(bl, "su2-feedback-voltage", NULL)) {
 			pdata->su2_feedback = AS3711_SU2_VOLTAGE;
@@ -314,8 +314,10 @@ static int as3711_backlight_parse_dt(str
 			pdata->su2_feedback = AS3711_SU2_CURR_AUTO;
 			count++;
 		}
-		if (count != 1)
-			return -EINVAL;
+		if (count != 1) {
+			ret = -EINVAL;
+			goto err_put_bl;
+		}
 
 		count = 0;
 		if (of_find_property(bl, "su2-fbprot-lx-sd4", NULL)) {
@@ -334,8 +336,10 @@ static int as3711_backlight_parse_dt(str
 			pdata->su2_fbprot = AS3711_SU2_GPIO4;
 			count++;
 		}
-		if (count != 1)
-			return -EINVAL;
+		if (count != 1) {
+			ret = -EINVAL;
+			goto err_put_bl;
+		}
 
 		count = 0;
 		if (of_find_property(bl, "su2-auto-curr1", NULL)) {
@@ -355,11 +359,20 @@ static int as3711_backlight_parse_dt(str
 		 * At least one su2-auto-curr* must be specified iff
 		 * AS3711_SU2_CURR_AUTO is used
 		 */
-		if (!count ^ (pdata->su2_feedback != AS3711_SU2_CURR_AUTO))
-			return -EINVAL;
+		if (!count ^ (pdata->su2_feedback != AS3711_SU2_CURR_AUTO)) {
+			ret = -EINVAL;
+			goto err_put_bl;
+		}
 	}
 
+	of_node_put(bl);
+
 	return 0;
+
+err_put_bl:
+	of_node_put(bl);
+
+	return ret;
 }
 
 static int as3711_backlight_probe(struct platform_device *pdev)


