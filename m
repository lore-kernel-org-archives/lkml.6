Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16490C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A3A2148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A3A2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbeKLF41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52052 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727449AbeKLF40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:26 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt2-0000lF-EX; Sun, 11 Nov 2018 19:59:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001XM-Sf; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Lee Jones" <lee.jones@linaro.org>,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        "Johan Hovold" <johan@kernel.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.261614401@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 130/366] backlight: as3711_bl: Fix Device Tree node
 lookup
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 4a9c8bb2aca5b5a2a15744333729745dd9903562 upstream.

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent mfd node was also prematurely freed.

Fixes: 59eb2b5e57ea ("drivers/video/backlight/as3711_bl.c: add OF support")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/backlight/as3711_bl.c | 33 ++++++++++++++++++++---------
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

