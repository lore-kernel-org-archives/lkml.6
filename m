Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3810C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5432084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHAokU4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5432084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJYWny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727699AbeJYWnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:43:53 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76C3F20834;
        Thu, 25 Oct 2018 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476658;
        bh=r0K3yHq+ZRm6DwY7LPP3K3WxyBUiTgutfizntv/k8WU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mHAokU4+DoopFTArWlek3mstbpOMkMPlvm0mlfSjGxmgPYnyAMBy+FIe+fsPNrTsv
         UYm3V/IhReLeer0ykKPtRLon08vttYfUn/VFeVJYr0Y0cQfFaqZHhQ/H3mkcyUpIS7
         BzWenjHwE7pRzGHtQfiP8KisITRW1lNTvPC4tOjk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Liad Kaufman <liad.kaufman@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 02/46] iwlwifi: dbg: allow wrt collection before ALIVE
Date:   Thu, 25 Oct 2018 10:10:09 -0400
Message-Id: <20181025141053.213330-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liad Kaufman <liad.kaufman@intel.com>

[ Upstream commit dfd4b08cf44f27587e2053e006e43a1603328006 ]

Even if no ALIVE was received, the WRT data can still
be collected. Add this.

Signed-off-by: Liad Kaufman <liad.kaufman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 2fa7ec466275..839010417241 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -950,7 +950,20 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	if (trigger)
 		delay = msecs_to_jiffies(le32_to_cpu(trigger->stop_delay));
 
-	if (WARN(fwrt->trans->state == IWL_TRANS_NO_FW,
+	/*
+	 * If the loading of the FW completed successfully, the next step is to
+	 * get the SMEM config data. Thus, if fwrt->smem_cfg.num_lmacs is non
+	 * zero, the FW was already loaded successully. If the state is "NO_FW"
+	 * in such a case - WARN and exit, since FW may be dead. Otherwise, we
+	 * can try to collect the data, since FW might just not be fully
+	 * loaded (no "ALIVE" yet), and the debug data is accessible.
+	 *
+	 * Corner case: got the FW alive but crashed before getting the SMEM
+	 *	config. In such a case, due to HW access problems, we might
+	 *	collect garbage.
+	 */
+	if (WARN((fwrt->trans->state == IWL_TRANS_NO_FW) &&
+		 fwrt->smem_cfg.num_lmacs,
 		 "Can't collect dbg data when FW isn't alive\n"))
 		return -EIO;
 
-- 
2.17.1

