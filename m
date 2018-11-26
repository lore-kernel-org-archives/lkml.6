Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565DFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DD72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DD72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeKZTDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:03:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:63598 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbeKZTDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:03:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 00:10:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,281,1539673200"; 
   d="scan'208";a="284169703"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by fmsmga006.fm.intel.com with ESMTP; 26 Nov 2018 00:10:31 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Avri Altman <Avri.Altman@wdc.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH] scsi: ufs: add fall through annotation
Date:   Mon, 26 Nov 2018 10:10:34 +0200
Message-Id: <20181126081034.30185-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add /* fallthrough */ annotation, to eliminate compilation warning:
warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/scsi/ufs/ufshcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3807efd895be..b15f5dab0618 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1549,6 +1549,7 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 		 * currently running. Hence, fall through to cancel gating
 		 * work and to enable clocks.
 		 */
+		/* fallthrough */
 	case CLKS_OFF:
 		ufshcd_scsi_block_requests(hba);
 		hba->clk_gating.state = REQ_CLKS_ON;
@@ -1560,6 +1561,7 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
 		 * fall through to check if we should wait for this
 		 * work to be done or not.
 		 */
+		/* fallthrough */
 	case REQ_CLKS_ON:
 		if (async) {
 			rc = -EAGAIN;
@@ -4618,6 +4620,7 @@ ufshcd_scsi_cmd_status(struct ufshcd_lrb *lrbp, int scsi_status)
 	switch (scsi_status) {
 	case SAM_STAT_CHECK_CONDITION:
 		ufshcd_copy_sense_data(lrbp);
+		/* fallthrough */
 	case SAM_STAT_GOOD:
 		result |= DID_OK << 16 |
 			  COMMAND_COMPLETE << 8 |
-- 
2.17.2

