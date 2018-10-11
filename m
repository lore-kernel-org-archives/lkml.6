Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19247C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A9521476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQxoGAQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A9521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbeJKXKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:10:44 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3BE5213A2;
        Thu, 11 Oct 2018 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272580;
        bh=OJ6PEiXQJus7qLmu5WWDsgzK61OEunIHINE+bAbgYZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQxoGAQ8QdNVzqqazFRA4+yc5Tk8xarzDTZNLADyY6dwAHLN0iOzMiLkHPg3MfITy
         rRncMmWjljvl4aoRPYreE2S2mzsRqYpudzJoLy7OsWsjk+CtMud0xEtpXOUho8oC21
         LSg98T8HDsa8JqNuJFhC4ii32AyVj1NmTKASIc7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.9 12/35] usb: xhci-mtk: resume USB3 roothub first
Date:   Thu, 11 Oct 2018 17:35:14 +0200
Message-Id: <20181011152520.673364346@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
References: <20181011152520.174949126@linuxfoundation.org>
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

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

commit 555df5820e733cded7eb8d0bf78b2a791be51d75 upstream.

Give USB3 devices a better chance to enumerate at USB3 speeds if
they are connected to a suspended host.
Porting from "671ffdff5b13 xhci: resume USB 3 roothub first"

Cc: <stable@vger.kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-mtk.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -735,10 +735,10 @@ static int __maybe_unused xhci_mtk_resum
 	xhci_mtk_host_enable(mtk);
 
 	xhci_dbg(xhci, "%s: restart port polling\n", __func__);
-	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
-	usb_hcd_poll_rh_status(hcd);
 	set_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
 	usb_hcd_poll_rh_status(xhci->shared_hcd);
+	set_bit(HCD_FLAG_POLL_RH, &hcd->flags);
+	usb_hcd_poll_rh_status(hcd);
 	return 0;
 }
 


