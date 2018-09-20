Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2F8ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5090E214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DxEOh4DN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5090E214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbeITWSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:18:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44195 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeITWSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:18:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so4616414pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JYOmla0n1uPX2EqcirMgDi34s3t054En5iJPSluVjc8=;
        b=DxEOh4DNQ8T7HT5fMkhMm20jrKBqFR6Xx4OlK/gu82Qtl/Z8P6Z15f+OgVeQOQ22sw
         JE9zpruU6ouEWDAs3odwi1qX5OoxviVTA9mh3tMOXJZxyd+sCXRiaD4R6qQeRTwbcK9X
         J13XJBtdj7wm3DWJlL11CnBWgZWWDdr27VRCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JYOmla0n1uPX2EqcirMgDi34s3t054En5iJPSluVjc8=;
        b=rc2SDboHwOEAhOt/BU50Tr+LpoD5fbecSMlo3Gx8iNwJYkkmPlKAcrUkVGhJnsE0Vl
         PeGaVvr/iu/dcs3wrlPCkg0pRl2wEqXiNr6g9jcXtVLaigItdqnAMAMrfPn/gNFPkbQK
         LSK4xFwxZ9DhE4xwuCB0qG6FPzu6po/P98JI8xUB1oR2YuH+4EbYAuDskRjTkJ8gxVj7
         r2vLjm9e6N1yRLaxWl5pQ7r/+Tu6SEy++/im8/1eo+boOaXr/bht9Zr4Hxfaih8Rea5I
         byZoVTh1iScuftyyA+REhyArB5deYQRcOchaJgpiaOALo2b14Ye4QC9OuwiSjc7o5u3c
         pF/g==
X-Gm-Message-State: APzg51DoZnc7fCfLyFQMQmgKKV6CodUVBZurvakZzgDJpfbnzR1CvS7e
        IPWr4BGc3LLmNCfrwkFYacI/2A==
X-Google-Smtp-Source: ANB0VdYHJxPufJR7V8EOcxYelE+2fOblhbLIJZqxb7yECQ2Pn1WkBgFymj5cCg1PCm6QvwqJxyjjfw==
X-Received: by 2002:a62:6711:: with SMTP id b17-v6mr42376156pfc.243.1537461275528;
        Thu, 20 Sep 2018 09:34:35 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p64-v6sm38594682pfa.47.2018.09.20.09.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:34:34 -0700 (PDT)
Date:   Thu, 20 Sep 2018 09:38:45 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/4] mm: move is_kernel_rodata() to
 asm-generic/sections.h
Message-ID: <20180920163845.GG1367@tuxbook-pro>
References: <20180828093332.20674-1-brgl@bgdev.pl>
 <20180828093332.20674-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828093332.20674-3-brgl@bgdev.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Aug 02:33 PDT 2018, Bartosz Golaszewski wrote:

> Export this routine so that we can use it later in devm_kstrdup_const()
> and devm_kfree_const().
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  include/asm-generic/sections.h | 14 ++++++++++++++
>  mm/util.c                      |  7 -------
>  2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
> index 849cd8eb5ca0..d79abca81a52 100644
> --- a/include/asm-generic/sections.h
> +++ b/include/asm-generic/sections.h
> @@ -141,4 +141,18 @@ static inline bool init_section_intersects(void *virt, size_t size)
>  	return memory_intersects(__init_begin, __init_end, virt, size);
>  }
>  
> +/**
> + * is_kernel_rodata - checks if the pointer address is located in the
> + *                    .rodata section
> + *
> + * @addr: address to check
> + *
> + * Returns: true if the address is located in .rodata, false otherwise.
> + */
> +static inline bool is_kernel_rodata(unsigned long addr)
> +{
> +	return addr >= (unsigned long)__start_rodata &&
> +	       addr < (unsigned long)__end_rodata;
> +}
> +
>  #endif /* _ASM_GENERIC_SECTIONS_H_ */
> diff --git a/mm/util.c b/mm/util.c
> index d2890a407332..41e9892a50ce 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -15,17 +15,10 @@
>  #include <linux/vmalloc.h>
>  #include <linux/userfaultfd_k.h>
>  
> -#include <asm/sections.h>
>  #include <linux/uaccess.h>
>  
>  #include "internal.h"
>  
> -static inline int is_kernel_rodata(unsigned long addr)
> -{
> -	return addr >= (unsigned long)__start_rodata &&
> -		addr < (unsigned long)__end_rodata;
> -}
> -
>  /**
>   * kfree_const - conditionally free memory
>   * @x: pointer to the memory
> -- 
> 2.18.0
> 
