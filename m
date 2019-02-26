Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C76BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31686217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfBZHc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:32:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:29683 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfBZHc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:32:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 23:32:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,414,1544515200"; 
   d="scan'208";a="127300126"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2019 23:32:27 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Cc:     somlo@cmu.edu, mst@redhat.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] fw_cfg: use __ATTR_RO_MODE to define rev sysfs
Date:   Tue, 26 Feb 2019 15:31:59 +0800
Message-Id: <20190226073159.13434-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leverage __ATTR_RO_MODE to define rev sysfs instead of using open code
to define the attribute.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 drivers/firmware/qemu_fw_cfg.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 039e0f91dba8..a1293cbd7adb 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -296,18 +296,13 @@ static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static ssize_t fw_cfg_showrev(struct kobject *k, struct attribute *a, char *buf)
+static ssize_t fw_cfg_rev_show(struct kobject *k, struct kobj_attribute *a,
+			       char *buf)
 {
 	return sprintf(buf, "%u\n", fw_cfg_rev);
 }
-
-static const struct {
-	struct attribute attr;
-	ssize_t (*show)(struct kobject *k, struct attribute *a, char *buf);
-} fw_cfg_rev_attr = {
-	.attr = { .name = "rev", .mode = S_IRUSR },
-	.show = fw_cfg_showrev,
-};
+static const struct kobj_attribute fw_cfg_rev_attr =
+	__ATTR_RO_MODE(fw_cfg_rev, 0400);
 
 /* fw_cfg_sysfs_entry type */
 struct fw_cfg_sysfs_entry {
-- 
2.19.1

