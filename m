Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79541C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252062081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 06:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252062081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeKHPnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:43:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55744 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbeKHPnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:43:32 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42rCYC4XP4z9ttSR;
        Thu,  8 Nov 2018 07:09:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7GM9rmS96FhL; Thu,  8 Nov 2018 07:09:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42rCYC41bNz9ttBh;
        Thu,  8 Nov 2018 07:09:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C96928B82A;
        Thu,  8 Nov 2018 07:09:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NHJVGxbchT84; Thu,  8 Nov 2018 07:09:38 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0F65A8B74C;
        Thu,  8 Nov 2018 07:09:37 +0100 (CET)
Subject: Re: [PATCH] powerpc: Mark variable `cpumsr` as unused
To:     Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Breno Leitao <leitao@debian.org>
Cc:     Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20181107202641.7865-1-malat@debian.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d3ba180c-9ab1-d204-7a62-0563ecabad70@c-s.fr>
Date:   Thu, 8 Nov 2018 06:09:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181107202641.7865-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/07/2018 08:26 PM, Mathieu Malaterre wrote:
> Add gcc attribute unused for `cpumsr` variable.
> 
> Fix warnings treated as errors with W=1:
> 
>    arch/powerpc/kernel/process.c:231:16: error: variable ‘cpumsr’ set but not used [-Werror=unused-but-set-variable]
>    arch/powerpc/kernel/process.c:296:16: error: variable ‘cpumsr’ set but not used [-Werror=unused-but-set-variable]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

I don't think this is the good way to fix that. This problem was 
introduced by commit 5c784c8414fb ("powerpc/tm: Remove 
msr_tm_active()"). That commit should be reverted and fixed.

That commit should have removed the macro and kept the inline function.

Christophe

> ---
>   arch/powerpc/kernel/process.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 96f34730010f..b9f1a2408738 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -228,7 +228,7 @@ EXPORT_SYMBOL_GPL(flush_fp_to_thread);
>   
>   void enable_kernel_fp(void)
>   {
> -	unsigned long cpumsr;
> +	unsigned long cpumsr __maybe_unused;
>   
>   	WARN_ON(preemptible());
>   
> @@ -293,7 +293,7 @@ EXPORT_SYMBOL(giveup_altivec);
>   
>   void enable_kernel_altivec(void)
>   {
> -	unsigned long cpumsr;
> +	unsigned long cpumsr __maybe_unused;
>   
>   	WARN_ON(preemptible());
>   
> 
