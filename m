Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7B0C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407AE2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407AE2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeJCAnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:43:51 -0400
Received: from relay1.sgi.com ([192.48.180.66]:40191 "EHLO relay.sgi.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbeJCAnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:43:50 -0400
Received: from stormcage.americas.sgi.com (stormcage.americas.sgi.com [128.162.236.70])
        by relay1.corp.sgi.com (Postfix) with ESMTP id C3F738F8073;
        Tue,  2 Oct 2018 10:59:10 -0700 (PDT)
Received: by stormcage.americas.sgi.com (Postfix, from userid 5508)
        id DF4A82015FDF0; Tue,  2 Oct 2018 13:01:44 -0500 (CDT)
Message-Id: <20181002180144.801700401@stormcage.americas.sgi.com>
References: <20181002180144.636925675@stormcage.americas.sgi.com>
User-Agent: quilt/0.46-1
Date:   Tue, 02 Oct 2018 13:01:45 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Borislav Petkov <bp@alien8.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Xiaoming Gao <gxm.linux.kernel@gmail.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 1/2] x86/platform/uv: Add is_early_uv_system check
Content-Disposition: inline; filename=add_is_early_uv_system
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce is_early_uv_system() which uses efi.uv_systab to decide early
in the boot process whether we're on a UV system.

This is needed to skip other early setup/init code that might break
the UV platform if done too early such as before necessary ACPI tables
parsing takes place.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Suggested-by: Hedi Berriche <hedi.berriche@hpe.com>
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
+static inline bool is_early_uv_system(void)
+{
+	return !((efi.uv_systab == EFI_INVALID_TABLE_ADDR) || !efi.uv_systab);
+}
 extern int is_uv_system(void);
 extern int is_uv_hubless(void);
 extern void uv_cpu_init(void);
@@ -23,6 +28,7 @@ extern const struct cpumask *uv_flush_tl
 #else	/* X86_UV */
 
 static inline enum uv_system_type get_uv_system_type(void) { return UV_NONE; }
+static inline bool is_early_uv_system(void)	{ return 0; }
 static inline int is_uv_system(void)	{ return 0; }
 static inline int is_uv_hubless(void)	{ return 0; }
 static inline void uv_cpu_init(void)	{ }

-- 
