Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95FFC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75667208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75667208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389608AbeGJSfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:35:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388472AbeGJSfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:35:39 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 597DBE78;
        Tue, 10 Jul 2018 18:35:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, n0000b.n000b@gmail.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.17 04/56] PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM
Date:   Tue, 10 Jul 2018 20:24:46 +0200
Message-Id: <20180710182503.722062027@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182503.544433950@linuxfoundation.org>
References: <20180710182503.544433950@linuxfoundation.org>
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

commit 26112ddc254c98681b224aa9ededefc01b6e02d2 upstream.

It is reported that commit c62ec4610c40 (PM / core: Fix direct_complete
handling for devices with no callbacks) introduced a system suspend
regression on Samsung 305V4A by allowing a PCI bridge (not a PCIe
port) to stay in D3 over suspend-to-RAM, which is a side effect of
setting power.direct_complete for the children of that bridge that
have no PM callbacks.

On the majority of systems PCI bridges are not allowed to be
runtime-suspended (the power/control sysfs attribute is set to "on"
for them by default), but user space can change that setting and if
it does so and a given bridge has no children with PM callbacks, the
direct_complete optimization will be applied to it and it will stay
in suspend over system suspend.  Apparently, that confuses the
platform firmware on the affected machine and that may very well
happen elsewhere, so avoid the direct_complete optimization for
PCI bridges with no drivers (if there is a driver, it should take
care of the PM handling) on suspend-to-RAM altogether (that should
not matter for suspend-to-idle as platform firmware is not involved
in it).

Fixes: c62ec4610c40 (PM / core: Fix direct_complete handling for devices with no callbacks)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=199941
Reported-by: n0000b.n000b@gmail.com
Tested-by: n0000b.n000b@gmail.com
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci-acpi.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -598,6 +598,18 @@ static bool acpi_pci_need_resume(struct
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
 
+	/*
+	 * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend over
+	 * system-wide suspend/resume confuses the platform firmware, so avoid
+	 * doing that, unless the bridge has a driver that should take care of
+	 * the PM handling.  According to Section 16.1.6 of ACPI 6.2, endpoint
+	 * devices are expected to be in D3 before invoking the S3 entry path
+	 * from the firmware, so they should not be affected by this issue.
+	 */
+	if (pci_is_bridge(dev) && !dev->driver &&
+	    acpi_target_system_state() != ACPI_STATE_S0)
+		return true;
+
 	if (!adev || !acpi_device_power_manageable(adev))
 		return false;
 


