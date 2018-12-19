Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBCAC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF786217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeLSEmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:42:55 -0500
Received: from ozlabs.org ([203.11.71.1]:51989 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbeLSEmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 23:42:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43KMhD4ngXz9s6w;
        Wed, 19 Dec 2018 15:42:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/prom: move the device tree if not in declared memory.
In-Reply-To: <9e06c82e76e8e29cb1ae0b989f3bbbb6b2099e03.1545053638.git.christophe.leroy@c-s.fr>
References: <9e06c82e76e8e29cb1ae0b989f3bbbb6b2099e03.1545053638.git.christophe.leroy@c-s.fr>
Date:   Wed, 19 Dec 2018 15:42:50 +1100
Message-ID: <871s6erut1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> If the device tree doesn't reside in the memory which is declared
> inside it, it has to be moved as well as this memory will not be
> mapped by the kernel.

I worry this will break some obscure platform, but I'll merge it anyway
and we'll see :)

cheers

> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 87a68e2dc531..4181ec715f88 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -124,8 +124,8 @@ static void __init move_device_tree(void)
>  	size = fdt_totalsize(initial_boot_params);
>  
>  	if ((memory_limit && (start + size) > PHYSICAL_START + memory_limit) ||
> -			overlaps_crashkernel(start, size) ||
> -			overlaps_initrd(start, size)) {
> +	    !memblock_is_memory(start + size - 1) ||
> +	    overlaps_crashkernel(start, size) || overlaps_initrd(start, size)) {
>  		p = __va(memblock_phys_alloc(size, PAGE_SIZE));
>  		memcpy(p, initial_boot_params, size);
>  		initial_boot_params = p;
> -- 
> 2.13.3
