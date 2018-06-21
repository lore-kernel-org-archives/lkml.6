Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF11C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE7320989
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE7320989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933331AbeFUPoY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:44:24 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:45946 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933246AbeFUPoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:44:12 -0400
Received: from belgarion.home ([90.55.203.186])
        by mwinf5d49 with ME
        id 1Tk01y00E41oiFu03TkAfA; Thu, 21 Jun 2018 17:44:10 +0200
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 21 Jun 2018 17:44:10 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 2/2] ALSA: ac97: add codecs devicetree binding
Date:   Thu, 21 Jun 2018 17:43:56 +0200
Message-Id: <20180621154356.5438-2-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180621154356.5438-1-robert.jarzmik@free.fr>
References: <20180621154356.5438-1-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree binding for codecs. This is especially useful if the
AC97 bitclk clock is provided by the codec, as it has to be described in
the devicetree description for the ac97 bus code to aquire it.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Special review query: review the "return of_node_get(node)", which
assumes that upon device removal, of_put_node(dev.of_node) will be
called...
---
 sound/ac97/bus.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 31f858eceffc..c8e20dd8786f 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -13,6 +13,7 @@
 #include <linux/idr.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -68,6 +69,27 @@ ac97_codec_find(struct ac97_controller *ac97_ctrl, unsigned int codec_num)
 	return ac97_ctrl->codecs[codec_num];
 }
 
+static struct device_node *
+ac97_of_get_child_device(struct ac97_controller *ac97_ctrl, int idx,
+			 unsigned int vendor_id)
+{
+	struct device_node *node;
+	u32 reg;
+	char compat[] = "ac97,0000,0000";
+
+	snprintf(compat, sizeof(compat), "ac97,%04x,%04x",
+		 vendor_id >> 16, vendor_id & 0xffff);
+
+	for_each_child_of_node(ac97_ctrl->parent->of_node, node) {
+		if ((idx != of_property_read_u32(node, "reg", &reg)) ||
+		    !of_device_is_compatible(node, compat))
+			continue;
+		return of_node_get(node);
+	}
+
+	return NULL;
+}
+
 static void ac97_codec_release(struct device *dev)
 {
 	struct ac97_codec_device *adev;
@@ -98,6 +120,8 @@ static int ac97_codec_add(struct ac97_controller *ac97_ctrl, int idx,
 
 	device_initialize(&codec->dev);
 	dev_set_name(&codec->dev, "%s:%u", dev_name(ac97_ctrl->parent), idx);
+	codec->dev.of_node = ac97_of_get_child_device(ac97_ctrl, idx,
+						      vendor_id);
 
 	ret = device_add(&codec->dev);
 	if (ret)
-- 
2.11.0

