Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6208EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275EF21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275EF21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388376AbeIXSgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:36:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58472 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbeIXSgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:36:47 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 865D11018;
        Mon, 24 Sep 2018 12:34:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 4.18 115/235] usb: xhci: fix interrupt transfer error happened on MTK platforms
Date:   Mon, 24 Sep 2018 13:51:41 +0200
Message-Id: <20180924113117.436313137@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

commit 0a3b53305c8ff427bbc1d9d5bd78524007f19600 upstream.

The MTK xHCI controller use some reserved bytes in endpoint context for
bandwidth scheduling, so need keep them in xhci_endpoint_copy();

The issue is introduced by:
commit f5249461b504 ("xhci: Clear the host side toggle manually when
endpoint is soft reset")
It resets endpoints and will drop bandwidth scheduling parameters used
by interrupt or isochronous endpoints on MTK xHCI controller.
Fixes: f5249461b504 ("xhci: Clear the host side toggle manually when
endpoint is soft reset")

Cc: stable@vger.kernel.org
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-mem.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1613,6 +1613,10 @@ void xhci_endpoint_copy(struct xhci_hcd
 	in_ep_ctx->ep_info2 = out_ep_ctx->ep_info2;
 	in_ep_ctx->deq = out_ep_ctx->deq;
 	in_ep_ctx->tx_info = out_ep_ctx->tx_info;
+	if (xhci->quirks & XHCI_MTK_HOST) {
+		in_ep_ctx->reserved[0] = out_ep_ctx->reserved[0];
+		in_ep_ctx->reserved[1] = out_ep_ctx->reserved[1];
+	}
 }
 
 /* Copy output xhci_slot_ctx to the input xhci_slot_ctx.


