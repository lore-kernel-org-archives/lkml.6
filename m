Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7723FC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1B42077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C1B42077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbeICVfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:35:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42236 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeICVfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:35:37 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 730C7D02;
        Mon,  3 Sep 2018 17:14:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 4.9 105/107] power: generic-adc-battery: check for duplicate properties copied from iio channels
Date:   Mon,  3 Sep 2018 18:57:09 +0200
Message-Id: <20180903165643.926585982@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165637.293735109@linuxfoundation.org>
References: <20180903165637.293735109@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: H. Nikolaus Schaller <hns@goldelico.com>

commit a427503edaaed9b75ed9746a654cece7e93e60a8 upstream.

If an iio channel defines a basic property, there are duplicate entries
in /sys/class/power/*/uevent.

So add a check to avoid duplicates. Since all channels may be duplicates,
we have to modify the related error check.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: stable@vger.kernel.org
Fixes: e60fea794e6e ("power: battery: Generic battery driver using IIO")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/generic-adc-battery.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -246,6 +246,7 @@ static int gab_probe(struct platform_dev
 	int ret = 0;
 	int chan;
 	int index = ARRAY_SIZE(gab_props);
+	bool any = false;
 
 	adc_bat = devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
 	if (!adc_bat) {
@@ -292,12 +293,22 @@ static int gab_probe(struct platform_dev
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


