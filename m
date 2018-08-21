Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739E1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A5D2170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 10:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A5D2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeHUNku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 09:40:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38933 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeHUNku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 09:40:50 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fs3mf-0003bE-En; Tue, 21 Aug 2018 10:21:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi: pcie: make array 'prop' static, shrinks object size
Date:   Tue, 21 Aug 2018 11:21:09 +0100
Message-Id: <20180821102109.1630-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array prop on the stack but instead make it static.
Makes the object code smaller by 30 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
  80138	  15382	    576	  96096	  17760	drivers/net/wireless/intel/iwlwifi/pcie/trans.o

After:
   text	   data	    bss	    dec	    hex	filename
  79948	  15542	    576	  96066	  17742	drivers/net/wireless/intel/iwlwifi/pcie/trans.o

(gcc version 8.2.0 x86_64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 7d319b6863fe..c7daf666ee21 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1947,7 +1947,7 @@ static void iwl_trans_pcie_removal_wk(struct work_struct *wk)
 	struct iwl_trans_pcie_removal *removal =
 		container_of(wk, struct iwl_trans_pcie_removal, work);
 	struct pci_dev *pdev = removal->pdev;
-	char *prop[] = {"EVENT=INACCESSIBLE", NULL};
+	static char *prop[] = {"EVENT=INACCESSIBLE", NULL};
 
 	dev_err(&pdev->dev, "Device gone - attempting removal\n");
 	kobject_uevent_env(&pdev->dev.kobj, KOBJ_CHANGE, prop);
-- 
2.17.1

