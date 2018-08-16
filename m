Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CB3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7A12148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SXJEF8TV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7A12148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404290AbeHPT3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:29:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55856 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbeHPT3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mYW6dycSklh2h6IxchPMyx1uRpZ9c+gQjfjbVfh8dr0=; b=SXJEF8TVI9/9820HywQaRSt0o
        eIceSntIFh1YlpQT49JdhbMneIB6f6aiQxTUbyUXfOKuA8qiS/y+x8zO1a4eU1IAGrKw5c9JmHmI0
        /hfxL5wuM63SFhJ+NcjPbeEX+VKjcXLgrj581VWa46dKPFgVODtzGS4ngvQQYd0vXnHvVVUu5Puq7
        YbR6ZxlXZbvQ0Yecwbqn0FvYadI4uyf7taB9m0weEQVoixQHtjbqDkxd5TXhth6wMX8rjpo6sL6qP
        KMoR69hro1aHV0AIwHVEg7Yz/QekiVxQo3V7LFpvpyXsfhfKRAyEsTx+f6ClSCUDuWCua2R9UifwO
        sRAyu5JCg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fqLA7-00065U-97; Thu, 16 Aug 2018 16:30:15 +0000
Subject: Re: [PATCH] kconfig: add build-only configurator targets
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <abba6b9a-597b-a3eb-6d91-8a7261492c78@infradead.org>
 <CAK7LNAQ3NnWvK=jJ5a-bpYuCGtpfYztu7qPpi4Gd+6jR_62eQQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a4139b9d-9842-a595-b273-1fce3eecf6a3@infradead.org>
Date:   Thu, 16 Aug 2018 09:30:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQ3NnWvK=jJ5a-bpYuCGtpfYztu7qPpi4Gd+6jR_62eQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15/2018 08:27 PM, Masahiro Yamada wrote:
> 2018-08-15 9:36 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Add build-only targets for build_menuconfig, build_nconfig,
>> build_xconfig, and build_gconfig.
>> (targets must end in "config" to qualify in top-level Makefile)
>>
>> This allows these target to be built without execution (e.g., to
>> look for errors or warnings) and/or to be built and checked by sparse.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>>  scripts/kconfig/Makefile |    8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> --- linux-next-20180814.orig/scripts/kconfig/Makefile
>> +++ linux-next-20180814/scripts/kconfig/Makefile
>> @@ -33,6 +33,14 @@ config: $(obj)/conf
>>  nconfig: $(obj)/nconf
>>         $< $(silent) $(Kconfig)
>>
>> +build_menuconfig: $(obj)/mconf
>> +
>> +build_nconfig: $(obj)/nconf
>> +
>> +build_gconfig: $(obj)/gconf
>> +
>> +build_xconfig: $(obj)/qconf
>> +
>>  localyesconfig localmodconfig: $(obj)/conf
>>         $(Q)perl $(srctree)/$(src)/streamline_config.pl --$@ $(srctree) $(Kconfig) > .tmp.config
>>         $(Q)if [ -f .config ]; then                                     \
>>
> 
> 
> OK, seems useful,
> but these should be phony targets.
> 
> May I squash the following change?
> 

Of course.  Thanks.

> 
> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index c0ca9ea..f7bdcc9 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -3,7 +3,8 @@
>  # Kernel configuration targets
>  # These targets are used from top-level makefile
> 
> -PHONY += xconfig gconfig menuconfig config localmodconfig localyesconfig
> +PHONY += xconfig gconfig menuconfig config localmodconfig localyesconfig \
> +       build_menuconfig build_nconfig build_gconfig build_xconfig
> 
>  ifdef KBUILD_KCONFIG
>  Kconfig := $(KBUILD_KCONFIG)


-- 
~Randy
