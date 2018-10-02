Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA45C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5BD206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5BD206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbeJBUPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:15:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34510 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731367AbeJBUPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:15:49 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01741C2B;
        Tue,  2 Oct 2018 13:32:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alagu Sankar <alagusankar@silex-india.com>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 037/137] ath10k: sdio: use same endpoint id for all packets in a bundle
Date:   Tue,  2 Oct 2018 06:23:58 -0700
Message-Id: <20181002132501.083309192@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
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

From: Alagu Sankar <alagusankar@silex-india.com>

[ Upstream commit 679e1f07c86221b7183dd69df7068fd42d0041f6 ]

All packets in a bundle should use the same endpoint id as the
first lookahead.

This matches how things are done is ath6kl, however,
this patch can theoretically handle several bundles
in ath10k_sdio_mbox_rx_process_packets().

Without this patch we get lots of errors about invalid endpoint id:

ath10k_sdio mmc2:0001:1: invalid endpoint in look-ahead: 224
ath10k_sdio mmc2:0001:1: failed to get pending recv messages: -12
ath10k_sdio mmc2:0001:1: failed to process pending SDIO interrupts: -12

Co-Developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Alagu Sankar <alagusankar@silex-india.com>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/sdio.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath10k/sdio.c
+++ b/drivers/net/wireless/ath/ath10k/sdio.c
@@ -434,12 +434,14 @@ static int ath10k_sdio_mbox_rx_process_p
 	enum ath10k_htc_ep_id id;
 	int ret, i, *n_lookahead_local;
 	u32 *lookaheads_local;
+	int lookahead_idx = 0;
 
 	for (i = 0; i < ar_sdio->n_rx_pkts; i++) {
 		lookaheads_local = lookaheads;
 		n_lookahead_local = n_lookahead;
 
-		id = ((struct ath10k_htc_hdr *)&lookaheads[i])->eid;
+		id = ((struct ath10k_htc_hdr *)
+		      &lookaheads[lookahead_idx++])->eid;
 
 		if (id >= ATH10K_HTC_EP_COUNT) {
 			ath10k_warn(ar, "invalid endpoint in look-ahead: %d\n",
@@ -462,6 +464,7 @@ static int ath10k_sdio_mbox_rx_process_p
 			/* Only read lookahead's from RX trailers
 			 * for the last packet in a bundle.
 			 */
+			lookahead_idx--;
 			lookaheads_local = NULL;
 			n_lookahead_local = NULL;
 		}


