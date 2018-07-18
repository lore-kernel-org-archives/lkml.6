Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E844ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0685A20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yZOOLHAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0685A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeGRHmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:42:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59934 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbeGRHmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9KqQvGLYTNkVWGy7DamzUDZd9kSxRENBo9pmNqB7mlI=; b=yZOOLHAaVWD2iIrypHJBeQmi3N
        EfmGfUAZXKuKu8OCcWjMVOWI9zKSnyDb9xsDnmnxoRqxug50l4H60Wmkt2fWluTNSOj6qjPvojDv9
        g/j3Wjm4lBK/zOJyoO399iDX0JnmiQWxijzykR5eP/NUZnZbnULLICJ3CCxkX6yV+xo/DAiSDfGzM
        4bHQ2Cpo48aEqpdmInrUQgHvve5My9cGf7tOUdKTKRgL3UvcQpgOInwn3ojrTw8+M8EX524xuWeiQ
        +IzaGO3uEbj9/zyNBjrAFfOuxhP9h/1OJ7q5zZj77ZiolHWYZu7nOhgz3X7m+0T83zd6Q6wUA+9+g
        p8WTq3Sg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffgXc-0000BL-Bo; Wed, 18 Jul 2018 07:06:28 +0000
Subject: Re: [PATCH 4/9] kconfig: include common Kconfig files from top-level
 Kconfig
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180708152004.21679-1-hch@lst.de>
 <20180708152004.21679-5-hch@lst.de>
 <CAK7LNAT5dzU-SOvqwnDs=bn3WA1_fmDj2abETmoHUdUExVF+WA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <17c45e87-d9be-8453-1bce-18753e0a68b9@infradead.org>
Date:   Wed, 18 Jul 2018 00:06:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK7LNAT5dzU-SOvqwnDs=bn3WA1_fmDj2abETmoHUdUExVF+WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 05:21 AM, Masahiro Yamada wrote:
> 2018-07-09 0:19 GMT+09:00 Christoph Hellwig <hch@lst.de>:
>> Instead of duplicating the source statements in every architecture just
>> do it once in the toplevel Kconfig file.
>>
>> Note that with this the inclusion of arch/$(SRCARCH/Kconfig moves out of
>> the top-level Kconfig into arch/Kconfig so that don't violate ordering
>> constraits while keeping a sensible menu structure.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> 
>> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
>> index dd4f3d3e644f..7ab7b148181b 100644
>> --- a/arch/sh/Kconfig
>> +++ b/arch/sh/Kconfig
>> @@ -168,10 +168,6 @@ config PGTABLE_LEVELS
>>         default 3 if X2TLB
>>         default 2
>>
>> -source "init/Kconfig"
>> -
>> -source "kernel/Kconfig.freezer"
>> -
>>  menu "System type"
>>
>>  #
>> @@ -553,8 +549,6 @@ endchoice
>>
>>  endif
>>
>> -source "arch/sh/mm/Kconfig"
> 
> 
> I noticed at least sh is broken
> because "arch/sh/mm/Kconfig" is no longer included by anyone.
> 
> I am not doing further tests.
> 
> 
> Please test *ALL* architectures.
> 
> If possible, matrix tests (arch, config-target), where
> arch = arm, arm64, ...
> config-target = allyesconfig, allnoconfig, alldefconfig, ...
> 
> 
> Note:
> scripts/diffconf is helpful.


For defconfig:

All $ARCH look equivalent except for microblaze and nios2.
For those, the config SWAP in init/Kconfig (line 221) comes before (and
hence takes precedence) over arch/$(SRCARCH)/Kconfig settings, which is
def_bool n for both microblaze and nios2.



-- 
~Randy
