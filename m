Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BF16DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2B42086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 05:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2B42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754492AbeFMFvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 01:51:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:23228 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754447AbeFMFvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 01:51:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 22:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,217,1526367600"; 
   d="scan'208";a="236714707"
Received: from ubuntu-kabylake-client-platform.sh.intel.com ([10.239.154.51])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jun 2018 22:51:02 -0700
From:   Even Xu <even.xu@intel.com>
To:     srinivas.pandruvada@linux.intel.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Even Xu <even.xu@intel.com>, stable@vger.kernel.org
Subject: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to support hibernation
Date:   Fri, 12 Feb 2016 04:11:34 +0800
Message-Id: <1455221494-2915-1-git-send-email-even.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current ISH driver only registers suspend/resume PM callbacks which don't
support hibernation (suspend to disk). Basically after hiberation, the ISH
can't resume properly and user may not see sensor events
(for example: screen rotation may not work).

User will not see a crash or panic or anything except the following message
in log:
hid-sensor-hub 001F:8086:22D8.0001: timeout waiting for response from ISHTP device

So this patch adds support for S4/hiberbation to ISH by using the
SIMPLE_DEV_PM_OPS() MACRO instead of struct dev_pm_ops directly. The suspend
and resume functions will now be used for both suspend to RAM and hibernation.

If power management is disabled, SIMPLE_DEV_PM_OPS will do nothing, the suspend
and resume related functions won't be used, so mark them as __maybe_unused to
clarify that this is the intended behavior, and remove #ifdefs for power
management.

Cc: stable@vger.kernel.org
Signed-off-by: Even Xu <even.xu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 582e449..a2c53ea 100644
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
2.7.4

