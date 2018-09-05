Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A25C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157E120867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157E120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeIEQK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:10:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21453 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbeIEQKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:10:23 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w85BYk7u013470;
        Wed, 5 Sep 2018 13:40:26 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2m7fw6xycd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 05 Sep 2018 13:40:26 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E34834;
        Wed,  5 Sep 2018 11:40:25 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D3582B82;
        Wed,  5 Sep 2018 11:40:25 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 5 Sep 2018
 13:40:25 +0200
Received: from localhost (10.201.20.5) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 5 Sep 2018 13:40:25 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 3/4] usb: dwc2: fix call to vbus supply exit routine, call it unlocked
Date:   Wed, 5 Sep 2018 13:40:04 +0200
Message-ID: <1536147605-26279-4-git-send-email-amelie.delaunay@st.com>
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

dwc2_vbus_supply_exit() may call regulator_disable(). It shouldn't be
called with interrupts disabled as it might sleep.
This is seen with DEBUG_ATOMIC_SLEEP=y.

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external
vbus supply")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/usb/dwc2/hcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index bb72517..e8a480e 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4484,7 +4484,9 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 		hprt0 |= HPRT0_SUSP;
 		hprt0 &= ~HPRT0_PWR;
 		dwc2_writel(hsotg, hprt0, HPRT0);
+		spin_unlock_irqrestore(&hsotg->lock, flags);
 		dwc2_vbus_supply_exit(hsotg);
+		spin_lock_irqsave(&hsotg->lock, flags);
 	}
 
 	/* Enter partial_power_down */
-- 
2.7.4

