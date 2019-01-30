Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2F1C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD8220882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730765AbfA3MdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:33:01 -0500
Received: from ozlabs.org ([203.11.71.1]:58445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfA3MdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:33:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43qN7H2tRFz9s9h;
        Wed, 30 Jan 2019 23:32:59 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/traps: fix the message printed when stack overflows
In-Reply-To: <5aa3c84a675405ac99382a5893406ef7e8dfd455.1548779831.git.christophe.leroy@c-s.fr>
References: <5aa3c84a675405ac99382a5893406ef7e8dfd455.1548779831.git.christophe.leroy@c-s.fr>
Date:   Wed, 30 Jan 2019 23:32:58 +1100
Message-ID: <87o97ypbph.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Today's message is useless:
>
> [   42.253267] Kernel stack overflow in process (ptrval), r1=c65500b0
>
> This patch fixes it:
>
> [   66.905235] Kernel stack overflow in process sh[356], r1=c65560b0
>
> Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: make checkpatch happy :)
>
>  arch/powerpc/kernel/traps.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 5e917a84f949..a3dc6872d5aa 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1535,8 +1535,8 @@ void alignment_exception(struct pt_regs *regs)
>  
>  void StackOverflow(struct pt_regs *regs)
>  {
> -	printk(KERN_CRIT "Kernel stack overflow in process %p, r1=%lx\n",
> -	       current, regs->gpr[1]);
> +	pr_crit("Kernel stack overflow in process %s[%d], r1=%lx\n",
> +		current->comm, current->pid, regs->gpr[1]);

I think you're meant to use task_pid_nr(current) these days.

I fixed it up when applying.

cheers

