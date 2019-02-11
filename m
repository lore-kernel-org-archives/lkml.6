Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADE8C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C99222A8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897018;
	bh=u561cNkjCs3PfC31j8MoMrsJwUJaM9djqQ0gEV9NeI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UjUHa06dyx1tYgz/cw9CEfmQIjmMb5OtkFTe4Aanu6MNwZcD03ylqnE+W0calCIuK
	 0K/EbOFSlUV2JPfE3yJo97mQKnPibdpWJvePpdEMO8Xv6RV76ZivGjNBmmsoY3G+VP
	 YJdhvMjymV9XmvJxyuip348sCFrsVZQY+iMAEVBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389260AbfBKO4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389247AbfBKO4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:56:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C6CE222A6;
        Mon, 11 Feb 2019 14:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897010;
        bh=u561cNkjCs3PfC31j8MoMrsJwUJaM9djqQ0gEV9NeI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPz8TnSiDewqBcrza7wDYjW4bAhOTqoJSVWfj9KOkFpBeOFdvpF9A6w1bJx4VS/tX
         TE4Wm63N02bAMiXITBlmHfdYhWrasQ3Ncsh8tyL0J0McAa99dVxrx9l/axbbDYYqKG
         prlLyiXy4lNgRB3O9LGxGqD6FeaycVSEcG2gBGrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 062/205] usb: dwc3: Correct the logic for checking TRB full in __dwc3_prepare_one_trb()
Date:   Mon, 11 Feb 2019 15:17:40 +0100
Message-Id: <20190211141832.857227516@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 727bf3c9f53b..b80eefa355b6 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -890,8 +890,6 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
-	dwc3_ep_inc_enq(dep);
-
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
 	trb->bpl = lower_32_bits(dma);
 	trb->bph = upper_32_bits(dma);
@@ -970,7 +968,7 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 	}
 
 	if ((!no_interrupt && !chain) ||
-			(dwc3_calc_trbs_left(dep) == 0))
+			(dwc3_calc_trbs_left(dep) == 1))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
 	if (chain)
@@ -981,6 +979,8 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
+	dwc3_ep_inc_enq(dep);
+
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
-- 
2.19.1



