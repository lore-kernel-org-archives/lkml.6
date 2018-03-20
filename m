Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeCTPm0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:42:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48900 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeCTPmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:42:21 -0400
Date: Tue, 20 Mar 2018 16:41:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] x86/microcode/AMD: Check equivalence table
 length in the early loader
Message-ID: <20180320154147.GA6815@cz.tnic>
References: <cover.1521150415.git.mail@maciej.szmigiero.name>
 <fe4fe465-b114-ffa5-7c2a-3ccb5b9ba38c@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe4fe465-b114-ffa5-7c2a-3ccb5b9ba38c@maciej.szmigiero.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 12:07:50AM +0100, Maciej S. Szmigiero wrote:
> Before loading a CPU equivalence table from a microcode container file we
> need to verify whether this file is actually large enough to contain the
> table of a size indicated in this file.
> If it is not, there is no point of continuing with loading it since
> microcode patches are located after the equivalence table anyway.
> 
> This patch adds these checks to the early loader.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>  arch/x86/kernel/cpu/microcode/amd.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
> index 6a93be0f771c..138c9fb983f2 100644
> --- a/arch/x86/kernel/cpu/microcode/amd.c
> +++ b/arch/x86/kernel/cpu/microcode/amd.c
> @@ -80,20 +80,33 @@ static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
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
> +	unsigned int cont_magic, cont_type;
> +	size_t equiv_tbl_len;
>  	u16 eq_id;
>  	u8 *buf;
>  
> +	if (size < CONTAINER_HDR_SZ)
> +		return 0;
> +
> +	cont_magic	= hdr[0];
> +	cont_type	= hdr[1];
> +	equiv_tbl_len	= hdr[2];

All three are u32.

>  	/* Am I looking at an equivalence table header? */
> -	if (hdr[0] != UCODE_MAGIC ||
> -	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
> -	    hdr[2] == 0)
> +	if (cont_magic != UCODE_MAGIC ||
> +	    cont_type != UCODE_EQUIV_CPU_TABLE_TYPE ||
> +	    equiv_tbl_len == 0)
>  		return CONTAINER_HDR_SZ;
>  
> +	if (equiv_tbl_len < sizeof(*eq) ||

If you do this, then the above == 0 check can go.

> +	    size - CONTAINER_HDR_SZ < equiv_tbl_len)
> +		return size;
> +
>  	buf = ucode;
>  
>  	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply. Srsly.
