Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D19DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A10521871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="OnU8P8pT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbeLROeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:34:12 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34588 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeLROeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:34:11 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so18415195qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQTHnc8iLR9vyw7mNyFhfftbitg0zVU4bkRdG1j0w90=;
        b=OnU8P8pTO5ftwD5Zjhsg9f2UzG4KQg6a+JfGINimW4tkggLiJOi2LQVuJYhkXyxX0Q
         6sJn9fct/JWA+H+nZxjgOKDNK2ZeGv3Je4x06I6CJRila2Fg8pmhoZt+PSmQZCdSgpyQ
         kNthbjRw2DRqSe/N4ED9Fr/Z1bjjQABOCtz8zsLOHYRUmGG+DNq8+kkV1glyI125mZKR
         gStobyBBp6Fo2uhFJOMcdbteJqBkAAyoUy8AdCmuy1/ALmHtrFeXafDHKa65uqsYdH8o
         jS9HOD/+frct3LCC1dfvf+95VXDgI3qbAEqKd1I22MbUpl1AfsUKhqDYEnvePYjL91G4
         Q//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQTHnc8iLR9vyw7mNyFhfftbitg0zVU4bkRdG1j0w90=;
        b=s2Ie6rwOsEQ8PtJahjTkxC8tB7+o+Y5fB2x/I7BebWhNtNk5tItxE0gvKY07x5C3vD
         QftZ03zRqbO109eAbexdI/WATsfyhl5NGaOkICtrulBE6pT9MoHH3kyizkZn/1bEnhFk
         FpYefs73WfkbRug3R4JWkt5kwJvgtiiD/xjuiunTcIkyJZpTzIhwKXAQWkaQ/R7Rb64D
         Ha5aGa0e3CN78ExE5Fsuz7B7YVhHbwFKuk+dnyJPljA7hV2lho9TegyyKxHsvpVCe3xm
         v5x8rcXtai7WbXadfymvu8Ra1rr8VsJhmpnjXgnwJGcmr2QyptcQsoMknMMbgU39HMaQ
         sjrA==
X-Gm-Message-State: AA+aEWaZAYeVEF18CdyVA8x/h4dNNXJXk+j7H1ZWM/MUxNlxCSKco/7R
        WQgHdoWHJoyVivCxj+w53Y+BPg==
X-Google-Smtp-Source: AFSGD/V+Ro8M+mJv+nSlY9dOh6zWEGc5UqWNGuOAXe+yZ/wtU1ca0jdOiGT/dysDfIx5rDDUd5A0HQ==
X-Received: by 2002:a0c:d602:: with SMTP id c2mr16915199qvj.151.1545143650639;
        Tue, 18 Dec 2018 06:34:10 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m41sm93088qtc.58.2018.12.18.06.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 06:34:09 -0800 (PST)
Message-ID: <1545143648.18411.20.camel@lca.pw>
Subject: Re: [PATCH] kbuild: fix false positive warning/error about missing
 libelf
From:   Qian Cai <cai@lca.pw>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Date:   Tue, 18 Dec 2018 09:34:08 -0500
In-Reply-To: <1545110741-10761-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545110741-10761-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 14:25 +0900, Masahiro Yamada wrote:
> For the same reason as commit 25896d073d8a ("x86/build: Fix compiler
> support check for CONFIG_RETPOLINE"), you cannot put this $(error ...)
> into the parse stage of the top Makefile.
> 
> Perhaps I'd propose a more sophisticated solution later, but this is
> the best I can do for now.
> 
> Link: https://lkml.org/lkml/2017/12/25/211
> Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 

Tested-by: Qian Cai <cai@lca.pw>

>  Makefile | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 56d5270..d45856f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -962,11 +962,6 @@ ifdef CONFIG_STACK_VALIDATION
>    ifeq ($(has_libelf),1)
>      objtool_target := tools/objtool FORCE
>    else
> -    ifdef CONFIG_UNWINDER_ORC
> -      $(error "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please
> install libelf-dev, libelf-devel or elfutils-libelf-devel")
> -    else
> -      $(warning "Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-
> dev, libelf-devel or elfutils-libelf-devel")
> -    endif
>      SKIP_STACK_VALIDATION := 1
>      export SKIP_STACK_VALIDATION
>    endif
> @@ -1125,6 +1120,14 @@ uapi-asm-generic:
>  
>  PHONY += prepare-objtool
>  prepare-objtool: $(objtool_target)
> +ifeq ($(SKIP_STACK_VALIDATION),1)
> +ifdef CONFIG_UNWINDER_ORC
> +	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y,
> please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
> +	@false
> +else
> +	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install
> libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
> +endif
> +endif
>  
>  # Generate some files
>  # ---------------------------------------------------------------------------
