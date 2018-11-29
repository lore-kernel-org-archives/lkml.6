Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1955C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894C321473
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqI8fxyP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894C321473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732738AbeK3BaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732729AbeK3BaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2F5B205C9;
        Thu, 29 Nov 2018 14:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501482;
        bh=ytVCJhGjiwGEid38vrm4PcEGUz1X8CgOYwRI5Fa4rW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqI8fxyPIRlK4vbpZ2AjfjahpdcEqYQJTFyyvzifONzKlDugpTNy8KKQyogU2eybm
         25BLQc/3ScsATzVE46Lrt4uOYbJISiakvE70PrYleaizGBneCUAswnBFvDnFfRVNZa
         P6601Ba/c8yp0AEA514DW7/6TyQ/O8J9QAi8DnAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 008/100] usb: dwc3: gadget: Properly check last unaligned/zero chain TRB
Date:   Thu, 29 Nov 2018 15:11:38 +0100
Message-Id: <20181129140059.633303880@linuxfoundation.org>
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

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit ba3a51ac32ebcf8d0a54b37f1af268ad8a31c52f upstream.

Current check for the last extra TRB for zero and unaligned transfers
does not account for isoc OUT. The last TRB of the Buffer Descriptor for
isoc OUT transfers will be retired with HWO=0. As a result, we won't
return early. The req->remaining will be updated to include the BUFSIZ
count of the extra TRB, and the actual number of transferred bytes
calculation will be wrong.

To fix this, check whether it's a short or zero packet and the last TRB
chain bit to return early.

Fixes: c6267a51639b ("usb: dwc3: gadget: align transfers to wMaxPacketSize")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2249,7 +2249,7 @@ static int __dwc3_cleanup_done_trbs(stru
 	 * with one TRB pending in the ring. We need to manually clear HWO bit
 	 * from that TRB.
 	 */
-	if ((req->zero || req->unaligned) && (trb->ctrl & DWC3_TRB_CTRL_HWO)) {
+	if ((req->zero || req->unaligned) && !(trb->ctrl & DWC3_TRB_CTRL_CHN)) {
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		return 1;
 	}


