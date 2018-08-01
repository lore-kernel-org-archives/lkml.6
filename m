Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D23C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7062083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7062083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407336AbeHATOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:14:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389735AbeHATOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:14:41 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2239CD4D;
        Wed,  1 Aug 2018 17:27:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xinming Hu <huxm@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 070/144] mwifiex: correct histogram data with appropriate index
Date:   Wed,  1 Aug 2018 18:51:37 +0200
Message-Id: <20180801164954.944640639@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801164949.023217860@linuxfoundation.org>
References: <20180801164949.023217860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xinming Hu <huxm@marvell.com>

[ Upstream commit 30bfce0b63fa68c14ae1613eb9d259fa18644074 ]

Correct snr/nr/rssi data index to avoid possible buffer underflow.

Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/marvell/mwifiex/util.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -723,12 +723,14 @@ void mwifiex_hist_data_set(struct mwifie
 			   s8 nflr)
 {
 	struct mwifiex_histogram_data *phist_data = priv->hist_data;
+	s8 nf   = -nflr;
+	s8 rssi = snr - nflr;
 
 	atomic_inc(&phist_data->num_samples);
 	atomic_inc(&phist_data->rx_rate[rx_rate]);
-	atomic_inc(&phist_data->snr[snr]);
-	atomic_inc(&phist_data->noise_flr[128 + nflr]);
-	atomic_inc(&phist_data->sig_str[nflr - snr]);
+	atomic_inc(&phist_data->snr[snr + 128]);
+	atomic_inc(&phist_data->noise_flr[nf + 128]);
+	atomic_inc(&phist_data->sig_str[rssi + 128]);
 }
 
 /* function to reset histogram data during init/reset */


