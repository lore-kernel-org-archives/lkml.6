Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54646C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE012147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692140;
	bh=bdLB6HXXaTV8zJHwoWxHcU4rKgcvEzCVdN8CBtMPEG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fz902rEAjVT9cDDGy+LswPnFC6n8V7ZDJOegqS1Le8K4weXrx3U/UmLGHcOUwt0+J
	 UhupXDV40bF+e+brXulyaDJauP38XP5VF7SWvQhshIRDEMfrdm25INF7PZKaU7sqer
	 A0PFDe84qPFVLWwho+1SKLMPtUZ6hvCbP3jUaBe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387434AbfA1QPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387809AbfA1QPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33EC2147A;
        Mon, 28 Jan 2019 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692136;
        bh=bdLB6HXXaTV8zJHwoWxHcU4rKgcvEzCVdN8CBtMPEG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOjEDpfQxDDhDgBpvk/GyJIUVUiLQ0AfHWxSuUI4I2nxXLsTwdfZ7oJ+V+3PM00Wd
         /wAn6WVeq1c0eyGhs9jtrs1CCegH637w4ly30ZyMy7yjdJobpddvU8JX561BElK+4/
         5YOfbKnBVXF7OMFK2ZCsfYt7ccsS/gsF1olhG5hM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Tejas Joglekar <joglekar@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 083/170] usb: dwc3: gadget: Disable CSP for stream OUT ep
Date:   Mon, 28 Jan 2019 11:10:33 -0500
Message-Id: <20190128161200.55107-83-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejas Joglekar <tejas.joglekar@synopsys.com>

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
index 59284acd8013..2f2e69233db0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -957,9 +957,13 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
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

