Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6501C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624E42084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624E42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeLLTwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:52:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbeLLTwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:52:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5DE307F6B2;
        Wed, 12 Dec 2018 19:52:37 +0000 (UTC)
Received: from localhost (ovpn-116-63.gru2.redhat.com [10.97.116.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6EA360C44;
        Wed, 12 Dec 2018 19:52:36 +0000 (UTC)
Date:   Wed, 12 Dec 2018 17:52:35 -0200
From:   Eduardo Habkost <ehabkost@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] target-i386: Reenable RDTSCP support on Opteron_G[345]
 CPU models
Message-ID: <20181212195235.GX7141@habkost.net>
References: <20181210183730.GJ4669@habkost.net>
 <20181210184153.GB5482@zn.tnic>
 <20181210190600.GK4669@habkost.net>
 <20181210194258.GD5482@zn.tnic>
 <20181210200843.GN4669@habkost.net>
 <20181211103839.GC921@redhat.com>
 <20181211115546.GQ4669@habkost.net>
 <e4d9a943-2de2-34a7-3f52-ee3d64ea889a@redhat.com>
 <20181211153017.GN921@redhat.com>
 <20181211161440.GG27375@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181211161440.GG27375@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 12 Dec 2018 19:52:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:14:40PM +0100, Borislav Petkov wrote:
> + qemu-devel.
> 
> On Tue, Dec 11, 2018 at 03:30:17PM +0000, Daniel P. Berrangé wrote:
> > Great, then, this is a non-issue - we just need to mention that fact
> > in the commit that sets the min version for the kernel
> 
> Ok, here's a first draft ontop of Eduardo's machine-next branch from
> http://github.com/ehabkost/qemu
> 
> Also, thanks for the help Eduardo! :-)
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Tue, 11 Dec 2018 17:01:00 +0100
> 
> The missing functionality was added ~3 years ago with the Linux commit
> 
>   46896c73c1a4 ("KVM: svm: add support for RDTSCP")
> 
> so reenable RDTSCP support on those CPU models.
> 
> Opteron_G2 - being family 15, model 6, doesn't have RDTSCP support
> (the real hardware doesn't have it. K8 got RDTSCP support with the NPT
> models, i.e., models >= 0x40).
> 
> Document the host's minimum required kernel version, while at it.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  include/hw/i386/pc.h | 17 +++++++++++++----
>  qemu-doc.texi        | 13 +++++++++++++
>  target/i386/cpu.c    | 11 ++++-------
>  3 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 9d29c4b1df2a..ebc28e816b04 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -296,6 +296,19 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>  
>  #define PC_COMPAT_3_1 \
>      HW_COMPAT_3_1 \
> +    {\
> +        .driver   = "Opteron_G3" "-" TYPE_X86_CPU,\
> +        .property = "rdtscp",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "Opteron_G4" "-" TYPE_X86_CPU,\
> +        .property = "rdtscp",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "Opteron_G5" "-" TYPE_X86_CPU,\
> +        .property = "rdtscp",\
> +        .value    = "off",\
> +    },

This looks correct.

