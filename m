Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85723C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C9720675
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895495;
	bh=SVHLVM9T5qMPc9X+jb1yR02K5jLyiibrb//H7/pQyvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jr6eJGq8sblvqr0DXu3btGq0kIyeOauasWt2GaWrgmXQQnN4YQ9l/1o17jf5tWBwH
	 fYzBtmphYiQuXEx5xy5JqXlcuL5O/ocvLui55ngYVe9FDEUQq53sfz5sJZqpuAqR5i
	 dk2ToSICcaTJTHJplwG9q/GUBkckZWWHLZ0QensA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfBKObe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:31:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729991AbfBKOb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98BBB20675;
        Mon, 11 Feb 2019 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895488;
        bh=SVHLVM9T5qMPc9X+jb1yR02K5jLyiibrb//H7/pQyvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=msg3MIO/+avy2vpp4jA5fUFc3V0u556moUz67Koq8e5R87/vL0b+XAFFdpGQxvjoG
         2J/7Uh33p3KoQHgt3etdEPS/aNimndcayh/YiLggKM99rR2UvbLw+L+n4u0CNH/hcd
         7kDHFIfDmxFPtCnRBk19qipHUXFPyO7kaAZq8orA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 222/352] iwlwifi: mvm: fix setting HE ppe FW config
Date:   Mon, 11 Feb 2019 15:17:29 +0100
Message-Id: <20190211141901.351715203@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 189b8d441b0f7825f0b4278851c52afaa0515ed2 ]

The FW expects to get the ppe value for each NSS-BW pair in the same
format as in the he phy capabilities IE, which means that a value of 0
implies ppe should be used for BPSK (mcs 0). If there are no PPE
thresholds in the IE, or if for some NSS-RU pair there's no threshold
set for it (this could happen because it's a variable-sized field), it
means no PPE should not be used for that pair, so the value sent to FW
should be 7 which corresponds to "none".

Fixes: 514c30696fbc ("iwlwifi: add support for IEEE802.11ax")
Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h   | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 1dd23f846fb9..f3ccd7948340 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -442,7 +442,7 @@ struct iwl_he_backoff_conf {
  * Support for Nss x BW (or RU) matrix:
  *	(0=SISO, 1=MIMO2) x (0-20MHz, 1-40MHz, 2-80MHz, 3-160MHz)
  * Each entry contains 2 QAM thresholds for 8us and 16us:
- *	0=BPSK, 1=QPSK, 2=16QAM, 3=64QAM, 4=256QAM, 5=1024QAM, 6/7=RES
+ *	0=BPSK, 1=QPSK, 2=16QAM, 3=64QAM, 4=256QAM, 5=1024QAM, 6=RES, 7=NONE
  * i.e. QAM_th1 < QAM_th2 such if TX uses QAM_tx:
  *	QAM_tx < QAM_th1            --> PPE=0us
  *	QAM_th1 <= QAM_tx < QAM_th2 --> PPE=8us
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 00f831d88366..5a42c617c54c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2005,7 +2005,13 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 	if (sta->he_cap.he_cap_elem.mac_cap_info[4] & IEEE80211_HE_MAC_CAP4_BQR)
 		sta_ctxt_cmd.htc_flags |= cpu_to_le32(IWL_HE_HTC_BQR_SUPP);
 
-	/* If PPE Thresholds exist, parse them into a FW-familiar format */
+	/*
+	 * Initialize the PPE thresholds to "None" (7), as described in Table
+	 * 9-262ac of 80211.ax/D3.0.
+	 */
+	memset(&sta_ctxt_cmd.pkt_ext, 7, sizeof(sta_ctxt_cmd.pkt_ext));
+
+	/* If PPE Thresholds exist, parse them into a FW-familiar format. */
 	if (sta->he_cap.he_cap_elem.phy_cap_info[6] &
 	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
 		u8 nss = (sta->he_cap.ppe_thres[0] &
-- 
2.19.1



