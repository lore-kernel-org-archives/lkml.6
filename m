Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A7FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE5C21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 23:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Fo2B4emr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ONUcm/5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392218AbeLUXUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 18:20:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56318 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLUXUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 18:20:42 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 35B3F607F1; Fri, 21 Dec 2018 23:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545434441;
        bh=9/uCD1BVEvuhX8Rlwmmtj+zeh+8t3srb9oXC9dQCg/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Fo2B4emrXynptGgNLe6pyuUc8y4HXRwOdicArYfPVOGh/YHa5+Ibgwi8IjuchlIXz
         Nkqr7B5scx44k1B919Mrp8LKRhSXdBI8TAS60M7U2TpIc3epW/WojBay+t6PS14Gr6
         VwVq54FgJE4EYQYlV8S0r9+pedmTG2LmBoujv920=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7CF1D601C3;
        Fri, 21 Dec 2018 23:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545434440;
        bh=9/uCD1BVEvuhX8Rlwmmtj+zeh+8t3srb9oXC9dQCg/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=ONUcm/5LgyvcTFDd4Y6HQWWIeC/AAYW4Tc8/UMeacrrvsUPUWTGrkZBNsA5f5H1UY
         JNGpSsa9TbWYTWCLZ7jIZ20CT8MObox8nN36XsNtLg/MBL0A1f2eQJxBH5ao1AVtPV
         qvd9d8dIl3LE9l+1CF1FLN59dBeLAKP13+KQKcJo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CF1D601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
From:   Jack Pham <jackp@codeaurora.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jack Pham <jackp@codeaurora.org>
Subject: [PATCH] usb: dwc3: gadget: Clear req->needs_extra_trb flag on cleanup
Date:   Fri, 21 Dec 2018 15:20:05 -0800
Message-Id: <20181221232005.5301-1-jackp@codeaurora.org>
X-Mailer: git-send-email 2.17.0
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

Signed-off-by: Jack Pham <jackp@codeaurora.org>
---
Hi Felipe,

There's probably zero chance this is making it to 4.20, so if you take
this after 4.21-rc1 so be it. But should this be Cc: stable? If so it
needs to be sent separately for <= 4.19 as needs_extra_trb was previously
req->unaligned and req->zero.

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
