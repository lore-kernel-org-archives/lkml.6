Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8269FC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E432086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E432086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935165AbeFROoI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:44:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:52544 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934109AbeFROoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:44:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 07:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,239,1526367600"; 
   d="scan'208";a="65517694"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 18 Jun 2018 07:44:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2AF6EFA; Mon, 18 Jun 2018 17:44:04 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] thunderbolt: Notify userspace when boot_acl is changed
Date:   Mon, 18 Jun 2018 17:44:04 +0300
Message-Id: <20180618144404.21055-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
introduced boot_acl attribute but missed the fact that now userspace
needs to poll the attribute constantly to find out whether it has
changed or not. Fix this by sending notification to the userspace
whenever the boot_acl attribute is changed.

Fixes: 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
Reported-by: Christian Kellner <ckellner@redhat.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/domain.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 6281266b8ec0..a923ebdeb73c 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -213,6 +213,10 @@ static ssize_t boot_acl_store(struct device *dev, struct device_attribute *attr,
 		goto err_free_acl;
 	}
 	ret = tb->cm_ops->set_boot_acl(tb, acl, tb->nboot_acl);
+	if (!ret) {
+		/* Notify userspace about the change */
+		kobject_uevent(&tb->dev.kobj, KOBJ_CHANGE);
+	}
 	mutex_unlock(&tb->lock);
 
 err_free_acl:
-- 
2.17.1

