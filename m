Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D5EF20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 04:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5EF20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbeGXFxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 01:53:53 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37040 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388203AbeGXFxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 01:53:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 8E709275DF;
        Tue, 24 Jul 2018 00:49:16 -0400 (EDT)
Date:   Tue, 24 Jul 2018 14:49:23 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     Andreas Schwab <schwab@linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: m68k allmodconfig build errors
In-Reply-To: <94dc0357-10d4-c3dc-ef2a-9643f08d2a09@infradead.org>
Message-ID: <alpine.LNX.2.21.1807241423000.8@nippy.intranet>
References: <28ebe45d-3dbd-2a82-f537-b0725f7a2bcf@infradead.org> <878t66idai.fsf@igel.home> <94dc0357-10d4-c3dc-ef2a-9643f08d2a09@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018, Randy Dunlap wrote:

> On 07/20/2018 12:20 AM, Andreas Schwab wrote:
> > On Jul 19 2018, Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> >> block/partitions/ldm.o: In function `ldm_partition':
> >> ldm.c:(.text+0x1900): undefined reference to `strcmp'
> >> ldm.c:(.text+0x1964): undefined reference to `strcmp'
> >> drivers/rtc/rtc-proc.o: In function `is_rtc_hctosys':
> >> rtc-proc.c:(.text+0x290): undefined reference to `strcmp'
> >> drivers/watchdog/watchdog_pretimeout.o: In function `watchdog_register_governor':
> >> (.text+0x142): undefined reference to `strcmp'
> > 
> > GCC has optimized strncmp to strcmp, but at a stage where macros are no
> > longer available.  I think the right fix is to use strcmp directly,
> > since strncmp doesn't make sense here.
> 
> Hi Andreas,
> 
> I don't see that all of these string compare fields are null-terminated.
> 

Some of the strncmp calls in ldm.c are null-terminated, some are not. 

That would imply that the compiler will emit both strcmp and strncmp 
calls.

A strncmp call isn't a problem, because m68k doesn't define 
__HAVE_ARCH_STRNCMP and so the one from lib/string.c gets built.

> How does one convert strncmp() users to strcmp()?
> 
> thanks,
> 

The untested patch below may work. It seems that it may be relevant to 
both arc and m68k:

$ diff -u <(egrep -rlw __HAVE_ARCH_STRCMP *) <(egrep -rlw __HAVE_ARCH_STRNCMP *)
--- /dev/fd/63  2018-07-24 14:22:56.180014584 +1000
+++ /dev/fd/62  2018-07-24 14:22:56.180014584 +1000
@@ -1,11 +1,12 @@
 arch/mips/include/asm/string.h
 arch/x86/lib/string_32.c
 arch/x86/include/asm/string_32.h
-arch/m68k/include/asm/string.h
 arch/xtensa/include/asm/string.h
 arch/sh/include/asm/string_32.h
+arch/powerpc/include/asm/string.h
 arch/s390/include/asm/string.h
 arch/arm64/include/asm/string.h
-arch/arc/include/asm/string.h
+arch/sparc/include/asm/string.h
+drivers/firmware/efi/libstub/string.c
 include/linux/string.h
 lib/string.c

How can all those __HAVE_ARCH_FOO feature macros work properly if the 
compiler makes assumptions about libc availability? Isn't that assumption 
invalidated by -ffreestanding?

Surely the strcmp optimization is only valid when there is a 
__builtin_strcmp?

-- 

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 0417937dfe99..4b9927344593 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -150,8 +150,7 @@ static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
 	toc->bitmap1_start = get_unaligned_be64(data + 0x2E);
 	toc->bitmap1_size  = get_unaligned_be64(data + 0x36);
 
-	if (strncmp (toc->bitmap1_name, TOC_BITMAP1,
-			sizeof (toc->bitmap1_name)) != 0) {
+	if (strcmp(toc->bitmap1_name, TOC_BITMAP1) != 0) {
 		ldm_crit ("TOCBLOCK's first bitmap is '%s', should be '%s'.",
 				TOC_BITMAP1, toc->bitmap1_name);
 		return false;
@@ -160,8 +159,7 @@ static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
 	toc->bitmap2_name[sizeof (toc->bitmap2_name) - 1] = 0;
 	toc->bitmap2_start = get_unaligned_be64(data + 0x50);
 	toc->bitmap2_size  = get_unaligned_be64(data + 0x58);
-	if (strncmp (toc->bitmap2_name, TOC_BITMAP2,
-			sizeof (toc->bitmap2_name)) != 0) {
+	if (strcmp(toc->bitmap2_name, TOC_BITMAP2) != 0) {
 		ldm_crit ("TOCBLOCK's second bitmap is '%s', should be '%s'.",
 				TOC_BITMAP2, toc->bitmap2_name);
 		return false;
diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
index a9dd9218fae2..5f9a5a720b4d 100644
--- a/drivers/rtc/rtc-proc.c
+++ b/drivers/rtc/rtc-proc.c
@@ -30,7 +30,7 @@ static bool is_rtc_hctosys(struct rtc_device *rtc)
 	if (size > NAME_SIZE)
 		return false;
 
-	return !strncmp(name, CONFIG_RTC_HCTOSYS_DEVICE, NAME_SIZE);
+	return !strcmp(name, CONFIG_RTC_HCTOSYS_DEVICE);
 }
 #else
 static bool is_rtc_hctosys(struct rtc_device *rtc)
diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index 9db07bfb4334..d4797452b011 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -136,8 +136,7 @@ int watchdog_register_governor(struct watchdog_governor *gov)
 	priv->gov = gov;
 	list_add(&priv->entry, &governor_list);
 
-	if (!strncmp(gov->name, WATCHDOG_PRETIMEOUT_DEFAULT_GOV,
-		     WATCHDOG_GOV_NAME_MAXLEN)) {
+	if (!strcmp(gov->name, WATCHDOG_PRETIMEOUT_DEFAULT_GOV)) {
 		spin_lock_irq(&pretimeout_lock);
 		default_gov = gov;
 
