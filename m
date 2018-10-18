Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873B2C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C752098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dPy57IOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C752098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeJSENN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:13:13 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:41294 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeJSENM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:13:12 -0400
Received: by mail-io1-f44.google.com with SMTP id q4-v6so21742649iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 13:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=co3uLZFdk/kCobCQe0s41BVJoYc4tFCNH15+HMAz5h0=;
        b=dPy57IOWY62NIdW8i+ynCAVxTVc9lTASqBiUZmTHVvw1NO8MT1Q3IpLQvDnPswxYQC
         5iqyAFUGt+5YL8HctCwmjWxBId1T2JUpKhMat+tsBEcUdURrnISUiB9nG8Rcp0H7mBoq
         X+XCDfRlumh0PCV7s1QC20lrdMyBLirT2UNCTyNxMTLF6NazAm4mIdG1XLB/CGxWK/pC
         a47xLnH6xwyKn7uleBU0ASdm2VUAKPvmtWTg7ufL1VSqf4ijDDdIKvQpZM+f70/f6Eil
         cPxx9ZxcWP3CZ6HE8iFRRv72qhCqIxTmG5Q7lla722PcKJL7khidShLhKDrRLPWR/Y97
         v5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=co3uLZFdk/kCobCQe0s41BVJoYc4tFCNH15+HMAz5h0=;
        b=AToEs4qoqf63cj2i2yl6TyD8LNNFR3xoX3KFiUCrkFljwRoUbU168MWyPZ6hjpch/I
         vYqmWbR1fAlWm4U62bXSgEqdXBMx8jg26AEPD4R2/Tw5huTvmtRwqcxqQ8Oh9IFrh6/2
         jQ+1g3AK6QgiQ+xIrY58zYODCQgSZ7OvklRO150WxEipp91QmXqY8tL0DK3BLuSQO1fL
         Et/cpS1FJFS1U5gRsWrD4V/QC5fnhao9TVZbkAc/MlMUXLSbDZh+5/+WIc8pxHY0IUYF
         Xm7O5mHqFxTBI71U6DFgqAJmL4cMEfw9qD0fwKjglyehvCJ2rrC8DJi+0ZTZtewz4NwT
         6cHA==
X-Gm-Message-State: AGRZ1gIzslRvsdvGnCRsQhR8r687vh4kxnrbnSlCpW19DWqk5h/Isi+3
        blSgbdigx9qimktNMEKcDUaBtIKULxA=
X-Google-Smtp-Source: AJdET5f8t3We6MeQPHVN0rkBjwfh5P3FVHgOaXQJmOad6nEKuFuTNXNiB/GeMTsR/+2/w8BgFaJ/mQ==
X-Received: by 2002:a5e:d809:: with SMTP id l9-v6mr1300050iok.238.1539893433626;
        Thu, 18 Oct 2018 13:10:33 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q123-v6sm7747393iod.23.2018.10.18.13.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 13:10:32 -0700 (PDT)
Subject: Re: bioset changes in 4.18 broke aha1542
To:     Ondrej Zary <linux@rainbow-software.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <201810182034.51724.linux@rainbow-software.org>
 <201810182155.15935.linux@rainbow-software.org>
 <d2684f0b-0b3a-fc0c-badf-57e44d514f40@kernel.dk>
 <201810182204.36894.linux@rainbow-software.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe5cf33d-8653-c43c-dbff-89a8f3413eb4@kernel.dk>
Date:   Thu, 18 Oct 2018 14:10:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <201810182204.36894.linux@rainbow-software.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 2:04 PM, Ondrej Zary wrote:
> On Thursday 18 October 2018 21:59:09 Jens Axboe wrote:
>> On 10/18/18 1:55 PM, Ondrej Zary wrote:
>>> On Thursday 18 October 2018 20:58:57 Jens Axboe wrote:
>>>> On 10/18/18 12:34 PM, Ondrej Zary wrote:
>>>>> Hello,
>>>>> aha1542 works fine in 4.17 but crashes in 4.18. It's hard to bisect because
>>>>> of many commits that don't compile.
>>>>> # only skipped commits left to test
>>>>> # possible first bad commit: [52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b] fs: convert block_dev.c to bioset_init()
>>>>> # possible first bad commit: [a47a28b74a5c7c27bf621276b85ad6c124651236] target: convert to bioset_init()/mempool_init()
>>>>> # possible first bad commit: [6f1c819c219f7841079f0f43ab62727a55b0d849] dm: convert to bioset_init()/mempool_init()
>>>>> # possible first bad commit: [afeee514ce7f4cab605beedd03be71ebaf0c5fc8] md: convert to bioset_init()/mempool_init()
>>>>> # possible first bad commit: [d19936a26658a7a53edd5619d631ee2c2c3151a2] bcache: convert to bioset_init()/mempool_init()
>>>>> # possible first bad commit: [b906bbb6997785d9ea0bd3f5585537afa6257c43] lightnvm: convert to bioset_init()/mempool_init()
>>>>>
>>>>> Testing manually, a47a28b74a5c7c27bf621276b85ad6c124651236 works.
>>>>> 52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b does not compile
>>>>> 8ac9f7c1fd1d342e82ddf078425423b050652ba0 does not compile
>>>>> e292d7bc63c8f2adb3dfda27910e805f1b6557f9 does not compile
>>>>> dad08527525f9a8ac9c7f278864c65f94bc5e9b3 does not compile
>>>>> 943cf9f3ca16133dbd00f9a4cbfea46512fcb0e8 works
>>>>> ..
>>>>> fedc3abe7bd2dcc4c80bcf3cff8708a3908d8219 works
>>>>> 04c4950d5b373ba712d928592e05e73510785bca crashes
>>>>
>>>> It looks like the ISA bioset pool isn't being initialized. You should
>>>> have messages like this in your dmesg:
>>>>
>>>> isa pool size: 16 pages
>>>>
>>>> (which you do), but also something on the bioset section. Do you have
>>>> this one:
>>>>
>>>> pool size: 64 pages
>>>>
>>>> as well?
>>>>
>>>
>>> No, it's not there.
>>
>> Can you attach your .config? I'm guessing CONFIG_HIGHMEM* isn't set.
>>
> 
> It is.

Puzzled... Does this work?


diff --git a/block/bounce.c b/block/bounce.c
index b30071ac4ec6..49564a1bfd22 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -35,10 +35,6 @@ static mempool_t page_pool, isa_page_pool;
 static __init int init_emergency_pool(void)
 {
 	int ret;
-#if defined(CONFIG_HIGHMEM) && !defined(CONFIG_MEMORY_HOTPLUG)
-	if (max_pfn <= max_low_pfn)
-		return 0;
-#endif
 
 	ret = mempool_init_page_pool(&page_pool, POOL_SIZE, 0);
 	BUG_ON(ret);

-- 
Jens Axboe

