Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFABDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1F121852
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeLSIEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:04:45 -0500
Received: from ozlabs.org ([203.11.71.1]:54191 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbeLSIEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:04:44 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43KS9620zxz9s7W;
        Wed, 19 Dec 2018 19:04:42 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc: implement CONFIG_DEBUG_VIRTUAL
In-Reply-To: <5e18c60e-9572-5844-b17d-aa55e7ff4709@c-s.fr>
References: <a42260e77d609a10667872c2e7bf14ceabcce050.1544562518.git.christophe.leroy@c-s.fr> <87y38nrkto.fsf@concordia.ellerman.id.au> <87a7l2s6p3.fsf@concordia.ellerman.id.au> <f725ff38-4dd8-0657-6023-4b0b5b0d5f4e@c-s.fr> <5e18c60e-9572-5844-b17d-aa55e7ff4709@c-s.fr>
Date:   Wed, 19 Dec 2018 19:04:42 +1100
Message-ID: <87woo6q6w5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> On 12/19/2018 06:57 AM, Christophe Leroy wrote:
...
>
> In fact the solution is the following:
>
> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index 4fc77a99c9bf..60401af2bc8f 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -143,7 +143,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long 
> size, pgprot_t prot, void *call
>   	 * Don't allow anybody to remap normal RAM that we're using.
>   	 * mem_init() sets high_memory so only do the check after that.
>   	 */
> -	if (slab_is_available() && (p < virt_to_phys(high_memory)) &&
> +	if (slab_is_available() && (p <= virt_to_phys(high_memory - 1)) &&
>   	    page_is_ram(__phys_to_pfn(p))) {
>   		printk("__ioremap(): phys addr 0x%llx is RAM lr %ps\n",
>   		       (unsigned long long)p, __builtin_return_address(0));
>
>
> I'll send an updated patch in a few minutes.

Awesome, thanks. I'll take v4.

cheers
