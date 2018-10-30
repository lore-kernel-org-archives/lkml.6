Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A25C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5512080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Zefh9YT/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5512080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJ3RKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:10:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42266 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeJ3RKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:10:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id f3-v6so10452382ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C5UMxB7npR4RaGrkvaFBDOE5Fk7KH1LfnH9Y4PcSTGI=;
        b=Zefh9YT/8U2b5/NAQ+cw5iMDX+KdGAl4OE23rBysT145Gx5TdZx1smRoV4cqjIOHUV
         EeL5Gw0YbrPHP0w62qSG+0hnQtzIYsjtUi/P/ya/6uAUUHJ+/18Q1GNaLC8DQ15o8MxD
         TB29781gyR+dOxwQLCH0KuvJyqE5RRq6jdHdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C5UMxB7npR4RaGrkvaFBDOE5Fk7KH1LfnH9Y4PcSTGI=;
        b=FNWyFE7CagvVwtGnm8TBFDFbqZAPXpTNZ8TfTS/79O6r868QkpSJbc8R+o/JsRawfV
         boaU1xRIUxp+qCH/6WQSluUMnx/pKuHNvJShEhvtG31LMpJ1xsBTeQcf4O29fjGskrcI
         j027XoozzRDsET31x+FtErL91Y+Mw6U2FmJfazvwy6KVNZZsjK6B/Ghz79tDwmAFnnah
         yX2GJjknSTvlXq5xlWcHhKsYPk6OYum7ZcNexQWVP7+a1oBFZ2HpKC39+uCDrImZai49
         8K5g2UMB1GZN/FnkxmQwIECMdqi/JaemaIxWKAd5Yp3codXoFdsD8iVDeMEAAfhOBmc6
         0rEQ==
X-Gm-Message-State: AGRZ1gIF706whEdVR35zya8fydfj8ruzISpjCzp1mryt/y7BYjVe/6y6
        CwGa20N5wDWxXI4K+HnHOZN99Q==
X-Google-Smtp-Source: AJdET5fTF5zxnu6ulCWRcmwi2CJ6d+6iKp7SkzD97XOIQzNGMoHni68VGD/mFWMJX714nj8/mTaB6Q==
X-Received: by 2002:a2e:710c:: with SMTP id m12-v6mr11358444ljc.66.1540887476470;
        Tue, 30 Oct 2018 01:17:56 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id h21sm2686389lfk.41.2018.10.30.01.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 01:17:55 -0700 (PDT)
Subject: Re: [PATCH] fs: proc: move linux_proc_banner to where it is used
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
References: <20181026212034.5491-1-linux@rasmusvillemoes.dk>
 <20181027194725.GA30155@avx2>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <408ef493-de1d-37bb-de66-69134c5a1aca@rasmusvillemoes.dk>
Date:   Tue, 30 Oct 2018 09:17:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181027194725.GA30155@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-27 21:47, Alexey Dobriyan wrote:
> On Fri, Oct 26, 2018 at 11:20:34PM +0200, Rasmus Villemoes wrote:
>> +#include <generated/compile.h>
> 
>> +#define linux_proc_banner \
>> +	"%s version %s" \
>> +	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")" \
>> +	" (" LINUX_COMPILER ") %s\n"
> 
> Include doesn't work if compiling from scratch:

Urgh, thanks. I assumed that all the include/generated/ stuff was always
generated by the prepare steps in the top Makefile. But the logic for
making compile.h is in init/Makefile.

> 	rm -rf ../obj
> 	mkdir ../obj
> 	make O=../obj defconfig
> 	make O=../obj fs/proc/version.o
> 
>   CC      fs/proc/version.o
> fs/proc/version.c:2:10: fatal error: generated/compile.h: No such file or directory

The same happens in current mainline for arch/x86/boot/version.o:

$ make arch/x86/boot/version.o
  CALL    scripts/checksyscalls.sh
  DESCEND  objtool
  CC      arch/x86/boot/version.o
arch/x86/boot/version.c:17:31: fatal error: generated/compile.h: No such
file or directory

Cc kbuild: Wouldn't it be a little nicer creating generated/compile.h
along with the other files in generated/, so that everybody can rely on
them being there instead of having the logic for compile.h hidden away
in init/Makefile and listing it as an explicit dependency? Or is there
some reason compile.h is special?

Rasmus

