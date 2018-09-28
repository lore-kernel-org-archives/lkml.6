Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFD4C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675D3206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 19:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675D3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeI2COK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:14:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeI2COJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:14:09 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5yki-0004iW-TG; Fri, 28 Sep 2018 21:48:41 +0200
Date:   Fri, 28 Sep 2018 21:48:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jeff loughlin <loughlinjd@gmail.com>
cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        pombredanne@nexb.com, brijesh.singh@amd.com,
        thomas.lendacky@amd.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: init: Remove raw kernel pointer from printk
In-Reply-To: <1538163460-17173-1-git-send-email-loughlinjd@gmail.com>
Message-ID: <alpine.DEB.2.21.1809282141410.1432@nanos.tec.linutronix.de>
References: <1538163460-17173-1-git-send-email-loughlinjd@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff, 

On Fri, 28 Sep 2018, Jeff loughlin wrote:

> From: Jeff Loughlin <loughlinjd@gmail.com>
> 
>     printk message in set_real_mode_mem() contains a raw kernel pointer, which printk rightly changes to (ptrval).

Please format your changelog properly next time. Left aligned and line
breaks around 78 characters.

>     This is useless in the dmesg log and should be removed.

Agreed, (ptrval) is pretty useless, but this is a debug printk and the real
address is not useless for debugging, so just removing it is not
necessarily the best solution.

>     Signed-off-by: Jeff Loughlin <loughlinjd@gmail.com>
> ---
>  arch/x86/realmode/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index d101058..d76a138 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -20,8 +20,8 @@ void __init set_real_mode_mem(phys_addr_t mem, size_t size)
>  	void *base = __va(mem);
>  
>  	real_mode_header = (struct real_mode_header *) base;
> -	printk(KERN_DEBUG "Base memory trampoline at [%p] %llx size %zu\n",
> -	       base, (unsigned long long)mem, size);
> +	printk(KERN_DEBUG "Base memory trampoline at %llx size %zu\n",
> +	       (unsigned long long)mem, size);

Please check your patches with scripts/checkpatch.pl next time. It would
have told you to change that printk(KERN_DEBUG) to pr_debug()

Thanks,

	tglx
