Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CE7C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DB5254BB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DB5254BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbeGAQ7Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:59:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032444AbeGAQoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:44:03 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C3138A73;
        Sun,  1 Jul 2018 16:44:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.17 164/220] mfd: intel-lpss: Fix Intel Cannon Lake LPSS I2C input clock
Date:   Sun,  1 Jul 2018 18:23:08 +0200
Message-Id: <20180701160915.121429398@linuxfoundation.org>
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

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

commit 4e93a658576ab115977225c9d0992b97ff19ba8c upstream.

Intel Cannon Lake PCH has much higher 216 MHz input clock to LPSS I2C
than Sunrisepoint which uses 120 MHz. Preliminary information was that
both share the same clock rate but actual silicon implements elevated
rate for better support for 3.4 MHz high-speed I2C.

This incorrect input clock rate results too high I2C bus clock in case
ACPI doesn't provide tuned I2C timing parameters since I2C host
controller driver calculates them from input clock rate.

Fix this by using the correct rate. We still share the same 230 ns SDA
hold time value than Sunrisepoint.

Cc: stable@vger.kernel.org
Fixes: b418bbff36dd ("mfd: intel-lpss: Add Intel Cannonlake PCI IDs")
Reported-by: Jian-Hong Pan <jian-hong@endlessm.com>
Reported-by: Chris Chiu <chiu@endlessm.com>
Reported-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mfd/intel-lpss-pci.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -124,6 +124,11 @@ static const struct intel_lpss_platform_
 	.properties = apl_i2c_properties,
 };
 
+static const struct intel_lpss_platform_info cnl_i2c_info = {
+	.clk_rate = 216000000,
+	.properties = spt_i2c_properties,
+};
+
 static const struct pci_device_id intel_lpss_pci_ids[] = {
 	/* BXT A-Step */
 	{ PCI_VDEVICE(INTEL, 0x0aac), (kernel_ulong_t)&bxt_i2c_info },
@@ -207,13 +212,13 @@ static const struct pci_device_id intel_
 	{ PCI_VDEVICE(INTEL, 0x9daa), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0x9dab), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0x9dfb), (kernel_ulong_t)&spt_info },
-	{ PCI_VDEVICE(INTEL, 0x9dc5), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x9dc6), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9dc5), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9dc6), (kernel_ulong_t)&cnl_i2c_info },
 	{ PCI_VDEVICE(INTEL, 0x9dc7), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0x9de8), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x9de9), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x9dea), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0x9deb), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9de8), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9de9), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9dea), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x9deb), (kernel_ulong_t)&cnl_i2c_info },
 	/* SPT-H */
 	{ PCI_VDEVICE(INTEL, 0xa127), (kernel_ulong_t)&spt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0xa128), (kernel_ulong_t)&spt_uart_info },
@@ -240,10 +245,10 @@ static const struct pci_device_id intel_
 	{ PCI_VDEVICE(INTEL, 0xa32b), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0xa37b), (kernel_ulong_t)&spt_info },
 	{ PCI_VDEVICE(INTEL, 0xa347), (kernel_ulong_t)&spt_uart_info },
-	{ PCI_VDEVICE(INTEL, 0xa368), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0xa369), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0xa36a), (kernel_ulong_t)&spt_i2c_info },
-	{ PCI_VDEVICE(INTEL, 0xa36b), (kernel_ulong_t)&spt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa368), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa369), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa36a), (kernel_ulong_t)&cnl_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0xa36b), (kernel_ulong_t)&cnl_i2c_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, intel_lpss_pci_ids);


