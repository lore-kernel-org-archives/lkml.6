Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeDRJNQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:13:16 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:38404 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbeDRJNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:13:14 -0400
X-Google-Smtp-Source: AIpwx49eSnTZC9dL/ZrS1h1ebVxLHArk9Nn7Elm/K40ScveG7NE0VdJpQT2OrycH9lEWB/2BcTFYeA==
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp,
        dalias@libc.org, thomas.petazzoni@free-electrons.com,
        robin.murphy@arm.com
Cc: geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <75621aa6-1fe9-2049-fc70-fd6d542c7307@cogentembedded.com>
Date: Wed, 18 Apr 2018 12:13:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 4/17/2018 4:35 PM, Jacopo Mondi wrote:

> With commit ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping
> operations observe dev->dma_pfn_offset") the generic DMA allocation
> function on which the SH 'dma_alloc_coherent()' function relies on,
> access the 'dma_pfn_offset' field of struct device.
> 
> Unfortunately the 'dma_generic_alloc_coherent()' function is called from
> several places with a NULL struct device argument, halting the CPU
> during the boot process.
> 
> This patch fixes the issue protecting access to dev->dma_pfn_offset,
> with a trivial check for validity. It also passes a valid 'struct device'
> in the 'platform_resource_setup_memory' function which is the main user
> of 'dma_alloc_coherent()', and inserting a WARN_ON() check to make future
> (and existing) bogus users of this function they're should provide a valid
> 'struct device' whenever possible.
> 
> Fixes: ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset")
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>   arch/sh/mm/consistent.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
> index 8ce9869..b257155 100644
> --- a/arch/sh/mm/consistent.c
> +++ b/arch/sh/mm/consistent.c
[...]
> @@ -69,9 +73,14 @@ void dma_generic_free_coherent(struct device *dev, size_t size,
>   			       unsigned long attrs)
>   {
>   	int order = get_order(size);
> -	unsigned long pfn = (dma_handle >> PAGE_SHIFT) + dev->dma_pfn_offset;
> +	unsigned long pfn = (dma_handle >> PAGE_SHIFT);

    Parens no longer needed...

[...]

MBR, Sergei
