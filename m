Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D3CECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3CB120892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7JxMDOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CB120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbeKIHlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:41:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:33428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbeKIHlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:41:46 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B14420844;
        Thu,  8 Nov 2018 22:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714656;
        bh=yY/ueFuPDBNJhim7+la0mG/TVhw6cmfIL098JDX/t9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7JxMDOp7FLDUfS5FBWB0OR4NXExL7yQU89WDXEOwLSUc1jLFmU2e2oiJyO96gbUc
         SMi1Yi1p1iZ9MuBzZFDENDKWo2WyZHJ9DTC2Hb1WI3IzIXvIgov2r3Dp5KAnTo/W7i
         bmly3Myu4oFWRzqtCCB+4eI1Kv0gyFHKOANt9CDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 055/171] ath10k: fix NAPI enable/disable symmetry for AHB interface
Date:   Thu,  8 Nov 2018 13:50:25 -0800
Message-Id: <20181108215131.477232231@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



