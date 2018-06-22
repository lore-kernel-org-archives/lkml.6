Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEDCC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF1224477
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF1224477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933713AbeFVPOP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:14:15 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41972 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933354AbeFVPOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:14:14 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWNlF-0007G3-AD; Fri, 22 Jun 2018 17:14:05 +0200
Date:   Fri, 22 Jun 2018 17:14:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
cc:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 6/7] x86/vdso: Introduce CPU number helper functions
In-Reply-To: <1529536506-26237-7-git-send-email-chang.seok.bae@intel.com>
Message-ID: <alpine.DEB.2.21.1806221644090.2402@nanos.tec.linutronix.de>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com> <1529536506-26237-7-git-send-email-chang.seok.bae@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2018, Chang S. Bae wrote:

> CPU number initialization in vDSO is now a bit cleaned up by
> the new helper functions. The helper functions will take
> care of combing CPU and node number and reading each from

s/combing/combining/ please

> the combined value.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/entry/vdso/vgetcpu.c  |  4 ++--
>  arch/x86/entry/vdso/vma.c      | 16 ++++++++--------
>  arch/x86/include/asm/segment.h | 28 ++++++++++++++++++++++++++++
>  arch/x86/include/asm/vgtod.h   |  2 --
>  4 files changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
> index 8ec3d1f..3284069 100644
> --- a/arch/x86/entry/vdso/vgetcpu.c
> +++ b/arch/x86/entry/vdso/vgetcpu.c
> @@ -18,9 +18,9 @@ __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
>  	p = __getcpu();

While we are touching this, can we please as a first step change __getcpu()
to something else? I've tripped over this several times in the past and
confused it with a (nonexisting) variant of get_cpu().

>  
>  	if (cpu)
> -		*cpu = p & VGETCPU_CPU_MASK;
> +		*cpu = lsl_tscp_to_cpu(p);
>
>  	if (node)
> -		*node = p >> 12;
> +		*node = lsl_tscp_to_node(p);

Are these new helpers going to be used at some other place than this? If
not, then there is really no point at all. Then just go and make this:

__vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
{
	vdso_read_cpu_and_node(cpu, node);
	return 0;
}

> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 833e229..1fc93da 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -340,19 +340,19 @@ static void vgetcpu_cpu_init(void *arg)
>  	int cpu = smp_processor_id();
>  	struct desc_struct d = { };
>  	unsigned long node = 0;
> +	unsigned long cpu_number = 0;

That's hardly a CPU number. It's encoded CPU and node information.

>  #ifdef CONFIG_NUMA
>  	node = cpu_to_node(cpu);
>  #endif

While at it please get rid of the ifdeffery. If CONFIG_NUMA=n then
cpu_to_node(cpu) resolves to (0).

> +	cpu_number = make_lsl_tscp(cpu, node);

So the whole thing can be reduced to:

        u64 cpudata = vdso_encode_cpu_and_node(cpu, cpu_to_node(cpu));

Or some other sensible function name.

Thanks,

	tglx
