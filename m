Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8E6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D674206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217870;
	bh=b+ha+dOpnQ1IN6Tsb2Jrr+wGN+7hPmOkgnOj1kRaw1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n3kovR0jWyF4T5grcOoOXDEwCAL/DYHBVAAyf0G3Yg5IB/X+vQiXjRe7sRnbsXyuY
	 c+BSwIOFo8vEHBT5RKohSJ+Qnx9G/GEdFNWQtKy394MALHjH3OdwFr5A8/lzT6GvZ5
	 2gG5NCIHBEDqZg+MTlkowfWOrHwUjQnbU9mw5ITQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391308AbfAKOo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:44:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404607AbfAKOoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:44:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82A320872;
        Fri, 11 Jan 2019 14:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217865;
        bh=b+ha+dOpnQ1IN6Tsb2Jrr+wGN+7hPmOkgnOj1kRaw1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrhivgbH2yzRfMehNhjmYkMKcW8aBDNtCVe8DAOsZ7RUt5LR8mm9EyaIUUsZcyTfy
         ZAAl+Axsap9V8xrKV/Xh/8bVS+q0mKzg6ShRSrv3K8qv+KULnLGD/Ru8Fp6az1mLfE
         4xPnkgLGnbXpuwQfmkSLHbPPZndt+8K0qB4JdsLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.20 37/65] PCI / PM: Allow runtime PM without callback functions
Date:   Fri, 11 Jan 2019 15:15:23 +0100
Message-Id: <20190111131101.734528578@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

commit c5eb1190074cfb14c5d9cac692f1912eecf1a5e4 upstream.

a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
nullified the runtime PM suspend/resume callback pointers while keeping the
runtime PM enabled.

This caused the SMBus PCI device to stay in D0 with
/sys/devices/.../power/runtime_status showing "error" when the runtime PM
framework attempted to autosuspend the device.  This is due to PCI bus
runtime PM, which checks for driver runtime PM callbacks and returns
-ENOSYS if they are not set.

Since i2c-i801.c doesn't need to do anything device-specific for runtime
PM, Jean Delvare proposed this be fixed in the PCI core rather than adding
dummy runtime PM callback functions in the PCI drivers.

Change pci_pm_runtime_suspend()/pci_pm_runtime_resume() so they allow
changing the PCI device power state during runtime PM transitions even if
the driver supplies no runtime PM callbacks.

This fixes the runtime PM regression on i2c-i801.c.

It is not obvious why the code previously required the runtime PM
callbacks.  The test has been there since the code was introduced by
6cbf82148ff2 ("PCI PM: Run-time callbacks for PCI bus type").

On the other hand, a similar change was done to generic runtime PM
callbacks in 05aa55dddb9e ("PM / Runtime: Lenient generic runtime pm
callbacks").

Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jean Delvare <jdelvare@suse.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: stable@vger.kernel.org	# v4.18+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci-driver.c |   27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1251,30 +1251,29 @@ static int pci_pm_runtime_suspend(struct
 		return 0;
 	}
 
-	if (!pm || !pm->runtime_suspend)
-		return -ENOSYS;
-
 	pci_dev->state_saved = false;
-	error = pm->runtime_suspend(dev);
-	if (error) {
+	if (pm && pm->runtime_suspend) {
+		error = pm->runtime_suspend(dev);
 		/*
 		 * -EBUSY and -EAGAIN is used to request the runtime PM core
 		 * to schedule a new suspend, so log the event only with debug
 		 * log level.
 		 */
-		if (error == -EBUSY || error == -EAGAIN)
+		if (error == -EBUSY || error == -EAGAIN) {
 			dev_dbg(dev, "can't suspend now (%pf returned %d)\n",
 				pm->runtime_suspend, error);
-		else
+			return error;
+		} else if (error) {
 			dev_err(dev, "can't suspend (%pf returned %d)\n",
 				pm->runtime_suspend, error);
-
-		return error;
+			return error;
+		}
 	}
 
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
-	if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
+	if (pm && pm->runtime_suspend
+	    && !pci_dev->state_saved && pci_dev->current_state != PCI_D0
 	    && pci_dev->current_state != PCI_UNKNOWN) {
 		WARN_ONCE(pci_dev->current_state != prev,
 			"PCI PM: State of device not saved by %pF\n",
@@ -1292,7 +1291,7 @@ static int pci_pm_runtime_suspend(struct
 
 static int pci_pm_runtime_resume(struct device *dev)
 {
-	int rc;
+	int rc = 0;
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
@@ -1306,14 +1305,12 @@ static int pci_pm_runtime_resume(struct
 	if (!pci_dev->driver)
 		return 0;
 
-	if (!pm || !pm->runtime_resume)
-		return -ENOSYS;
-
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 	pci_enable_wake(pci_dev, PCI_D0, false);
 	pci_fixup_device(pci_fixup_resume, pci_dev);
 
-	rc = pm->runtime_resume(dev);
+	if (pm && pm->runtime_resume)
+		rc = pm->runtime_resume(dev);
 
 	pci_dev->runtime_d3cold = false;
 


