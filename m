Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeDFPdu convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:33:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38677 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752926AbeDFPds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:33:48 -0400
Date: Fri, 06 Apr 2018 17:33:35 +0200
Message-ID: <20180406173335.Horde.Qgml03BtHOxSl6SzIPgQLA9@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 03/19] powerpc: Mark variable `l` as unused, remove
 `path`
References: <20180322202007.23088-4-malat@debian.org>
 <20180405202648.2836-1-malat@debian.org>
In-Reply-To: <20180405202648.2836-1-malat@debian.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> a écrit :

> Add gcc attribute unused for `l` variable, replace `path` variable directly
> with prom_scratch. Fix warnings treated as errors with W=1:
>
>   arch/powerpc/kernel/prom_init.c:607:6: error: variable ‘l’ set but  
> not used [-Werror=unused-but-set-variable]
>   arch/powerpc/kernel/prom_init.c:1388:8: error: variable ‘path’ set  
> but not used [-Werror=unused-but-set-variable]
>
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v4: redo v3 since path variable can be avoided
> v3: really move path within ifdef DEBUG_PROM
> v2: move path within ifdef DEBUG_PROM
>
>  arch/powerpc/kernel/prom_init.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c  
> b/arch/powerpc/kernel/prom_init.c
> index f8a9a50ff9b5..4b223a9470be 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -604,7 +604,7 @@ static void __init early_cmdline_parse(void)
>  	const char *opt;
>
>  	char *p;
> -	int l = 0;
> +	int l __maybe_unused = 0;

Instead of hiding the problem with __maybe_unused, I think we could  
replace the
#ifdef CONFIG_CMDLINE
by a
if (IS_ENABLED(CONFIG_CMDLINE_BOOL))

This is recommanded by Linux codying style

Christophe

>
>  	prom_cmd_line[0] = 0;
>  	p = prom_cmd_line;
> @@ -1386,7 +1386,7 @@ static void __init reserve_mem(u64 base, u64 size)
>  static void __init prom_init_mem(void)
>  {
>  	phandle node;
> -	char *path, type[64];
> +	char type[64];
>  	unsigned int plen;
>  	cell_t *p, *endp;
>  	__be32 val;
> @@ -1407,7 +1407,6 @@ static void __init prom_init_mem(void)
>  	prom_debug("root_size_cells: %x\n", rsc);
>
>  	prom_debug("scanning memory:\n");
> -	path = prom_scratch;
>
>  	for (node = 0; prom_next_node(&node); ) {
>  		type[0] = 0;
> @@ -1432,9 +1431,9 @@ static void __init prom_init_mem(void)
>  		endp = p + (plen / sizeof(cell_t));
>
>  #ifdef DEBUG_PROM
> -		memset(path, 0, PROM_SCRATCH_SIZE);
> -		call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
> -		prom_debug("  node %s :\n", path);
> +		memset(prom_scratch, 0, PROM_SCRATCH_SIZE);
> +		call_prom("package-to-path", 3, 1, node, prom_scratch,  
> PROM_SCRATCH_SIZE - 1);
> +		prom_debug("  node %s :\n", prom_scratch);
>  #endif /* DEBUG_PROM */
>
>  		while ((endp - p) >= (rac + rsc)) {
> --
> 2.11.0
