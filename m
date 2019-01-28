Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3657AC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BAD21738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691474;
	bh=nEFArfkRICKerMzA/bikpjdDUnlsvrIEudBWI1+9V6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AyNGstf6/Jgh93Wew8C/IGBFQNy6XyVqKUptFBhFdXPU/0NDJyvgqPMd6AwZVurCw
	 3QFv21Dn8k/H/OXuG4XZQuhfTvW3QTBF9DZjgc4946oKZV4+lQoCWFZBrsPjCdfsfM
	 y2VbAqImbQXtt+eKOGNJK4tkYIVo4tt8JfzgywDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbfA1QEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:04:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731564AbfA1QE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:04:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DDE20989;
        Mon, 28 Jan 2019 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691465;
        bh=nEFArfkRICKerMzA/bikpjdDUnlsvrIEudBWI1+9V6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fB0sPUbCo/+bx2fXyiKnPRoK3LUDhEfw/KrY34M/E3nSNqtJov9UX0XgWjRXeJmCj
         RjGu4X4wAtxwUYgFrsVb5zZOKEpgZPPyWGhvIAAzlJhm4NAS4cdWJ2YoXebD4lIX4N
         36jfDm56CCkx6tpiNUj5rABiSP03HxwYRxt74p+o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 102/258] usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()
Date:   Mon, 28 Jan 2019 10:56:48 -0500
Message-Id: <20190128155924.51521-102-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>

[ Upstream commit b7a4fbe2300a8965ea760c7e871507b84aea17f6 ]

Availability of TRB's is calculated using dwc3_calc_trbs_left(), which
determines total available TRB's based on the HWO bit set in a TRB.

In the present code, __dwc3_prepare_one_trb() is called with a TRB which
needs to be prepared for transfer. This __dwc3_prepare_one_trb() calls
dwc3_calc_trbs_left() to determine total available TRBs and set IOC bit
if the total available TRBs are zero. Since the present working TRB (which
is passed as an argument to __dwc3_prepare_one_trb() )  doesn't yet have
the HWO bit set before calling dwc3_calc_trbs_left(), there are chances
that dwc3_calc_trbs_left() wrongly calculates this present working TRB
as free(since the HWO bit is not yet set) and returns the total available
TRBs as greater than zero (including the present working TRB). This could
be a problem.

This patch corrects the above mentioned problem in __dwc3_prepare_one_trb()
by increementing the dep->trb_enqueue at the last (after preparing the TRB)
instead of increementing at the start and setting the IOC bit only if the
total available TRBs returned by dwc3_calc_trbs_left() is 1 . Since we are
increementing the dep->trb_enqueue at the last, the present working TRB is
also considered as available by dwc3_calc_trbs_left() and non zero value is
returned . So, according to the modified logic, when the total available
TRBs is equal to 1 that means the total available TRBs in the pool are 0.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
Tested-by: Tejas Joglekar <tejas.joglekar@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 558949b826d0..a9f22a0a3462 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -910,8 +910,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
-	dwc3_ep_inc_enq(dep);
-
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
 	trb->bpl = lower_32_bits(dma);
 	trb->bph = upper_32_bits(dma);
@@ -990,7 +988,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	}
 
 	if ((!no_interrupt && !chain) ||
-			(dwc3_calc_trbs_left(dep) == 0))
+			(dwc3_calc_trbs_left(dep) == 1))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
@@ -1001,6 +999,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_ep_inc_enq(dep);
+
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-- 
2.19.1

