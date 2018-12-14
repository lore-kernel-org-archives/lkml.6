Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C5C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B8020811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B8020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeLNGWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:22:36 -0500
Received: from ozlabs.org ([203.11.71.1]:34031 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbeLNGWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:22:36 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43GL7Y02mzz9s3q;
        Fri, 14 Dec 2018 17:22:32 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/prom: fix early DEBUG messages
In-Reply-To: <531e7e818b5c4867148412c7902a9cbeee5745ee.1544709040.git.christophe.leroy@c-s.fr>
References: <531e7e818b5c4867148412c7902a9cbeee5745ee.1544709040.git.christophe.leroy@c-s.fr>
Date:   Fri, 14 Dec 2018 17:22:31 +1100
Message-ID: <87pnu4vd94.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index fe758cedb93f..d8e56e03c9c6 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -749,7 +749,11 @@ void __init early_init_devtree(void *params)
>  	memblock_allow_resize();
>  	memblock_dump_all();
>  
> +#ifdef CONFIG_PHYS_64BIT
>  	DBG("Phys. mem: %llx\n", memblock_phys_mem_size());
> +#else
> +	DBG("Phys. mem: %x\n", memblock_phys_mem_size());
> +#endif

Can we just do:

  	DBG("Phys. mem: %llx\n", (unsigned long long)memblock_phys_mem_size());

?

cheers
