Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2971C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724D320643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197393;
	bh=pLKVVID7QScmujQDnECyGGoVykYdBkhTptIfCeCmt6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bYBKaACuKckSmWyqB44s0cRYT5oWe4wZPq4Q6OGz8q8bq8sImSAVtfwA/ZkjlQ2ZD
	 uIwICLpKF7qmcTTwumpLvCesHlFpcx0eIqFGw4YBa2qh7hjhKWcLlivwQda7tNi/sG
	 x4w+m+xIyrWoRHXYGUKX0PWFd2SK8ITVdXh8ioqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfBOCXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:23:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391834AbfBOCOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:14:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28D0206BA;
        Fri, 15 Feb 2019 02:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196875;
        bh=pLKVVID7QScmujQDnECyGGoVykYdBkhTptIfCeCmt6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFeWAOsuqgCW8PmwkKlRiMRKGCyE1ZTqvLv00FxqWxuZ1kh9M3/kPxZ7HbsSDzVBe
         b3EX7BkLQbOPig1aC+2O26fWJEaxNbPHP/TQrSORTeikY8uliFpKycBXjrkD/37o5e
         iOP2NlOBYKNYKDPm8EJ+40dq1tY5kJBN/+VpwgpY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bo He <bo.he@intel.com>, Yu Wang <yu.y.wang@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 05/27] usb: dwc3: gadget: synchronize_irq dwc irq in suspend
Date:   Thu, 14 Feb 2019 21:14:02 -0500
Message-Id: <20190215021424.178979-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021424.178979-1-sashal@kernel.org>
References: <20190215021424.178979-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bo He <bo.he@intel.com>

[ Upstream commit 01c10880d24291a96a4ab0da773e3c5ce4d12da8 ]

We see dwc3 endpoint stopped by unwanted irq during
suspend resume test, which is caused dwc3 ep can't be started
with error "No Resource".

Here, add synchronize_irq before suspend to sync the
pending IRQ handlers complete.

Signed-off-by: Bo He <bo.he@intel.com>
Signed-off-by: Yu Wang <yu.y.wang@intel.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ed6b9bfe3759..c481df18a5a1 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3096,6 +3096,8 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
 
+	synchronize_irq(dwc->irq_gadget);
+
 	return 0;
 }
 
-- 
2.19.1

