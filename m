Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40E3C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B70620844
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ma+DC0Bv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B70620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbeGZNWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:22:15 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:54391 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbeGZNWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:22:15 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DBABB10C1058;
        Thu, 26 Jul 2018 05:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532606743; bh=BJbcTjXXv9GeS0h8cmCwzPh3zo7XQ0RmAYG3l19c++g=;
        h=From:To:Cc:Subject:Date:From;
        b=ma+DC0BvYE5YC9zjUuJXgkLFahFcdhaaWYFAw5+cKHtOa7vcjEZloSJgY6MMDGwWY
         9fG6zSw2Xmq6OKaOrSD2SS0NUT8J8z4opT1SojIUAGGqq0/EAloSf2YHSjEtphXd52
         9fvk6ZmkGy7glJ384c0lShtXsBIc+518pWo9MrTHEga8pFbb2WcjT0ErsmRSsUOmjx
         +j4jzoIoit7SXnn9jCHGIo/4pI1DZgxJcO+cw/1xTIDhYd3cheS5eC+6iBIrn0Ll3k
         EMDR2KHtJwR6sJfwHHvpHdg7yLFvjUaH9zBYK+OCLffsMh1WpR+o/y0jiB7hr//fVW
         0su0OUMTrv2+A==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5BF0058CC;
        Thu, 26 Jul 2018 05:05:41 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        "David S . Miller" <davem@davemloft.net>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] NET: stmmac: align DMA stuff to largest cache line length
Date:   Thu, 26 Jul 2018 15:05:37 +0300
Message-Id: <20180726120537.4664-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 60f59abab009..ef6a8d39db2f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -53,7 +53,7 @@
 #include "dwmac1000.h"
 #include "hwif.h"
 
-#define STMMAC_ALIGN(x)	L1_CACHE_ALIGN(x)
+#define	STMMAC_ALIGN(x)		__ALIGN_KERNEL(x, SMP_CACHE_BYTES)
 #define	TSO_MAX_BUFF_SIZE	(SZ_16K - 1)
 
 /* Module parameters */
-- 
2.14.4

