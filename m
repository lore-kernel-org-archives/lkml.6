Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD453C282C7
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C86721909
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQJUgaYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfA0DHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 22:07:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41475 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfA0DHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 22:07:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so6245263plm.8;
        Sat, 26 Jan 2019 19:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5gqtElyGAjgWA1IcD3f1+6EYOKOhZl25WPW+/clLjQw=;
        b=DQJUgaYyc2s9cDIgDXTbhgKcePEzBol2WZvwvI6xmrwG+LJZGqMLESHYlxBSvlyyQ+
         oUI2SaaDg/nIxSIVyyBEipyPmK2fYHmtCyy+DuhILnqyKmu6E9VS52zUYIar2ouPKRdT
         spF0yBPuFHYuwM3tKB7m/bM+hdtYY8xeINYQ75T8D69QJml4TyVnU8zheDFZ5xRv/+d0
         fZacP6AYd7yMLzeYEBYuBCZR0ps5yO4SEfRDf0avcrWF/WhVzAvlgh4beOcKHCs3Rmim
         bGR8TFht5XxX3GHKhLXiZmgiwFe5kndg4WxAiv/zrboSXN3mxjy6wEx8Agq+Buk9nU7Q
         w6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5gqtElyGAjgWA1IcD3f1+6EYOKOhZl25WPW+/clLjQw=;
        b=BMQ3W1xhnkMVrdYnOInCElkDEtIksCOFew/hBK95eGuxZs5voHK4HOJrFO1J9Axaxt
         3SDnkYzZdzIThd/O3Jm1MCMTfsIqKVWAOKl8sjSwJyyxsZW0DXfZ6s8Hi0ndZdQYBA/a
         HFhIeal5Nw2WJltZJMOJlTlPA2ugSYpEAxlj60usGLkpXCA3e+wUnUoHZHhsPhAUlKnA
         tTFdshsa3uyf9JzVp7O79JlB8/AYXTTLvxZI8634/A8R4Uslm7PqxbvmPDQTNlcD12q1
         R0+x6U6GyVXYZXAs3fv9xdtS8FWNxgHB8gyh1HPMZLWWawOm66yfOU0nfo6c3eYRiqWT
         9+1Q==
X-Gm-Message-State: AJcUukfD5SXfuf9Z6AzfivPuNW66vt63Wn1vQGxdjEQz5aflDenm22pv
        bUAWkDELE52iuq/PQLoHcrU=
X-Google-Smtp-Source: ALg8bN5eshCohDgRr4aNT4DHZbbxXbPGsl6tcfcU1p2ZW+JtAH0/P63w9fWMtbQ4B+tA+eLKxDtTiQ==
X-Received: by 2002:a17:902:584:: with SMTP id f4mr17453617plf.28.1548558431604;
        Sat, 26 Jan 2019 19:07:11 -0800 (PST)
Received: from localhost (g206.124-44-15.ppp.wakwak.ne.jp. [124.44.15.206])
        by smtp.gmail.com with ESMTPSA id t24sm53501159pfm.127.2019.01.26.19.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 19:07:10 -0800 (PST)
Date:   Sun, 27 Jan 2019 12:07:08 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mark Salter <msalter@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Burton <paul.burton@mips.com>,
        Petr Mladek <pmladek@suse.com>, Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        devicetree@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 01/21] openrisc: prefer memblock APIs returning
 virtual address
Message-ID: <20190127030708.GU3235@lianli.shorne-pla.net>
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-2-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548057848-15136-2-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:03:48AM +0200, Mike Rapoport wrote:
> The allocation of the page tables memory in openrics uses
> memblock_phys_alloc() and then converts the returned physical address to
> virtual one. Use memblock_alloc_raw() and add a panic() if the allocation
> fails.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/openrisc/mm/init.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index d157310..caeb418 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -105,7 +105,10 @@ static void __init map_ram(void)
>  			}
>  
>  			/* Alloc one page for holding PTE's... */
> -			pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
> +			pte = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
> +			if (!pte)
> +				panic("%s: Failed to allocate page for PTEs\n",
> +				      __func__);
>  			set_pmd(pme, __pmd(_KERNPG_TABLE + __pa(pte)));
>  
>  			/* Fill the newly allocated page with PTE'S */

This seems reasonable to me.

Acked-by: Stafford Horne <shorne@gmail.com>

