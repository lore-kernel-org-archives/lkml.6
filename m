Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6761AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C9B20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="PPRKteYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfAaGHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:07:53 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:25735 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfAaGHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:07:52 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43qqXN2zD6z9v0y2;
        Thu, 31 Jan 2019 07:07:48 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PPRKteYu; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 8eQljt9yKxMk; Thu, 31 Jan 2019 07:07:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43qqXN19Kmz9v0y0;
        Thu, 31 Jan 2019 07:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548914868; bh=NCah7PD0r/noHO/Uh52qxtNlyFWpGoyRnjJU9LYwodw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PPRKteYuUZeYij8URy8Yi6SlDuWnapGXe+mGP4EjcgzMqqNP8EZdSP5FNVjPYInsT
         1SLAJFU3/5dHTmUUvReCIz9Epq15HGwbyMCJ7xsQ51aFHaQlJbFmKmOks3EsEBfY8B
         rAbHZg9+ub3vVM8gaD3FsZGuNpYhHL+xUNVYs/Xg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E31D88B78D;
        Thu, 31 Jan 2019 07:07:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UCr4ES66h6TH; Thu, 31 Jan 2019 07:07:48 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FD748B74C;
        Thu, 31 Jan 2019 07:07:46 +0100 (CET)
Subject: Re: [PATCH v2 19/21] treewide: add checks for the return value of
 memblock_alloc*()
To:     Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org
Cc:     Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev@googlegroups.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Salter <msalter@redhat.com>,
        Dennis Zhou <dennis@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        linux-snps-arc@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
        linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, Rob Herring <robh+dt@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        xen-devel@lists.xenproject.org, Stafford Horne <shorne@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        openrisc@lists.librecores.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b7c12014-14ae-2a38-900c-41fd145307bc@c-s.fr>
Date:   Thu, 31 Jan 2019 07:07:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548057848-15136-20-git-send-email-rppt@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/01/2019 à 09:04, Mike Rapoport a écrit :
> Add check for the return value of memblock_alloc*() functions and call
> panic() in case of error.
> The panic message repeats the one used by panicing memblock allocators with
> adjustment of parameters to include only relevant ones.
> 
> The replacement was mostly automated with semantic patches like the one
> below with manual massaging of format strings.
> 
> @@
> expression ptr, size, align;
> @@
> ptr = memblock_alloc(size, align);
> + if (!ptr)
> + 	panic("%s: Failed to allocate %lu bytes align=0x%lx\n", __func__,
> size, align);
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Reviewed-by: Guo Ren <ren_guo@c-sky.com>             # c-sky
> Acked-by: Paul Burton <paul.burton@mips.com>	     # MIPS
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
> Reviewed-by: Juergen Gross <jgross@suse.com>         # Xen
> ---

[...]

> diff --git a/mm/sparse.c b/mm/sparse.c
> index 7ea5dc6..ad94242 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c

[...]

> @@ -425,6 +436,10 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>   		memblock_alloc_try_nid_raw(size, PAGE_SIZE,
>   						__pa(MAX_DMA_ADDRESS),
>   						MEMBLOCK_ALLOC_ACCESSIBLE, nid);
> +	if (!sparsemap_buf)
> +		panic("%s: Failed to allocate %lu bytes align=0x%lx nid=%d from=%lx\n",
> +		      __func__, size, PAGE_SIZE, nid, __pa(MAX_DMA_ADDRESS));
> +

memblock_alloc_try_nid_raw() does not panic (help explicitly says: Does 
not zero allocated memory, does not panic if request cannot be satisfied.).

Stephen Rothwell reports a boot failure due to this change.

Christophe

>   	sparsemap_buf_end = sparsemap_buf + size;
>   }
>   
> 
