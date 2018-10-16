Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96525C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618552089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF0BgeSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618552089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeJQBCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727246AbeJQBCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:02:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33AF021476;
        Tue, 16 Oct 2018 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709880;
        bh=Rx9HUsOghiIs1G4kmOrXegjuLhQ2Nc2gOAdbsUSWHtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uF0BgeSY/8wcKm+vfX6fynAUqgiCFQL9kQccNXEFIPQFmhjq/nhBsRAeLXse1fw/o
         GTLbJyIoeww76TesGMBKOIH+oPINRbO8tEGkRgRIA/mLCNxrtfWU278ybV95t3X3NY
         Nw2nEkgVk2nXJA9WKl9pShbsUCdRhQtrj3ZR6e9E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 028/135] net: qualcomm: rmnet: Fix incorrect allocation flag in transmit
Date:   Tue, 16 Oct 2018 19:04:18 +0200
Message-Id: <20181016170517.062489759@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
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

From: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

[ Upstream commit 6392ff3c8e4c23d0a09b0ae9f94feb3effed490b ]

The incoming skb needs to be reallocated in case the headroom
is not sufficient to add the MAP header. This allocation needs to
be atomic otherwise it results in the following splat

[32805.801456] BUG: sleeping function called from invalid context
[32805.841141] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[32805.904773] task: ffffffd7c5f62280 task.stack: ffffff80464a8000
[32805.910851] pc : ___might_sleep+0x180/0x188
[32805.915143] lr : ___might_sleep+0x180/0x188
[32806.131520] Call trace:
[32806.134041]  ___might_sleep+0x180/0x188
[32806.137980]  __might_sleep+0x50/0x84
[32806.141653]  __kmalloc_track_caller+0x80/0x3bc
[32806.146215]  __kmalloc_reserve+0x3c/0x88
[32806.150241]  pskb_expand_head+0x74/0x288
[32806.154269]  rmnet_egress_handler+0xb0/0x1d8
[32806.162239]  rmnet_vnd_start_xmit+0xc8/0x13c
[32806.166627]  dev_hard_start_xmit+0x148/0x280
[32806.181181]  sch_direct_xmit+0xa4/0x198
[32806.185125]  __qdisc_run+0x1f8/0x310
[32806.188803]  net_tx_action+0x23c/0x26c
[32806.192655]  __do_softirq+0x220/0x408
[32806.196420]  do_softirq+0x4c/0x70

Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -147,7 +147,7 @@ static int rmnet_map_egress_handler(stru
 	}
 
 	if (skb_headroom(skb) < required_headroom) {
-		if (pskb_expand_head(skb, required_headroom, 0, GFP_KERNEL))
+		if (pskb_expand_head(skb, required_headroom, 0, GFP_ATOMIC))
 			return -ENOMEM;
 	}
 


