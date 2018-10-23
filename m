Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C67C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BF3207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="QOvT+kqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39BF3207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metanate.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeJWWbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 18:31:02 -0400
Received: from dougal.metanate.com ([90.155.101.14]:49637 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbeJWWbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 18:31:01 -0400
X-Greylist: delayed 1460 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2018 18:30:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=odhuCzb/dOdWC5S9mjKZUkng4ktxpugMcjGnrB7yp+o=; b=QOvT+kqoExsrPnbRkaLz977CAE
        GfP8VOrUK2drgjRBEtrBFBmkJUobdIHx8fc+istkNDmtxadcLFBwY8CxjBfptnY5DgWU7xxvVY387
        HAFn+YopqvFp69ArzumRzrEmSkXzgj4zSWxoF/nglpS/jbOaKRIMcWFbv4/6tb9WU5tZa7Eqnzgcy
        /HSuWinB3VDmBfmjhQzOgJxNLhExRdS0ZskgB+2Qxl1iNc5lJ2jeQTIW459o8hk84hz8OfNkA2KiE
        TRRiMOQDzm2JBk1vLU5BJ/9HvOPwBIaz4KbYSppkEVdO0wZs/zZoPeuUldOjN9W1Ep/RVZ+75YiDp
        O4fvRrPw==;
Received: from dougal.metanate.com ([192.168.88.1] helo=localhost.localdomain)
        by shrek.metanate.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <john@metanate.com>)
        id 1gEwxZ-0004DG-4p; Tue, 23 Oct 2018 14:43:01 +0100
From:   John Keeping <john@metanate.com>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Keeping <john@metanate.com>
Subject: [PATCH] usb: dwc2: gadget: fix ISOC frame overflow handling
Date:   Tue, 23 Oct 2018 14:43:55 +0100
Message-Id: <20181023134355.29829-1-john@metanate.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By clearing the overrun flag as soon as the target frame is next
incremented, we can end up incrementing the target frame more than
expected in dwc2_gadget_handle_ep_disabled() when the endpoint's
interval is greater than 1.  This happens if the target frame has just
wrapped at the point when the endpoint is disabled and the frame number
has not yet done so.

Instead, wait until the frame number also wraps and then clear the
overrun flag.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/dwc2/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 2d6d2c8244de..8da2c052dfa1 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -117,7 +117,7 @@ static inline void dwc2_gadget_incr_frame_num(struct dwc2_hsotg_ep *hs_ep)
 	if (hs_ep->target_frame > DSTS_SOFFN_LIMIT) {
 		hs_ep->frame_overrun = true;
 		hs_ep->target_frame &= DSTS_SOFFN_LIMIT;
-	} else {
+	} else if (hs_ep->parent->frame_number < hs_ep->target_frame) {
 		hs_ep->frame_overrun = false;
 	}
 }
-- 
2.19.1

