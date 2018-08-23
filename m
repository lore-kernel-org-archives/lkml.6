Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C60C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A317B206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A317B206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388939AbeHWMjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:39:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56582 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbeHWMjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:39:00 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2B3AECAA;
        Thu, 23 Aug 2018 09:10:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, teika kazura <teika@gmx.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.17 317/324] PCI / ACPI / PM: Resume all bridges on suspend-to-RAM
Date:   Thu, 23 Aug 2018 09:56:23 +0200
Message-Id: <20180823075011.956610797@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
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

commit 9d64b539b738fc181442caab95f1f76d9bd58539 upstream.

Commit 26112ddc254c (PCI / ACPI / PM: Resume bridges w/o drivers on
suspend-to-RAM) attempted to fix a functional regression resulting
from commit c62ec4610c40 (PM / core: Fix direct_complete handling
for devices with no callbacks) by resuming PCI bridges without
drivers (that is, "parallel PCI" ones) during system-wide suspend if
the target system state is not ACPI S0 (working state).

That turns out insufficient, however, as it is reported that, at
least in one case, the platform firmware gets confused if a PCIe
root port is suspended before entering the ACPI S3 sleep state.
That issue was exposed by commit 77b3729ca03 (PCI / PM: Use
SMART_SUSPEND and LEAVE_SUSPENDED flags for PCIe ports) that allowed
PCIe ports to stay in runtime suspend during system-wide suspend
(which is OK for suspend-to-idle, but turns out to be problematic
otherwise).

For this reason, drop the driver check from acpi_pci_need_resume()
and resume all bridges (including PCIe ports with drivers) during
system-wide suspend if the target system state is not ACPI S0.

[If the target system state is ACPI S0, it means suspend-to-idle
 and the platform firmware is not going to be invoked to actually
 suspend the system, so there is no need to resume the bridges in
 that case.]

Fixes: 77b3729ca03 (PCI / PM: Use SMART_SUSPEND and LEAVE_SUSPENDED flags for PCIe ports)
Link: https://bugzilla.kernel.org/show_bug.cgi?id=200675
Reported-by: teika kazura <teika@gmx.com>
Tested-by: teika kazura <teika@gmx.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: 4.16+ <stable@vger.kernel.org> # 4.16+: 26112ddc254c (PCI / ACPI / PM: Resume bridges ...)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci-acpi.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -601,13 +601,11 @@ static bool acpi_pci_need_resume(struct
 	/*
 	 * In some cases (eg. Samsung 305V4A) leaving a bridge in suspend over
 	 * system-wide suspend/resume confuses the platform firmware, so avoid
-	 * doing that, unless the bridge has a driver that should take care of
-	 * the PM handling.  According to Section 16.1.6 of ACPI 6.2, endpoint
+	 * doing that.  According to Section 16.1.6 of ACPI 6.2, endpoint
 	 * devices are expected to be in D3 before invoking the S3 entry path
 	 * from the firmware, so they should not be affected by this issue.
 	 */
-	if (pci_is_bridge(dev) && !dev->driver &&
-	    acpi_target_system_state() != ACPI_STATE_S0)
+	if (pci_is_bridge(dev) && acpi_target_system_state() != ACPI_STATE_S0)
 		return true;
 
 	if (!adev || !acpi_device_power_manageable(adev))


