Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5461AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189EF206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550196561;
	bh=90by3f4RJ4Le5sQpCAINm3MdVIJ5a6qF+s4R04m7QaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R9B6F9Lka1SAwRdou/eQT5i5maY6/i1L1AMlS01HPk5SaL8mvy40cpeimmfsDVu/l
	 wHcRxijfTqRBy+Yv6Cc/537XmQFbkxtc/QoclVBzGtbWP953uPz1QG6P/2eS+uxvFE
	 YdnzXNkLG9AAT63gNfM423iDs2ADT9QfnFBQtFg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbfBOCJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:09:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731535AbfBOCJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:09:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA8BC222C9;
        Fri, 15 Feb 2019 02:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196554;
        bh=90by3f4RJ4Le5sQpCAINm3MdVIJ5a6qF+s4R04m7QaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w1KlrqjHYrJIIBCNaVZQYUB4FTdKPmpiTR4OS/V+eXdBxwo5dKJFdOYfDHYatAYx9
         /LTzJzFJS6yjf18bUhC5mkHQmUncRQiy9vrkFnsaBEVRpI03fJw46Ob7GZkiylSo0k
         y+MXFQVVKt5haKTQyFHg2zPeI1bxgZFTyDOyCwoU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bo He <bo.he@intel.com>, Yu Wang <yu.y.wang@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 12/77] usb: dwc3: gadget: synchronize_irq dwc irq in suspend
Date:   Thu, 14 Feb 2019 21:07:50 -0500
Message-Id: <20190215020855.176727-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215020855.176727-1-sashal@kernel.org>
References: <20190215020855.176727-1-sashal@kernel.org>
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
index 2a4ea9a1b1e3..f51527c8925b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3279,6 +3279,8 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
 
+	synchronize_irq(dwc->irq_gadget);
+
 	return 0;
 }
 
-- 
2.19.1

