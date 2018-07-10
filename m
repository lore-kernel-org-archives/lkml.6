Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C7DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D51620936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D51620936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733301AbeGJS2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:28:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44986 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732408AbeGJS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:28:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96FD3DB4;
        Tue, 10 Jul 2018 18:28:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 08/47] ath10k: fix rfc1042 header retrieval in QCA4019 with eth decap mode
Date:   Tue, 10 Jul 2018 20:24:32 +0200
Message-Id: <20180710182337.391814838@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
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

From: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>

commit 2f38c3c01de945234d23dd163e3528ccb413066d upstream.

Chipset from QCA99X0 onwards (QCA99X0, QCA9984, QCA4019 & future)
rx_hdr_status is not padded to align in 4-byte boundary. Define a
new hw_params field to handle different alignment behaviour between
different hw. This patch fixes improper retrieval of rfc1042 header
with QCA4019. This patch along with "ath10k: Properly remove padding
from the start of rx payload" will fix traffic failure in ethernet
decap mode for QCA4019.

Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
[bwh: This just adds the part that was left out of the previous backport,
 commit b88fb9ea475a.]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1166,6 +1166,7 @@ static void *ath10k_htt_rx_h_find_rfc104
 	size_t hdr_len, crypto_len;
 	void *rfc1042;
 	bool is_first, is_last, is_amsdu;
+	int bytes_aligned = ar->hw_params.decap_align_bytes;
 
 	rxd = (void *)msdu->data - sizeof(*rxd);
 	hdr = (void *)rxd->rx_hdr_status;
@@ -1182,8 +1183,8 @@ static void *ath10k_htt_rx_h_find_rfc104
 		hdr_len = ieee80211_hdrlen(hdr->frame_control);
 		crypto_len = ath10k_htt_rx_crypto_param_len(ar, enctype);
 
-		rfc1042 += round_up(hdr_len, 4) +
-			   round_up(crypto_len, 4);
+		rfc1042 += round_up(hdr_len, bytes_aligned) +
+			   round_up(crypto_len, bytes_aligned);
 	}
 
 	if (is_amsdu)


