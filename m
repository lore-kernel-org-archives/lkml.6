Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD59C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6535621479
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCYtEQtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6535621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeJPMBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbeJPMBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060EF21476;
        Tue, 16 Oct 2018 04:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663177;
        bh=3nFx60WAi+u6LfHAu9vPiI2BfyS6lmjfhdrsOcFC788=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCYtEQtGQQFe/s4td4prdhoYVn9eqXl5b0b9Gs3U3DRjTJKKu75oUmC5KSEA1eR+s
         HyrRrwkcq4O81F0fFkN9xqIRUGm6GUV6nLFkHMoY3Tn83dc7c0N0I+YjIrjMRzGoG2
         vwOgscFjSJ/fOSsg/ScQvET4yYquufRLR9ikJL2M=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 037/100] bnxt_en: Fix TX timeout during netpoll.
Date:   Tue, 16 Oct 2018 00:11:18 -0400
Message-Id: <20181016041221.135528-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 73f21c653f930f438d53eed29b5e4c65c8a0f906 ]

The current netpoll implementation in the bnxt_en driver has problems
that may miss TX completion events.  bnxt_poll_work() in effect is
only handling at most 1 TX packet before exiting.  In addition,
there may be in flight TX completions that ->poll() may miss even
after we fix bnxt_poll_work() to handle all visible TX completions.
netpoll may not call ->poll() again and HW may not generate IRQ
because the driver does not ARM the IRQ when the budget (0 for netpoll)
is reached.

We fix it by handling all TX completions and to always ARM the IRQ
when we exit ->poll() with 0 budget.

Also, the logic to ACK the completion ring in case it is almost filled
with TX completions need to be adjusted to take care of the 0 budget
case, as discussed with Eric Dumazet <edumazet@google.com>

Reported-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Song Liu <songliubraving@fb.com>
Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 80b05597c5fe..bcb4a6731d76 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1882,8 +1882,11 @@ static int bnxt_poll_work(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		if (TX_CMP_TYPE(txcmp) == CMP_TYPE_TX_L2_CMP) {
 			tx_pkts++;
 			/* return full budget so NAPI will complete. */
-			if (unlikely(tx_pkts > bp->tx_wake_thresh))
+			if (unlikely(tx_pkts > bp->tx_wake_thresh)) {
 				rx_pkts = budget;
+				raw_cons = NEXT_RAW_CMP(raw_cons);
+				break;
+			}
 		} else if ((TX_CMP_TYPE(txcmp) & 0x30) == 0x10) {
 			if (likely(budget))
 				rc = bnxt_rx_pkt(bp, bnapi, &raw_cons, &event);
@@ -1911,7 +1914,7 @@ static int bnxt_poll_work(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 
-		if (rx_pkts == budget)
+		if (rx_pkts && rx_pkts == budget)
 			break;
 	}
 
@@ -2025,8 +2028,12 @@ static int bnxt_poll(struct napi_struct *napi, int budget)
 	while (1) {
 		work_done += bnxt_poll_work(bp, bnapi, budget - work_done);
 
-		if (work_done >= budget)
+		if (work_done >= budget) {
+			if (!budget)
+				BNXT_CP_DB_REARM(cpr->cp_doorbell,
+						 cpr->cp_raw_cons);
 			break;
+		}
 
 		if (!bnxt_has_work(bp, cpr)) {
 			if (napi_complete_done(napi, work_done))
-- 
2.17.1

