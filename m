Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EF5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F0720870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F0720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbeJ3DDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:03:47 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:56105 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbeJ3DDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:03:45 -0400
X-Originating-IP: 2.224.242.101
Received: from w540.lan (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E671E40006;
        Mon, 29 Oct 2018 18:13:57 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     geert+renesas@glider.be, laurent.pinchart@ideasonboard.com,
        horms@verge.net.au
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>, linus.walleij@linaro.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: sh-pfc: Introduce VIN_DATA_PIN_GROUP_VER
Date:   Mon, 29 Oct 2018 19:13:43 +0100
Message-Id: <1540836824-4636-2-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1540836824-4636-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VIN data groups may appear on different sets of pins, usually named
"vinX_data_[a|b]". The existing VIN_DATA_PIN_GROUP() does not support appending
the 'a' or 'b' suffix, leading to the definition of groups names not consistent
with the ones defined using SH_PFC_PIN_GROUP() macro.

Fix this by adding a macro that supports appending suffixes when required.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 458ae0a..2930e9a 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -54,17 +54,27 @@ struct sh_pfc_pin_group {
 
 /*
  * Using union vin_data saves memory occupied by the VIN data pins.
- * VIN_DATA_PIN_GROUP() is  a macro  used  to describe the VIN pin groups
- * in this case.
+ *
+ * VIN_DATA_PIN_GROUP() is  a macro  used  to describe the VIN pin groups,
+ * while VIN_DATA_PIN_GROUP_VER() is used when the same pin group can appear
+ * on different sets of pins.
  */
-#define VIN_DATA_PIN_GROUP(n, s)				\
-	{							\
-		.name = #n#s,					\
+#define __VIN_DATA_PIN_GROUP(n, s)				\
 		.pins = n##_pins.data##s,			\
 		.mux = n##_mux.data##s,				\
 		.nr_pins = ARRAY_SIZE(n##_pins.data##s),	\
 	}
 
+#define VIN_DATA_PIN_GROUP(n, s)				\
+	{							\
+		.name = #n#s,					\
+		__VIN_DATA_PIN_GROUP(n, s)
+
+#define VIN_DATA_PIN_GROUP_VER(n, v, s)				\
+	{							\
+		.name = #n#s"_"#v,				\
+		__VIN_DATA_PIN_GROUP(n##_##v, s)
+
 union vin_data {
 	unsigned int data24[24];
 	unsigned int data20[20];
-- 
2.7.4

