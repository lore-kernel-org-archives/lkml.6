Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D14CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062B820664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkkUymW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062B820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeKAIok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbeKAIHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C755C20838;
        Wed, 31 Oct 2018 23:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027245;
        bh=cS9lFM0fSU86x0TjFVKRQWCLSp5vPysdcFuiAfI6+24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkkUymW0tMWCO+1IJbyrqAyDTD8to64V8/yyYuyT1d6FEUXQ/IMtlV7fzc1fqghh8
         Bz4Dq0hzR34E98oaZIFmyqLBMGqR/r80KZHbzM7Y05iklnpZIjP+3OKLnjW3LDK5gY
         sKiopGDyYFTcpuMkNG/RbrCZlbmobJ5V41K6H3Jo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 114/146] usb: dwc2: fix call to vbus supply exit routine, call it unlocked
Date:   Wed, 31 Oct 2018 19:05:09 -0400
Message-Id: <20181031230541.28822-114-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

[ Upstream commit 5aa678c7fd5371769efde30763fb43a43a118cd0 ]

dwc2_vbus_supply_exit() may call regulator_disable(). It shouldn't be
called with interrupts disabled as it might sleep.
This is seen with DEBUG_ATOMIC_SLEEP=y.

Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external
vbus supply")

Tested-by: Artur Petrosyan <arturp@synopsys.com>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc2/hcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 2bd6e6bfc241..befaf1e9d98a 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4482,7 +4482,9 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 		hprt0 |= HPRT0_SUSP;
 		hprt0 &= ~HPRT0_PWR;
 		dwc2_writel(hsotg, hprt0, HPRT0);
+		spin_unlock_irqrestore(&hsotg->lock, flags);
 		dwc2_vbus_supply_exit(hsotg);
+		spin_lock_irqsave(&hsotg->lock, flags);
 	}
 
 	/* Enter partial_power_down */
-- 
2.17.1

