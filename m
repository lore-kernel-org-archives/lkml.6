Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA31C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3542173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rW9kVESq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3542173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeHTWLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:11:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46800 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTWLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:11:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so7206666pfn.13;
        Mon, 20 Aug 2018 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=474UQ1/inJopfqmpByXPF803z38Oe4PEgKFD6gwthMk=;
        b=rW9kVESqVP5qtf1/9zol+T5nOev9+aspKYt8YmdFtDUDzT+IRpotGuE8gn++rdyv9u
         5fErkHW6f820AgoAjqsnraibbvrz1pQ3G7tbI5CxPYIBIbyJ00amsks4ONTSclqsEPtq
         tdl1uVd9Qdlba5RDz25zF0gDu7j4aRkkGNcvVeEGSeCcOHw2MUXFaE2//zO84a7XN18W
         LelFwQHVDDmIWHismpuAbC1Gme2RekZLWQXu/KOeWal35jg2USPxaSX0khGvfeArGBAx
         87wrSkG0bYhmwj+PSX/JoyNyaIA/RjdM/SyHDT+4RoouGfoqI5H5teQf3YNOAHgtGZjf
         sWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=474UQ1/inJopfqmpByXPF803z38Oe4PEgKFD6gwthMk=;
        b=KucPsInBUrc+z+JjuHPIpfvTfNnkYkN4ULCWELIWAUbThLubQeOjxkc37nerP18PUR
         7qleo+C7iqE80ZGsy8vIJLV9EyaW17snQ2j+WHS95BmP1w+Urqnp5RmWXPi+Yr0F3oXN
         nhxUdkyAAjFjRemZk1/4P85h8KHAUtfiQYPo03NVlfshdXU0F8HI3xx1D2ng1v0ZZDqY
         X0n19pEdJNbvFJ9aKtNCUr+ULpARxm87SKQ12MLlmpEP8TyOAaK7vpirobsJHRRNRbwQ
         cVAg6jjRGmdcg4S+/OUO98JRGZVLfICV7xLuGQa0g/HaiFsWNhbCez3U3t+76DrhiocP
         ftpQ==
X-Gm-Message-State: AOUpUlHhQbxzv7vASIrojqQyL6Qbhxc70JHFk2sTQS3Glp8W4Awad6xI
        puD/FN+OcCvBMnTwge4swtI=
X-Google-Smtp-Source: AA+uWPxdz4sHpw9wr0moevqdlff59W1HLGwxweDVH0lb98QxXWVM8fVW3L4YPBLYnp45d0J1ZWEAxA==
X-Received: by 2002:a63:3c5c:: with SMTP id i28-v6mr5053154pgn.415.1534791305049;
        Mon, 20 Aug 2018 11:55:05 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id 16-v6sm19719178pfo.164.2018.08.20.11.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 11:55:04 -0700 (PDT)
Subject: Re: [PATCH] scripts/dtc: consolidate include path options in Makefile
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <cfb66b67-f423-0c26-0b22-0d57a581b44a@gmail.com>
Date:   Mon, 20 Aug 2018 11:55:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/18 18:59, Masahiro Yamada wrote:
> It is tedious to specify extra compiler options for every file.
> HOST_EXTRACFLAGS is useful to add options to all files in a
> directory.
> 
> -I$(src)/libfdt is needed for all the files in this directory
> to include libfdt_env.h etc. from scripts/dtc/libfdt/.
> 
> On the other hand, -I$(src) is used to include check-in headers
> from generated C files.  Thus, I added it only to dtc-lexer.lex.o
> and dtc-parser.tab.o .
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  scripts/dtc/Makefile | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> index 9cac65b..1c943e0 100644
> --- a/scripts/dtc/Makefile
> +++ b/scripts/dtc/Makefile
> @@ -9,21 +9,11 @@ dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>  dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o
>  
>  # Source files need to get at the userspace version of libfdt_env.h to compile
> +HOST_EXTRACFLAGS := -I$(src)/libfdt

Shouldn't that be += instead of :=?

-Frank

>  
> -HOSTCFLAGS_DTC := -I$(src) -I$(src)/libfdt
> -
> -HOSTCFLAGS_checks.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_data.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_dtc.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_flattree.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_fstree.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_livetree.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_srcpos.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_treesource.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_util.o := $(HOSTCFLAGS_DTC)
> -
> -HOSTCFLAGS_dtc-lexer.lex.o := $(HOSTCFLAGS_DTC)
> -HOSTCFLAGS_dtc-parser.tab.o := $(HOSTCFLAGS_DTC)
> +# Generated files need one more search path to include headers in source tree
> +HOSTCFLAGS_dtc-lexer.lex.o := -I$(src)
> +HOSTCFLAGS_dtc-parser.tab.o := -I$(src)
>  
>  # dependencies on generated files need to be listed explicitly
>  $(obj)/dtc-lexer.lex.o: $(obj)/dtc-parser.tab.h
> 

