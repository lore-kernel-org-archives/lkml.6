Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752446AbeC2QOn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:14:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:33806 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752077AbeC2QOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:14:41 -0400
Date: Thu, 29 Mar 2018 18:14:22 +0200
Message-ID: <20180329181422.Horde.4gvIQbpSZkuyC4Yzg06PKw2@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 03/19] powerpc: Mark variables as unused
References: <20180322202007.23088-4-malat@debian.org>
 <20180328193307.978-1-malat@debian.org>
In-Reply-To: <20180328193307.978-1-malat@debian.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> a écrit :

> Add gcc attribute unused for two variables. Fix warnings treated as errors
> with W=1:
>
>   arch/powerpc/kernel/prom_init.c:1388:8: error: variable ‘path’ set  
> but not used [-Werror=unused-but-set-variable]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: move path within ifdef DEBUG_PROM
>
>  arch/powerpc/kernel/prom_init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_init.c  
> b/arch/powerpc/kernel/prom_init.c
> index acf4b2e0530c..4163b11abb6c 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -603,7 +603,7 @@ static void __init early_cmdline_parse(void)
>  	const char *opt;
>
>  	char *p;
> -	int l = 0;
> +	int l __maybe_unused = 0;
>
>  	prom_cmd_line[0] = 0;
>  	p = prom_cmd_line;
> @@ -1385,7 +1385,7 @@ static void __init reserve_mem(u64 base, u64 size)
>  static void __init prom_init_mem(void)
>  {
>  	phandle node;
> -	char *path, type[64];
> +	char *path __maybe_unused, type[64];

You should enclose that in an ifdef DEBUG_PROM instead of hiding the warning

Christophe

>  	unsigned int plen;
>  	cell_t *p, *endp;
>  	__be32 val;
> @@ -1406,7 +1406,6 @@ static void __init prom_init_mem(void)
>  	prom_debug("root_size_cells: %x\n", rsc);
>
>  	prom_debug("scanning memory:\n");
> -	path = prom_scratch;
>
>  	for (node = 0; prom_next_node(&node); ) {
>  		type[0] = 0;
> @@ -1431,6 +1430,7 @@ static void __init prom_init_mem(void)
>  		endp = p + (plen / sizeof(cell_t));
>
>  #ifdef DEBUG_PROM
> +		path = prom_scratch;
>  		memset(path, 0, PROM_SCRATCH_SIZE);
>  		call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
>  		prom_debug("  node %s :\n", path);
> --
> 2.11.0
