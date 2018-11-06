Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EABC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEE620862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCEE620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbeKGEFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:05:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:64582 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730477AbeKGEFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:05:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 10:39:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="278827956"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga006.fm.intel.com with ESMTP; 06 Nov 2018 10:39:14 -0800
Date:   Tue, 6 Nov 2018 10:39:15 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        qiuxu.zhuo@intel.com, linux-edac@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC, skx: Better fix for randconfig builds
Message-ID: <20181106183914.GA26731@agluck-desk>
References: <20181102153232.1450251-1-arnd@arndb.de>
 <20181102161013.GG14602@zn.tnic>
 <20181102173959.GA27709@agluck-desk>
 <20181102234255.GE26770@zn.tnic>
 <CAK8P3a2yE8FGvpN0P8hXnyCpS4h-ZOHeYhSCjE+Ov=7s1TB=5g@mail.gmail.com>
 <20181106143253.GH13712@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106143253.GH13712@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 03:32:53PM +0100, Borislav Petkov wrote:
> On Tue, Nov 06, 2018 at 02:44:42PM +0100, Arnd Bergmann wrote:
> > No, it was unintentional, the 'if ACPI' can be dropped when we add
> > 'depends on ACPI'.
> 
> So I have one fix already which takes care of non-sensical configs. If
> you or Tony wanna make it prettier, feel free to test it thoroughly and
> send me a patch ontop of
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=for-next
> 


It was previously noted that Kconfig complained about unmet
dependencies when trying to configure skx_edac together with
CONFIG_ACPI=n. First fix for this checked for ACPI when doing

	select ACPI_ADXL

but this required stub functions for the case where ACPI wasn't
selected. It also allowed building a driver that didn't actually
work for a system that has non-volatile DIMMs.

Arnd Bergmann pointed out that the right fix is to make EDAC_SKX
"depend on ACPI".

Fixes: a324e9396ca3 ("EDAC, skx: Fix randconfig builds")
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/Kconfig | 4 ++--
 include/linux/adxl.h | 5 -----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index ec2727b27556..e286b5b99003 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -231,10 +231,10 @@ config EDAC_SBRIDGE
 
 config EDAC_SKX
 	tristate "Intel Skylake server Integrated MC"
-	depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG
+	depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG && ACPI
 	depends on ACPI_NFIT || !ACPI_NFIT # if ACPI_NFIT=m, EDAC_SKX can't be y
 	select DMI
-	select ACPI_ADXL if ACPI
+	select ACPI_ADXL
 	help
 	  Support for error detection and correction the Intel
 	  Skylake server Integrated Memory Controllers. If your
diff --git a/include/linux/adxl.h b/include/linux/adxl.h
index 2d29f55923e3..2a629acb4c3f 100644
--- a/include/linux/adxl.h
+++ b/include/linux/adxl.h
@@ -7,12 +7,7 @@
 #ifndef _LINUX_ADXL_H
 #define _LINUX_ADXL_H
 
-#ifdef CONFIG_ACPI_ADXL
 const char * const *adxl_get_component_names(void);
 int adxl_decode(u64 addr, u64 component_values[]);
-#else
-static inline const char * const *adxl_get_component_names(void)  { return NULL; }
-static inline int adxl_decode(u64 addr, u64 component_values[])   { return  -EOPNOTSUPP; }
-#endif
 
 #endif /* _LINUX_ADXL_H */
-- 
2.19.1

