Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E84C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FB121479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="My92qQye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FB121479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJHWiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727524AbeJHWiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 317272150B;
        Mon,  8 Oct 2018 15:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012357;
        bh=jTnMrgMdxxY9A+ljdAEFjBKwKM/i0ryfptcUnhaIWGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=My92qQyejPPG1Uqf5iMnEomfcpnVyRh31vXhj2dICTeCmHfL0NP66Gtb8Ldd/06CV
         cMqHKF/ZyNZj9ft56Tqnx9p1udOfTrccIqvgHTlEFx1FyWJxJOtjYV79IcWppUuu/u
         uv13lgPC6cqn71cTl2dg7LtPc7PwMYHTM1G8w2/0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 32/58] net: mvpp2: fix a txq_done race condition
Date:   Mon,  8 Oct 2018 11:24:57 -0400
Message-Id: <20181008152523.70705-32-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 661fa5a38df2..a1c7193cf858 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3055,10 +3055,12 @@ static int mvpp2_poll(struct napi_struct *napi, int budget)
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
-- 
2.17.1

