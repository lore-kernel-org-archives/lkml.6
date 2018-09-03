Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EAAC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7995C20862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7995C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbeICWAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:00:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49288 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbeICWAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:00:50 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3E55AA95;
        Mon,  3 Sep 2018 17:39:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 4.18 118/123] power: generic-adc-battery: fix out-of-bounds write when copying channel properties
Date:   Mon,  3 Sep 2018 18:57:42 +0200
Message-Id: <20180903165724.484193109@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: H. Nikolaus Schaller <hns@goldelico.com>

commit 932d47448c3caa0fa99e84d7f5bc302aa286efd8 upstream.

We did have sporadic problems in the pinctrl framework during boot
where a pin group name unexpectedly became NULL leading to a NULL
dereference in strcmp.

Detailled analysis of the failing cases did reveal that there were
two devm allocated objects close to each other. The second one was
the affected group_desc in pinmux and the first one was the
psy_desc->properties buffer of the gab driver.

Review of the gab code showed that the address calculation for
one memcpy() is wrong. It does

	properties + sizeof(type) * index

but C is defined to do the index multiplication already for
pointer + integer additions. Hence the factor was applied twice
and the memcpy() does write outside of the properties buffer.
Sometimes it happened to be the pinctrl and triggered the strcmp(NULL).

Anyways, it is overkill to use a memcpy() here instead of a simple
assignment, which is easier to read and has less risk for wrong
address calculations. So we change code to a simple assignment.

If we initialize the index to the first free location, we can even
remove the local variable 'properties'.

This bug seems to exist right from the beginning in 3.7-rc1 in

commit e60fea794e6e ("power: battery: Generic battery driver using IIO")

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: stable@vger.kernel.org
Fixes: e60fea794e6e ("power: battery: Generic battery driver using IIO")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/generic-adc-battery.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -241,10 +241,9 @@ static int gab_probe(struct platform_dev
 	struct power_supply_desc *psy_desc;
 	struct power_supply_config psy_cfg = {};
 	struct gab_platform_data *pdata = pdev->dev.platform_data;
-	enum power_supply_property *properties;
 	int ret = 0;
 	int chan;
-	int index = 0;
+	int index = ARRAY_SIZE(gab_props);
 
 	adc_bat = devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
 	if (!adc_bat) {
@@ -278,8 +277,6 @@ static int gab_probe(struct platform_dev
 	}
 
 	memcpy(psy_desc->properties, gab_props, sizeof(gab_props));
-	properties = (enum power_supply_property *)
-			((char *)psy_desc->properties + sizeof(gab_props));
 
 	/*
 	 * getting channel from iio and copying the battery properties
@@ -293,15 +290,12 @@ static int gab_probe(struct platform_dev
 			adc_bat->channel[chan] = NULL;
 		} else {
 			/* copying properties for supported channels only */
-			memcpy(properties + sizeof(*(psy_desc->properties)) * index,
-					&gab_dyn_props[chan],
-					sizeof(gab_dyn_props[chan]));
-			index++;
+			psy_desc->properties[index++] = gab_dyn_props[chan];
 		}
 	}
 
 	/* none of the channels are supported so let's bail out */
-	if (index == 0) {
+	if (index == ARRAY_SIZE(gab_props)) {
 		ret = -ENODEV;
 		goto second_mem_fail;
 	}
@@ -312,7 +306,7 @@ static int gab_probe(struct platform_dev
 	 * as come channels may be not be supported by the device.So
 	 * we need to take care of that.
 	 */
-	psy_desc->num_properties = ARRAY_SIZE(gab_props) + index;
+	psy_desc->num_properties = index;
 
 	adc_bat->psy = power_supply_register(&pdev->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(adc_bat->psy)) {


