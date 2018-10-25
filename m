Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8656DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5FE20856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpz7xjup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5FE20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeJYXPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728726AbeJYWr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:58 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEAA420848;
        Thu, 25 Oct 2018 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476901;
        bh=qrxlJgcz9N6L11VsttLVzPosf6w0RLeNfgst7uamyo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpz7xjupmsh7Npszl4RMd1qH4n3/T4gAnhPEt0Ixsag9elC/ueSN4FN5EJ70UGD0t
         gHzEAoru7LpS26Fjt2H7KgtjeGh0Zy5HGdtMogZHBIEvZDICy7qbN2aYZZ0bcz9bTg
         x4keroka35GiZQT5Wec5o/9OaeO69PHVAIuY1vHA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 24/98] ath10k: fix NAPI enable/disable symmetry for AHB interface
Date:   Thu, 25 Oct 2018 10:13:09 -0400
Message-Id: <20181025141423.213774-24-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>

[ Upstream commit a7595a820b07db9ac0d8f479ff62002bdd32a05a ]

Move NAPI enable to 'ath10k_ahb_hif_start' from
'ath10k_ahb_hif_power_up'. This is to maintain the symmetry
of calling napi_enable() from ath10k_ahb_hif_start() so that it
matches with  napi_disable() being called from ath10k_pci_hif_stop().

This change is based on the crash fix from Kalle for PCI interface in
commit 1427228d5869 ("ath10k: fix napi crash during rmmod when probe
firmware fails").

Signed-off-by: Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>
Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/ahb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/ahb.c b/drivers/net/wireless/ath/ath10k/ahb.c
index 45226dbee5ce..da770af83036 100644
--- a/drivers/net/wireless/ath/ath10k/ahb.c
+++ b/drivers/net/wireless/ath/ath10k/ahb.c
@@ -640,6 +640,7 @@ static int ath10k_ahb_hif_start(struct ath10k *ar)
 {
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot ahb hif start\n");
 
+	napi_enable(&ar->napi);
 	ath10k_ce_enable_interrupts(ar);
 	ath10k_pci_enable_legacy_irq(ar);
 
@@ -692,7 +693,6 @@ static int ath10k_ahb_hif_power_up(struct ath10k *ar)
 		ath10k_err(ar, "could not wake up target CPU: %d\n", ret);
 		goto err_ce_deinit;
 	}
-	napi_enable(&ar->napi);
 
 	return 0;
 
-- 
2.17.1

