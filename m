Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FE1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9747020852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9747020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755299AbeFRLI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:08:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:37633 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934643AbeFRLHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:07:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 04:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="233457948"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 18 Jun 2018 04:07:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9FABD519; Mon, 18 Jun 2018 14:07:31 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 3/5] thunderbolt: No need to take tb->lock in domain suspend/complete
Date:   Mon, 18 Jun 2018 14:07:29 +0300
Message-Id: <20180618110731.57427-4-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
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
2.17.1

