Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4EAC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F186E20672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Be62e63e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F186E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbeLJTnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:43:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40800 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbeLJTnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:43:14 -0500
Received: from zn.tnic (p200300EC2BCAD0002992494E33A10E64.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:d000:2992:494e:33a1:e64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B08FE1EC0322;
        Mon, 10 Dec 2018 20:43:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544470991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=R3/0yZ3bgwn8Y2d3uComLHqu3wA0o0EVEaIte+1vFiA=;
        b=Be62e63eW47c/nj8XiFbIv9Hmx0Ec+m1MKMy12mMB+rxOShGdXCRVMC8GrhF9juyd9V4U7
        sHopg8ewuQeZYoXcLS8DpM2xXtq05M80QRUJGFA0OP+L7J+T3Knniqlum6cofl97ox7EC+
        QW8SnBYLDTW0fVrVzK62x6TblJZOEx8=
Date:   Mon, 10 Dec 2018 20:42:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: kvm: RDTSCP on AMD
Message-ID: <20181210194258.GD5482@zn.tnic>
References: <20181210181328.GA762@zn.tnic>
 <20181210183730.GJ4669@habkost.net>
 <20181210184153.GB5482@zn.tnic>
 <20181210190600.GK4669@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181210190600.GK4669@habkost.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 05:06:00PM -0200, Eduardo Habkost wrote:
> I mean documenting it.  We already have code that will print
> warnings if a feature isn't available.
> 
> See my previous attempt to document the minimum kernel version
> at <https://www.mail-archive.com/qemu-devel@nongnu.org/msg486559.html>.

Something like this?

I still have no clue how to add RDTSCP on pc-*-4.0 and newer.

Thx.

---
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
index f81d35e1f914..34bb5b74136d 100644
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
+	    CPUID_EXT2_RDTSCP,
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
