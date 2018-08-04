Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BC0C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48D72177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48D72177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389537AbeHDLMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:12:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50514 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388557AbeHDLMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:12:51 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7E2DE89C;
        Sat,  4 Aug 2018 09:12:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 108/124] NET: stmmac: align DMA stuff to largest cache line length
Date:   Sat,  4 Aug 2018 11:01:37 +0200
Message-Id: <20180804082706.497901268@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

[ Upstream commit 9939a46d90c6c76f4533d534dbadfa7b39dc6acc ]

As for today STMMAC_ALIGN macro (which is used to align DMA stuff)
relies on L1 line length (L1_CACHE_BYTES).
This isn't correct in case of system with several cache levels
which might have L1 cache line length smaller than L2 line. This
can lead to sharing one cache line between DMA buffer and other
data, so we can lose this data while invalidate DMA buffer before
DMA transaction.

Fix that by using SMP_CACHE_BYTES instead of L1_CACHE_BYTES for
aligning.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -54,7 +54,7 @@
 #include <linux/reset.h>
 #include <linux/of_mdio.h>
 
-#define STMMAC_ALIGN(x)	L1_CACHE_ALIGN(x)
+#define	STMMAC_ALIGN(x)		__ALIGN_KERNEL(x, SMP_CACHE_BYTES)
 
 /* Module parameters */
 #define TX_TIMEO	5000


