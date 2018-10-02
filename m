Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078D2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93B021473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93B021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeJBIK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 04:10:29 -0400
Received: from relay1.sgi.com ([192.48.180.66]:47038 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbeJBIK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 04:10:28 -0400
Received: from stormcage.americas.sgi.com (stormcage.americas.sgi.com [128.162.236.70])
        by relay1.corp.sgi.com (Postfix) with ESMTP id 8C3AF8F8039;
        Mon,  1 Oct 2018 18:19:30 -0700 (PDT)
Received: by stormcage.americas.sgi.com (Postfix, from userid 5508)
        id A4D34201E76F7; Mon,  1 Oct 2018 20:22:04 -0500 (CDT)
Message-Id: <20181002012204.568382740@stormcage.americas.sgi.com>
References: <20181002012204.297193336@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date:   Mon, 01 Oct 2018 20:22:06 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Hedi Berriche <hedi@sgi.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ram Pai <linuxram@us.ibm.com>, Juergen Gross <jgross@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Sinan Kaya <okaya@codeaurora.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Hedi Berriche <hedi.berriche@hpe.com>
Subject: [PATCH 2/2] x86/tsc: Fix UV TSC initialization
Content-Disposition: inline; filename=fix_tsc_early_init
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix regression introduced by

commit cf7a63ef4e02 ("x86/tsc: Calibrate tsc only once")

as it changed setup_arch() so that it now calls tsc_early_init() before
acpi_boot_table_init() which is a necessary step, in the case of UV
systems, to inform tsc_sanitize_first_cpu() that we're on a platform
with async TSC resets as documented in

commit 341102c3ef29 ("x86/tsc: Add option that TSC on Socket 0 being non-zero is valid")

Fix by skipping tsc_early_init() on UV systems and let TSC initialization
take place later in tsc_init().

Fixes: cf7a63ef4e02 ("x86/tsc: Calibrate tsc only once") 
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
Reviewed-by: Russ Anderson <rja@hpe.com>
Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
---
 arch/x86/kernel/setup.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux.orig/arch/x86/kernel/setup.c
+++ linux/arch/x86/kernel/setup.c
@@ -117,6 +117,7 @@
 #include <asm/microcode.h>
 #include <asm/kaslr.h>
 #include <asm/unwind.h>
+#include <asm/uv/uv.h>
 
 /*
  * max_low_pfn_mapped: highest direct mapped pfn under 4GB
@@ -1015,7 +1016,10 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	init_hypervisor_platform();
 
-	tsc_early_init();
+	/* UV TSC multi-chassis synchronization already set, don't change it */
+	if (!is_early_uv_system())
+		tsc_early_init();
+
 	x86_init.resources.probe_roms();
 
 	/* after parse_early_param, so could debug it */

-- 
