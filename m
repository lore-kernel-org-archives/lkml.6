Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA7AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F66220843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2m2rYaG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F66220843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbeKCD6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbeKCD6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:58:24 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 808E120843;
        Fri,  2 Nov 2018 18:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184610;
        bh=vAVu3h+UfmaT0XUiYfBLXTqYBL+4vKZQyauBm8EhYb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2m2rYaG1CTQ76eOKW//C0gnsQREo+tksjNIe21Mlg6JYK061f+0hgyFNCUGOZsJHB
         lCDKRb3GAgl0etboBSvKdKMTIMMTMGVBO8KTHZXjCASD66XH/NXPpH0f7o5/vfDrCM
         gokNKbwuFFsCFUV3nw8s1ziPKmGkyyu4DRs1gayk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 050/143] iwlwifi: mvm: check for short GI only for OFDM
Date:   Fri,  2 Nov 2018 19:33:55 +0100
Message-Id: <20181102182901.045133770@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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

[ Upstream commit 4c59ff5a9a9c54cc26c807dc2fa6933f7e9fa4ef ]

This bit will be used in CCK to indicate short preamble.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 2d14a58cbdd7..c73e4be9bde3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -439,7 +439,8 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->bw = RATE_INFO_BW_160;
 		break;
 	}
-	if (rate_n_flags & RATE_MCS_SGI_MSK)
+	if (!(rate_n_flags & RATE_MCS_CCK_MSK) &&
+	    rate_n_flags & RATE_MCS_SGI_MSK)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 	if (rate_n_flags & RATE_HT_MCS_GF_MSK)
 		rx_status->enc_flags |= RX_ENC_FLAG_HT_GF;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index e2196dc35dc6..8ba8c70571fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -981,7 +981,9 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 		rx_status->bw = RATE_INFO_BW_160;
 		break;
 	}
-	if (rate_n_flags & RATE_MCS_SGI_MSK)
+
+	if (!(rate_n_flags & RATE_MCS_CCK_MSK) &&
+	    rate_n_flags & RATE_MCS_SGI_MSK)
 		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 	if (rate_n_flags & RATE_HT_MCS_GF_MSK)
 		rx_status->enc_flags |= RX_ENC_FLAG_HT_GF;
-- 
2.17.1



