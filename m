Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E7CC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F18C20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhbtbWx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F18C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbeKIIBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:34652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730844AbeKIHmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:40 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C62220892;
        Thu,  8 Nov 2018 22:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714710;
        bh=Tl/rRj7TewppcGCVf63gxvviTsmzRxdfkMWZzBUbURw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RhbtbWx93OlATe3tTMTV+lz9GAzKBZQ6CT79Dzc6yYOdAVTQtQ6iK3Zpt4NJuz9r4
         XvVHTRFSne6gn+FpDJpGIdye1IuQZuaPfTNVTY6C/fMBhJb4K/Cc9YdGMBS98GAOob
         14e20kgISnEfd2WUQrmPqykIGEfN5MVXszzzYnto=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 080/171] usb: renesas_usbhs: gadget: fix unused-but-set-variable warning
Date:   Thu,  8 Nov 2018 13:50:50 -0800
Message-Id: <20181108215133.350469484@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b7d44c36a6f6d956e1539e0dd42f98b26e5a4684 ]

The commit b8b9c974afee ("usb: renesas_usbhs: gadget: disable all eps
when the driver stops") causes the unused-but-set-variable warning.
But, if the usbhsg_ep_disable() will return non-zero value, udc/core.c
doesn't clear the ep->enabled flag. So, this driver should not return
non-zero value, if the pipe is zero because this means the pipe is
already disabled. Otherwise, the ep->enabled flag is never cleared
when the usbhsg_ep_disable() is called by the renesas_usbhs driver first.

Fixes: b8b9c974afee ("usb: renesas_usbhs: gadget: disable all eps when the driver stops")
Fixes: 11432050f070 ("usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()")
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/renesas_usbhs/mod_gadget.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 54a3237aac08..5984fb134cf4 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -639,14 +639,11 @@ static int usbhsg_ep_disable(struct usb_ep *ep)
 	struct usbhsg_uep *uep = usbhsg_ep_to_uep(ep);
 	struct usbhs_pipe *pipe;
 	unsigned long flags;
-	int ret = 0;
 
 	spin_lock_irqsave(&uep->lock, flags);
 	pipe = usbhsg_uep_to_pipe(uep);
-	if (!pipe) {
-		ret = -EINVAL;
+	if (!pipe)
 		goto out;
-	}
 
 	usbhsg_pipe_disable(uep);
 	usbhs_pipe_free(pipe);
-- 
2.17.1



