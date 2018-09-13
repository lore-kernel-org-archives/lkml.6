Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E02C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2908520C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2908520C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeIMQj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:39:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:45641 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbeIMQj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:39:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 04:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,368,1531810800"; 
   d="scan'208";a="88415838"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2018 04:30:34 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Evan Green <evgreen@chromium.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Janek Kotas <jank@cadence.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Li Wei <liwei213@huawei.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: [PATCH RFC] scsi: ufs: Disable blk-mq for now
Date:   Thu, 13 Sep 2018 14:28:48 +0300
Message-Id: <20180913112848.7807-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk-mq does not support runtime pm, so disable blk-mq support for now.

Fixes: d5038a13eca7 ("scsi: core: switch to scsi-mq by default")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/scsi/ufs/ufshcd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 40548bae8efa..a4d36497a047 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7975,6 +7975,13 @@ int ufshcd_alloc_host(struct device *dev, struct ufs_hba **hba_handle)
 		err = -ENOMEM;
 		goto out_error;
 	}
+
+	/*
+	 * Do not use blk-mq at this time because blk-mq does not support
+	 * runtime pm.
+	 */
+	host->use_blk_mq = false;
+
 	hba = shost_priv(host);
 	hba->host = host;
 	hba->dev = dev;
-- 
2.17.1

