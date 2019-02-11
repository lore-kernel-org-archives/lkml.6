Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B811AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896AB2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896251;
	bh=X/+vfLyYPTa/hpi9OiIX2rTY88OA1tCce8mmXSHe7Jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wZeB8wPbs90r4hGwd50/snmwWeSqjradctzbXxt3Ohh82T6CuYdc8sGANBsoZB3sc
	 Y0viQkrAgjkj3K5DfkteuWPREjAm+ccyisMTGOIDCFG8TIolGWsSM3dHjOvkFf+62/
	 QiM3/xwX5t9IdCfeS1Bh3BMgeqwoGpzEamynFtJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbfBKOoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:44:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731910AbfBKOoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:44:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0371214DA;
        Mon, 11 Feb 2019 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896245;
        bh=X/+vfLyYPTa/hpi9OiIX2rTY88OA1tCce8mmXSHe7Jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wUlnQmRztOdXpZOejiQj8a81GBQliaG3jjr8UHrOL6jECzMgdWE3T0Z1GW9H2bpR9
         tQvVpJFRKT7cOEbCniwuUwewodpBG+7aKxiNboHAChfyqSEnGBsv2JjdM1aYA/5cJk
         v6ZZMjM02aWvPy+VM3/7sZQLBA0bkdaQLQVvMXYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejas Joglekar <joglekar@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 119/313] usb: dwc3: gadget: Disable CSP for stream OUT ep
Date:   Mon, 11 Feb 2019 15:16:39 +0100
Message-Id: <20190211141901.777414179@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 244add8ebfb231c39db9e33b204bd0ce8f24f782 ]

In stream mode, when fast-forwarding TRBs, the stream number
is not cleared causing the new stream to not get assigned. So
we don't want controller to carry on transfers when short packet
is received. So disable the CSP for stream capable endpoint.

This is based on the 3.30a Programming guide, where table 3-1
device descriptor structure field definitions says for CSP bit
If this bit is 0, the controller generates an XferComplete event
and remove the stream. So if we keep CSP as 1 then switching between
streams would not happen as in stream mode, when fast-forwarding
TRBs, the stream number is not cleared causing the new stream to not get
assigned.

Signed-off-by: Tejas Joglekar <joglekar@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 74d29159f3b9..105278ccf487 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -981,9 +981,13 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 				usb_endpoint_type(dep->endpoint.desc));
 	}
 
-	/* always enable Continue on Short Packet */
+	/*
+	 * Enable Continue on Short Packet
+	 * when endpoint is not a stream capable
+	 */
 	if (usb_endpoint_dir_out(dep->endpoint.desc)) {
-		trb->ctrl |= DWC3_TRB_CTRL_CSP;
+		if (!dep->stream_capable)
+			trb->ctrl |= DWC3_TRB_CTRL_CSP;
 
 		if (short_not_ok)
 			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
-- 
2.19.1



