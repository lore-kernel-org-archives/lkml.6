Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FDCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4112073D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197699;
	bh=L4CZlLuEJ/CmW/pV70a9n89HvYR8WY2j6cqFmbA6abI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tW5DK9lRaiGaZmKnbuGKI2lDSjxpZr3hUKrBast7qmqWf+F2z7mh/2qTbyBll6xVi
	 oy1AbP2RYOCJoFuG7jMHl2VqvNjzHQhgeo9CjwgyxXWkW5VTCiunOzYI6ebUU6CkT2
	 nEfKWQ0IMc0TQqV6Z8RQtpQ9ZJSf4lkfCJ+sjfD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfBOC2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:28:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391409AbfBOCN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:13:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28E3221934;
        Fri, 15 Feb 2019 02:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196807;
        bh=L4CZlLuEJ/CmW/pV70a9n89HvYR8WY2j6cqFmbA6abI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxmhLZGmCfh1/l/VzCS+c/M5OcPPBMuSPxt1zVZnZxXCeDwUp4hWx3ovnpqoogBPR
         Yj6daV3fJ0iU3bc1AHWNKbPSXVYWMwfy8YXFbRaErfpPoBcHH1+L4seP3OIuZCBudU
         pXeLPI256mJW6UcOf1y3vAJOLA2wlefQuNNA7fLE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bo He <bo.he@intel.com>, Yu Wang <yu.y.wang@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/40] usb: dwc3: gadget: synchronize_irq dwc irq in suspend
Date:   Thu, 14 Feb 2019 21:12:40 -0500
Message-Id: <20190215021313.178476-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021313.178476-1-sashal@kernel.org>
References: <20190215021313.178476-1-sashal@kernel.org>
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
index 727bf3c9f53b..e50f7ca9ca6e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3323,6 +3323,8 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
 
+	synchronize_irq(dwc->irq_gadget);
+
 	return 0;
 }
 
-- 
2.19.1

