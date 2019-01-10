Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2782C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729F0213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Xo7zfHVB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UVhDHMh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfAJUkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:40:15 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbfAJUkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:40:15 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F7346055A; Thu, 10 Jan 2019 20:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547152814;
        bh=xMnvTGCTdIG4CkZNAHo7OB4PW/yqZ15fzZRJSuiKI1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xo7zfHVBADe1TLeeyK5WjrI6z4PJwnmZN8dLNTifKKIB6JM3ZuFCCfDi+hSphDaDb
         mQSKP3czQ8PI9aMBqpNbFo+otKJkGpMfwNe12NTT1W5E6W0ds5cTbttspPuYjPnkpz
         AtVxU7y7r6bpCq/Z8a3QamWD47EIoqtcU3OK4iTo=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 514C5601B4;
        Thu, 10 Jan 2019 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547152813;
        bh=xMnvTGCTdIG4CkZNAHo7OB4PW/yqZ15fzZRJSuiKI1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UVhDHMh02RAFxnvRqUET7CZg1FY1M+rm3YwpndchAkr7uhGDseuy4AdCahZ0Wso+R
         JzEYED6efi98zjhEkaj1KSYuJRoBdtFjVn3yhBrWBey+cneKBEnwiKM5OLEr/l3rvU
         SUv9LCBfndQRahMUCjmtLWAb0CO6RPLdJKgIaig8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 514C5601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
From:   Jack Pham <jackp@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>, stable@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: gadget: Clear req->needs_extra_trb flag on cleanup
Date:   Thu, 10 Jan 2019 12:39:55 -0800
Message-Id: <20190110203955.10724-1-jackp@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <87pnt5c53o.fsf@linux.intel.com>
References: <87pnt5c53o.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OUT endpoint requests may somtimes have this flag set when
preparing to be submitted to HW indicating that there is an
additional TRB chained to the request for alignment purposes.
If that request is removed before the controller can execute the
transfer (e.g. ep_dequeue/ep_disable), the request will not go
through the dwc3_gadget_ep_cleanup_completed_request() handler
and will not have its needs_extra_trb flag cleared when
dwc3_gadget_giveback() is called.  This same request could be
later requeued for a new transfer that does not require an
extra TRB and if it is successfully completed, the cleanup
and TRB reclamation will incorrectly process the additional TRB
which belongs to the next request, and incorrectly advances the
TRB dequeue pointer, thereby messing up calculation of the next
requeust's actual/remaining count when it completes.

The right thing to do here is to ensure that the flag is cleared
before it is given back to the function driver.  A good place
to do that is in dwc3_gadget_del_and_unmap_request().

Fixes: c6267a51639b ("usb: dwc3: gadget: align transfers to wMaxPacketSize")
Cc: stable@vger.kernel.org
Signed-off-by: Jack Pham <jackp@codeaurora.org>
---
v2: Added Fixes tag and Cc: stable

Felipe, as I mentioned in the cover for v1, for stable (from 4.11 where
c6267a51639b first landed through 4.20), the fix needs to be modified to
assign to the separate req->unaligned and req->zero flags in lieu of
needs_extra_trb which appeared in 5.0-rc1 in:

	commit 1a22ec643580626f439c8583edafdcc73798f2fb
	Author: Felipe Balbi <felipe.balbi@linux.intel.com>
	Date:   Wed Aug 1 13:15:05 2018 +0300

	    usb: dwc3: gadget: combine unaligned and zero flags

Do I need to send a separate patch for <= 4.20 or will you handle it?
It's straightforward really, the code change should instead be

+	req->unaligned = false;
+	req->zero = false;

Thanks,
Jack

 drivers/usb/dwc3/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2ecde30ad0b7..e97b14f444c8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -177,6 +177,7 @@ static void dwc3_gadget_del_and_unmap_request(struct dwc3_ep *dep,
 	req->started = false;
 	list_del(&req->list);
 	req->remaining = 0;
+	req->needs_extra_trb = false;
 
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
