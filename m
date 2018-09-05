Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E40C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1214B20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1214B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeIEQKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:10:23 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40662 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726046AbeIEQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:10:21 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w85BYIgO004475;
        Wed, 5 Sep 2018 13:40:25 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2m7g7wxh5x-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 05 Sep 2018 13:40:25 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C5A4A31;
        Wed,  5 Sep 2018 11:40:24 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A364E2B7E;
        Wed,  5 Sep 2018 11:40:24 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 5 Sep 2018
 13:40:24 +0200
Received: from localhost (10.201.20.5) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 5 Sep 2018 13:40:24 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 2/4] usb: dwc2: fix a race with external vbus supply
Date:   Wed, 5 Sep 2018 13:40:03 +0200
Message-ID: <1536147605-26279-3-git-send-email-amelie.delaunay@st.com>
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

There's a race with root hub resume, when using external vbus supply.
Root hub gets resumed, but runtime pm autosuspend runs as external vbus
supply isn't enabled. So, host never exit from power down properly.
Initialize vbus external supply before, rater that after hub resume.

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external
vbus supply")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/usb/dwc2/hcd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index c205cfa..bb72517 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4387,6 +4387,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	struct usb_bus *bus = hcd_to_bus(hcd);
 	unsigned long flags;
+	int ret;
 
 	dev_dbg(hsotg->dev, "DWC OTG HCD START\n");
 
@@ -4402,6 +4403,13 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 
 	dwc2_hcd_reinit(hsotg);
 
+	/* enable external vbus supply before resuming root hub */
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+	ret = dwc2_vbus_supply_init(hsotg);
+	if (ret)
+		return ret;
+	spin_lock_irqsave(&hsotg->lock, flags);
+
 	/* Initialize and connect root hub if one is not already attached */
 	if (bus->root_hub) {
 		dev_dbg(hsotg->dev, "DWC OTG HCD Has Root Hub\n");
@@ -4411,7 +4419,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	return dwc2_vbus_supply_init(hsotg);
+	return 0;
 }
 
 /*
-- 
2.7.4

