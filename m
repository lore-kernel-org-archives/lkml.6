Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932141AbeCKJ76 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 05:59:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51592 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932113AbeCKJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 05:59:56 -0400
X-Google-Smtp-Source: AG47ELvmd7mZmT0diRAnfXvaZcxYb1GxSbQQufbc76psGAaqsUvEOOPqNTbjssAh8kiGiD7PYJ34Jw==
Date: Sun, 11 Mar 2018 10:59:52 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/AMD: check microcode file sanity before
 loading it
Message-ID: <20180311095952.vphoszyohug7tkme@gmail.com>
References: <34e9d679-2eca-90cf-9a95-3864f0be060e@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34e9d679-2eca-90cf-9a95-3864f0be060e@maciej.szmigiero.name>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Maciej S. Szmigiero <mail@maciej.szmigiero.name> wrote:

> Currently, it is very easy to make the AMD microcode update driver crash
> or spin on a malformed microcode file since it does very little
> consistency checking on data loaded from such file.
> 
> This commit introduces various checks, mostly on length-type fields, so
> all corrupted microcode files are (hopefully) correctly rejected instead.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
> Test files are at https://pastebin.com/XkKUSmMp
> One has to enable KASAN in the kernel config and rename a particular
> test file to name appropriate to the running CPU family to test its
> loading.
> 
>  arch/x86/include/asm/microcode_amd.h |   6 ++
>  arch/x86/kernel/cpu/microcode/amd.c  | 111 ++++++++++++++++++++++++++---------
>  2 files changed, 89 insertions(+), 28 deletions(-)

Treating microcode update files as external input and sanity checking the data 
makes sense I suppose, but there's various small uglies in the patch:

> +/* if a patch is larger than this the microcode file is surely corrupted */
> +#define PATCH_MAX_SIZE_ABSOLUTE (16 * 1024 * 1024)

Please capitalize comments.

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
> +	u32 eqsize;
>  	u16 eq_id;
>  	u8 *buf;

So we have 'eq_id', but 'eqsize'? Why not 'eq_size' to have fewer random 
variations of coding style?

>  
> +	if (size < CONTAINER_HDR_SZ)
> +		return 0;

The comment about CONTAINER_HDR_SZ better belongs here, where we use it.

>  	/* Am I looking at an equivalence table header? */
>  	if (hdr[0] != UCODE_MAGIC ||
>  	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
>  	    hdr[2] == 0)
>  		return CONTAINER_HDR_SZ;
>  
> +	eqsize = hdr[2];
> +	if (eqsize < sizeof(*eq) ||
> +	    eqsize > UCODE_EQUIV_CPU_TABLE_MAX_SIZE)
> +		return 0;
> +
> +	if (size < CONTAINER_HDR_SZ + eqsize)
> +		return 0;
> +
>  	buf = ucode;
>  
>  	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
>  
>  	/* Find the equivalence ID of our CPU in this table: */
> -	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
> +	eq_id = find_equiv_id(eq, eqsize / sizeof(*eq), desc->cpuid_1_eax);

Does eq_size have to be a multiple of sizeof(*eq)? If yes then we should probably 
check that too.

> -static int install_equiv_cpu_table(const u8 *buf)
> +static int install_equiv_cpu_table(const u8 *buf, size_t bufsize)

s/bufsize/buf_size

>  {
>  	unsigned int *ibuf = (unsigned int *)buf;
> -	unsigned int type = ibuf[1];
> -	unsigned int size = ibuf[2];
> +	unsigned int type, size;
>  
> -	if (type != UCODE_EQUIV_CPU_TABLE_TYPE || !size) {
> -		pr_err("empty section/"
> -		       "invalid type field in container file section header\n");
> +	if (bufsize < CONTAINER_HDR_SZ) {
> +		pr_err("no container header\n");
> +		return -EINVAL;
> +	}
> +
> +	type = ibuf[1];
> +	if (type != UCODE_EQUIV_CPU_TABLE_TYPE) {
> +		pr_err("invalid type field in container file section header\n");
> +		return -EINVAL;
> +	}
> +
> +	size = ibuf[2];
> +	if (size < sizeof(struct equiv_cpu_entry) ||
> +	    size > UCODE_EQUIV_CPU_TABLE_MAX_SIZE) {
> +		pr_err("equivalent CPU table size invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	if (bufsize < CONTAINER_HDR_SZ + size) {
> +		pr_err("equivalent CPU table truncated\n");
>  		return -EINVAL;
>  	}
>  
> @@ -559,6 +599,7 @@ static int install_equiv_cpu_table(const u8 *buf)
>  	}
>  
>  	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, size);
> +	equiv_cpu_table_size = size / sizeof(struct equiv_cpu_entry);

Btw., 'equiv_cpu_table_size' is an ambiguous name: often _size variables are in 
byte units - but this is number of entries. So the name should be 
'equiv_cpu_table_entries' or so.

Thanks,

	Ingo
