Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA0AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7416320834
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7416320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388746AbeHGJbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:31:32 -0400
Received: from ozlabs.org ([203.11.71.1]:38485 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbeHGJbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:31:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41l5Tg6sZ1z9ryt;
        Tue,  7 Aug 2018 17:18:31 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: make CPU selection logic generic in Makefile
In-Reply-To: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
References: <273f8ed3e980b9385c6e1b31e17f890ea08ce33c.1528365638.git.christophe.leroy@c-s.fr>
Date:   Tue, 07 Aug 2018 17:18:31 +1000
Message-ID: <874lg6d4qg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> At the time being, when adding a new CPU for selection, both
> Kconfig.cputype and Makefile have to be modified.
>
> This patch moves into Kconfig.cputype the name of the CPU to me
> passed to the -mcpu= argument.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/Makefile                  |  8 +-------
>  arch/powerpc/platforms/Kconfig.cputype | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 9704ab360d39..9a5642552abc 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -175,13 +175,7 @@ ifdef CONFIG_MPROFILE_KERNEL
>      endif
>  endif
>  
> -CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
> -CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
> -CFLAGS-$(CONFIG_POWER6_CPU) += $(call cc-option,-mcpu=power6)
> -CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)
> -CFLAGS-$(CONFIG_POWER8_CPU) += $(call cc-option,-mcpu=power8)
> -CFLAGS-$(CONFIG_POWER9_CPU) += $(call cc-option,-mcpu=power9)
> -CFLAGS-$(CONFIG_PPC_8xx) += $(call cc-option,-mcpu=860)
> +CFLAGS-$(CONFIG_SPECIAL_CPU_BOOL) += $(call cc-option,-mcpu=$(CONFIG_SPECIAL_CPU))

This looks good.

I'll rename it from "SPECIAL_CPU" to "TARGET_CPU" because that's the
terminology used in the GCC docs, eg:

    -mcpu=name
           Specify the name of the target processor, optionally suffixed by one or more feature modifiers.


cheers
