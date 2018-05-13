Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeEMBCS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 21:02:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbeEMBCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 21:02:17 -0400
To: LKML <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Edac Mailing List <linux-edac@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] edac: fix skx_edac build error when ACPI_NFIT=m
Message-ID: <2a09f7f3-c129-d4c4-76cc-223550601bdb@infradead.org>
Date: Sat, 12 May 2018 18:02:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Prevent build error when CONFIG_ACPI_NFIT=m and CONFIG_EDAC_SKX=y
by limiting EDAC_SKX based on how ACPI_NFIT is set.

Fixes this build error:
drivers/edac/skx_edac.o: In function `get_nvdimm_info':
../drivers/edac/skx_edac.c:399: undefined reference to `nfit_get_smbios_id'

Fixes: 58ca9ac1463d ("EDAC, skx_edac: Detect non-volatile DIMMs")

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/edac/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- lnx-417-rc4.orig/drivers/edac/Kconfig
+++ lnx-417-rc4/drivers/edac/Kconfig
@@ -232,6 +232,7 @@ config EDAC_SBRIDGE
 config EDAC_SKX
 	tristate "Intel Skylake server Integrated MC"
 	depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG
+	depends on ACPI_NFIT || !ACPI_NFIT
 	select DMI
 	help
 	  Support for error detection and correction the Intel
