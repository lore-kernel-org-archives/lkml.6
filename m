Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E38C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824DA208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824DA208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeH0TXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:23:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:2557 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbeH0TXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:23:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 08:36:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,295,1531810800"; 
   d="scan'208";a="69476202"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 27 Aug 2018 08:35:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 79FFA67; Mon, 27 Aug 2018 18:35:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/7] extcon: Switch to use kasprintf() instead of open coded
Date:   Mon, 27 Aug 2018 18:35:52 +0300
Message-Id: <20180827153557.58363-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827153557.58363-1-andriy.shevchenko@linux.intel.com>
References: <20180827153557.58363-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use kasprintf() instead of open coded variant.
No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/extcon/extcon.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index c21650a92689..5ab0498be652 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -1123,7 +1123,6 @@ int extcon_dev_register(struct extcon_dev *edev)
 			(unsigned long)atomic_inc_return(&edev_no));
 
 	if (edev->max_supported) {
-		char buf[10];
 		char *str;
 		struct extcon_cable *cable;
 
@@ -1137,9 +1136,7 @@ int extcon_dev_register(struct extcon_dev *edev)
 		for (index = 0; index < edev->max_supported; index++) {
 			cable = &edev->cables[index];
 
-			snprintf(buf, 10, "cable.%d", index);
-			str = kzalloc(strlen(buf) + 1,
-				      GFP_KERNEL);
+			str = kasprintf(GFP_KERNEL, "cable.%d", index);
 			if (!str) {
 				for (index--; index >= 0; index--) {
 					cable = &edev->cables[index];
@@ -1149,7 +1146,6 @@ int extcon_dev_register(struct extcon_dev *edev)
 
 				goto err_alloc_cables;
 			}
-			strcpy(str, buf);
 
 			cable->edev = edev;
 			cable->cable_index = index;
@@ -1172,7 +1168,6 @@ int extcon_dev_register(struct extcon_dev *edev)
 	}
 
 	if (edev->max_supported && edev->mutually_exclusive) {
-		char buf[80];
 		char *name;
 
 		/* Count the size of mutually_exclusive array */
@@ -1197,9 +1192,8 @@ int extcon_dev_register(struct extcon_dev *edev)
 		}
 
 		for (index = 0; edev->mutually_exclusive[index]; index++) {
-			sprintf(buf, "0x%x", edev->mutually_exclusive[index]);
-			name = kzalloc(strlen(buf) + 1,
-				       GFP_KERNEL);
+			name = kasprintf(GFP_KERNEL, "0x%x",
+					 edev->mutually_exclusive[index]);
 			if (!name) {
 				for (index--; index >= 0; index--) {
 					kfree(edev->d_attrs_muex[index].attr.
@@ -1210,7 +1204,6 @@ int extcon_dev_register(struct extcon_dev *edev)
 				ret = -ENOMEM;
 				goto err_muex;
 			}
-			strcpy(name, buf);
 			sysfs_attr_init(&edev->d_attrs_muex[index].attr);
 			edev->d_attrs_muex[index].attr.name = name;
 			edev->d_attrs_muex[index].attr.mode = 0000;
-- 
2.18.0

