Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C591C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB190208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB190208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbeG0PIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:08:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:36075 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730632AbeG0PIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:08:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jul 2018 06:46:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,409,1526367600"; 
   d="scan'208";a="243839114"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2018 06:46:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 105D8790; Fri, 27 Jul 2018 16:46:22 +0300 (EEST)
Date:   Fri, 27 Jul 2018 16:46:22 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dmitry Malkin <d.malkin@real-time-systems.com>
Cc:     linux-x86_64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Message-ID: <20180727134622.5htfsqa3aciultyf@black.fi.intel.com>
References: <f1fb3e5e-f18a-9f89-84c5-1dc73e08ceef@real-time-systems.com>
 <20180725212122.f2m3cfiqb4az3cb7@black.fi.intel.com>
 <a3e428be-0875-3b64-7680-252cd61b52c9@real-time-systems.com>
 <20180726145008.ccmeklqx4ofb4456@black.fi.intel.com>
 <9e22ee9b-0ada-9863-32aa-db3cacd25862@real-time-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9e22ee9b-0ada-9863-32aa-db3cacd25862@real-time-systems.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:21:11PM +0000, Dmitry Malkin wrote:
> On 07/26/2018 04:50 PM, Kirill A. Shutemov wrote:
> > > > > 2. reading from memory which may be reserved in case of EFI systems:
> > > > > > >      ebda_start = *(unsigned short *)0x40e << 4;
> > > > > > >      bios_start = *(unsigned short *)0x413 << 10;
> > > > > Also, on EFI system without CSM it will results in all zeros. Which will
> > > > > place trampoline_start to 0x9d000. And it also may be reserved memory. In
> > > > > fact I have such system and it is causes instant reboot (when code starts
> > > > > copying to "trampoline_start").
> > > > Could you show dmesg from such system?
> > > Sure, here it is (please note than not both pages are reserved but only
> > > second one: 0x9e000-0x9ffff):
> > Well. That's bad.
> > 
> > I don't see much options but parse e820 in decompression code. I hoped to
> > avoid this.
> > 
> > Let me see what I can do there.
> Just in case of UEFI (I don't know much about BIOS and kexec):
> register RSI (right before call paging_prepare) will contains pointer to
> "struct boot_params" (returned by function efi_main() in eboot.c).
> There are fields e820_table and e820_entries.
> 

Could you check if this makes a difference for you?

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 8c5107545251..9e2157371491 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,3 +1,4 @@
+#include <asm/e820/types.h>
 #include <asm/processor.h>
 #include "pgtable.h"
 #include "../string.h"
@@ -34,10 +35,62 @@ unsigned long *trampoline_32bit __section(.data);
 extern struct boot_params *boot_params;
 int cmdline_find_option_bool(const char *option);
 
+static unsigned long find_trampoline_placement(void)
+{
+	unsigned long bios_start, ebda_start;
+	unsigned long trampoline_start;
+	struct boot_e820_entry *entry;
+	int i;
+
+	/*
+	 * Find a suitable spot for the trampoline.
+	 * This code is based on reserve_bios_regions().
+	 */
+
+	ebda_start = *(unsigned short *)0x40e << 4;
+	bios_start = *(unsigned short *)0x413 << 10;
+
+	if (bios_start < BIOS_START_MIN || bios_start > BIOS_START_MAX)
+		bios_start = BIOS_START_MAX;
+
+	if (ebda_start > BIOS_START_MIN && ebda_start < bios_start)
+		bios_start = ebda_start;
+
+	bios_start = round_down(bios_start, PAGE_SIZE);
+
+	/* Find the first usable memory region under bios_start. */
+	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
+		entry = &boot_params->e820_table[i];
+
+		/* Skip all entries above bios_start. */
+		if (bios_start <= entry->addr)
+			continue;
+
+		/* Skip non-RAM entries. */
+		if (entry->type != E820_TYPE_RAM)
+			continue;
+
+		/* Adjust bios_start to the end of the entry if needed. */
+		if (bios_start > entry->addr + entry->size)
+			bios_start = entry->addr + entry->size;
+
+		/* Keep bios_start page-aligned. */
+		bios_start = round_down(bios_start, PAGE_SIZE);
+
+		/* Skip the entry if it's too small. */
+		if (bios_start - TRAMPOLINE_32BIT_SIZE < entry->addr)
+			continue;
+
+		break;
+	}
+
+	/* Place the trampoline just below the end of low memory */
+	return bios_start - TRAMPOLINE_32BIT_SIZE;
+}
+
 struct paging_config paging_prepare(void *rmode)
 {
 	struct paging_config paging_config = {};
-	unsigned long bios_start, ebda_start;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
 	boot_params = rmode;
@@ -61,23 +114,7 @@ struct paging_config paging_prepare(void *rmode)
 		paging_config.l5_required = 1;
 	}
 
-	/*
-	 * Find a suitable spot for the trampoline.
-	 * This code is based on reserve_bios_regions().
-	 */
-
-	ebda_start = *(unsigned short *)0x40e << 4;
-	bios_start = *(unsigned short *)0x413 << 10;
-
-	if (bios_start < BIOS_START_MIN || bios_start > BIOS_START_MAX)
-		bios_start = BIOS_START_MAX;
-
-	if (ebda_start > BIOS_START_MIN && ebda_start < bios_start)
-		bios_start = ebda_start;
-
-	/* Place the trampoline just below the end of low memory, aligned to 4k */
-	paging_config.trampoline_start = bios_start - TRAMPOLINE_32BIT_SIZE;
-	paging_config.trampoline_start = round_down(paging_config.trampoline_start, PAGE_SIZE);
+	paging_config.trampoline_start = find_trampoline_placement();
 
 	trampoline_32bit = (unsigned long *)paging_config.trampoline_start;
 
-- 
 Kirill A. Shutemov
