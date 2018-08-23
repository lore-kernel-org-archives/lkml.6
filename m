Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D859C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE21B2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE21B2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbeHWMKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:10:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49884 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHWMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:10:20 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 724DC8B1;
        Thu, 23 Aug 2018 08:41:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Minas Harutyunyan <hminas@synopsys.com>,
        Artur Petrosyan <arturp@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 052/324] usb: dwc2: Fix host exit from hibernation flow.
Date:   Thu, 23 Aug 2018 09:51:58 +0200
Message-Id: <20180823074958.400145782@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Artur Petrosyan <Arthur.Petrosyan@synopsys.com>

[ Upstream commit 22bb5cfdf13ae70c6a34508a16cfeee48f162443 ]

In case when a hub is connected to DWC2 host
auto suspend occurs and host goes to
hibernation. When any device connected to hub
host hibernation exiting incorrectly.

- Added dwc2_hcd_rem_wakeup() function call to
  exit from suspend state by remote wakeup.

- Increase timeout value for port suspend bit to be set.

Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Artur Petrosyan <arturp@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/hcd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -5437,7 +5437,7 @@ int dwc2_host_enter_hibernation(struct d
 	dwc2_writel(hprt0, hsotg->regs + HPRT0);
 
 	/* Wait for the HPRT0.PrtSusp register field to be set */
-	if (dwc2_hsotg_wait_bit_set(hsotg, HPRT0, HPRT0_SUSP, 300))
+	if (dwc2_hsotg_wait_bit_set(hsotg, HPRT0, HPRT0_SUSP, 3000))
 		dev_warn(hsotg->dev, "Suspend wasn't generated\n");
 
 	/*
@@ -5618,6 +5618,8 @@ int dwc2_host_exit_hibernation(struct dw
 		return ret;
 	}
 
+	dwc2_hcd_rem_wakeup(hsotg);
+
 	hsotg->hibernated = 0;
 	hsotg->bus_suspended = 0;
 	hsotg->lx_state = DWC2_L0;