>  
>  #define PC_COMPAT_3_0 \
>      HW_COMPAT_3_0 \
> @@ -527,10 +540,6 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>          .driver   = "qemu32" "-" TYPE_X86_CPU,\
>          .property = "popcnt",\
>          .value    = "on",\
> -    },{\
> -        .driver   = "Opteron_G2" "-" TYPE_X86_CPU,\
> -        .property = "rdtscp",\
> -        .value    = "on",\

Why did you remove this entry from PC_COMPAT_2_4?

We must keep compatibility with old behavior of Opteron_G2 on
pc-2.4, even if the old behavior was incorrect.


>      },{\
>          .driver   = "Opteron_G3" "-" TYPE_X86_CPU,\
>          .property = "rdtscp",\
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index f7ad1dfe4b69..16b955cbf985 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -37,6 +37,7 @@
>  * QEMU System emulator for non PC targets::
>  * QEMU Guest Agent::
>  * QEMU User space emulator::
> +* System requirements::
>  * Implementation notes::
>  * Deprecated features::
>  * Supported build platforms::
> @@ -2813,6 +2814,18 @@ Act as if the host page size was 'pagesize' bytes
>  Run the emulation in single step mode.
>  @end table
>  
> +@node System requirements
> +@chapter System requirements
> +
> +@section KVM kernel module
> +
> +On x86_64 hosts, the default set of CPU features enabled by the KVM accelerator
> +require the host to be running Linux v4.5 or newer.
> +
> +The OpteronG[345] CPU models require KVM support for RDTSCP, which was
> +added with Linux 4.5 which is supported by the major distros. And even
> +if RHEL7 has kernel 3.10, KVM there has the required functionality there
> +to make it close to a 4.5 or newer kernel.
>  
>  @include qemu-tech.texi
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f81d35e1f914..a7def11b27cd 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2706,7 +2706,6 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_DE | CPUID_FP87,
>          .features[FEAT_1_ECX] =
>              CPUID_EXT_CX16 | CPUID_EXT_SSE3,
> -        /* Missing: CPUID_EXT2_RDTSCP */

This is Opteron_G2, and feature is not being added.  Looks
correct.

>          .features[FEAT_8000_0001_EDX] =
>              CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
>          .features[FEAT_8000_0001_ECX] =
> @@ -2730,9 +2729,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>          .features[FEAT_1_ECX] =
>              CPUID_EXT_POPCNT | CPUID_EXT_CX16 | CPUID_EXT_MONITOR |
>              CPUID_EXT_SSE3,
> -        /* Missing: CPUID_EXT2_RDTSCP */
>          .features[FEAT_8000_0001_EDX] =
> -            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL,
> +            CPUID_EXT2_LM | CPUID_EXT2_NX | CPUID_EXT2_SYSCALL |
> +            CPUID_EXT2_RDTSCP,

This is Opteron_G3.  Looks correct.

>          .features[FEAT_8000_0001_ECX] =
>              CPUID_EXT3_MISALIGNSSE | CPUID_EXT3_SSE4A |
>              CPUID_EXT3_ABM | CPUID_EXT3_SVM | CPUID_EXT3_LAHF_LM,
> @@ -2757,10 +2756,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_EXT_POPCNT | CPUID_EXT_SSE42 | CPUID_EXT_SSE41 |
>              CPUID_EXT_CX16 | CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ |
>              CPUID_EXT_SSE3,
> -        /* Missing: CPUID_EXT2_RDTSCP */
>          .features[FEAT_8000_0001_EDX] =
>              CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_NX |
> -            CPUID_EXT2_SYSCALL,
> +            CPUID_EXT2_SYSCALL | CPUID_EXT2_RDTSCP,

This is Opteron_G4.  Looks correct.


>          .features[FEAT_8000_0001_ECX] =
>              CPUID_EXT3_FMA4 | CPUID_EXT3_XOP |
>              CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
> @@ -2788,10 +2786,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_EXT_AES | CPUID_EXT_POPCNT | CPUID_EXT_SSE42 |
>              CPUID_EXT_SSE41 | CPUID_EXT_CX16 | CPUID_EXT_FMA |
>              CPUID_EXT_SSSE3 | CPUID_EXT_PCLMULQDQ | CPUID_EXT_SSE3,
> -        /* Missing: CPUID_EXT2_RDTSCP */
>          .features[FEAT_8000_0001_EDX] =
>              CPUID_EXT2_LM | CPUID_EXT2_PDPE1GB | CPUID_EXT2_NX |
> -            CPUID_EXT2_SYSCALL,
> +            CPUID_EXT2_SYSCALL | CPUID_EXT2_RDTSCP,

This is Opteron_G5.  Looks correct.

>          .features[FEAT_8000_0001_ECX] =
>              CPUID_EXT3_TBM | CPUID_EXT3_FMA4 | CPUID_EXT3_XOP |
>              CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
> -- 
> 2.19.1
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

-- 
Eduardo
