Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233D8C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14C320837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2Npj+8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E14C320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeKCD62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbeKCD61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:58:27 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C33C20847;
        Fri,  2 Nov 2018 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184613;
        bh=gYB7agTSZNPp3z84rrItLKI6MSHLBSxlK7KMygyMz0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2Npj+8p117xEGbtg70ZuLZI/qA+Iao0OS7YaphIX/TOKBA2ajE24+TEqSjwB+rCa
         tbTt8ChC8mgN/vnHXu8S9GN009mxNYjs3uQYFbjZzaStZPnCEONdx0IbixkQYNujCM
         4gGXuSY6RQZAMRN/uuS4GfSzMXXcyogMUtv+YUVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liad Kaufman <liad.kaufman@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 051/143] iwlwifi: dbg: allow wrt collection before ALIVE
Date:   Fri,  2 Nov 2018 19:33:56 +0100
Message-Id: <20181102182901.137629007@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



