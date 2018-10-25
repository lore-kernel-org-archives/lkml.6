Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F226EECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B397C20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2jyX1ySr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B397C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeJYWnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbeJYWnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:43:52 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27E2D2054F;
        Thu, 25 Oct 2018 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476657;
        bh=SoaFqKjLC72lx7G5tojpsp/OYxgceXGmkm7ULeCanPA=;
        h=From:To:Cc:Subject:Date:From;
        b=2jyX1ySrfcD/CLsyiqs6o8AXSyIQXXcslV2QEwI2kgkyXRg6biBBZhsCFfVV3TmNk
         yb55kGYD3aBrtkgubYCEN3Lqyy0/9BP3sKQEyvcvXzyffw49Saz9+1XBf3dUy1Yf22
         Frask9tL0JkZ1pr0Vxsy+QV+UlsfqjDDM4hxywnc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 01/46] iwlwifi: mvm: check for short GI only for OFDM
Date:   Thu, 25 Oct 2018 10:10:08 -0400
Message-Id: <20181025141053.213330-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

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

