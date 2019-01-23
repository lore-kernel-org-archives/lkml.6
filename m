Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F0AC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4363720870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfAWOOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:14:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfAWOOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:14:39 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38E5CA7888;
        Wed, 23 Jan 2019 14:14:39 +0000 (UTC)
Received: from localhost (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF5256C207;
        Wed, 23 Jan 2019 14:14:35 +0000 (UTC)
Date:   Wed, 23 Jan 2019 22:14:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, jbohac@suse.cz,
        adobriyan@gmail.com, akpm@linux-foundation.org, osandov@fb.com,
        bhsharma@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v2] x86/gart/kcore: Exclude GART aperture from kcore
Message-ID: <20190123141432.GA19177@MiWiFi-R3L-srv>
References: <20190102105408.7124-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102105408.7124-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 23 Jan 2019 14:14:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/19 at 06:54pm, Kairui Song wrote:
> diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
> index 58176b56354e..c8a56f083419 100644
> --- a/arch/x86/kernel/aperture_64.c
> +++ b/arch/x86/kernel/aperture_64.c
> @@ -14,6 +14,7 @@
>  #define pr_fmt(fmt) "AGP: " fmt
>  
>  #include <linux/kernel.h>
> +#include <linux/kcore.h>
>  #include <linux/types.h>
>  #include <linux/init.h>
>  #include <linux/memblock.h>
> @@ -57,7 +58,7 @@ int fallback_aper_force __initdata;
>  
>  int fix_aperture __initdata = 1;
>  
> -#ifdef CONFIG_PROC_VMCORE
> +#if defined(CONFIG_PROC_VMCORE) || defined(CONFIG_PROC_KCORE)
>  /*
>   * If the first kernel maps the aperture over e820 RAM, the kdump kernel will
>   * use the same range because it will remain configured in the northbridge.
> @@ -66,7 +67,7 @@ int fix_aperture __initdata = 1;
>   */
>  static unsigned long aperture_pfn_start, aperture_page_count;
>  
> -static int gart_oldmem_pfn_is_ram(unsigned long pfn)
> +static int gart_mem_pfn_is_ram(unsigned long pfn)
>  {
>  	return likely((pfn < aperture_pfn_start) ||
>  		      (pfn >= aperture_pfn_start + aperture_page_count));
> @@ -76,7 +77,12 @@ static void exclude_from_vmcore(u64 aper_base, u32 aper_order)

Shouldn't this function name be changed? It's not only handling vmcore
stuff any more, but also kcore. And this function is not excluding, but
resgistering.

Other than this, it looks good to me.

Thanks
Baoquan

>  {
>  	aperture_pfn_start = aper_base >> PAGE_SHIFT;
>  	aperture_page_count = (32 * 1024 * 1024) << aper_order >> PAGE_SHIFT;
> -	WARN_ON(register_oldmem_pfn_is_ram(&gart_oldmem_pfn_is_ram));
> +#ifdef CONFIG_PROC_VMCORE
> +	WARN_ON(register_oldmem_pfn_is_ram(&gart_mem_pfn_is_ram));
> +#endif
> +#ifdef CONFIG_PROC_KCORE
> +	WARN_ON(register_mem_pfn_is_ram(&gart_mem_pfn_is_ram));
> +#endif
>  }
>  #else
>  static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
