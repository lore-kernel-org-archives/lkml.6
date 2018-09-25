Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F51C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3515B20870
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 01:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3515B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbeIYHeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 03:34:02 -0400
Received: from ozlabs.org ([203.11.71.1]:50217 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbeIYHeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 03:34:02 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42K3Pn5wjLz9s4V;
        Tue, 25 Sep 2018 11:29:01 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/traps: merge unrecoverable_exception() and nonrecoverable_exception()
In-Reply-To: <f49e2e4ff1eacbad161eb6c1645cca7a281dcf3e.1537765881.git.christophe.leroy@c-s.fr>
References: <f49e2e4ff1eacbad161eb6c1645cca7a281dcf3e.1537765881.git.christophe.leroy@c-s.fr>
Date:   Tue, 25 Sep 2018 11:29:01 +1000
Message-ID: <875zyu5pr6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 6ab66a88db14..4567eeb6524e 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -2090,8 +2082,9 @@ void SPEFloatingPointRoundException(struct pt_regs *regs)
>   */
>  void unrecoverable_exception(struct pt_regs *regs)
>  {
> -	printk(KERN_EMERG "Unrecoverable exception %lx at %lx\n",
> -	       regs->trap, regs->nip);
> +	pr_emerg("Unrecoverable exception %lx at %lx (msr=%lx)\n",
> +		 regs->trap, regs->nip, regs->msr);
> +	debugger(regs);
>  	die("Unrecoverable exception", regs, SIGABRT);

die() already calls debugger() if the trap is != 0x100.

I don't think we want to call it twice?

cheers
