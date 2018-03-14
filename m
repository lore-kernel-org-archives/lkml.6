Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbeCNRFk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:05:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34494 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751461AbeCNRFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 13:05:36 -0400
Date: Wed, 14 Mar 2018 18:04:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] x86/microcode/AMD: check whether the equivalence
 table fits in the file
Message-ID: <20180314170457.GE16605@pd.tnic>
References: <cover.1520973389.git.mail@maciej.szmigiero.name>
 <e2de27e0-6250-a10f-8d08-99c0c8d417ba@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2de27e0-6250-a10f-8d08-99c0c8d417ba@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 10:06:23PM +0100, Maciej S. Szmigiero wrote:
> Before loading a CPU equivalence table from a microcode container file we
> need to verify whether this file is actually large enough to contain the
> table of a size indicated in this file.
> If it is not, there is no point of continuing with loading it since
> microcode patches are located after the equivalence table anyway.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 54 ++++++++++++++++++++++++++-----------
>  1 file changed, 38 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index ffe0d0ce57fc..ac06e2819f26 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -80,20 +80,29 @@ static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
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
> +	size_t eq_size;
>  	u16 eq_id;
>  	u8 *buf;
>  
>  	/* Am I looking at an equivalence table header? */

That comment becomes wrong when you add this check here.

> +	if (size < CONTAINER_HDR_SZ)
> +		return 0;
> +
>  	if (hdr[0] != UCODE_MAGIC ||
>  	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
>  	    hdr[2] == 0)
>  		return CONTAINER_HDR_SZ;
>  
> +	eq_size = hdr[2];

If we're going to have special local vars for the container header, then
do it right:

	cont_magic	= hdr[0];
	cont_type  	= hdr[1];
	equiv_tbl_len	= hdr[2];

and then use those from now on.

> +	if (eq_size < sizeof(*eq) ||
> +	    size - CONTAINER_HDR_SZ < eq_size)
> +		return 0;

I think you want

	if (size < eqiv_tbl_len + CONTAINER_HDR_SZ)
		return size;

here to skip over the next, hopefully not truncated container.

> +
>  	buf = ucode;
>  
>  	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
> @@ -101,8 +110,8 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
>  	/* Find the equivalence ID of our CPU in this table: */
>  	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
>  
> -	buf  += hdr[2] + CONTAINER_HDR_SZ;
> -	size -= hdr[2] + CONTAINER_HDR_SZ;
> +	buf  += eq_size + CONTAINER_HDR_SZ;
> +	size -= eq_size + CONTAINER_HDR_SZ;
>  
>  	/*
>  	 * Scan through the rest of the container to find where it ends. We do
> @@ -159,15 +168,13 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
>   */
>  static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
>  {
> -	ssize_t rem = size;
> -
> -	while (rem >= 0) {
> -		ssize_t s = parse_container(ucode, rem, desc);
> +	while (size > 0) {
> +		size_t s = parse_container(ucode, size, desc);
>  		if (!s)
>  			return;
>  
>  		ucode += s;
> -		rem   -= s;
> +		size  -= s;
>  	}
>  }
>  

All changes upto here need to be a separate patch.
install_equiv_cpu_table() changes below are the second patch.

> @@ -540,15 +547,30 @@ static enum ucode_state apply_microcode_amd(int cpu)
>  	return UCODE_UPDATED;
>  }
>  
> -static int install_equiv_cpu_table(const u8 *buf)
> +static int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
>  {
>  	unsigned int *ibuf = (unsigned int *)buf;
> -	unsigned int type = ibuf[1];
> -	unsigned int size = ibuf[2];
> +	unsigned int type, size;

unsigned int type, equiv_tbl_len;

> +
> +	if (buf_size < CONTAINER_HDR_SZ) {

		     <= is ok too.

> +		pr_err("no container header\n");

More descriptive error messages:

			"Truncated microcode container header.\n"

> +		return -EINVAL;
> +	}
> +
> +	type = ibuf[1];
> +	if (type != UCODE_EQUIV_CPU_TABLE_TYPE) {
> +		pr_err("invalid type field in container file section header\n");

			"Wrong microcode container equivalence table type: %d.\n"

> +		return -EINVAL;
> +	}
> +
> +	size = ibuf[2];
> +	if (size < sizeof(struct equiv_cpu_entry)) {
> +		pr_err("equivalent CPU table too short\n");

			"Truncated equivalence table.\n"

> +		return -EINVAL;
> +	}
>  
> -	if (type != UCODE_EQUIV_CPU_TABLE_TYPE || !size) {
> -		pr_err("empty section/"
> -		       "invalid type field in container file section header\n");
> +	if (buf_size - CONTAINER_HDR_SZ < size) {
> +		pr_err("equivalent CPU table truncated\n");

Combine that test with the above one and use the same error message.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
