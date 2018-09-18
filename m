Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4ADC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAB5214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="F39V2UQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAB5214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbeIRNQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 09:16:07 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:54982 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeIRNQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 09:16:06 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w8I7iUd1029030;
        Tue, 18 Sep 2018 16:44:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w8I7iUd1029030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1537256671;
        bh=FYgWFURChMAO55afr7lwbs5gjV6O7bT9AwHWXnUHfMU=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=F39V2UQu6j0JAiOmHpsm4ALvrqzasrtyVYl/Ip85uSWmkJNxsMt7TuA5R85WjpYyl
         R5h0TRcTN/Tdc76YaXWfbLm4Q+vLuTBK19SNpUsybAHmgEIZqHFTC3irEwhOU0IAFJ
         vv6zTpeIld37rGfd0KMLQkg2gzFuG7atVWZfR69Vv0Icf5sp9B3/OnsG/p53K5nV/+
         yo+epRqCTIKk8JiIPsEhgkt5ckJ76gkYv4WadcXfoqcFBYCH9pc6EH8ekME8yLthPc
         IyErQmQkVSDDsYBk/m5RK3ubcQx7ZVGY6ZJXS3p4Jp0HlJbEGaxRF210+jSz1+R3tq
         KElaE9GK6+3tA==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id f4-v6so443471uao.10;
        Tue, 18 Sep 2018 00:44:31 -0700 (PDT)
X-Gm-Message-State: APzg51AsHatu1wH303RwFbFOM70+0kdxW4vO3H2QYgY6b5q2KO50Lyq2
        iUBhbN3QRmk/+cflKCChYRTiFK4HXom8yB9ixYY=
X-Google-Smtp-Source: ANB0VdaaEZ3s4OL5GoSDIhFFDubp/dmOjwPe03vV0tSSTYnBxM5taFl6KBWKqhP9v71qgFp+NuCx5ORshTXl8V+nZnQ=
X-Received: by 2002:a9f:3e87:: with SMTP id x7-v6mr924244uai.53.1537256670411;
 Tue, 18 Sep 2018 00:44:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:7111:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 00:43:49
 -0700 (PDT)
In-Reply-To: <db3a6d4ab976c12bfe90354ac370d541@agner.ch>
References: <20180918023157.23951-1-stefan@agner.ch> <CAK7LNASz4zabEdjO2AVscWbqGyjpEBE6Li7busC_sbYkuuJ7tQ@mail.gmail.com>
 <db3a6d4ab976c12bfe90354ac370d541@agner.ch>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 18 Sep 2018 16:43:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASBtO3F3_JmRdstVsy1jUaisHuNZWiQd4ZLEyt3f9_z9g@mail.gmail.com>
Message-ID: <CAK7LNASBtO3F3_JmRdstVsy1jUaisHuNZWiQd4ZLEyt3f9_z9g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: allow to use GCC toolchain not in Clang search path
To:     Stefan Agner <stefan@agner.ch>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

2018-09-18 12:11 GMT+09:00 Stefan Agner <stefan@agner.ch>:
> On 17.09.2018 20:06, Masahiro Yamada wrote:
>> Hi Stefan,
>>
>> 2018-09-18 11:31 GMT+09:00 Stefan Agner <stefan@agner.ch>:
>>> When using a GCC cross toolchain which is not in a compiled in
>>> Clang search path, Clang reverts to the system assembler and
>>> linker. This leads to assembler or linker errors, depending on
>>> which tool is first used for a given architecture.
>>>
>>> It seems that Clang is not searching $PATH for a matching
>>> assembler or linker.
>>
>>
>> The current code passes the absolute path of toolchains
>> to --gcc-toolchain option.
>> In my understanding, this is enough for Clang
>> to find the proper linker and the assembler.
>>
>>
>> Why is the --prefix option also needed ?
>>
>
> It seems that Clang makes a difference between "toolchain" and search path for toolchain binaries.
>
> Without this patch building fails for the described use case, see the github link for more context.


OK, I confirmed this patch fixed the problem.


I will wait a little more just in case Nick has comments about this.



Thanks.



-- 
Best Regards
Masahiro Yamada
