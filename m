Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA05ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071B820854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="VsHHEIsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071B820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbeKES1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:27:55 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57292 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbeKES1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:27:54 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 34C415C0A09;
        Mon,  5 Nov 2018 10:09:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1541408951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qe+KkULrxlCZcJNfNGvzFG1C9YdiRj2CoJUjuqrmeXE=;
        b=VsHHEIsLCOBYmNd57ZgUllDzjPWnwrH2EgZIBqGCyj6d3E0c9orPnw77jy1w2rhbrBTEI1
        ArBN7Qg4LvmNa9WBCXvfTqnJB51Aaim+5b4UurbDxbyP3K8/mI+AiKi6Hcl6X9o56gvhly
        pF602Ho/6oG2g+avHtHLNhcStcF6eWw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 05 Nov 2018 10:09:11 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Chris Fries <cfries@google.com>, Joel Stanley <joel@jms.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: consolidate Clang compiler flags
In-Reply-To: <1541386099-13118-1-git-send-email-yamada.masahiro@socionext.com>
References: <1541386099-13118-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <a55e4534ef759585088a037e4cfd8468@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.11.2018 03:48, Masahiro Yamada wrote:
> Add basic options for Clang such as --target, --prefix, --gcc-toolchain,
> -no-integrated-as to a single variable CLANG_FLAGS.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Makefile | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 93315eb..58c838a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -487,18 +487,17 @@ endif
>  
>  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>  ifneq ($(CROSS_COMPILE),)
> -CLANG_TARGET	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
> +CLANG_FLAGS	= --target=$(notdir $(CROSS_COMPILE:%-=%))
>  GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> -CLANG_PREFIX	:= --prefix=$(GCC_TOOLCHAIN_DIR)
> +CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)

So this will expand later now, is this ok?

--
Stefan

>  GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>  endif
>  ifneq ($(GCC_TOOLCHAIN),)
> -CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
> +CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
> -KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
> -KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
> +CLANG_FLAGS	+= $(call cc-option, -no-integrated-as)
> +KBUILD_CFLAGS	+= $(CLANG_FLAGS)
> +KBUILD_AFLAGS	+= $(CLANG_FLAGS)
>  endif
>  
>  RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern
> -mindirect-branch-register
