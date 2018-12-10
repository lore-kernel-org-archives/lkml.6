Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D268EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879CA2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="YMSHMvXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879CA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbeLJUQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:16:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45546 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbeLJUQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:16:40 -0500
Received: from zn.tnic (p200300EC2BCAD0002992494E33A10E64.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:d000:2992:494e:33a1:e64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 55C311EC0322;
        Mon, 10 Dec 2018 21:16:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544472998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vJVoCEbVQTKjndn2sfQ0TIxUjDGxPv9bnp8WpazORJ4=;
        b=YMSHMvXONrJMzIOYA9CjEk3C5ssb3TISvNWOVwCsz3oB5dAGeh8oHl8Ib5zHrpUwK1z9uM
        rcPe6lZQDB9r2zJS1GfGKBmMTujmuMgkkE3sn822AOY7UWszKJOIji6w4QpXDeZ+XpuMkE
        ABCLrLBagHWxDftSXoZXGYGN27hX7ps=
Date:   Mon, 10 Dec 2018 21:16:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: kvm: RDTSCP on AMD
Message-ID: <20181210201626.GE5482@zn.tnic>
References: <20181210181328.GA762@zn.tnic>
 <20181210183730.GJ4669@habkost.net>
 <20181210184153.GB5482@zn.tnic>
 <20181210194725.GM4669@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181210194725.GM4669@habkost.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 05:47:25PM -0200, Eduardo Habkost wrote:
> On Mon, Dec 10, 2018 at 07:41:53PM +0100, Borislav Petkov wrote:
> > On Mon, Dec 10, 2018 at 04:37:30PM -0200, Eduardo Habkost wrote:
> > > It isn't as simply as reverting commit 33b5e8c03ae7, but we can
> > > surely re-add RDTSCP on pc-*-4.0 and newer.
> > 
> > Sure. If you could only point me to an example how to add that to
> > pc-*-4.0 and newer, I'll gladly cook up a patch and test it.
> 
> Sorry, I forgot to reply to this part.
> 
> See commit 33b5e8c03ae7 for reference.  The differences will be:
> * Instead of removing RDTSCP from builtin_x86_defs, you'll be adding it.
> * Instead of adding rdtscp=on entries to PC_COMPAT_2_4, you'll
>   be adding rdtscp=off entries to PC_COMPAT_3_1.
> 
> PC_COMPAT_3_1 is added by the patch that creates the 4.0
> machine-types.  You can find it on my machine-next branch at:
> 
>   http://github.com/ehabkost/qemu

Thanks for the patient explanation, diff below ontop of your branch.

It is notable to point out that Opteron_G2 - it being family 0xf, model
6 - should not deal with RDTSCP as it doesn't have it.

Although looking at the docs, they say it does but I *have* a K8 laptop
which I just checked and it *doesn't* have RDTSCP in CPUID. So lemme
clarify that aspect first with folks. :)

---
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 9d29c4b1df2a..ebc28e816b04 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -296,6 +296,19 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
 #define PC_COMPAT_3_1 \
     HW_COMPAT_3_1 \
+    {\
+        .driver   = "Opteron_G3" "-" TYPE_X86_CPU,\
+        .property = "rdtscp",\
+        .value    = "off",\
+    },{\
+        .driver   = "Opteron_G4" "-" TYPE_X86_CPU,\
+        .property = "rdtscp",\
+        .value    = "off",\
+    },{\
+        .driver   = "Opteron_G5" "-" TYPE_X86_CPU,\
+        .property = "rdtscp",\
+        .value    = "off",\
+    },
 
 #define PC_COMPAT_3_0 \
     HW_COMPAT_3_0 \
@@ -527,10 +540,6 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = "qemu32" "-" TYPE_X86_CPU,\
         .property = "popcnt",\
         .value    = "on",\
-    },{\
-        .driver   = "Opteron_G2" "-" TYPE_X86_CPU,\
-        .property = "rdtscp",\
-        .value    = "on",\
     },{\
         .driver   = "Opteron_G3" "-" TYPE_X86_CPU,\
         .property = "rdtscp",\
diff --git a/qemu-doc.texi b/qemu-doc.texi
index f7ad1dfe4b69..913b2ef68d54 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -37,6 +37,7 @@
 * QEMU System emulator for non PC targets::
 * QEMU Guest Agent::
 * QEMU User space emulator::
+* System requirements::
 * Implementation notes::
 * Deprecated features::
 * Supported build platforms::
@@ -2813,6 +2814,13 @@ Act as if the host page size was 'pagesize' bytes
 Run the emulation in single step mode.
 @end table
 
+@node System requirements
+@chapter System requirements
+
+@section KVM kernel module
+
+On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
+require the host to be running Linux v4.5 or newer.
 
 @include qemu-tech.texi
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f81d35e1f914..a7def11b27cd 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2706,7 +2706,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_DE | CPUID_FP87,
         .features[FEAT_1_ECX] =
             CPUID_EXT_CX16 | CPUID_EXT_SSE3,
-        /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
         .features[FEAT_8000_0001_ECX] =
@@ -2730,9 +2729,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_1_ECX] =
             CPUID_EXT_POPCNT | CPUID_EXT_CX16 | CPUID_EXT_MONITOR |
             CPUID_EXT_SSE3,
-        /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
-            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
+            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL |
+            CPUID_EXT2_RDTSCP,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A |
             CPUID_EXT3_ABM | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
@@ -2757,10 +2756,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_POPCNT | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
             CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
             CPUID_EXT_SSE3,
-        /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_RDTSCP,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_FMA4 | CPUID_EXT3_XOP |
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
@@ -2788,10 +2786,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
             CPUID_EXT_AES | CPUID_EXT_POPCNT | CPUID_EXT_SSE42 |
             CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_FMA |
             CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
-        /* Missing: CPUID_EXT2_RDTSCP */
         .features[FEAT_8000_0001_EDX] =
             CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_NX |
-            CPUID_EXT2_SYSCALL,
+            CPUID_EXT2_SYSCALL | CPUID_EXT2_RDTSCP,
         .features[FEAT_8000_0001_ECX] =
             CPUID_EXT3_TBM | CPUID_EXT3_FMA4 | CPUID_EXT3_XOP |
             CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
