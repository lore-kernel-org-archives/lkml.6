Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeFDHda (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:33:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39792 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752329AbeFDHd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:33:28 -0400
Date: Mon, 4 Jun 2018 08:33:23 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: linux-next: manual merge of the kvm tree with the arm64 tree
Message-ID: <20180604073319.GF22983@e103592.cambridge.arm.com>
References: <20180604165754.6ae09612@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604165754.6ae09612@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 04:57:54PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the kvm tree got a conflict in:
> 
>   arch/arm64/include/asm/processor.h
> 
> between commit:
> 
>   94b07c1f8c39 ("arm64: signal: Report signal frame size to userspace via auxv")
> 
> from the arm64 tree and commit:
> 
>   9a6e594869b2 ("arm64/sve: Move sve_pffr() to fpsimd.h and make inline")
> 
> from the kvm tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

The resolution looks fine here, thanks.

---Dave

> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc arch/arm64/include/asm/processor.h
> index 65ab83e8926e,c99e657fdd57..000000000000
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@@ -246,9 -246,17 +248,20 @@@ void cpu_enable_pan(const struct arm64_
>   void cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused);
>   void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused);
>   
>  +extern unsigned long __ro_after_init signal_minsigstksz; /* sigframe size */
>  +extern void __init minsigstksz_setup(void);
>  +
> + /*
> +  * Not at the top of the file due to a direct #include cycle between
> +  * <asm/fpsimd.h> and <asm/processor.h>.  Deferring this #include
> +  * ensures that contents of processor.h are visible to fpsimd.h even if
> +  * processor.h is included first.
> +  *
> +  * These prctl helpers are the only things in this file that require
> +  * fpsimd.h.  The core code expects them to be in this header.
> +  */
> + #include <asm/fpsimd.h>
> + 
>   /* Userspace interface for PR_SVE_{SET,GET}_VL prctl()s: */
>   #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
>   #define SVE_GET_VL()	sve_get_current_vl()
