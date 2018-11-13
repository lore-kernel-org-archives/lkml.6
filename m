Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCF8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1183922360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1183922360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbeKMTot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:44:49 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:51162 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbeKMTot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:44:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4F00F606C474;
        Tue, 13 Nov 2018 10:47:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BR7WZ334hGnj; Tue, 13 Nov 2018 10:47:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 666ED606D487;
        Tue, 13 Nov 2018 10:47:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rlrJzKEpNQCi; Tue, 13 Nov 2018 10:47:28 +0100 (CET)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 86CC2606D481;
        Tue, 13 Nov 2018 10:47:27 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] um: remove -fno-unit-at-a-time workaround for pre-4.0 GCC
Date:   Tue, 13 Nov 2018 10:47:27 +0100
Message-ID: <2624257.jg98z2FPBI@blindfold>
In-Reply-To: <1541990120-9643-2-git-send-email-yamada.masahiro@socionext.com>
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com> <1541990120-9643-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 12. November 2018, 03:35:19 CET schrieb Masahiro Yamada:
> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> bumped the minimum GCC version to 4.6 for all architectures.
> 
> '$(call cc-option,-fno-unit-at-a-time)' is now dead code since
> '$(cc-version) -lt 0400' is always false.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/x86/Makefile.um | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
> index 91085a0..577976b 100644
> --- a/arch/x86/Makefile.um
> +++ b/arch/x86/Makefile.um
> @@ -26,12 +26,8 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
>  # an unresolved reference.
>  cflags-y += -ffreestanding
>  
> -# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
> -# a lot more stack due to the lack of sharing of stacklots.  Also, gcc
> -# 4.3.0 needs -funit-at-a-time for extern inline functions.
> -KBUILD_CFLAGS += $(shell if [ $(cc-version) -lt 0400 ] ; then \
> -			echo $(call cc-option,-fno-unit-at-a-time); \
> -			else echo $(call cc-option,-funit-at-a-time); fi ;)
> +# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
> +KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard



