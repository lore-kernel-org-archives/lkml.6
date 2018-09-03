Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981AFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5833020867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5833020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeICRkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:40:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:6971 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeICRkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:40:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 06:20:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,325,1531810800"; 
   d="scan'208";a="259449140"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2018 06:20:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 77B7FBB; Mon,  3 Sep 2018 16:20:12 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/2] thunderbolt: Initialize after IOMMUs
Date:   Mon,  3 Sep 2018 16:20:12 +0300
Message-Id: <20180903132012.23531-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903132012.23531-1-mika.westerberg@linux.intel.com>
References: <20180903132012.23531-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IOMMU is enabled and Thunderbolt driver is built into the kernel
image, it will be probed before IOMMUs are attached to the PCI bus.
Because of this DMA mappings the driver does will not go through IOMMU
and start failing right after IOMMUs are enabled.

For this reason move the Thunderbolt driver initialization happen at
rootfs level.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/nhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 88cff05a1808..5cd6bdfa068f 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1191,5 +1191,5 @@ static void __exit nhi_unload(void)
 	tb_domain_exit();
 }
 
-fs_initcall(nhi_init);
+rootfs_initcall(nhi_init);
 module_exit(nhi_unload);
-- 
2.18.0

