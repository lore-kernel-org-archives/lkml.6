Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF48BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF34E20675
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dcsQxIkQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dcsQxIkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfAKGCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:02:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:47408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfAKGCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:02:25 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7773C608CC; Fri, 11 Jan 2019 06:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547186544;
        bh=SH94WpQExnUoO5RLz6hLFLfFG8ZQRAV8pjzksEY8rT0=;
        h=From:To:Cc:Subject:Date:From;
        b=dcsQxIkQ1X7ZgIRC6SCH1Xxvo9RcKSg1YnVj5JzMf+kuKKFC6g5faXbe8GFpDW+EV
         +8sggYHZTsS8oiBgfdWY+OsaT2Rr2P6YmPQScAXWYzzKLIScYUdpqlO19RW48RImHk
         I7qVtjFW83s1/KCKi7C9r/KrcqYmjGrmJl3nPdnI=
Received: from mgautam-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03764601B4;
        Fri, 11 Jan 2019 06:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547186544;
        bh=SH94WpQExnUoO5RLz6hLFLfFG8ZQRAV8pjzksEY8rT0=;
        h=From:To:Cc:Subject:Date:From;
        b=dcsQxIkQ1X7ZgIRC6SCH1Xxvo9RcKSg1YnVj5JzMf+kuKKFC6g5faXbe8GFpDW+EV
         +8sggYHZTsS8oiBgfdWY+OsaT2Rr2P6YmPQScAXWYzzKLIScYUdpqlO19RW48RImHk
         I7qVtjFW83s1/KCKi7C9r/KrcqYmjGrmJl3nPdnI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03764601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
From:   Manu Gautam <mgautam@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:DESIGNWARE USB3 DRD IP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] usb: dwc3: gadget: Fail request submission if it was already queued
Date:   Fri, 11 Jan 2019 11:32:12 +0530
Message-Id: <20190111060212.7390-1-mgautam@codeaurora.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a function driver tries to re-submit an already queued request,
it can results in corruption of pending/started request lists.
Catch such conditions and fail the request submission to DCD.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
---
 drivers/usb/dwc3/gadget.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 679c12e14522..51716c6b286a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1290,6 +1290,12 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 				&req->request, req->dep->name))
 		return -EINVAL;
 
+	if (req->request.status == -EINPROGRESS) {
+		dev_err(dwc->dev, "%s: %pK request already in queue\n",
+					dep->name, req);
+		return -EBUSY;
+	}
+
 	pm_runtime_get(dwc->dev);
 
 	req->request.actual	= 0;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

