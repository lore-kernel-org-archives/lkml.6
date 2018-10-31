Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F58ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172CF20843
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1j6cIYfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172CF20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbeKAIJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730517AbeKAIJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12C920838;
        Wed, 31 Oct 2018 23:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027365;
        bh=8DchUv9ENxnBwR0PR30WtrWFlWPcq596TZfuyVlu/Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1j6cIYfCtwww/M4ykXk4EpdO9HciYLiIMAXNh2sd7knM30a/xMeYRBa2nUkVdhkPE
         +imfksEI5EwIoDUlSF92wO7x3o1ds0sC3xzyTJsPmJXXgMvATFI8s3Pv01hcwmpFkc
         Dtu8tSQs8aWZHrliBcL+CmOp7JGT3/9rKGZQXvbg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 100/126] usb: dwc2: fix a race with external vbus supply
Date:   Wed, 31 Oct 2018 19:07:28 -0400
Message-Id: <20181031230754.29029-100-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

[ Upstream commit 41ee1ea21052583eaf5487dfa0d0c907c9667548 ]

There's a race with root hub resume, when using external vbus supply.
Root hub gets resumed, but runtime pm autosuspend runs as external vbus
supply isn't enabled. So, host never exit from power down properly.
Initialize vbus external supply before, rater that after hub resume.

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external
vbus supply")

Tested-by: Artur Petrosyan <arturp@synopsys.com>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/hcd.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 6e2cdd7b93d4..05a68f035d19 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4394,6 +4394,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	struct usb_bus *bus = hcd_to_bus(hcd);
 	unsigned long flags;
+	int ret;
 
 	dev_dbg(hsotg->dev, "DWC OTG HCD START\n");
 
@@ -4409,6 +4410,13 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 
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
@@ -4418,7 +4426,7 @@ static int _dwc2_hcd_start(struct usb_hcd *hcd)
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	return dwc2_vbus_supply_init(hsotg);
+	return 0;
 }
 
 /*
-- 
2.17.1

