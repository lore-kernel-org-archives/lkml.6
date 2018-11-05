Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69B6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAC720825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WcE1Aep7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAC720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbeKFH5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:57:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46982 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388034AbeKFH5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:57:44 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA5MXgBZ009782
        for <linux-kernel@vger.kernel.org>; Mon, 5 Nov 2018 14:35:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=z+B/rlr/YWeW91bdB9QkfqTblPJ9XzU3SNWQbNx0uR8=;
 b=WcE1Aep7p95TTO8mIX1eS1soPT2iLLBWqHZPdo7H9Gqw7G2ceVSY3rfDOXqbVWBdYJvK
 m5TFS+9AnORdba8YzH3+rNcSajGYalSsvsqo+jwZylKmryW4ZU5ld49Lv1ttzVOOkwMS
 Ya9VAtiXRZwT3If27v3GiY9D3SuT6JFsQEU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2njvx20c2f-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:35:46 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Mon, 5 Nov 2018 14:35:45 -0800
Received: by devvm24792.prn1.facebook.com (Postfix, from userid 150176)
        id E4C867A7E5F7; Mon,  5 Nov 2018 14:35:42 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Tao Ren <taoren@fb.com>
Smtp-Origin-Hostname: devvm24792.prn1.facebook.com
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tao Ren <taoren@fb.com>, <openbmc@lists.ozlabs.org>
Smtp-Origin-Cluster: prn1c35
Subject: [PATCH net] net: phy: Allow BCM54616S PHY to setup internal TX/RX clock delay
Date:   Mon, 5 Nov 2018 14:35:40 -0800
Message-ID: <20181105223540.1897084-1-taoren@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows users to enable/disable internal TX and/or RX clock
delay for BCM54616S PHYs so as to satisfy RGMII timing specifications.

On a particular platform, whether TX and/or RX clock delay is required
depends on how PHY connected to the MAC IP. This requirement can be
specified through "phy-mode" property in the platform device tree.

The patch is inspired by commit 733336262b28 ("net: phy: Allow BCM5481x
PHYs to setup internal TX/RX clock delay").

Signed-off-by: Tao Ren <taoren@fb.com>
---
 drivers/net/phy/broadcom.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index e86ea105c802..704537010453 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -92,7 +92,7 @@ static int bcm54612e_config_init(struct phy_device *phydev)
 	return 0;
 }
 
-static int bcm5481x_config(struct phy_device *phydev)
+static int bcm54xx_config_clock_delay(struct phy_device *phydev)
 {
 	int rc, val;
 
@@ -429,7 +429,7 @@ static int bcm5481_config_aneg(struct phy_device *phydev)
 	ret = genphy_config_aneg(phydev);
 
 	/* Then we can set up the delay. */
-	bcm5481x_config(phydev);
+	bcm54xx_config_clock_delay(phydev);
 
 	if (of_property_read_bool(np, "enet-phy-lane-swap")) {
 		/* Lane Swap - Undocumented register...magic! */
@@ -442,6 +442,19 @@ static int bcm5481_config_aneg(struct phy_device *phydev)
 	return ret;
 }
 
+static int bcm54616s_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Aneg firsly. */
+	ret = genphy_config_aneg(phydev);
+
+	/* Then we can set up the delay. */
+	bcm54xx_config_clock_delay(phydev);
+
+	return ret;
+}
+
 static int brcm_phy_setbits(struct phy_device *phydev, int reg, int set)
 {
 	int val;
@@ -636,6 +649,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.features	= PHY_GBIT_FEATURES,
 	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm54xx_config_init,
+	.config_aneg	= bcm54616s_config_aneg,
 	.ack_interrupt	= bcm_phy_ack_intr,
 	.config_intr	= bcm_phy_config_intr,
 }, {
-- 
2.17.1

