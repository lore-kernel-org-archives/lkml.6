Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KnTpIO3WHVuhWQAAmS7hNA
	; Mon, 11 Jun 2018 01:57:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 744C060792; Mon, 11 Jun 2018 01:57:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EDF22604D4;
	Mon, 11 Jun 2018 01:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EDF22604D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753872AbeFKB46 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 21:56:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:59111 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753689AbeFKB44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 21:56:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2018 18:56:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,499,1520924400";
   d="scan'208";a="62032644"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jun 2018 18:56:56 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Even Xu <even.xu@intel.com>
Subject: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to support hibernation
Date: Sun, 10 Jun 2018 18:56:50 -0700
Message-Id: <20180611015650.51385-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Even Xu <even.xu@intel.com>

Current ish driver only register resume/suspend PM callbacks which
don't support hibernation (suspend to disk). Now use the
SIMPLE_DEV_PM_OPS() MACRO instead of struct dev_pm_ops directly.
The suspend and resume functions will now be used for both suspend
to RAM and hibernation.

If power management is disable, SIMPLE_DEV_PM_OPS will do nothing,
the suspend and resume related functions won't be used, so mark them
as __maybe_unused to clarify that this is intended behavior, and
remove #ifdefs for power management.

Signed-off-by: Even Xu <even.xu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 582e449be9fe..a2c53ea3b5ed 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -205,8 +205,7 @@ static void ish_remove(struct pci_dev *pdev)
 	kfree(ishtp_dev);
 }
 
-#ifdef CONFIG_PM
-static struct device *ish_resume_device;
+static struct device __maybe_unused *ish_resume_device;
 
 /* 50ms to get resume response */
 #define WAIT_FOR_RESUME_ACK_MS		50
@@ -220,7 +219,7 @@ static struct device *ish_resume_device;
  * in that case a simple resume message is enough, others we need
  * a reset sequence.
  */
-static void ish_resume_handler(struct work_struct *work)
+static void __maybe_unused ish_resume_handler(struct work_struct *work)
 {
 	struct pci_dev *pdev = to_pci_dev(ish_resume_device);
 	struct ishtp_device *dev = pci_get_drvdata(pdev);
@@ -262,7 +261,7 @@ static void ish_resume_handler(struct work_struct *work)
  *
  * Return: 0 to the pm core
  */
-static int ish_suspend(struct device *device)
+static int __maybe_unused ish_suspend(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct ishtp_device *dev = pci_get_drvdata(pdev);
@@ -288,7 +287,7 @@ static int ish_suspend(struct device *device)
 	return 0;
 }
 
-static DECLARE_WORK(resume_work, ish_resume_handler);
+static __maybe_unused DECLARE_WORK(resume_work, ish_resume_handler);
 /**
  * ish_resume() - ISH resume callback
  * @device:	device pointer
@@ -297,7 +296,7 @@ static DECLARE_WORK(resume_work, ish_resume_handler);
  *
  * Return: 0 to the pm core
  */
-static int ish_resume(struct device *device)
+static int __maybe_unused ish_resume(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct ishtp_device *dev = pci_get_drvdata(pdev);
@@ -311,21 +310,14 @@ static int ish_resume(struct device *device)
 	return 0;
 }
 
-static const struct dev_pm_ops ish_pm_ops = {
-	.suspend = ish_suspend,
-	.resume = ish_resume,
-};
-#define ISHTP_ISH_PM_OPS	(&ish_pm_ops)
-#else
-#define ISHTP_ISH_PM_OPS	NULL
-#endif /* CONFIG_PM */
+static SIMPLE_DEV_PM_OPS(ish_pm_ops, ish_suspend, ish_resume);
 
 static struct pci_driver ish_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = ish_pci_tbl,
 	.probe = ish_probe,
 	.remove = ish_remove,
-	.driver.pm = ISHTP_ISH_PM_OPS,
+	.driver.pm = &ish_pm_ops,
 };
 
 module_pci_driver(ish_driver);
-- 
2.13.6
