Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D5DECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06072214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06072214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbeIREln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:41:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50688 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbeIREln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:41:43 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 37FF3707;
        Mon, 17 Sep 2018 23:12:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 075/158] iwlwifi: pcie: dont access periphery registers when not available
Date:   Tue, 18 Sep 2018 00:41:45 +0200
Message-Id: <20180917211714.734842045@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit f98ad635c097c29339b7a7d6947173000485893d ]

The periphery can't be accessed before we set the
INIT_DONE bit which initializes the device.

A previous patch added a reconfiguration of the MSI-X
tables upon resume, but at that point in the flow,
INIT_DONE wasn't set. Since the reconfiguration of the
MSI-X tables require periphery access, it failed.

The difference between WoWLAN and without WoWLAN is that
in WoWLAN, iwl_trans_pcie_d3_suspend clears the INIT_DONE
without clearing the STATUS_DEVICE_ENABLED bit in the
software status. Because of that, the resume code thinks
that the device is enabled, but the INIT_DONE bit has been
cleared.

To fix this, don't reconfigure the MSI-X tables in case
WoWLAN is enabled. It will be done in
iwl_trans_pcie_d3_resume anyway.

Fixes: 52848a79b9d2 ("iwlwifi: pcie: reconfigure MSI-X HW on resume")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |    4 ++++
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c |   24 ++++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1003,6 +1003,10 @@ static int iwl_pci_resume(struct device
 	if (!trans->op_mode)
 		return 0;
 
+	/* In WOWLAN, let iwl_trans_pcie_d3_resume do the rest of the work */
+	if (test_bit(STATUS_DEVICE_ENABLED, &trans->status))
+		return 0;
+
 	/* reconfigure the MSI-X mapping to get the correct IRQ for rfkill */
 	iwl_pcie_conf_msix_hw(trans_pcie);
 
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1539,18 +1539,6 @@ static int iwl_trans_pcie_d3_resume(stru
 
 	iwl_pcie_enable_rx_wake(trans, true);
 
-	/*
-	 * Reconfigure IVAR table in case of MSIX or reset ict table in
-	 * MSI mode since HW reset erased it.
-	 * Also enables interrupts - none will happen as
-	 * the device doesn't know we're waking it up, only when
-	 * the opmode actually tells it after this call.
-	 */
-	iwl_pcie_conf_msix_hw(trans_pcie);
-	if (!trans_pcie->msix_enabled)
-		iwl_pcie_reset_ict(trans);
-	iwl_enable_interrupts(trans);
-
 	iwl_set_bit(trans, CSR_GP_CNTRL,
 		    BIT(trans->cfg->csr->flag_mac_access_req));
 	iwl_set_bit(trans, CSR_GP_CNTRL,
@@ -1568,6 +1556,18 @@ static int iwl_trans_pcie_d3_resume(stru
 		return ret;
 	}
 
+	/*
+	 * Reconfigure IVAR table in case of MSIX or reset ict table in
+	 * MSI mode since HW reset erased it.
+	 * Also enables interrupts - none will happen as
+	 * the device doesn't know we're waking it up, only when
+	 * the opmode actually tells it after this call.
+	 */
+	iwl_pcie_conf_msix_hw(trans_pcie);
+	if (!trans_pcie->msix_enabled)
+		iwl_pcie_reset_ict(trans);
+	iwl_enable_interrupts(trans);
+
 	iwl_pcie_set_pwr(trans, false);
 
 	if (!reset) {


