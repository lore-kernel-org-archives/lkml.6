Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12291C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D0021471
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJW+NTLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D0021471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeJQBCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeJQBCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:02:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 234EF20866;
        Tue, 16 Oct 2018 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539709838;
        bh=U0MGVEG0RIw8j93yNMkHOlukfXYfFgjUURTPJk21Y0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJW+NTLN/IM54FofeSTYda0dGobz29HSKVhtMgFs4/PBg66H5TaI8kJ4xvosIx3a8
         Rgse2pwkqIDfYam1lheRUdsnXPnmd7O3304w/I3yibtbRZz2FSZzUX1aZoyibtmVqQ
         M7/q31E/OiIm0+ASqeoWJMNYPSYwuyKyw+gMreys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Chulski <stefanc@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 014/135] net: mvpp2: fix a txq_done race condition
Date:   Tue, 16 Oct 2018 19:04:04 +0200
Message-Id: <20181016170516.379781809@linuxfoundation.org>
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

From: Antoine Tenart <antoine.tenart@bootlin.com>

[ Upstream commit 774268f3e51b53ed432a1ec516574fd5ba469398 ]

When no Tx IRQ is available, the txq_done() routine (called from
tx_done()) shouldn't be called from the polling function, as in such
case it is already called in the Tx path thanks to an hrtimer. This
mostly occurred when using PPv2.1, as the engine then do not have Tx
IRQs.

Fixes: edc660fa09e2 ("net: mvpp2: replace TX coalescing interrupts with hrtimer")
Reported-by: Stefan Chulski <stefanc@marvell.com>
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3056,10 +3056,12 @@ static int mvpp2_poll(struct napi_struct
 				   cause_rx_tx & ~MVPP2_CAUSE_MISC_SUM_MASK);
 	}
 
-	cause_tx = cause_rx_tx & MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_MASK;
-	if (cause_tx) {
-		cause_tx >>= MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_OFFSET;
-		mvpp2_tx_done(port, cause_tx, qv->sw_thread_id);
+	if (port->has_tx_irqs) {
+		cause_tx = cause_rx_tx & MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_MASK;
+		if (cause_tx) {
+			cause_tx >>= MVPP2_CAUSE_TXQ_OCCUP_DESC_ALL_OFFSET;
+			mvpp2_tx_done(port, cause_tx, qv->sw_thread_id);
+		}
 	}
 
 	/* Process RX packets */


