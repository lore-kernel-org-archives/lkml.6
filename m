Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9810CC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F07420866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLr//kKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F07420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbeJQBOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:14:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbeJQBOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:14:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E179820866;
        Tue, 16 Oct 2018 17:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710597;
        bh=sAmxf/eLuPWk9o+UyD3Z+qcZ9E5DW229I/6wH/dYNzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XLr//kKOCHb96Cl7+WdfehzPmku6wNiHE6knz6c+8b6Lw0YIGEWp5ixg3EyPG6Avz
         OGcuUpPU1g3qPwu54fYmix5MHW5fHY8X6jZRVIClxILGjNPw7hVwTA/PTyjxRcbEKW
         Ib0eS1ZbTxgijtbGXtpg/xjv19s1Nm5XHvagCwAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 22/71] bnxt_en: Fix TX timeout during netpoll.
Date:   Tue, 16 Oct 2018 19:09:19 +0200
Message-Id: <20181016170540.504648463@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1666,8 +1666,11 @@ static int bnxt_poll_work(struct bnxt *b
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
@@ -1685,7 +1688,7 @@ static int bnxt_poll_work(struct bnxt *b
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
 
-		if (rx_pkts == budget)
+		if (rx_pkts && rx_pkts == budget)
 			break;
 	}
 
@@ -1797,8 +1800,12 @@ static int bnxt_poll(struct napi_struct
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


