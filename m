Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735F0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB60213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2n9PcPrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB60213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbeK3BaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:57092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731500AbeK3BaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 695D0205C9;
        Thu, 29 Nov 2018 14:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501479;
        bh=iSI1EbAOYP2fpKX+9SJpOPkHJsKKruFJPALgRBifXqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2n9PcPrjVsn8CKleH7pCIyyDGgotSruA7IiuvagdVnallC7m8Q/RiiZuFwU7/sgqj
         pcV/nRhPyhMrPCzfZPHL20lpvEfn/dGXzxMZ05fGyHOJ11FH/w/EnKhvckb+HPLFAQ
         O1iKgzAP3rEsdM1jjTjiHy5JpV3ivZgslq34+3wA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 007/100] usb: dwc3: gadget: fix ISOC TRB type on unaligned transfers
Date:   Thu, 29 Nov 2018 15:11:37 +0100
Message-Id: <20181129140059.521079455@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felipe Balbi <felipe.balbi@linux.intel.com>

commit 2fc6d4be35fb1e262f209758e25bfe2b7a113a7f upstream.

When chaining ISOC TRBs together, only the first ISOC TRB should be of
type ISOC_FIRST, all others should be of type ISOC. This patch fixes
that.

Fixes: c6267a51639b ("usb: dwc3: gadget: align transfers to wMaxPacketSize")
Cc: <stable@vger.kernel.org> # v4.11+
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1088,7 +1088,7 @@ static void dwc3_prepare_one_trb_sg(stru
 			/* Now prepare one extra TRB to align transfer size */
 			trb = &dep->trb_pool[dep->trb_enqueue];
 			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr,
-					maxp - rem, false, 0,
+					maxp - rem, false, 1,
 					req->request.stream_id,
 					req->request.short_not_ok,
 					req->request.no_interrupt);
@@ -1120,7 +1120,7 @@ static void dwc3_prepare_one_trb_linear(
 		/* Now prepare one extra TRB to align transfer size */
 		trb = &dep->trb_pool[dep->trb_enqueue];
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp - rem,
-				false, 0, req->request.stream_id,
+				false, 1, req->request.stream_id,
 				req->request.short_not_ok,
 				req->request.no_interrupt);
 	} else if (req->request.zero && req->request.length &&
@@ -1136,7 +1136,7 @@ static void dwc3_prepare_one_trb_linear(
 		/* Now prepare one extra TRB to handle ZLP */
 		trb = &dep->trb_pool[dep->trb_enqueue];
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
-				false, 0, req->request.stream_id,
+				false, 1, req->request.stream_id,
 				req->request.short_not_ok,
 				req->request.no_interrupt);
 	} else {


