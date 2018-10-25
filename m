Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64757C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217F420665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bikr/vE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217F420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbeJYWyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbeJYWyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:13 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8666520883;
        Thu, 25 Oct 2018 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477275;
        bh=GIFwBVWJNaKpyY3kEtFJCjc1BAMG1I5vvtVz/cmn+P4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bikr/vE3tOC4mYI09CMzAi+2kS5dqbBGccwf0kFDHViasdn65UyiDiv1V8mKz2zJY
         TAc7qJT2KcVYlTZ9gGRpRxJ6oDAyzGEzohpuyS6sdFOp2xX9hZOlymtfDLI+uHzLik
         29QpRFvaeHifptnBG4U/plD7UFaPgesRFZ/GRvJo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arik Nemtsov <arikx.nemtsov@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 91/98] iwlwifi: pcie: correctly define 7265-D cfg
Date:   Thu, 25 Oct 2018 10:18:46 -0400
Message-Id: <20181025141853.214051-91-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arik Nemtsov <arikx.nemtsov@intel.com>

[ Upstream commit 2b0e2b0f7bfe9a9098bda6109176adcf78f9b7ac ]

The trans cfg was not replaced for 7265-D cards. This led to a check of
the min-NVM version against a 7265-C card, causing very-old 7265-D cards
to operate incorrectly with the driver.

Fixes: 3fd0d3c170ad ("iwlwifi: pcie: support 7265-D devices")
Signed-off-by: Arik Nemtsov <arikx.nemtsov@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/iwlwifi/pcie/drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/iwlwifi/pcie/drv.c b/drivers/net/wireless/iwlwifi/pcie/drv.c
index 8407ce5f672f..4c7be34219d7 100644
--- a/drivers/net/wireless/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/iwlwifi/pcie/drv.c
@@ -533,8 +533,10 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	else if (cfg == &iwl7265_n_cfg)
 		cfg_7265d = &iwl7265d_n_cfg;
 	if (cfg_7265d &&
-	    (iwl_trans->hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D)
+	    (iwl_trans->hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D) {
 		cfg = cfg_7265d;
+		iwl_trans->cfg = cfg_7265d;
+	}
 #endif
 
 	pci_set_drvdata(pdev, iwl_trans);
-- 
2.17.1

