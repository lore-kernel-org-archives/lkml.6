Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752794AbeD3JFl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:05:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59702 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752521AbeD3JFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:05:40 -0400
Date: Mon, 30 Apr 2018 11:05:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] x86/microcode/AMD: Check microcode container data
 in the early loader
Message-ID: <20180430090506.GB6509@pd.tnic>
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <60157b92eef72a73778d9e483b5376db737b5a97.1524515406.git.mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60157b92eef72a73778d9e483b5376db737b5a97.1524515406.git.mail@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:34:08PM +0200, Maciej S. Szmigiero wrote:
> This commit converts the early loader in the AMD microcode update driver to

Avoid beginning the commit message of a patch with "This patch" or "This
commit". It is tautologically useless. Simply get to the point directly:

"Convert the container parsing function ... "

> use the container data checking functions introduced by the previous
> commit.
> 
> We have to be careful to call these functions with 'early' parameter set,
> so they won't try to print errors as the early loader runs too early for
> printk()-style functions to work.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 45 ++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 4fafaf0852d7..94fcd702a67a 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -216,29 +216,33 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size, bool early)
>   * Returns the amount of bytes consumed while scanning. @desc contains all the
>   * data we're going to use in later stages of the application.
>   */
> -static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
> +static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
>  {
>  	struct equiv_cpu_entry *eq;
> -	ssize_t orig_size = size;
> +	size_t orig_size = size;
>  	u32 *hdr = (u32 *)ucode;
> +	u32 equiv_tbl_len;
>  	u16 eq_id;
>  	u8 *buf;
>  
> -	/* Am I looking at an equivalence table header? */
> -	if (hdr[0] != UCODE_MAGIC ||
> -	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
> -	    hdr[2] == 0)
> +	if (!verify_container(ucode, size, true))
> +		return 0;

 		return CONTAINER_HDR_SZ;

We want to make some forward progress after all.

> +	if (!verify_equivalence_table(ucode, size, true))
>  		return CONTAINER_HDR_SZ;
>  
>  	buf = ucode;
>  
> +	equiv_tbl_len = hdr[2];
>  	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
>  
>  	/* Find the equivalence ID of our CPU in this table: */
>  	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
>  
> -	buf  += hdr[2] + CONTAINER_HDR_SZ;
> -	size -= hdr[2] + CONTAINER_HDR_SZ;
> +	buf  += CONTAINER_HDR_SZ;
> +	buf  += equiv_tbl_len;
> +	size -= CONTAINER_HDR_SZ;
> +	size -= equiv_tbl_len;
>  
>  	/*
>  	 * Scan through the rest of the container to find where it ends. We do
> @@ -250,25 +254,22 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
>  
>  		hdr = (u32 *)buf;
>  
> -		if (hdr[0] != UCODE_UCODE_TYPE)
> +		if (!verify_patch_section(buf, size, true))

So there's verify_patch_section(), verify_patch() and
verify_patch_size() now. One of the three looks redundant to me. Sounds
to me verify_patch_size() could be expanded into verify_patch() and
former dropped.

>  			break;
>  
> -		/* Sanity-check patch size. */
>  		patch_size = hdr[1];
> -		if (patch_size > PATCH_MAX_SIZE)
> -			break;
>  
> -		/* Skip patch section header: */
> -		buf  += SECTION_HDR_SIZE;
> -		size -= SECTION_HDR_SIZE;
> -
> -		mc = (struct microcode_amd *)buf;
> -		if (eq_id == mc->hdr.processor_rev_id) {
> +		mc = (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
> +		if (eq_id == mc->hdr.processor_rev_id &&
> +		    verify_patch(x86_family(desc->cpuid_1_eax), buf, size,
> +				 true)) {

This needs to be made readable.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
