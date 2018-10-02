Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEC0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F655213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F655213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeJBIKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 04:10:24 -0400
Received: from relay2.sgi.com ([192.48.180.65]:56871 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbeJBIKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 04:10:23 -0400
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Oct 2018 04:10:22 EDT
Received: from stormcage.americas.sgi.com (stormcage.americas.sgi.com [128.162.236.70])
        by relay2.corp.sgi.com (Postfix) with ESMTP id 85C3D304043;
        Mon,  1 Oct 2018 18:19:30 -0700 (PDT)
Received: by stormcage.americas.sgi.com (Postfix, from userid 5508)
        id 88C8A201E76F6; Mon,  1 Oct 2018 20:22:04 -0500 (CDT)
Message-Id: <20181002012204.453928259@stormcage.americas.sgi.com>
References: <20181002012204.297193336@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date:   Mon, 01 Oct 2018 20:22:05 -0500
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
Subject: [PATCH 1/2] x86/platform/uv: Add is_early_uv_system check
Content-Disposition: inline; filename=add_is_early_uv_system
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce is_early_uv_system() which uses efi.uv_systab to decide early
in the boot process whether we're on a UV system.

This is needed to skip other early setup/init code that might break UV
platform if done too early such as before necessary ACPI tables parsing
takes place.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
Reviewed-by: Russ Anderson <rja@hpe.com>
Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
---
 arch/x86/include/asm/uv/uv.h |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux.orig/arch/x86/include/asm/uv/uv.h
+++ linux/arch/x86/include/asm/uv/uv.h
@@ -10,8 +10,13 @@ struct cpumask;
 struct mm_struct;
 
 #ifdef CONFIG_X86_UV
+#include <linux/efi.h>
 
 extern enum uv_system_type get_uv_system_type(void);
+static inline int is_early_uv_system(void)
+{
+	return !((efi.uv_systab == EFI_INVALID_TABLE_ADDR) || !efi.uv_systab);
+}
 extern int is_uv_system(void);
 extern int is_uv_hubless(void);
 extern void uv_cpu_init(void);
@@ -23,6 +28,7 @@ extern const struct cpumask *uv_flush_tl
 #else	/* X86_UV */
 
 static inline enum uv_system_type get_uv_system_type(void) { return UV_NONE; }
+static inline int is_early_uv_system(void)	{ return 0; }
 static inline int is_uv_system(void)	{ return 0; }
 static inline int is_uv_hubless(void)	{ return 0; }
 static inline void uv_cpu_init(void)	{ }

-- 
