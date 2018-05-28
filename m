Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164262AbeE1Kzj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164400AbeE1Kzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Elior <ariel.elior@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 313/496] qede: Do not drop rx-checksum invalidated packets.
Date: Mon, 28 May 2018 12:01:38 +0200
Message-Id: <20180528100333.018569432@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manish Chopra <manish.chopra@cavium.com>

[ Upstream commit 58f101bf87e32753342a6924772c6ebb0fbde24a ]

Today, driver drops received packets which are indicated as
invalid checksum by the device. Instead of dropping such packets,
pass them to the stack with CHECKSUM_NONE indication in skb.

Signed-off-by: Ariel Elior <ariel.elior@cavium.com>
Signed-off-by: Manish Chopra <manish.chopra@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qede/qede_fp.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -1245,16 +1245,10 @@ static int qede_rx_process_cqe(struct qe
 
 	csum_flag = qede_check_csum(parse_flag);
 	if (unlikely(csum_flag == QEDE_CSUM_ERROR)) {
-		if (qede_pkt_is_ip_fragmented(fp_cqe, parse_flag)) {
+		if (qede_pkt_is_ip_fragmented(fp_cqe, parse_flag))
 			rxq->rx_ip_frags++;
-		} else {
-			DP_NOTICE(edev,
-				  "CQE has error, flags = %x, dropping incoming packet\n",
-				  parse_flag);
+		else
 			rxq->rx_hw_errors++;
-			qede_recycle_rx_bd_ring(rxq, fp_cqe->bd_num);
-			return 0;
-		}
 	}
 
 	/* Basic validation passed; Need to prepare an SKB. This would also
