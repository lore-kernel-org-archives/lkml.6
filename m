Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0349C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74792080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74792080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731903AbeKLGFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:05:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53126 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731140AbeKLGFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:05:43 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt1-0000oJ-UE; Sun, 11 Nov 2018 19:59:12 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001Xb-0A; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        "Johan Hovold" <johan@kernel.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.319627941@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 133/366] backlight: as3711_bl: Fix Device Tree node leaks
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

commit d5318d302e7cf6583ec85a2a8bfbb3a3910ae372 upstream.

Two framebuffer device-node names were looked up during probe, but were
only used as flags to indicate the presence of two framebuffer device.

Drop the unused framebuffer name along with a likewise unused device
pointer from the driver data, and update the platform data to pass in
booleans instead of the framebuffer strings. This allows us do drop the
node references acquired during probe, which would otherwise leak.

Note that there are no other in-kernel users of the modified
platform-data fields.

Fixes: 59eb2b5e57ea ("drivers/video/backlight/as3711_bl.c: add OF support")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/backlight/as3711_bl.c | 12 ++++++------
 include/linux/mfd/as3711.h          |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/video/backlight/as3711_bl.c
+++ b/drivers/video/backlight/as3711_bl.c
@@ -28,8 +28,6 @@ enum as3711_bl_type {
 
 struct as3711_bl_data {
 	bool powered;
-	const char *fb_name;
-	struct device *fb_dev;
 	enum as3711_bl_type type;
 	int brightness;
 	struct backlight_device *bl;
@@ -273,7 +271,9 @@ static int as3711_backlight_parse_dt(str
 
 	fb = of_parse_phandle(bl, "su1-dev", 0);
 	if (fb) {
-		pdata->su1_fb = fb->full_name;
+		of_node_put(fb);
+
+		pdata->su1_fb = true;
 
 		ret = of_property_read_u32(bl, "su1-max-uA", &pdata->su1_max_uA);
 		if (pdata->su1_max_uA <= 0)
@@ -286,7 +286,9 @@ static int as3711_backlight_parse_dt(str
 	if (fb) {
 		int count = 0;
 
-		pdata->su2_fb = fb->full_name;
+		of_node_put(fb);
+
+		pdata->su2_fb = true;
 
 		ret = of_property_read_u32(bl, "su2-max-uA", &pdata->su2_max_uA);
 		if (pdata->su2_max_uA <= 0)
@@ -425,7 +427,6 @@ static int as3711_backlight_probe(struct
 
 	if (pdata->su1_fb) {
 		su = &supply->su1;
-		su->fb_name = pdata->su1_fb;
 		su->type = AS3711_BL_SU1;
 
 		max_brightness = min(pdata->su1_max_uA, 31);
@@ -436,7 +437,6 @@ static int as3711_backlight_probe(struct
 
 	if (pdata->su2_fb) {
 		su = &supply->su2;
-		su->fb_name = pdata->su2_fb;
 		su->type = AS3711_BL_SU2;
 
 		switch (pdata->su2_fbprot) {
--- a/include/linux/mfd/as3711.h
+++ b/include/linux/mfd/as3711.h
@@ -107,9 +107,9 @@ struct as3711_regulator_pdata {
 };
 
 struct as3711_bl_pdata {
-	const char *su1_fb;
+	bool su1_fb;
 	int su1_max_uA;
-	const char *su2_fb;
+	bool su2_fb;
 	int su2_max_uA;
 	enum as3711_su2_feedback su2_feedback;
 	enum as3711_su2_fbprot su2_fbprot;

