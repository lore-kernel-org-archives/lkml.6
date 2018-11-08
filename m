Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D5DECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4F320892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AB/KWq1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4F320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeKIHeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbeKIHeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:19 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE8A420892;
        Thu,  8 Nov 2018 21:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714212;
        bh=gio5bY3jcVUwYv2xl6Bl8Pity5JJANLqTPvxJBekw9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AB/KWq1aOqDtj9MM7VJfr26h15ZEGgXJlsdgQUlksrC429Ek/5AWkU9rvkUkxBMvQ
         5wZW0IXgK1TYQ7V/2PUPJ0JK3w50nysus4lZoJtbOz61Z9NTnicPVDLeU72cnln5+V
         r5YD5V1OUg10Ux4jlp8nxzAlX5t0Xzmw7L2gQK10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arik Nemtsov <arikx.nemtsov@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 119/144] iwlwifi: pcie: correctly define 7265-D cfg
Date:   Thu,  8 Nov 2018 13:51:30 -0800
Message-Id: <20181108215106.629958962@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



