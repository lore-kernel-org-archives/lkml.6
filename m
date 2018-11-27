Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82501C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DBA208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFvCYUdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DBA208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeK1IPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:15:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45721 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeK1IPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:15:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so8423022pgc.12;
        Tue, 27 Nov 2018 13:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=POLOYIiJuU8CSX2TWzyy+YnWmRatYsfe9ljSBPA02cc=;
        b=ZFvCYUdPkDH7NO0rp6JgX1scwTdNTO8jtyDg7Rwsfu2WJCKOnycrvqEYrFlEr/cmKI
         aeOjz2bskKgyZvu8lcXfVqHlDRi4k+fbk+EhjmScBxi53fhER9x9BZuIh3e9DiQDnjfC
         RjfTuHmUzn9LmJsIs5uiHMe1h/8aVb3BUmqJdd/qfjMS679ratilbx3u/6LPkZl+oUGb
         eQ54kVVLrev7o8CxgOLedEcQEP6KaTbhGB49Hvl8daEeetNklnYqDYubYvVENHDZxrwS
         brHRLhvU8eZZBLcZlOlAdQXRnLZjl/sVWsDae715iO1f+vPg9/obZv0J4ZGjRa6wOqad
         TrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=POLOYIiJuU8CSX2TWzyy+YnWmRatYsfe9ljSBPA02cc=;
        b=JOXNzdmVwkwJSO0c1X2bLD0077wWMOxQmNR/J3gmNyDy/ttkTSd2PyP+Fms5S/I2oL
         kofYSZVGkFWknaCYAGqQYqEETymkacPniSJP2gQw5YZEGuK6iACgUqmLHeoLFkIGFvdz
         GgpKcqbG2InRUVcqTPxlR4CUyK7sKWAG9d98hKwMY2RmjnNtfgyyKZDjSxTMHTqSBDGt
         hio5rosDEaHxSDXctYz8g2LiUrYiiOKRyVX10yrxLnB+l07y3oiAexYa30M+zlkY1akn
         R8oNnUcQ5QslZfhUjVgFlY9j2mYtVCr1xUeWDKuQzcmBe63ljQa4N8l2uEfLoBLJuCCQ
         n5ZA==
X-Gm-Message-State: AA+aEWa4PXdcjl29dZzMJA6mN8SfEd+R5voVTLjqUGAIl8pcbQkrvUbX
        ASIjsvEs4R/3EBtx/7cMQr4z8PCrkqY=
X-Google-Smtp-Source: AFSGD/XiXnPx8nsrAwbkwBA1FsS2iMO2juvBawJVCbnt6kjMC7HFbLiLGwtBdZhmWYphxFeYJ/Q3RA==
X-Received: by 2002:a63:fe48:: with SMTP id x8mr31264176pgj.261.1543353363014;
        Tue, 27 Nov 2018 13:16:03 -0800 (PST)
Received: from localhost (g206.124-44-15.ppp.wakwak.ne.jp. [124.44.15.206])
        by smtp.gmail.com with ESMTPSA id 69sm6193028pgg.86.2018.11.27.13.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 13:16:02 -0800 (PST)
Date:   Wed, 28 Nov 2018 06:16:00 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Greentime Hu <green.hu@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Michal Simek <monstr@monstr.eu>,
        Mark Salter <msalter@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Vincent Chen <deanbo422@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 4/5] openrisc: simplify pte_alloc_one_kernel()
Message-ID: <20181127211600.GB3235@lianli.shorne-pla.net>
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
 <1543182277-8819-5-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543182277-8819-5-git-send-email-rppt@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2018 at 11:44:36PM +0200, Mike Rapoport wrote:
> The pte_alloc_one_kernel() function allocates a page using
> __get_free_page(GFP_KERNEL) when mm initialization is complete and
> memblock_phys_alloc() on the earlier stages. The physical address of the
> page allocated with memblock_phys_alloc() is converted to the virtual
> address and in the both cases the allocated page is cleared using
> clear_page().
> 
> The code is simplified by replacing __get_free_page() with
> get_zeroed_page() and by replacing memblock_phys_alloc() with
> memblock_alloc().

Hello Mike,

This looks fine to me.  How do you plan to get this merged?  Will you be taking
care of the whole series or so you want me to queue this openrisc part?

> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/mm/ioremap.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index c969752..cfef989 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -123,13 +123,10 @@ pte_t __ref *pte_alloc_one_kernel(struct mm_struct *mm,
>  {
>  	pte_t *pte;
>  
> -	if (likely(mem_init_done)) {
> -		pte = (pte_t *) __get_free_page(GFP_KERNEL);
> -	} else {
> -		pte = (pte_t *) __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
> -	}
> +	if (likely(mem_init_done))
> +		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
> +	else
> +		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  
> -	if (pte)
> -		clear_page(pte);
>  	return pte;
>  }
> -- 
> 2.7.4
> 
