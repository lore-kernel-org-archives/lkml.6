Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3461FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DBF2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 12:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbeLQM22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:28:28 -0500
Received: from ozlabs.org ([203.11.71.1]:38229 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbeLQM22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 07:28:28 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43JL6L30wlz9s4s;
        Mon, 17 Dec 2018 23:28:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/mm: make NULL pointer deferences explicit on bad page faults.
In-Reply-To: <46e2533084dc3255a1d67553b682bd4b9642b176.1544800765.git.christophe.leroy@c-s.fr>
References: <46e2533084dc3255a1d67553b682bd4b9642b176.1544800765.git.christophe.leroy@c-s.fr>
Date:   Mon, 17 Dec 2018 23:28:19 +1100
Message-ID: <87mup4tk0s.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 01b9bcc7fa85..3398291f4785 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -636,21 +636,24 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
>  	switch (TRAP(regs)) {
>  	case 0x300:
>  	case 0x380:
> -		printk(KERN_ALERT "Unable to handle kernel paging request for "
> -			"data at address 0x%08lx\n", regs->dar);
> +		if (regs->dar < PAGE_SIZE)
> +			pr_alert("BUG: Kernel NULL pointer dereference");
> +		else
> +			pr_alert("BUG: Unable to handle kernel data access");
> +		pr_cont(" at 0x%08lx\n", regs->dar);

It's best to avoid pr_cont() as it can lead to interleaving, so I
rewrote this as:

		pr_alert("BUG: %s at 0x%08lx\n",
			 regs->dar < PAGE_SIZE ? "Kernel NULL pointer dereference" :
			 "Unable to handle kernel data access", regs->dar);


>  		break;
>  	case 0x400:
>  	case 0x480:
> -		printk(KERN_ALERT "Unable to handle kernel paging request for "
> -			"instruction fetch\n");
> +		pr_alert("BUG: Unable to handle kernel instruction fetch%s",
> +			 regs->nip < PAGE_SIZE ? " (NULL pointer ?)\n" : "\n");
                                       I dropped the space here ^


cheers
