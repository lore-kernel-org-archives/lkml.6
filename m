Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeD3JGD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:06:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59724 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752024AbeD3JGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:06:02 -0400
Date: Mon, 30 Apr 2018 11:05:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] x86/microcode/AMD: Check microcode container data
 in the late loader
Message-ID: <20180430090527.GC6509@pd.tnic>
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
 <8f204a953dc4b46477e214ebd291021d7ab6fa6c.1524515406.git.mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8f204a953dc4b46477e214ebd291021d7ab6fa6c.1524515406.git.mail@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:34:09PM +0200, Maciej S. Szmigiero wrote:
> This commit converts the late loader in the AMD microcode update driver to
> use newly introduced microcode container data checking functions as the
> previous commit did for the early loader.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 87 +++++++++++++++++--------------------
>  1 file changed, 40 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 94fcd702a67a..b429d3f554b9 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -677,28 +677,24 @@ static enum ucode_state apply_microcode_amd(int cpu)
>  	return UCODE_UPDATED;
>  }
>  
> -static int install_equiv_cpu_table(const u8 *buf)
> +static unsigned int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
>  {
> -	unsigned int *ibuf = (unsigned int *)buf;
> -	unsigned int type = ibuf[1];
> -	unsigned int size = ibuf[2];
> +	const u32 *hdr = (const u32 *)buf;

Ok, since we're verifying now, let's do that assignment...

> +	u32 equiv_tbl_len;
>  
> -	if (type != UCODE_EQUIV_CPU_TABLE_TYPE || !size) {
> -		pr_err("empty section/"
> -		       "invalid type field in container file section header\n");
> -		return -EINVAL;
> -	}
> +	if (!verify_equivalence_table(buf, buf_size, false))
> +		return 0;

... after the check has passed.

> -	equiv_cpu_table = vmalloc(size);
> +	equiv_tbl_len = hdr[2];

<---- newline here.

> +	equiv_cpu_table = vmalloc(equiv_tbl_len);
>  	if (!equiv_cpu_table) {
>  		pr_err("failed to allocate equivalent CPU table\n");
> -		return -ENOMEM;
> +		return 0;
>  	}
>  
> -	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, size);
> +	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
>  
> -	/* add header length */
> -	return size + CONTAINER_HDR_SZ;
> +	return equiv_tbl_len;
>  }
>  
>  static void free_equiv_cpu_table(void)
> @@ -715,20 +711,26 @@ static void cleanup(void)
>  
>  /*
>   * We return the current size even if some of the checks failed so that
> - * we can skip over the next patch. If we return a negative value, we
> - * signal a grave error like a memory allocation has failed and the
> - * driver cannot continue functioning normally. In such cases, we tear
> - * down everything we've used up so far and exit.
> + * we can skip over the next patch. If we return zero, we signal a
> + * grave error like a memory allocation has failed and the driver cannot
> + * continue functioning normally. In such cases, we tear down everything
> + * we've used up so far and exit.
>   */
> -static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
> +static unsigned int verify_and_add_patch(u8 family, u8 *fw,
> +					 unsigned int leftover)
>  {
> +	u32 *hdr = (u32 *)fw;
>  	struct microcode_header_amd *mc_hdr;
>  	struct ucode_patch *patch;
> -	unsigned int patch_size, crnt_size, ret;
> +	u32 patch_size;
> +	unsigned int crnt_size;
>  	u32 proc_fam;
>  	u16 proc_id;
>  
> -	patch_size  = *(u32 *)(fw + 4);
> +	if (!verify_patch_section(fw, leftover, false))
> +		return leftover;
> +
> +	patch_size  = hdr[1];
>  	crnt_size   = patch_size + SECTION_HDR_SIZE;
>  	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
>  	proc_id	    = mc_hdr->processor_rev_id;
> @@ -750,28 +752,20 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
>  		return crnt_size;
>  	}
>  
> -	/*
> -	 * The section header length is not included in this indicated size
> -	 * but is present in the leftover file length so we need to subtract
> -	 * it before passing this value to the function below.
> -	 */
> -	ret = verify_patch_size(family, patch_size, leftover - SECTION_HDR_SIZE);
> -	if (!ret) {
> -		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
> +	if (!verify_patch(family, fw, leftover, false))
>  		return crnt_size;
> -	}
>  
>  	patch = kzalloc(sizeof(*patch), GFP_KERNEL);
>  	if (!patch) {
>  		pr_err("Patch allocation failure.\n");
> -		return -EINVAL;
> +		return 0;

So by convention returning 0 is success and negative value means error.
I don't see the reason for changing that in the whole code.

>  	}
>  
>  	patch->data = kmemdup(fw + SECTION_HDR_SIZE, patch_size, GFP_KERNEL);
>  	if (!patch->data) {
>  		pr_err("Patch data allocation failure.\n");
>  		kfree(patch);
> -		return -EINVAL;
> +		return 0;
>  	}
>  
>  	INIT_LIST_HEAD(&patch->plist);
> @@ -793,26 +787,27 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
>  	enum ucode_state ret = UCODE_ERROR;
>  	unsigned int leftover;
>  	u8 *fw = (u8 *)data;
> -	int crnt_size = 0;
> -	int offset;
> +	unsigned int offset;
>  
> -	offset = install_equiv_cpu_table(data);
> -	if (offset < 0) {
> +	offset = install_equiv_cpu_table(data, size);
> +	if (!offset) {
>  		pr_err("failed to create equivalent cpu table\n");
>  		return ret;
>  	}
> -	fw += offset;
> -	leftover = size - offset;
>  
> -	if (*(u32 *)fw != UCODE_UCODE_TYPE) {
> -		pr_err("invalid type field in container file section header\n");
> -		free_equiv_cpu_table();
> -		return ret;
> -	}
> +	/*
> +	 * Skip also the container header, since install_equiv_cpu_table()
> +	 * returns just the raw equivalence table size without the header.
> +	 */
> +	fw += CONTAINER_HDR_SZ;
> +	fw += offset;
> +	leftover = size - CONTAINER_HDR_SZ - offset;
>  
>  	while (leftover) {
> +		unsigned int crnt_size;
> +
>  		crnt_size = verify_and_add_patch(family, fw, leftover);
> -		if (crnt_size < 0)
> +		if (!crnt_size)

Ditto.

>  			return ret;
>  
>  		fw	 += crnt_size;
> @@ -895,10 +890,8 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
>  	}
>  
>  	ret = UCODE_ERROR;
> -	if (*(u32 *)fw->data != UCODE_MAGIC) {
> -		pr_err("invalid magic value (0x%08x)\n", *(u32 *)fw->data);
> +	if (!verify_container(fw->data, fw->size, false))
>  		goto fw_release;
> -	}
>  
>  	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size);
>  

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
