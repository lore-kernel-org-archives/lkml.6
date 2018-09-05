Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F67C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA5E20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA5E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeIEQKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:10:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52635 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbeIEQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:10:22 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w85BXwCh009969;
        Wed, 5 Sep 2018 13:40:24 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2macxjghs2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 05 Sep 2018 13:40:24 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7AA131;
        Wed,  5 Sep 2018 11:40:23 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8D3932B7E;
        Wed,  5 Sep 2018 11:40:23 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 5 Sep 2018
 13:40:23 +0200
Received: from localhost (10.201.20.5) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 5 Sep 2018 13:40:22 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/4] usb: dwc2: get optional vbus-supply regulator once
Date:   Wed, 5 Sep 2018 13:40:02 +0200
Message-ID: <1536147605-26279-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536147605-26279-1-git-send-email-amelie.delaunay@st.com>
References: <1536147605-26279-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-05_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

Move devm_regulator_get_optional() call to probe routine. This avoids
'vbus-supply' regulator to be requested lots of times, upon each call
to dwc2_vbus_supply_init(), e.g. like with runtime pm.

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external
vbus supply")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/usb/dwc2/hcd.c      | 12 +++---------
 drivers/usb/dwc2/platform.c |  8 ++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 2bd6e6b..c205cfa 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -358,16 +358,10 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 
 static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
 {
-	int ret;
-
-	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
-	if (IS_ERR(hsotg->vbus_supply)) {
-		ret = PTR_ERR(hsotg->vbus_supply);
-		hsotg->vbus_supply = NULL;
-		return ret == -ENODEV ? 0 : ret;
-	}
+	if (hsotg->vbus_supply)
+		return regulator_enable(hsotg->vbus_supply);
 
-	return regulator_enable(hsotg->vbus_supply);
+	return 0;
 }
 
 static int dwc2_vbus_supply_exit(struct dwc2_hsotg *hsotg)
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 9a53a58..957e342 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -434,6 +434,14 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	if (retval)
 		return retval;
 
+	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
+	if (IS_ERR(hsotg->vbus_supply)) {
+		retval = PTR_ERR(hsotg->vbus_supply);
+		hsotg->vbus_supply = NULL;
+		if (retval != -ENODEV)
+			return retval;
+	}
+
 	retval = dwc2_lowlevel_hw_enable(hsotg);
 	if (retval)
 		return retval;
-- 
2.7.4

