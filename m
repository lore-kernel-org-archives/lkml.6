Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C132CECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CD9214F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vletjZDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CD9214F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbeJYWyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731391AbeJYWyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:16 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F71A20870;
        Thu, 25 Oct 2018 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477278;
        bh=MPWFi560yOeX4JgVSuJpYQypv0uTb7WtGvIpj3T+jTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vletjZDkq65gOUqI9IM6SX4Ogvzh5/yh20E+cp0P2PnVB2djR1R8vq/dThDckv04S
         nP8puJ5oJ99dtGFsVfO4dlfzVg8AtDDDH8eKJMGmyVWbO+IuEad1UB1RqBHSHAQsAk
         sLxvrpt7ccYEr/N6TdrG3ozodQjweZV5i0ak+c/c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jan Beulich <JBeulich@suse.com>, Jan Beulich <jbeulich@suse.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 93/98] igb: fix NULL derefs due to skipped SR-IOV enabling
Date:   Thu, 25 Oct 2018 10:18:48 -0400
Message-Id: <20181025141853.214051-93-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Beulich <JBeulich@suse.com>

[ Upstream commit be06998f96ecb93938ad2cce46c4289bf7cf45bc ]

The combined effect of commits 6423fc3416 ("igb: do not re-init SR-IOV
during probe") and ceee3450b3 ("igb: make sure SR-IOV init uses the
right number of queues") causes VFs no longer getting set up, leading
to NULL pointer dereferences due to the adapter's ->vf_data being NULL
while ->vfs_allocated_count is non-zero. The first commit not only
neglected the side effect of igb_sriov_reinit() that the second commit
tried to account for, but also that of setting IGB_FLAG_HAS_MSIX,
without which igb_enable_sriov() is effectively a no-op. Calling
igb_{,re}set_interrupt_capability() as done here seems to address this,
but I'm not sure whether this is better than sinply reverting the other
two commits.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 84049078c4f0..b73c896ed184 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2866,6 +2866,13 @@ static void igb_probe_vfs(struct igb_adapter *adapter)
 	if ((hw->mac.type == e1000_i210) || (hw->mac.type == e1000_i211))
 		return;
 
+	/* Of the below we really only want the effect of getting
+	 * IGB_FLAG_HAS_MSIX set (if available), without which
+	 * igb_enable_sriov() has no effect.
+	 */
+	igb_set_interrupt_capability(adapter, true);
+	igb_reset_interrupt_capability(adapter);
+
 	pci_sriov_set_totalvfs(pdev, 7);
 	igb_enable_sriov(pdev, max_vfs);
 
-- 
2.17.1

