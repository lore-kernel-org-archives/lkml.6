Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90383C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591D421477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zYuAEtBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591D421477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbeJQBKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:10:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbeJQBKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:10:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8FD72098A;
        Tue, 16 Oct 2018 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710316;
        bh=xgNr9IEL1oCRDnsLNQaocKb2q2BTe9U+ZU4MjetfGA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zYuAEtBcHfcLMNyCaMh2OHF4D//8Ijhk34vr2l3T42mLVr+sgg8zb6VYy8/3M5UOQ
         sHOvcGHc6lGw2b0TzX2y9VcnNLTBrQwK57QAYz5zqNe/QMy1p3bsImltIvy9oeOiHB
         rc31RriFAAe5gP1g0thC/Vdkvr8IKXOvw9Ovn+nI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Sperbeck <jsperbeck@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 033/109] bonding: fix warning message
Date:   Tue, 16 Oct 2018 19:05:01 +0200
Message-Id: <20181016170526.836004700@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
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

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit 0f3b914c9cfcd7bbedd445dc4ac5dd999fa213c2 ]

RX queue config for bonding master could be different from its slave
device(s). With the commit 6a9e461f6fe4 ("bonding: pass link-local
packets to bonding master also."), the packet is reinjected into stack
with skb->dev as bonding master. This potentially triggers the
message:

   "bondX received packet on queue Y, but number of RX queues is Z"

whenever the queue that packet is received on is higher than the
numrxqueues on bonding master (Y > Z).

Fixes: 6a9e461f6fe4 ("bonding: pass link-local packets to bonding master also.")
Reported-by: John Sperbeck <jsperbeck@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1193,6 +1193,7 @@ static rx_handler_result_t bond_handle_f
 
 		if (nskb) {
 			nskb->dev = bond->dev;
+			nskb->queue_mapping = 0;
 			netif_rx(nskb);
 		}
 		return RX_HANDLER_PASS;


