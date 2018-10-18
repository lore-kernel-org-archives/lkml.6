Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7830C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E772145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xN203UKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E772145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeJSEbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:31:21 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38128 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSEbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:31:20 -0400
Received: by mail-it1-f194.google.com with SMTP id i76-v6so2009943ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AlH7aFBh9LBPqEh2my4cGuUFIT4INFCUN481J/mPJ4c=;
        b=xN203UKucSUUW4V02dc7w673l3nWVVWX/7W5fh4GekQaPVmQr8R0KdZceZRSRuAxac
         ahtDdKtbU+EcLCfXMuuUy8/g88tnOqLZdCI37E7gfRYPXyXKnkG6I8+C3yJ2tYRUszGx
         dAKq1pPHB9XnXjcvRe9hIA884L/ew8+9cVbMAtsqU/kvVqfKHbmJTIsW0IQaD7D9IA/e
         BneNRDyiooJxU9pRE+3VvkuqWF/+8W3FVgfcTbmPQ433ujOczkT1SctkvaSj2qLrs9fW
         byA35ijwFRtiy6Wd326iWJV8T9/iRJWC4+SWbPj4AVF8wZOBRDYqa3nDfrInPIp9NnP4
         wrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AlH7aFBh9LBPqEh2my4cGuUFIT4INFCUN481J/mPJ4c=;
        b=hzHAUz8t6UMQES69IggQzaBPg6+ajt0jqY7MYw0yNMeK16f4ITq1TC/NXi2xc8EV4e
         6gMQaQUZfW4xds9fIBt3xUgzP4OpyKjVwXojopeRN3AetBC3uX334QNx2L9PLvIvzqUv
         PqUzpZa8hVLoaKmRoWKJfmZ+945X6KPnCNzYTuU4dgRAa4OUZnhP26ijLFQGby3n4BL9
         0On00jbsOb1+Pg/BvNfgvmU1eVOki+20SlwRlKp28KmXI95NoeNuVRearVnojOUdFLHw
         OtTfDPUBiJs5YtgeGMJmju0B6PkyUBZpTqWCR8e4B1xK+jAZGk1XJzly7sLIGT5ZM/tP
         lkQg==
X-Gm-Message-State: ABuFfohf+dbtPqSdwWGIeKi3fpXYWc0++0U54vM2nzp3VcQ7wnrciwIv
        kQJhjn9hqMCx0tbRh8bAuUjP4zx5D6k=
X-Google-Smtp-Source: ACcGV63Ufe13r+IwbOYmXREhtLxHS3Q97D17QnHGD7BrOYI/p8Cz4cda7/AkffIhPHSABeCHThig5Q==
X-Received: by 2002:a24:4113:: with SMTP id x19-v6mr1332521ita.112.1539894517838;
        Thu, 18 Oct 2018 13:28:37 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a14-v6sm6651938iod.53.2018.10.18.13.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 13:28:36 -0700 (PDT)
Subject: Re: bioset changes in 4.18 broke aha1542
To:     Ondrej Zary <linux@rainbow-software.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <201810182034.51724.linux@rainbow-software.org>
 <201810182204.36894.linux@rainbow-software.org>
 <fe5cf33d-8653-c43c-dbff-89a8f3413eb4@kernel.dk>
 <201810182222.41789.linux@rainbow-software.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2baee56c-8e56-3dba-0000-1af1392a89f7@kernel.dk>
