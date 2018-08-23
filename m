Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455E4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EAC2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EAC2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbeHWMSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:18:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51138 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbeHWMSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:18:30 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 523C6C83;
        Thu, 23 Aug 2018 08:49:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        Peter Chen <peter.chen@nxp.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 122/324] usb: chipidea: host: fix disconnection detect issue
Date:   Thu, 23 Aug 2018 09:53:08 +0200
Message-Id: <20180823075001.998792236@linuxfoundation.org>
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

From: Peter Chen <peter.chen@nxp.com>

[ Upstream commit 90f26cc6bb90b35040f4da0347f480ea9df6e2fc ]

The commit 4e88d4c08301 ("usb: add a flag to skip PHY
initialization to struct usb_hcd") delete the assignment
for hcd->usb_phy, it causes usb_phy_notify_connect{disconnect)
are not called, the USB PHY driver is not notified of hot plug
event, then the disconnection will not be detected by hardware.

Fixes: 4e88d4c08301 ("usb: add a flag to skip PHY initialization
	to struct usb_hcd")
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reported-by: Mats Karrman <mats.dev.list@gmail.com>
Tested-by: Mats Karrman <mats.dev.list@gmail.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/chipidea/host.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/usb/chipidea/host.c
+++ b/drivers/usb/chipidea/host.c
@@ -124,8 +124,11 @@ static int host_start(struct ci_hdrc *ci
 
 	hcd->power_budget = ci->platdata->power_budget;
 	hcd->tpl_support = ci->platdata->tpl_support;
-	if (ci->phy || ci->usb_phy)
+	if (ci->phy || ci->usb_phy) {
 		hcd->skip_phy_initialization = 1;
+		if (ci->usb_phy)
+			hcd->usb_phy = ci->usb_phy;
+	}
 
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = ci->hw_bank.cap;


