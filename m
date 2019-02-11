Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05067C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C769B21855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900084;
	bh=GxnrUA1VpNt3tf0K1A+HVk165pZudS2WrtzzDtRaLnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ickNE7ad9SF8PyBmD3rxvgyF2jx7YxUwsTOAg7VRWxbV5atcrCYQigSnmniGNgIjb
	 6aWa72nFFDZKNGUEv2XzAUgXWd6oJIHoF9hx4Nt/MKhSSMNCWQaySZOT1JaxcX1I9r
	 600ygD6yHFFoJE3Pu9V1nrY/IA+WqGMDXNNb2WKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfBKPsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:48:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732152AbfBKOlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:41:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A216520838;
        Mon, 11 Feb 2019 14:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896060;
        bh=GxnrUA1VpNt3tf0K1A+HVk165pZudS2WrtzzDtRaLnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7ij4yQiDfDNwlGDrtkVfjrHjGyGPNRLz+GNroDW10wRJ8i+Kwmq4vhXplXld+S5e
         OtzfDin4NS+pBw2M6KcW7C6DyWVtMtyVUSLFbY/oU3k+olvLjK6WolWayF8nKctxp1
         mMw3Dz2SCJP7tyUTStwvqa5VKktEBiNNBea1cd1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 030/313] iwlwifi: fw: do not set sgi bits for HE connection
Date:   Mon, 11 Feb 2019 15:15:10 +0100
Message-Id: <20190211141855.441236678@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5c2dbebb446539eb9640bf59a02756d6e7f1fc53 ]

If the association supports HE, HT/VHT rates will never be used for Tx
and therefore there's no need to set the sgi-per-channel-width-support
bits, so don't set them in this case.

Fixes: 110b32f065f3 ("iwlwifi: mvm: rs: add basic implementation of the new RS API handlers")
Signed-off-by: Naftali Goldstein <naftali.goldstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 8169d1450b3b..d1c1a8069c7e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -98,8 +98,12 @@ static u8 rs_fw_sgi_cw_support(struct ieee80211_sta *sta)
 {
 	struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
+	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
 	u8 supp = 0;
 
+	if (he_cap && he_cap->has_he)
+		return 0;
+
 	if (ht_cap->cap & IEEE80211_HT_CAP_SGI_20)
 		supp |= BIT(IWL_TLC_MNG_CH_WIDTH_20MHZ);
 	if (ht_cap->cap & IEEE80211_HT_CAP_SGI_40)
-- 
2.19.1