Date:   Thu, 18 Oct 2018 14:28:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <201810182222.41789.linux@rainbow-software.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/18 2:22 PM, Ondrej Zary wrote:
> On Thursday 18 October 2018 22:10:31 Jens Axboe wrote:
>> On 10/18/18 2:04 PM, Ondrej Zary wrote:
>>> On Thursday 18 October 2018 21:59:09 Jens Axboe wrote:
>>>> On 10/18/18 1:55 PM, Ondrej Zary wrote:
>>>>> On Thursday 18 October 2018 20:58:57 Jens Axboe wrote:
>>>>>> On 10/18/18 12:34 PM, Ondrej Zary wrote:
>>>>>>> Hello,
>>>>>>> aha1542 works fine in 4.17 but crashes in 4.18. It's hard to bisect because
>>>>>>> of many commits that don't compile.
>>>>>>> # only skipped commits left to test
>>>>>>> # possible first bad commit: [52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b] fs: convert block_dev.c to bioset_init()
>>>>>>> # possible first bad commit: [a47a28b74a5c7c27bf621276b85ad6c124651236] target: convert to bioset_init()/mempool_init()
>>>>>>> # possible first bad commit: [6f1c819c219f7841079f0f43ab62727a55b0d849] dm: convert to bioset_init()/mempool_init()
>>>>>>> # possible first bad commit: [afeee514ce7f4cab605beedd03be71ebaf0c5fc8] md: convert to bioset_init()/mempool_init()
>>>>>>> # possible first bad commit: [d19936a26658a7a53edd5619d631ee2c2c3151a2] bcache: convert to bioset_init()/mempool_init()
>>>>>>> # possible first bad commit: [b906bbb6997785d9ea0bd3f5585537afa6257c43] lightnvm: convert to bioset_init()/mempool_init()
>>>>>>>
>>>>>>> Testing manually, a47a28b74a5c7c27bf621276b85ad6c124651236 works.
>>>>>>> 52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b does not compile
>>>>>>> 8ac9f7c1fd1d342e82ddf078425423b050652ba0 does not compile
>>>>>>> e292d7bc63c8f2adb3dfda27910e805f1b6557f9 does not compile
>>>>>>> dad08527525f9a8ac9c7f278864c65f94bc5e9b3 does not compile
>>>>>>> 943cf9f3ca16133dbd00f9a4cbfea46512fcb0e8 works
>>>>>>> ..
>>>>>>> fedc3abe7bd2dcc4c80bcf3cff8708a3908d8219 works
>>>>>>> 04c4950d5b373ba712d928592e05e73510785bca crashes
>>>>>>
>>>>>> It looks like the ISA bioset pool isn't being initialized. You should
>>>>>> have messages like this in your dmesg:
>>>>>>
>>>>>> isa pool size: 16 pages
>>>>>>
>>>>>> (which you do), but also something on the bioset section. Do you have
>>>>>> this one:
>>>>>>
>>>>>> pool size: 64 pages
>>>>>>
>>>>>> as well?
>>>>>>
>>>>>
>>>>> No, it's not there.
>>>>
>>>> Can you attach your .config? I'm guessing CONFIG_HIGHMEM* isn't set.
>>>>
>>>
>>> It is.
>>
>> Puzzled... Does this work?
>>
>>
>> diff --git a/block/bounce.c b/block/bounce.c
>> index b30071ac4ec6..49564a1bfd22 100644
>> --- a/block/bounce.c
>> +++ b/block/bounce.c
>> @@ -35,10 +35,6 @@ static mempool_t page_pool, isa_page_pool;
>>  static __init int init_emergency_pool(void)
>>  {
>>  	int ret;
>> -#if defined(CONFIG_HIGHMEM) && !defined(CONFIG_MEMORY_HOTPLUG)
>> -	if (max_pfn <= max_low_pfn)
>> -		return 0;
>> -#endif
>>  
>>  	ret = mempool_init_page_pool(&page_pool, POOL_SIZE, 0);
>>  	BUG_ON(ret);
>>
> 
> Yes, it does! 
> bounce: pool size: 64 pages
> and aha1542 works.
> 
> Also added printks for pfn:
> max_pfn=65520, max_low_pfn=65520

This should be a better fix, though I'm still puzzled why we need
it now. Can you test this one?


diff --git a/block/bounce.c b/block/bounce.c
index b30071ac4ec6..1356a2f4aae2 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -31,6 +31,24 @@
 static struct bio_set bounce_bio_set, bounce_bio_split;
 static mempool_t page_pool, isa_page_pool;
 
+static __init void init_bounce_bioset(void)
+{
+	static bool bounce_bs_setup;
+	int ret;
+
+	if (bounce_bs_setup)
+		return;
+
+	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
+	BUG_ON(ret);
+	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
+		BUG_ON(1);
+
+	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
+	BUG_ON(ret);
+	bounce_bs_setup = true;
+}
+
 #if defined(CONFIG_HIGHMEM)
 static __init int init_emergency_pool(void)
 {
@@ -44,14 +62,7 @@ static __init int init_emergency_pool(void)
 	BUG_ON(ret);
 	pr_info("pool size: %d pages\n", POOL_SIZE);
 
-	ret = bioset_init(&bounce_bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
-	BUG_ON(ret);
-	if (bioset_integrity_create(&bounce_bio_set, BIO_POOL_SIZE))
-		BUG_ON(1);
-
-	ret = bioset_init(&bounce_bio_split, BIO_POOL_SIZE, 0, 0);
-	BUG_ON(ret);
-
+	init_bounce_bioset();
 	return 0;
 }
 
@@ -102,6 +113,7 @@ int init_emergency_isa_pool(void)
 	BUG_ON(ret);
 
 	pr_info("isa pool size: %d pages\n", ISA_POOL_SIZE);
+	init_bounce_bioset();
 	return 0;
 }
 

-- 
Jens Axboe

