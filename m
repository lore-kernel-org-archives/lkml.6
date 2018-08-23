Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEFFC43615
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344F72083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344F72083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbeHWMKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:10:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHWMKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:10:34 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4FB2F7F6;
        Thu, 23 Aug 2018 08:41:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Grigor Tovmasyan <tovmasya@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 056/324] usb: gadget: dwc2: fix memory leak in gadget_init()
Date:   Thu, 23 Aug 2018 09:52:02 +0200
Message-Id: <20180823074958.628028121@linuxfoundation.org>
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

From: Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>

[ Upstream commit 9bb073a053f0464ea74a4d4c331fdb7da58568d6 ]

Freed allocated request for ep0 to prevent memory leak in case when
dwc2_driver_probe() failed.

Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Grigor Tovmasyan <tovmasya@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/gadget.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4721,9 +4721,11 @@ int dwc2_gadget_init(struct dwc2_hsotg *
 	}
 
 	ret = usb_add_gadget_udc(dev, &hsotg->gadget);
-	if (ret)
+	if (ret) {
+		dwc2_hsotg_ep_free_request(&hsotg->eps_out[0]->ep,
+					   hsotg->ctrl_req);
 		return ret;
-
+	}
 	dwc2_hsotg_dump(hsotg);
 
 	return 0;
@@ -4736,6 +4738,7 @@ int dwc2_gadget_init(struct dwc2_hsotg *
 int dwc2_hsotg_remove(struct dwc2_hsotg *hsotg)
 {
 	usb_del_gadget_udc(&hsotg->gadget);
+	dwc2_hsotg_ep_free_request(&hsotg->eps_out[0]->ep, hsotg->ctrl_req);
 
 	return 0;
 }


