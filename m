Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7276DC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBFA208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FYy3PW9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBFA208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932938AbeGHKmU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 06:42:20 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:45312 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932690AbeGHKmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 06:42:19 -0400
Received: from mail-ua0-f179.google.com (mail-ua0-f179.google.com [209.85.217.179]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id w68AgEja010174;
        Sun, 8 Jul 2018 19:42:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w68AgEja010174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531046535;
        bh=rhGd301Z6SQGs3Y+WGvz3hl2LcH3HlULkh3DYiVU78Q=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=FYy3PW9mtxsaHuR/8aVWohXTUTJ+ICiSuZASNF46ZzCTdxK0ybu/+f5Pr/LFwvcJ9
         CTKIvExaamrhzea4J0snQpZANSxOwS6mjhaX9ME00ToTRSmCQcNaw06zbbFhuBsjxm
         u2Y0elUQHKmC6iUyUaV+0n49hU3N1t06pIVWgyBKbpAti79CtP3/DCEVULoGH1KBMW
         zLKoyvJVrfLF7INz7omPSl/H2MuLFw5bBBnJHfWzVpopolEoIrjsaxnM/1jcTU2pvj
         3hTBox9sfynoAG0OVxHcG0SHensK9SrFXFlpMitFhZAFXPlVbBsG8mH/+TxV5H0Rcm
         Re5kyBwc+TyYA==
X-Nifty-SrcIP: [209.85.217.179]
Received: by mail-ua0-f179.google.com with SMTP id k25-v6so1146819uao.11;
        Sun, 08 Jul 2018 03:42:14 -0700 (PDT)
X-Gm-Message-State: APt69E1Pjstyx1MOL0q8ydPD96gfBpN9kJ4jXbwAKeOZIlowBD8PXadv
        tDDB8S5i46js6+q/OUF7KieX4jeU1RIfpe2QYWA=
X-Google-Smtp-Source: AAOMgpeh0G+w+aBeZXSp7gPyza0z5t59y+2lLU6IezNjqfN3fwQFI5wj2TsEgslecFhmpqKOO+AopYdY8xuabeEE7hE=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr10135937uaf.199.1531046533489;
 Sun, 08 Jul 2018 03:42:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Sun, 8 Jul 2018 03:41:32 -0700 (PDT)
In-Reply-To: <AM5PR0701MB265789020943AD2E03E81AD2E4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
References: <AM5PR0701MB2657B3C36CDB2D67702077D8E4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
 <AM5PR0701MB265789020943AD2E03E81AD2E4450@AM5PR0701MB2657.eurprd07.prod.outlook.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 8 Jul 2018 19:41:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT1bqDKo2zS3kUVKnPYgziibuwCdQ4+Y5hQE_xbjcGAWw@mail.gmail.com>
Message-ID: <CAK7LNAT1bqDKo2zS3kUVKnPYgziibuwCdQ4+Y5hQE_xbjcGAWw@mail.gmail.com>
Subject: Re: [PATCH] Fix the oldconfig target rule
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-08 17:09 GMT+09:00 Bernd Edlinger <bernd.edlinger@hotmail.de>:
> On 07/08/18 08:31, Bernd Edlinger wrote:
>> The next make after an oldconfig reads in the outdated
>> include/config/auto.conf which can kill the make before
>> it is able to call the syncconfig target.
>>
>> $ make defconfig
>> *** Default configuration is based on 'x86_64_defconfig'
>> $ make
>> scripts/kconfig/conf  --syncconfig Kconfig
>> Makefile:936: *** "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y,
>> please install libelf-dev, libelf-devel or elfutils-libelf-devel".  Stop.
>>
>> $ sed -i s/CONFIG_UNWINDER_ORC=y// .configs
>> $ make oldconfig
>> Choose kernel unwinder
>>> 1. ORC unwinder (UNWINDER_ORC) (NEW)
>>    2. Frame pointer unwinder (UNWINDER_FRAME_POINTER)
>> choice[1-2?]: 2
>> $ make
>> Makefile:936: *** "Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y,
>> please install libelf-dev, libelf-devel or elfutils-libelf-devel".  Stop.
>>
>> With this patch oldconfig and similar targets like
>> menuconfig call syncconfig to avoid this failure.
>>
>> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
>> ---
>>   scripts/kconfig/Makefile | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
>> index a3ac2c9..ef34275 100644
>> --- a/scripts/kconfig/Makefile
>> +++ b/scripts/kconfig/Makefile
>> @@ -62,6 +62,7 @@ PHONY += $(simple-targets)
>>
>>   $(simple-targets): $(obj)/conf
>>       $< $(silent) --$@ $(Kconfig)
>> +    $(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
>
> On second thought, removing the auto.conf might be sufficient:
> $(Q)rm -f include/config/auto.conf include/config/auto.conf.cmd
>
> Would you prefer that?

No.

My suggestion is this:
https://patchwork.kernel.org/patch/10513065/






-- 
Best Regards
Masahiro Yamada
