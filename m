Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CABC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECA620661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ECA620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeLIW1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:27:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34664 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbeLIVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:11 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0002ia-KZ; Sun, 09 Dec 2018 21:55:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0003EB-QO; Sun, 09 Dec 2018 21:55:06 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Sebastian Reichel" <sebastian.reichel@collabora.co.uk>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.460345489@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 026/328] power: generic-adc-battery: check for
 duplicate properties copied from iio channels
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "H. Nikolaus Schaller" <hns@goldelico.com>

commit a427503edaaed9b75ed9746a654cece7e93e60a8 upstream.

If an iio channel defines a basic property, there are duplicate entries
in /sys/class/power/*/uevent.

So add a check to avoid duplicates. Since all channels may be duplicates,
we have to modify the related error check.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Fixes: e60fea794e6e ("power: battery: Generic battery driver using IIO")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
[bwh: Backported to 3.16:
 - s/psy_desc/psy/
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/power/generic-adc-battery.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/power/generic-adc-battery.c
+++ b/drivers/power/generic-adc-battery.c
@@ -244,6 +244,7 @@ static int gab_probe(struct platform_dev
 	int ret = 0;
 	int chan;
 	int index = ARRAY_SIZE(gab_props);
+	bool any = false;
 
 	adc_bat = devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
 	if (!adc_bat) {
@@ -288,12 +289,22 @@ static int gab_probe(struct platform_dev
 			adc_bat->channel[chan] = NULL;
 		} else {
 			/* copying properties for supported channels only */
-			psy->properties[index++] = gab_dyn_props[chan];
+			int index2;
+
+			for (index2 = 0; index2 < index; index2++) {
+				if (psy->properties[index2] ==
+				    gab_dyn_props[chan])
+					break;	/* already known */
+			}
+			if (index2 == index)	/* really new */
+				psy->properties[index++] =
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

