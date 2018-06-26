Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD75C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDA025C18
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDA025C18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965596AbeFZN3P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:29:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:33436 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965545AbeFZN2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:28:49 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o12DNO4Ij0JfyqA2nA=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 43.10 DYNA|AUTH)
        with ESMTPSA id L06bd3u5QDSWNPw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 26 Jun 2018 15:28:32 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Sebastian Reichel <sre@kernel.org>,
        anish kumar <anish198519851985@gmail.com>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        Anton Vorontsov <cbouatmailru@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        "H. Nikolaus Schaller" <hns@goldelico.com>, stable@vger.kernel.org
Subject: [PATCH 2/2] power: generic-adc-battery: check for duplicate properties copied from iio channels
Date:   Tue, 26 Jun 2018 15:28:30 +0200
Message-Id: <0df4d5dc7d3591b8341dba50481d10fbb201fa9d.1530019688.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <cover.1530019688.git.hns@goldelico.com>
References: <cover.1530019688.git.hns@goldelico.com>
In-Reply-To: <cover.1530019688.git.hns@goldelico.com>
References: <cover.1530019688.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an iio channel defines a basic property, there are duplicate entries
in /sys/class/power/*/uevent.

So add a check to avoid duplicates. Since all channels may be duplicates,
we have to modify the related error check.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: stable@vger.kernel.org
---
 drivers/power/supply/generic-adc-battery.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index 11f59275bff4..bc462d1ec963 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -244,6 +244,7 @@ static int gab_probe(struct platform_device *pdev)
 	int ret = 0;
 	int chan;
 	int index = ARRAY_SIZE(gab_props);
+	bool any = false;
 
 	adc_bat = devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
 	if (!adc_bat) {
@@ -290,12 +291,22 @@ static int gab_probe(struct platform_device *pdev)
 			adc_bat->channel[chan] = NULL;
 		} else {
 			/* copying properties for supported channels only */
-			psy_desc->properties[index++] = gab_dyn_props[chan];
+			int index2;
+
+			for (index2 = 0; index2 < index; index2++) {
+				if (psy_desc->properties[index2] ==
+				    gab_dyn_props[chan])
+					break;	/* already known */
+			}
+			if (index2 == index)	/* really new */
+				psy_desc->properties[index++] =
+					gab_dyn_props[chan];
+			any = true;
 		}
 	}
 
 	/* none of the channels are supported so let's bail out */
-	if (index == ARRAY_SIZE(gab_props)) {
+	if (!any) {
 		ret = -ENODEV;
 		goto second_mem_fail;
 	}
-- 
2.12.2

