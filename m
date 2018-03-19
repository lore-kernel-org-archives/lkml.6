Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936733AbeCSWkt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:40:49 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39812 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936636AbeCSWjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:39:53 -0400
X-Google-Smtp-Source: AG47ELtZGkM4X2v6Qe58Hq0c3XzEctPCmALOpy+ofujYZmXroDaCucMneK6u4so6vzb/O0snNGJWdA==
Date: Tue, 20 Mar 2018 09:39:40 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH  1/2] powerpc/mm: Add missing tracepoint for tlbie
Message-ID: <20180320093940.56144adf@balbir.ozlabs.ibm.com>
In-Reply-To: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
References: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Mar 2018 11:32:38 +0100 (CET)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> commit 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
> added tracepoints for tlbie calls, but _tlbil_va() was forgotten
> 
> Fixes: 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/mmu_decl.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index 57fbc554c785..b9991e0c61a2 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -21,6 +21,7 @@
>  #include <linux/mm.h>
>  #include <asm/tlbflush.h>
>  #include <asm/mmu.h>
> +#include <asm/trace.h>
>  
>  #ifdef CONFIG_PPC_MMU_NOHASH
>  
> @@ -56,6 +57,7 @@ static inline void _tlbil_va(unsigned long address, unsigned int pid,
>  			     unsigned int tsize, unsigned int ind)
>  {
>  	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
> +	trace_tlbie(pid, 0, address, 0, 0, 0, 0);


I did not really cover a whole lot of NOHASH, any idea why its
called tlbil_va and not _tlbie_va?

The first field is really the lpid and should be 0 for non-virtualized
systems. Can I recommend that we rs field for pid and the rb field for
address? so effectively something like

trace_tlbie(0, 0, address, pid, 0, 0, 0);

Balbir
