Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0692DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0B72081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0B72081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeKJEaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:30:23 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:42214 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728162AbeKJEaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:30:23 -0500
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA9IjggU024776;
        Fri, 9 Nov 2018 12:48:06 -0600
Received: from ni.com (skprod3.natinst.com [130.164.80.24])
        by mx0a-00010702.pphosted.com with ESMTP id 2nn531jd7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Nov 2018 12:48:06 -0600
Received: from us-aus-exhub2.ni.corp.natinst.com (us-aus-exhub2.ni.corp.natinst.com [130.164.68.32])
        by us-aus-skprod3.natinst.com (8.16.0.22/8.16.0.22) with ESMTPS id wA9Im5DM008577
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 9 Nov 2018 12:48:05 -0600
Received: from us-aus-exch3.ni.corp.natinst.com (130.164.68.13) by
 us-aus-exhub2.ni.corp.natinst.com (130.164.68.32) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 9 Nov 2018 12:48:05 -0600
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch3.ni.corp.natinst.com (130.164.68.13) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Fri, 9 Nov 2018 12:48:05 -0600
Received: from senary.amer.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1395.4 via Frontend Transport; Fri, 9 Nov 2018 12:48:05 -0600
From:   Kyle Roeschley <kyle.roeschley@ni.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     "David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Kyle Roeschley <kyle.roeschley@ni.com>
Subject: [PATCH v3] net: phy: leds: Don't make our own link speed names
Date:   Fri, 9 Nov 2018 12:48:03 -0600
Message-ID: <20181109184803.15588-1-kyle.roeschley@ni.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-09_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy core provides a handy phy_speed_to_str() helper, so use that
instead of doing our own formatting of the different known link speeds.
To do this, increase PHY_LED_TRIGGER_SPEED_SUFFIX_SIZE to 11 so we can fit
'Unsupported' if necessary.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
---
v3: const-ify suffix param of phy_led_trigger_format_name() to silence warning.
v2: Increase PHY_LED_TRIGGER_SPEED_SUFFIX_SIZE to fit 'Unsupported'.

 drivers/net/phy/phy_led_triggers.c | 15 ++-------------
 include/linux/phy_led_triggers.h   |  2 +-
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/phy_led_triggers.c b/drivers/net/phy/phy_led_triggers.c
index 491efc1bf5c4..263385b75bba 100644
--- a/drivers/net/phy/phy_led_triggers.c
+++ b/drivers/net/phy/phy_led_triggers.c
@@ -67,7 +67,7 @@ void phy_led_trigger_change_speed(struct phy_device *phy)
 EXPORT_SYMBOL_GPL(phy_led_trigger_change_speed);
 
 static void phy_led_trigger_format_name(struct phy_device *phy, char *buf,
-					size_t size, char *suffix)
+					size_t size, const char *suffix)
 {
 	snprintf(buf, size, PHY_ID_FMT ":%s",
 		 phy->mdio.bus->id, phy->mdio.addr, suffix);
@@ -77,20 +77,9 @@ static int phy_led_trigger_register(struct phy_device *phy,
 				    struct phy_led_trigger *plt,
 				    unsigned int speed)
 {
-	char name_suffix[PHY_LED_TRIGGER_SPEED_SUFFIX_SIZE];
-
 	plt->speed = speed;
-
-	if (speed < SPEED_1000)
-		snprintf(name_suffix, sizeof(name_suffix), "%dMbps", speed);
-	else if (speed == SPEED_2500)
-		snprintf(name_suffix, sizeof(name_suffix), "2.5Gbps");
-	else
-		snprintf(name_suffix, sizeof(name_suffix), "%dGbps",
-			 DIV_ROUND_CLOSEST(speed, 1000));
-
 	phy_led_trigger_format_name(phy, plt->name, sizeof(plt->name),
-				    name_suffix);
+				    phy_speed_to_str(speed));
 	plt->trigger.name = plt->name;
 
 	return led_trigger_register(&plt->trigger);
diff --git a/include/linux/phy_led_triggers.h b/include/linux/phy_led_triggers.h
index b37b05bfd1a6..4587ce362535 100644
--- a/include/linux/phy_led_triggers.h
+++ b/include/linux/phy_led_triggers.h
@@ -20,7 +20,7 @@ struct phy_device;
 #include <linux/leds.h>
 #include <linux/phy.h>
 
-#define PHY_LED_TRIGGER_SPEED_SUFFIX_SIZE	10
+#define PHY_LED_TRIGGER_SPEED_SUFFIX_SIZE	11
 
 #define PHY_LINK_LED_TRIGGER_NAME_SIZE (MII_BUS_ID_SIZE + \
 				       FIELD_SIZEOF(struct mdio_device, addr)+\
-- 
2.19.1

