Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62348C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2355525040
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2355525040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932151AbeFXPjR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:39:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755183AbeFXPjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:39:15 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CB6592C;
        Sun, 24 Jun 2018 15:39:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Even Xu <even.xu@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.16 60/64] HID: intel_ish-hid: ipc: register more pm callbacks to support hibernation
Date:   Sun, 24 Jun 2018 23:22:41 +0800
Message-Id: <20180624142747.358813738@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Even Xu <even.xu@intel.com>

commit ebeaa367548e9e92dd9374b9464ff6e7d157117b upstream.

Current ISH driver only registers suspend/resume PM callbacks which don't
support hibernation (suspend to disk). Basically after hiberation, the ISH
can't resume properly and user may not see sensor events (for example: screen
		rotation may not work).

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
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c |   22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -205,8 +205,7 @@ static void ish_remove(struct pci_dev *p
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
@@ -262,7 +261,7 @@ static void ish_resume_handler(struct wo
  *
  * Return: 0 to the pm core
  */
-static int ish_suspend(struct device *device)
+static int __maybe_unused ish_suspend(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct ishtp_device *dev = pci_get_drvdata(pdev);
@@ -288,7 +287,7 @@ static int ish_suspend(struct device *de
 	return 0;
 }
 
-static DECLARE_WORK(resume_work, ish_resume_handler);
+static __maybe_unused DECLARE_WORK(resume_work, ish_resume_handler);
 /**
  * ish_resume() - ISH resume callback
  * @device:	device pointer
@@ -297,7 +296,7 @@ static DECLARE_WORK(resume_work, ish_res
  *
  * Return: 0 to the pm core
  */
-static int ish_resume(struct device *device)
+static int __maybe_unused ish_resume(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct ishtp_device *dev = pci_get_drvdata(pdev);
@@ -311,21 +310,14 @@ static int ish_resume(struct device *dev
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


