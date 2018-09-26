Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F68C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37BC204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZzvuZ8hC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37BC204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbeIZPKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:10:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:32957 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZPKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:10:09 -0400
Received: by mail-lf1-f67.google.com with SMTP id o21-v6so8700881lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IGdS/na7H308GKp6gGd8SHe9o1R5BO15JOr6Fd00qd4=;
        b=ZzvuZ8hCRwzksY5yki0gtDE6ccNurkYaiwrzcS/ANS7etgYLugK3EtLbbfCRwo3Q4f
         VlsNsHrGpjtiGASEziPHUJQvfN6/LpIts/Dquj5/7MpRpgS2nlPPj/w+lrY+raIzwsbJ
         JY8QTMP/GK92R2FQsHH9x0jJEtWRvjCgUUNJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IGdS/na7H308GKp6gGd8SHe9o1R5BO15JOr6Fd00qd4=;
        b=GZ5hug+dCgUYd8EmZ+GLjxHnZt6v8LT5A3gONq4BQ7TJCPV0EiumwFZXHWQa67CZ9w
         +O7Mx5FjzM6iT/v2cg8wJ3E7gASBAUyFR7TUk/e34kacuaTHQN9qIN34j8+CQ4ZZIAp1
         tSLn/lr4ScruTSHoNXgC83+ndL+e/9TYOhW9rTr5ir8rpQYLAERIz53zbDlhnumN3S/N
         bjDs7PVdbQMYN3o9EFQUx+jRSojEhzj/shCtc+ALaP5rLIr5GxUPQ91RmKwExRgffQM5
         eJhpMPOG/XQzBjDR65fh1Woza3Eczhw+cxoNJEFZdamMj1Xq6dfKqcso50YI7lMHgoes
         pyng==
X-Gm-Message-State: ABuFfohmeezLi/aonSwpf1F51Jjy+l/cF0vMMlk2uE1oRLDoQDEJ5WyJ
        ApjoW++yp5Kyz+HIT5neqOvNRg==
X-Google-Smtp-Source: ACcGV63Pu1WJTYINa9nH0m2R0hsfXFm3YD3xN6OPCVWtZ20xmUOObKc6QPA0G/Nzj6DLf1ysBIMAvw==
X-Received: by 2002:a19:aa8b:: with SMTP id t133-v6mr1529912lfe.92.1537952293026;
        Wed, 26 Sep 2018 01:58:13 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s76-v6sm472474lje.94.2018.09.26.01.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 01:58:12 -0700 (PDT)
Subject: Re: [PATCH v8 02/10] Makefile: Prepare for using macros for inline
 asm
To:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kbuild@vger.kernel.org
References: <20180918212847.199085-1-namit@vmware.com>
 <20180918212847.199085-3-namit@vmware.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1aa5a1f3-ef3d-5cd3-831c-2202d73d3c9e@rasmusvillemoes.dk>
Date:   Wed, 26 Sep 2018 10:58:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918212847.199085-3-namit@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-18 23:28, Nadav Amit wrote:

> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 8f6e7eb8ae9f..944fa3bc9376 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -214,8 +214,8 @@ ifdef CONFIG_X86_64
>  KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
>  endif
>  
> -# Speed up the build
> -KBUILD_CFLAGS += -pipe
> +# We cannot use -pipe flag since we give an additional .s file to the compiler
> +#KBUILD_CFLAGS += -pipe

Is this really necessary? The gas manual says that one can use -- to
name stdin, though that's probably a typo and should just be - . Doing

gcc -pipe -Wa,foo.s -Wa,-

does seem to work as expected (and would also make it possible to append
some .s file should that ever be required).
>  
> +archmacros:
> +	$(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
> +
> +ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
> +export ASM_MACRO_FLAGS
> +KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
How does this affect what gets rebuilt when one of the asm/foo.h files
going into macros.s changes? Does that cause a global rebuild because
everything depends on macros.s, or do we still only rebuild the files
that actually include asm/foo.h?

Rasmus
