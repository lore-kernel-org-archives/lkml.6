Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8851DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A7720883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 05:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JRMrjNqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfAIF5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 00:57:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34927 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfAIF5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 00:57:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so2837490pgs.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 21:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aa1uCBP59MSaio3VSgOuyxVekJ64BN6jptSWeh729UM=;
        b=JRMrjNqvaANp2nwjIVi+v62CRRtIdsNdmrS4Xik+9U7Ze3Q3sZ79s8pImwHbYTgQjS
         Dv+rbhL7lHgHqTtv6NNNHHhY87BF4q3oM9eBrLFz9thIB3V/f8TqwV0lhqohwKlxYWDB
         p07mbFI5okRzpWqPFYdIgURZ1V/O/oYdbhPO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Aa1uCBP59MSaio3VSgOuyxVekJ64BN6jptSWeh729UM=;
        b=INRmbTV8ze30bNIHgzI6lBZyiuX2WAo9msUxDJv47co3RuETsGRjZyIJD+Q9KCs41b
         VeLXoQ8bZV+9JU6rwPPYLx+5ABFjyRCWern5l/UYvcx/IhM9+XfrfK3rcwVala/c7cMD
         oFtHomSKZm0bRF6U4EDDMWQf3xuq59w8Srqp+8twDeQYeiWH12Q5wj0ASarawo87OCCW
         7UvL325+1a30eeUy+VCmZM8413ZYuzrj/K56/J8vdNOLc4q8dKIlCNo7NLhJmXEOBVB1
         skLCnSWz//+SW3u6BRgj/+u8WZIxcA+QrIGUzTUzNc/8ucEAP+acgjSyzyCt1wCUW7bu
         O+yw==
X-Gm-Message-State: AJcUukdd+YkGxCski5Br9OnuUZJXQWk8A7dDQaaEpXfBm6tuL7OdpbHn
        7PWxlVm5GHUL4NI87HeQBq0QEg==
X-Google-Smtp-Source: ALg8bN67dfDF9e4WDOng/a/8ks/+HlzffpdXluuxKI+qUAPC45qiOTRTz4GtqYR9pVsdAlmUUxwtnA==
X-Received: by 2002:a63:a91a:: with SMTP id u26mr4147921pge.349.1547013465557;
        Tue, 08 Jan 2019 21:57:45 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id i1sm102627966pgb.46.2019.01.08.21.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 21:57:44 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal: mtk: Allocate enough space for mtk_thermal.
Date:   Wed,  9 Jan 2019 13:57:24 +0800
Message-Id: <20190109055724.184692-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk_thermal struct contains a 'struct mtk_thermal_bank banks[];',
but the allocation only allocates sizeof(struct mtk_thermal) bytes,
which cause out of bound access with the ->banks[] member. Change it to
a fixed size array instead.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/thermal/mtk_thermal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 0691f260f6eabe..ea11edb3fcced6 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -159,6 +159,9 @@
 #define MT7622_NUM_SENSORS_PER_ZONE	1
 #define MT7622_TS1	0
 
+/* The maximum number of banks */
+#define MAX_NUM_ZONES		8
+
 struct mtk_thermal;
 
 struct thermal_bank_cfg {
@@ -178,7 +181,7 @@ struct mtk_thermal_data {
 	const int *sensor_mux_values;
 	const int *msr;
 	const int *adcpnp;
-	struct thermal_bank_cfg bank_data[];
+	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
 };
 
 struct mtk_thermal {
@@ -197,7 +200,7 @@ struct mtk_thermal {
 	s32 vts[MT8173_NUM_SENSORS];
 
 	const struct mtk_thermal_data *conf;
-	struct mtk_thermal_bank banks[];
+	struct mtk_thermal_bank banks[MAX_NUM_ZONES];
 };
 
 /* MT8173 thermal sensor data */
-- 
2.20.1.97.g81188d93c3-goog

