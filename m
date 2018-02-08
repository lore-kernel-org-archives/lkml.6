Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeBHPP3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:15:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49538 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbeBHPP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:15:28 -0500
Date: Thu, 8 Feb 2018 16:15:07 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, bp@suse.de,
        tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/MCE/AMD, EDAC/mce_amd: Enumerate Reserved SMCA
 bank type
Message-ID: <20180208151507.GE7964@pd.tnic>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
 <20180201184813.82253-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180201184813.82253-2-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 12:48:12PM -0600, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Currently, bank 4 is reserved on Fam17h, so we chose not to initialize
> bank 4 in the smca_banks array. This means that when we check if a bank
> is initialized, like during boot or resume, we will see that bank 4 is
> not initialized and try to initialize it. This may cause a call trace,
> when resuming from suspend, due to *on_cpu() calls in the init path.

Please be more specific: the rdmsr_*_on_cpu() calls issue an IPI but we're
running with interrupts disabled, which triggers:

 WARNING: CPU: 0 PID: 11523 at kernel/smp.c:291 smp_call_function_single+0xdc/0xe0

> Reserved banks will be read-as-zero, so their MCA_IPID register will be
> zero. So, like the smca_banks array, the threshold_banks array will not
> have an entry for a reserved bank since all its MCA_MISC* registers will
> be zero.
> 
> Enumerate a "Reserved" bank type that matches on a HWID_MCATYPE of 0,0.
> 
> Use the "Reserved" type when checking if a bank is reserved. It's
> possible that other bank numbers may be reserved on future systems.
> 
> Don't try to find the block address on reserved banks.
> 
> Cc: <stable@vger.kernel.org> # 4.14.x
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/include/asm/mce.h           |  1 +
>  arch/x86/kernel/cpu/mcheck/mce_amd.c |  7 +++++++
>  drivers/edac/mce_amd.c               | 11 +++++++----
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 96ea4b5ba658..340070415c2c 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -346,6 +346,7 @@ enum smca_bank_types {
>  	SMCA_IF,	/* Instruction Fetch */
>  	SMCA_L2_CACHE,	/* L2 Cache */
>  	SMCA_DE,	/* Decoder Unit */
> +	SMCA_RESERVED,	/* Reserved */
>  	SMCA_EX,	/* Execution Unit */
>  	SMCA_FP,	/* Floating Point */
>  	SMCA_L3_CACHE,	/* L3 Cache */
> diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> index 4e16afc0794d..bf53b4549a17 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
> @@ -82,6 +82,7 @@ static struct smca_bank_name smca_names[] = {
>  	[SMCA_IF]	= { "insn_fetch",	"Instruction Fetch Unit" },
>  	[SMCA_L2_CACHE]	= { "l2_cache",		"L2 Cache" },
>  	[SMCA_DE]	= { "decode_unit",	"Decode Unit" },
> +	[SMCA_RESERVED]	= { "reserved",		"Reserved" },
>  	[SMCA_EX]	= { "execution_unit",	"Execution Unit" },
>  	[SMCA_FP]	= { "floating_point",	"Floating Point Unit" },
>  	[SMCA_L3_CACHE]	= { "l3_cache",		"L3 Cache" },
> @@ -127,6 +128,9 @@ static enum smca_bank_types smca_get_bank_type(unsigned int bank)
>  static struct smca_hwid smca_hwid_mcatypes[] = {
>  	/* { bank_type, hwid_mcatype, xec_bitmap } */
>  
> +	/* Reserved type */
> +	{ SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0), 0x0 },
> +
>  	/* ZN Core (HWID=0xB0) MCA types */
>  	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFEF },
>  	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1), 0x3FFF },
> @@ -433,6 +437,9 @@ static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 hi
>  	u32 addr = 0, offset = 0;
>  
>  	if (mce_flags.smca) {

As a last patch in the series: please carve the code in this
if-statement into a smca_get_block_address() helper. And it doesn't need
the stable tag as it is only a cleanup.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
