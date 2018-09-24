Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EBCC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A366F2148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A366F2148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbeIXSdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:33:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbeIXSdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:33:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB7741099;
        Mon, 24 Sep 2018 12:31:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Dirk van der Merwe <dirk.vandermerwe@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 077/235] nfp: avoid buffer leak when FW communication fails
Date:   Mon, 24 Sep 2018 13:51:03 +0200
Message-Id: <20180924113112.848828428@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
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

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit 07300f774fec9519663a597987a4083225588be4 ]

After device is stopped we reset the rings by moving all free buffers
to positions [0, cnt - 2], and clear the position cnt - 1 in the ring.
We then proceed to clear the read/write pointers.  This means that if
we try to reset the ring again the code will assume that the next to
fill buffer is at position 0 and swap it with cnt - 1.  Since we
previously cleared position cnt - 1 it will lead to leaking the first
buffer and leaving ring in a bad state.

This scenario can only happen if FW communication fails, in which case
the ring will never be used again, so the fact it's in a bad state will
not be noticed.  Buffer leak is the only problem.  Don't try to move
buffers in the ring if the read/write pointers indicate the ring was
never used or have already been reset.

nfp_net_clear_config_and_disable() is now fully idempotent.

Found by code inspection, FW communication failures are very rare,
and reconfiguring a live device is not common either, so it's unlikely
anyone has ever noticed the leak.

Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -1093,7 +1093,7 @@ static bool nfp_net_xdp_complete(struct
  * @dp:		NFP Net data path struct
  * @tx_ring:	TX ring structure
  *
- * Assumes that the device is stopped
+ * Assumes that the device is stopped, must be idempotent.
  */
 static void
 nfp_net_tx_ring_reset(struct nfp_net_dp *dp, struct nfp_net_tx_ring *tx_ring)
@@ -1295,13 +1295,18 @@ static void nfp_net_rx_give_one(const st
  * nfp_net_rx_ring_reset() - Reflect in SW state of freelist after disable
  * @rx_ring:	RX ring structure
  *
- * Warning: Do *not* call if ring buffers were never put on the FW freelist
- *	    (i.e. device was not enabled)!
+ * Assumes that the device is stopped, must be idempotent.
  */
 static void nfp_net_rx_ring_reset(struct nfp_net_rx_ring *rx_ring)
 {
 	unsigned int wr_idx, last_idx;
 
+	/* wr_p == rd_p means ring was never fed FL bufs.  RX rings are always
+	 * kept at cnt - 1 FL bufs.
+	 */
+	if (rx_ring->wr_p == 0 && rx_ring->rd_p == 0)
+		return;
+
 	/* Move the empty entry to the end of the list */
 	wr_idx = D_IDX(rx_ring, rx_ring->wr_p);
 	last_idx = rx_ring->cnt - 1;
@@ -2524,6 +2529,8 @@ static void nfp_net_vec_clear_ring_data(
 /**
  * nfp_net_clear_config_and_disable() - Clear control BAR and disable NFP
  * @nn:      NFP Net device to reconfigure
+ *
+ * Warning: must be fully idempotent.
  */
 static void nfp_net_clear_config_and_disable(struct nfp_net *nn)
 {


