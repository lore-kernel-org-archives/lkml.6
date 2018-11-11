Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F12BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1248221479
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1248221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbeKLBjZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 20:39:25 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:8806 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbeKLBjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 20:39:25 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42tJHx3n7bz9v0qx;
        Sun, 11 Nov 2018 16:50:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id B4aG1vEPXBHF; Sun, 11 Nov 2018 16:50:21 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42tJHx302Mz9v0qZ;
        Sun, 11 Nov 2018 16:50:21 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 7F48963E; Sun, 11 Nov 2018 16:50:17 +0100 (CET)
Received: from lim91-2-88-180-148-239.fbx.proxad.net
 (lim91-2-88-180-148-239.fbx.proxad.net [88.180.148.239]) by
 messagerie.si.c-s.fr (Horde Framework) with HTTP; Sun, 11 Nov 2018 16:50:17
 +0100
Date:   Sun, 11 Nov 2018 16:50:17 +0100
Message-ID: <20181111165017.Horde.p-JAEzMAEZNYBCQTqILU4A1@messagerie.si.c-s.fr>
From:   LEROY Christophe <christophe.leroy@c-s.fr>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 05/30] powerpc/traps: restore
 recoverability of machine_check interrupts
References: <20181104135325.88524-1-sashal@kernel.org>
 <20181104135325.88524-5-sashal@kernel.org>
In-Reply-To: <20181104135325.88524-5-sashal@kernel.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this patch didn't make its way into 4.14 yet. Is there a  
problem with this patch ?

Christophe

Sasha Levin <sashal@kernel.org> a écrit :

> From: Christophe Leroy <christophe.leroy@c-s.fr>
>
> [ Upstream commit daf00ae71dad8aa05965713c62558aeebf2df48e ]
>
> commit b96672dd840f ("powerpc: Machine check interrupt is a non-
> maskable interrupt") added a call to nmi_enter() at the beginning of
> machine check restart exception handler. Due to that, in_interrupt()
> always returns true regardless of the state before entering the
> exception, and die() panics even when the system was not already in
> interrupt.
>
> This patch calls nmi_exit() before calling die() in order to restore
> the interrupt state we had before calling nmi_enter()
>
> Fixes: b96672dd840f ("powerpc: Machine check interrupt is a  
> non-maskable interrupt")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/powerpc/kernel/traps.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index ac2e5e56a9f0..a5f2b7593976 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -694,12 +694,17 @@ void machine_check_exception(struct pt_regs *regs)
>  	if (check_io_access(regs))
>  		goto bail;
>
> -	die("Machine check", regs, SIGBUS);
> -
>  	/* Must die if the interrupt is not recoverable */
>  	if (!(regs->msr & MSR_RI))
>  		nmi_panic(regs, "Unrecoverable Machine check");
>
> +	if (!nested)
> +		nmi_exit();
> +
> +	die("Machine check", regs, SIGBUS);
> +
> +	return;
> +
>  bail:
>  	if (!nested)
>  		nmi_exit();
> --
> 2.17.1


