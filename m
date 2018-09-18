Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91963ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEBC21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="Wlb3trhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEBC21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeIRIl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:41:57 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:33536 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeIRIl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:41:57 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 112FA5C05D1;
        Tue, 18 Sep 2018 05:11:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537240286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2tLV6SYZVQXTTN+sxElDRLhxwYJAer6ny7FcOZAFOI=;
        b=Wlb3trhVxtQrC5HvyPNhBCtw3VWhlGCWBfP7fY7mJmFjpi18GWCVlg80m0T6rxyUWhTFFv
        7pF5JJXOhrwClTrGcPpnJ2i3P+5Hb+ff73aEAteiH/Hmaepw72jQpVVxK5YBQfO7jHDKNS
        F4H4b4M1BAzzeuDfsDVPdkfdlI4+tZA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Sep 2018 20:11:26 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kbuild: allow to use GCC toolchain not in Clang search
 path
In-Reply-To: <CAK7LNASz4zabEdjO2AVscWbqGyjpEBE6Li7busC_sbYkuuJ7tQ@mail.gmail.com>
References: <20180918023157.23951-1-stefan@agner.ch>
 <CAK7LNASz4zabEdjO2AVscWbqGyjpEBE6Li7busC_sbYkuuJ7tQ@mail.gmail.com>
Message-ID: <db3a6d4ab976c12bfe90354ac370d541@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.09.2018 20:06, Masahiro Yamada wrote:
> Hi Stefan,
> 
> 2018-09-18 11:31 GMT+09:00 Stefan Agner <stefan@agner.ch>:
>> When using a GCC cross toolchain which is not in a compiled in
>> Clang search path, Clang reverts to the system assembler and
>> linker. This leads to assembler or linker errors, depending on
>> which tool is first used for a given architecture.
>>
>> It seems that Clang is not searching $PATH for a matching
>> assembler or linker.
> 
> 
> The current code passes the absolute path of toolchains
> to --gcc-toolchain option.
> In my understanding, this is enough for Clang
> to find the proper linker and the assembler.
> 
> 
> Why is the --prefix option also needed ?
> 

It seems that Clang makes a difference between "toolchain" and search path for toolchain binaries.

Without this patch building fails for the described use case, see the github link for more context.

--
Stefan


> 
> Am I missing something?
> 
> 
> 
>> Make sure that Clang picks up the correct assembler or linker by
>> passing the cross compilers bin directory as search path.
>>
>> This allows to use Clang provided by distributions with GCC
>> toolchains not in /usr/bin.
>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/78
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Nick, I removed your Reviewed-by since I had to change variable
>> assignment slightly...
>>
>>  Makefile | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 4d5c883a98e5..d5de2db4b549 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -495,13 +495,15 @@ endif
>>  ifeq ($(cc-name),clang)
>>  ifneq ($(CROSS_COMPILE),)
>>  CLANG_TARGET   := --target=$(notdir $(CROSS_COMPILE:%-=%))
>> -GCC_TOOLCHAIN  := $(realpath $(dir $(shell which $(LD)))/..)
>> +GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
>> +CLANG_PREFIX   := --prefix=$(GCC_TOOLCHAIN_DIR)
>> +GCC_TOOLCHAIN  := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>>  endif
>>  ifneq ($(GCC_TOOLCHAIN),)
>>  CLANG_GCC_TC   := --gcc-toolchain=$(GCC_TOOLCHAIN)
>>  endif
>> -KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
>> -KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC)
>> +KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>> +KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
>>  KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
>>  KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
>>  endif
>> --
>> 2.19.0
>>
