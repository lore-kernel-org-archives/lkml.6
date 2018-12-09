Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE50DC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD07A2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD07A2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeLIW16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:27:58 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34642 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbeLIVzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:11 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0002ic-J7; Sun, 09 Dec 2018 21:55:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0003E6-Pd; Sun, 09 Dec 2018 21:55:06 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        "Sebastian Reichel" <sebastian.reichel@collabora.co.uk>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.170902977@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 025/328] power: generic-adc-battery: fix
 out-of-bounds write when copying channel properties
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
Fixes: e60fea794e6e ("power: battery: Generic battery driver using IIO")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
[bwh: Backported to 3.16:
 - s/psy_desc/psy/g
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/power/generic-adc-battery.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- a/drivers/power/generic-adc-battery.c
+++ b/drivers/power/generic-adc-battery.c
@@ -241,10 +241,9 @@ static int gab_probe(struct platform_dev
 	struct gab *adc_bat;
 	struct power_supply *psy;
 	struct gab_platform_data *pdata = pdev->dev.platform_data;
-	enum power_supply_property *properties;
 	int ret = 0;
 	int chan;
-	int index = 0;
+	int index = ARRAY_SIZE(gab_props);
 
 	adc_bat = devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
 	if (!adc_bat) {
@@ -276,8 +275,6 @@ static int gab_probe(struct platform_dev
 	}
 
 	memcpy(psy->properties, gab_props, sizeof(gab_props));
-	properties = (enum power_supply_property *)
-				((char *)psy->properties + sizeof(gab_props));
 
 	/*
 	 * getting channel from iio and copying the battery properties
@@ -291,15 +288,12 @@ static int gab_probe(struct platform_dev
 			adc_bat->channel[chan] = NULL;
 		} else {
 			/* copying properties for supported channels only */
-			memcpy(properties + sizeof(*(psy->properties)) * index,
-					&gab_dyn_props[chan],
-					sizeof(gab_dyn_props[chan]));
-			index++;
+			psy->properties[index++] = gab_dyn_props[chan];
 		}
 	}
 
 	/* none of the channels are supported so let's bail out */
-	if (index == 0) {
+	if (index == ARRAY_SIZE(gab_props)) {
 		ret = -ENODEV;
 		goto second_mem_fail;
 	}
@@ -310,7 +304,7 @@ static int gab_probe(struct platform_dev
 	 * as come channels may be not be supported by the device.So
 	 * we need to take care of that.
 	 */
-	psy->num_properties = ARRAY_SIZE(gab_props) + index;
+	psy->num_properties = index;
 
 	ret = power_supply_register(&pdev->dev, psy);
 	if (ret)

