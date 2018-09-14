Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E30FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E04B20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E04B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeINRuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:50:50 -0400
Received: from [101.8.162.226] ([101.8.162.226]:15824 "EHLO
        E6440.gar.corp.intel.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727803AbeINRuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:50:50 -0400
X-Greylist: delayed 4042 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Sep 2018 13:50:50 EDT
Received: from E6440.gar.corp.intel.com (localhost [127.0.0.1])
        by E6440.gar.corp.intel.com (Postfix) with ESMTP id 1F031C23C1;
        Fri, 14 Sep 2018 16:58:19 +0800 (CST)
From:   Harry Pan <harry.pan@intel.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     gs0622@gmail.com, jongpil19.jung@samsung.com, rajatja@chromium.org,
        Harry Pan <harry.pan@intel.com>, gregkh@linuxfoundation.org,
        kai.heng.feng@canonical.com, stern@rowland.harvard.edu,
        felipe.balbi@linux.intel.com, snecknico@gmail.com,
        jackstocker.93@gmail.com, oneukum@suse.com,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: core: safely deal with the dynamic quirk lists
Date:   Fri, 14 Sep 2018 16:58:16 +0800
Message-Id: <20180914085816.10888-1-harry.pan@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applying dynamic usbcore quirks in early booting when the slab is
not yet ready would cause kernel panic of null pointer dereference
because the quirk_count has been counted as 1 while the quirk_list
was failed to allocate.

i.e.,
[    1.044970] BUG: unable to handle kernel NULL pointer dereference at           (null)
[    1.044995] IP: [<ffffffffb0953ec7>] usb_detect_quirks+0x88/0xd1
[    1.045016] PGD 0
[    1.045026] Oops: 0000 [#1] PREEMPT SMP
[    1.046986] gsmi: Log Shutdown Reason 0x03
[    1.046995] Modules linked in:
[    1.047008] CPU: 0 PID: 81 Comm: kworker/0:3 Not tainted 4.4.154 #28
[    1.047016] Hardware name: Google Coral/Coral, BIOS Google_Coral.10068.27.0 12/04/2017
[    1.047028] Workqueue: usb_hub_wq hub_event
[    1.047037] task: ffff88017a321c80 task.stack: ffff88017a384000
[    1.047044] RIP: 0010:[<ffffffffb0953ec7>]  [<ffffffffb0953ec7>] usb_detect_quirks+0x88/0xd1

To tackle this odd, let's balance the quirk_count to 0 when the kcalloc
call fails, and defer the quirk setting into a lower level callback
which ensures that the kernel memory management has been initialized.

Fixes: 027bd6cafd9a ("usb: core: Add "quirks" parameter for usbcore")

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 drivers/usb/core/quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 097057d2eacf..1fe9843fb9c8 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -58,6 +58,7 @@ static int quirks_param_set(const char *val, const struct kernel_param *kp)
 	quirk_list = kcalloc(quirk_count, sizeof(struct quirk_entry),
 			     GFP_KERNEL);
 	if (!quirk_list) {
+		quirk_count = 0;
 		mutex_unlock(&quirk_mutex);
 		return -ENOMEM;
 	}
@@ -154,7 +155,7 @@ static struct kparam_string quirks_param_string = {
 	.string = quirks_param,
 };
 
-module_param_cb(quirks, &quirks_param_ops, &quirks_param_string, 0644);
+device_param_cb(quirks, &quirks_param_ops, &quirks_param_string, 0644);
 MODULE_PARM_DESC(quirks, "Add/modify USB quirks by specifying quirks=vendorID:productID:quirks");
 
 /* Lists of quirky USB devices, split in device quirks and interface quirks.
-- 
2.16.4

