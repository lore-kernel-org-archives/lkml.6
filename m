Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D9C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750DA20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750DA20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJ3V3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:29:40 -0400
Received: from ozlabs.org ([203.11.71.1]:38607 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbeJ3V3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:29:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42krYb3vfqz9s89;
        Tue, 30 Oct 2018 23:36:19 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Mackerras <paulus@samba.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] kbuild: replace cc-name test with CONFIG_CC_IS_CLANG
In-Reply-To: <1540873293-29817-1-git-send-email-yamada.masahiro@socionext.com>
References: <1540873293-29817-1-git-send-email-yamada.masahiro@socionext.com>
Date:   Tue, 30 Oct 2018 23:36:17 +1100
Message-ID: <877ehzk3we.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 17be664..338e827 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -96,7 +96,7 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
>  aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
>  endif
>  
> -ifneq ($(cc-name),clang)
> +ifneq ($(CONFIG_CC_IS_CLANG),y)
>    cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
>  endif
>  
> @@ -175,7 +175,7 @@ endif
>  # Work around gcc code-gen bugs with -pg / -fno-omit-frame-pointer in gcc <= 4.8
>  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44199
>  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=52828
> -ifneq ($(cc-name),clang)
> +ifneq ($(CONFIG_CC_IS_CLANG),y)
>  CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)
>  endif
>  endif

Does this behave like other CONFIG variables, ie. it will not be defined
when it's false?

And if so can't we use ifdef/ifndef? eg:

ifndef CONFIG_CC_IS_CLANG
  CC_FLAGS_FTRACE	+= $(call cc-ifversion, -lt, 0409, -mno-sched-epilog)

That reads cleaner to me.

Still this patch is fine as is:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
