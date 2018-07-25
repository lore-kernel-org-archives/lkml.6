Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8E3C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403162064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403162064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeGYJNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:13:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:10644 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbeGYJNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:13:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 01:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="248736882"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2018 01:03:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 64C551F2; Wed, 25 Jul 2018 11:03:22 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] thunderbolt: No need to take tb->lock in domain suspend/complete
Date:   Wed, 25 Jul 2018 11:03:18 +0300
Message-Id: <20180725080321.35746-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725080321.35746-1-mika.westerberg@linux.intel.com>
References: <20180725080321.35746-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the connection manager implementation needs to touch the domain
structures it ought to take the lock itself. Currently only ICM
implements these hooks and it does not need the lock because we there
will be no notifications before driver ready message is sent to it.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/domain.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 6281266b8ec0..b34e7f118fcf 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -505,26 +505,13 @@ int tb_domain_resume_noirq(struct tb *tb)
 
 int tb_domain_suspend(struct tb *tb)
 {
-	int ret;
-
-	mutex_lock(&tb->lock);
-	if (tb->cm_ops->suspend) {
-		ret = tb->cm_ops->suspend(tb);
-		if (ret) {
-			mutex_unlock(&tb->lock);
-			return ret;
-		}
-	}
-	mutex_unlock(&tb->lock);
-	return 0;
+	return tb->cm_ops->suspend ? tb->cm_ops->suspend(tb) : 0;
 }
 
 void tb_domain_complete(struct tb *tb)
 {
-	mutex_lock(&tb->lock);
 	if (tb->cm_ops->complete)
 		tb->cm_ops->complete(tb);
-	mutex_unlock(&tb->lock);
 }
 
 /**
-- 
2.18.0

