Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BD2C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6B8208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6B8208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934711AbeGFFwu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:52:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33988 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934657AbeGFFwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:52:46 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 345AA898;
        Fri,  6 Jul 2018 05:52:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hao Wei Tee <angelsl@in04.sg>,
        Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 51/61] iwlwifi: pcie: compare with number of IRQs requested for, not number of CPUs
Date:   Fri,  6 Jul 2018 07:47:15 +0200
Message-Id: <20180706054714.295152969@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hao Wei Tee <angelsl@in04.sg>

[ Upstream commit ab1068d6866e28bf6427ceaea681a381e5870a4a ]

When there are 16 or more logical CPUs, we request for
`IWL_MAX_RX_HW_QUEUES` (16) IRQs only as we limit to that number of
IRQs, but later on we compare the number of IRQs returned to
nr_online_cpus+2 instead of max_irqs, the latter being what we
actually asked for. This ends up setting num_rx_queues to 17 which
causes lots of out-of-bounds array accesses later on.

Compare to max_irqs instead, and also add an assertion in case
num_rx_queues > IWM_MAX_RX_HW_QUEUES.

This fixes https://bugzilla.kernel.org/show_bug.cgi?id=199551

Fixes: 2e5d4a8f61dc ("iwlwifi: pcie: Add new configuration to enable MSIX")
Signed-off-by: Hao Wei Tee <angelsl@in04.sg>
Tested-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1499,14 +1499,13 @@ static void iwl_pcie_set_interrupt_capa(
 					struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	int max_irqs, num_irqs, i, ret, nr_online_cpus;
+	int max_irqs, num_irqs, i, ret;
 	u16 pci_cmd;
 
 	if (!trans->cfg->mq_rx_supported)
 		goto enable_msi;
 
-	nr_online_cpus = num_online_cpus();
-	max_irqs = min_t(u32, nr_online_cpus + 2, IWL_MAX_RX_HW_QUEUES);
+	max_irqs = min_t(u32, num_online_cpus() + 2, IWL_MAX_RX_HW_QUEUES);
 	for (i = 0; i < max_irqs; i++)
 		trans_pcie->msix_entries[i].entry = i;
 
@@ -1532,16 +1531,17 @@ static void iwl_pcie_set_interrupt_capa(
 	 * Two interrupts less: non rx causes shared with FBQ and RSS.
 	 * More than two interrupts: we will use fewer RSS queues.
 	 */
-	if (num_irqs <= nr_online_cpus) {
+	if (num_irqs <= max_irqs - 2) {
 		trans_pcie->trans->num_rx_queues = num_irqs + 1;
 		trans_pcie->shared_vec_mask = IWL_SHARED_IRQ_NON_RX |
 			IWL_SHARED_IRQ_FIRST_RSS;
-	} else if (num_irqs == nr_online_cpus + 1) {
+	} else if (num_irqs == max_irqs - 1) {
 		trans_pcie->trans->num_rx_queues = num_irqs;
 		trans_pcie->shared_vec_mask = IWL_SHARED_IRQ_NON_RX;
 	} else {
 		trans_pcie->trans->num_rx_queues = num_irqs - 1;
 	}
+	WARN_ON(trans_pcie->trans->num_rx_queues > IWL_MAX_RX_HW_QUEUES);
 
 	trans_pcie->alloc_vecs = num_irqs;
 	trans_pcie->msix_enabled = true;


