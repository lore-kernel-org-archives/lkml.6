Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9C4C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5FE25326
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5FE25326
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031423AbeGAQh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:37:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36218 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031397AbeGAQhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:37:16 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F114892B;
        Sun,  1 Jul 2018 16:37:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.17 019/220] PCI / PM: Do not clear state_saved for devices that remain suspended
Date:   Sun,  1 Jul 2018 18:20:43 +0200
Message-Id: <20180701160909.148373756@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 656088aa9b513907833ba091d0dcde87571fe05b upstream.

The state_saved flag should not be cleared in pci_pm_suspend() if the
given device is going to remain suspended, or the device's config
space will not be restored properly during the subsequent resume.

Namely, if the device is going to stay in suspend, both the late
and noirq callbacks return early for it, so if its state_saved flag
is cleared in pci_pm_suspend(), it will remain unset throughout the
remaining part of suspend and resume and pci_restore_state() called
for the device going forward will return without doing anything.

For this reason, change pci_pm_suspend() to only clear state_saved
if the given device is not going to remain suspended.  [This is
analogous to what commit ae860a19f37c (PCI / PM: Do not clear
state_saved in pci_pm_freeze() when smart suspend is set) did for
hibernation.]

Fixes: c4b65157aeef (PCI / PM: Take SMART_SUSPEND driver flag into account)
Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci-driver.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -753,10 +753,11 @@ static int pci_pm_suspend(struct device
 	 * better to resume the device from runtime suspend here.
 	 */
 	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
-	    !pci_dev_keep_suspended(pci_dev))
+	    !pci_dev_keep_suspended(pci_dev)) {
 		pm_runtime_resume(dev);
+		pci_dev->state_saved = false;
+	}
 
-	pci_dev->state_saved = false;
 	if (pm->suspend) {
 		pci_power_t prev = pci_dev->current_state;
 		int error;


