Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B337C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD0320844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfBFNV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:21:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:26742 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730587AbfBFNRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 05:17:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="316787169"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 06 Feb 2019 05:17:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6886D806; Wed,  6 Feb 2019 15:17:39 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "David S . Miller" <davem@davemloft.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org
Subject: [PATCH v2 22/28] thunderbolt: Run tb_xdp_handle_request() in system workqueue
Date:   Wed,  6 Feb 2019 16:17:32 +0300
Message-Id: <20190206131738.43696-23-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We run all XDomain requests during discovery in tb->wq and since it only
runs one work at the time it means that sending back reply to the other
domain may be delayed too much depending whether there is an active
XDomain discovery request running.

To make sure we can send reply to the other domain as soon as possible
run tb_xdp_handle_request() in system workqueue instead. Since the
device can be hot-removed in the middle we need to make sure the domain
structure is still around when the function is run so increase reference
count before we schedule the reply work.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.h      | 7 +++++++
 drivers/thunderbolt/xdomain.c | 6 ++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index e06e5a944998..7e155eed1fee 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -410,6 +410,13 @@ int tb_domain_approve_xdomain_paths(struct tb *tb, struct tb_xdomain *xd);
 int tb_domain_disconnect_xdomain_paths(struct tb *tb, struct tb_xdomain *xd);
 int tb_domain_disconnect_all_paths(struct tb *tb);
 
+static inline struct tb *tb_domain_get(struct tb *tb)
+{
+	if (tb)
+		get_device(&tb->dev);
+	return tb;
+}
+
 static inline void tb_domain_put(struct tb *tb)
 {
 	put_device(&tb->dev);
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index e27dd8beb94b..59789bdd93ac 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -524,6 +524,8 @@ static void tb_xdp_handle_request(struct work_struct *work)
 out:
 	kfree(xw->pkg);
 	kfree(xw);
+
+	tb_domain_put(tb);
 }
 
 static void
@@ -538,9 +540,9 @@ tb_xdp_schedule_request(struct tb *tb, const struct tb_xdp_header *hdr,
 
 	INIT_WORK(&xw->work, tb_xdp_handle_request);
 	xw->pkg = kmemdup(hdr, size, GFP_KERNEL);
-	xw->tb = tb;
+	xw->tb = tb_domain_get(tb);
 
-	queue_work(tb->wq, &xw->work);
+	schedule_work(&xw->work);
 }
 
 /**
-- 
2.20.1

