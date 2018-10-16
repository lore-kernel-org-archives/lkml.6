Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF13FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9899C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9CYb+G/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9899C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbeJPMEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbeJPMEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:04:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3978421470;
        Tue, 16 Oct 2018 04:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663378;
        bh=AYZCV+rwWdX7kdgEpYqSpIqYAUA09VpjWBpa1wPz5Go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9CYb+G/pM5LSD3N4r2zko7LURONKjBiZieCTYaIOK2/mKTFJcDp5L/ftgQK+wP2n
         cSpAaAjubpILBYCbsQnRUEoyBcOxEDRcSgIZsDR29BBUplP790yfstU5VXhAYMzdQj
         SDIuc5DZcMzrgSdZNyVEFPE+2St68cbghY3rVFE0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 12/25] bnxt_en: Fix TX timeout during netpoll.
Date:   Tue, 16 Oct 2018 00:15:53 -0400
Message-Id: <20181016041606.135876-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041606.135876-1-sashal@kernel.org>
References: <20181016041606.135876-1-sashal@kernel.org>
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
index 4ffacafddacb..fea8116da06a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1343,8 +1343,11 @@ static int bnxt_poll_work(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
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
 			rc = bnxt_rx_pkt(bp, bnapi, &raw_cons, &agg_event);
 			if (likely(rc >= 0))
@@ -1362,7 +1365,7 @@ static int bnxt_poll_work(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 
-		if (rx_pkts == budget)
+		if (rx_pkts && rx_pkts == budget)
 			break;
 	}
 
@@ -1404,8 +1407,12 @@ static int bnxt_poll(struct napi_struct *napi, int budget)
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
 			napi_complete(napi);
-- 
2.17.1

