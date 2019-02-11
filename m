Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FB3C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F29421A80
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901160;
	bh=4ly3N3X+3sGiw+0HJQZKh10aKDLsx43I9emOZvXAaTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LUkFlp89q1bujcUaNm9ipyk/tV2yBgZY0k2Rito3V3Y6sB7+Phv3hM8jL951scA7t
	 JMkMmYF8H4xqiGEw1Wl6QwEO7YmOjkn5K4IiWEJJywVGccHmGFV/laR5fSyFDaMoHY
	 n9K4sMAbMFPFF9GDELVz0+tvhNdUemY2zs/W5Pnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfBKQF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:05:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:33286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfBKO13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:27:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C640214DA;
        Mon, 11 Feb 2019 14:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895248;
        bh=4ly3N3X+3sGiw+0HJQZKh10aKDLsx43I9emOZvXAaTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SgA6gJRMG5aSKwhrDgEzOfYS/DAibBNJmnOwoTu/5TUXpeDDjwZDDCRfvJYXLnSBH
         rFU/aGjJbc3iLpEUpgCKdz2fVfQCpIBtwRX2qd8lLoSNoKCcjqEcYWcJGopUDibeQG
         E30w/vjEiIGYUrvaEQUZ1dH3JABIcOyT9MGFeOO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejas Joglekar <joglekar@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 141/352] usb: dwc3: gadget: Disable CSP for stream OUT ep
Date:   Mon, 11 Feb 2019 15:16:08 +0100
Message-Id: <20190211141855.495645697@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 88f69d823be5..357a2b330137 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -990,9 +990,13 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
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



