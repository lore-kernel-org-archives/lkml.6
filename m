Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174CFC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D552E2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762978;
	bh=z16YqNXFSZak6EozmT0RpVAF0q0xGqJRIffH+yYbP5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AIeutoun92dKRe4wNkuzLm3ARPijRaG8OCAKTEEaPc06hWANBZJGFw2CNhZH01pDy
	 PJy3DHhUIXzIPZ9pORXpnYlxd0wJPVlaJWxXEJvLGa0r4ZjBTOTbMjeAkPIFTQ6Orq
	 YbRC1qd3woqdOyuxqukAQXojQayasvEnS3k6Co/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfA2LuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:50:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:40978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731346AbfA2Ltv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:49:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30FF62086C;
        Tue, 29 Jan 2019 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762590;
        bh=z16YqNXFSZak6EozmT0RpVAF0q0xGqJRIffH+yYbP5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOO0/TLGXx11KEn/PuLoHJ1zfDeHsiZBxxZhAz9ZXjLV0mFH0QEpwnHZXTYVn+nbp
         Sqwi9LkF2exOT1FH4KblIuRb/0so4VHIqK0gAoqX1x69c4LIfSTt8jQo3GrHXgwZ84
         HSZfVu4cYTmhLFpAMQouahIlsXnN+Bi0JxunuemA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jack Pham <jackp@codeaurora.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 4.14 58/68] usb: dwc3: gadget: Clear req->needs_extra_trb flag on cleanup
Date:   Tue, 29 Jan 2019 12:36:20 +0100
Message-Id: <20190129113137.108921532@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
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

From: Jack Pham <jackp@codeaurora.org>

commit bd6742249b9ca918565e4e3abaa06665e587f4b5 upstream.

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
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
[jackp: backport to <= 4.20: replaced 'needs_extra_trb' with 'unaligned'
        and 'zero' members in patch and reworded commit text]
Signed-off-by: Jack Pham <jackp@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/gadget.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -182,6 +182,8 @@ void dwc3_gadget_del_and_unmap_request(s
 	req->started = false;
 	list_del(&req->list);
 	req->remaining = 0;
+	req->unaligned = false;
+	req->zero = false;
 
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;


