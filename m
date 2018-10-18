Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61950ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A952098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rainbow-software.org header.i=@rainbow-software.org header.b="Cgge1T7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A952098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rainbow-software.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeJSEZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:25:26 -0400
Received: from smtp-1b-out-4.atlantis.sk ([80.94.52.30]:58797 "EHLO
        smtp-1b-out-4.atlantis.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeJSEZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:25:25 -0400
Received: from [192.168.0.2] (188-167-58-14.dynamic.chello.sk [188.167.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp-1b.atlantis.sk (Postfix) with ESMTPSA id 0E5BB8352DE3;
        Thu, 18 Oct 2018 22:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rainbow-software.org;
        s=atlsmtp; t=1539894164;
        bh=0jyFCF34wDxrF1E3lR1qMOppH/Sz+8992KgGRDKA+i4=;
        h=From:To:Subject:Date:Cc:References:In-Reply-To;
        b=Cgge1T7TC7Y3CjN6kEIsI5xz3jjvM1pe2bjqnSVvLGC3AnWYxQo8AlCUVVxnUIHkR
         2gZdEPsQwXiSiT1GVFWWCZD0ToCNUIZqRzdJ5v20s3zK14e6k9Mm3rROaCp+BjvK+F
         xAMayKLCt3UUeHjXrAY5+kujBK4fQ7XKgetMlQog=
From:   Ondrej Zary <linux@rainbow-software.org>
To:     Jens Axboe <axboe@kernel.dk>
Subject: Re: bioset changes in 4.18 broke aha1542
Date:   Thu, 18 Oct 2018 22:22:41 +0200
User-Agent: KMail/1.9.10 (enterprise35 0.20100827.1168748)
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <201810182034.51724.linux@rainbow-software.org> <201810182204.36894.linux@rainbow-software.org> <fe5cf33d-8653-c43c-dbff-89a8f3413eb4@kernel.dk>
In-Reply-To: <fe5cf33d-8653-c43c-dbff-89a8f3413eb4@kernel.dk>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201810182222.41789.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 October 2018 22:10:31 Jens Axboe wrote:
> On 10/18/18 2:04 PM, Ondrej Zary wrote:
> > On Thursday 18 October 2018 21:59:09 Jens Axboe wrote:
> >> On 10/18/18 1:55 PM, Ondrej Zary wrote:
> >>> On Thursday 18 October 2018 20:58:57 Jens Axboe wrote:
> >>>> On 10/18/18 12:34 PM, Ondrej Zary wrote:
> >>>>> Hello,
> >>>>> aha1542 works fine in 4.17 but crashes in 4.18. It's hard to bisect because
> >>>>> of many commits that don't compile.
> >>>>> # only skipped commits left to test
> >>>>> # possible first bad commit: [52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b] fs: convert block_dev.c to bioset_init()
> >>>>> # possible first bad commit: [a47a28b74a5c7c27bf621276b85ad6c124651236] target: convert to bioset_init()/mempool_init()
> >>>>> # possible first bad commit: [6f1c819c219f7841079f0f43ab62727a55b0d849] dm: convert to bioset_init()/mempool_init()
> >>>>> # possible first bad commit: [afeee514ce7f4cab605beedd03be71ebaf0c5fc8] md: convert to bioset_init()/mempool_init()
> >>>>> # possible first bad commit: [d19936a26658a7a53edd5619d631ee2c2c3151a2] bcache: convert to bioset_init()/mempool_init()
> >>>>> # possible first bad commit: [b906bbb6997785d9ea0bd3f5585537afa6257c43] lightnvm: convert to bioset_init()/mempool_init()
> >>>>>
> >>>>> Testing manually, a47a28b74a5c7c27bf621276b85ad6c124651236 works.
> >>>>> 52190f8abe7f2bf2b4e5f9760cbcc1427ca2136b does not compile
> >>>>> 8ac9f7c1fd1d342e82ddf078425423b050652ba0 does not compile
> >>>>> e292d7bc63c8f2adb3dfda27910e805f1b6557f9 does not compile
> >>>>> dad08527525f9a8ac9c7f278864c65f94bc5e9b3 does not compile
> >>>>> 943cf9f3ca16133dbd00f9a4cbfea46512fcb0e8 works
> >>>>> ..
> >>>>> fedc3abe7bd2dcc4c80bcf3cff8708a3908d8219 works
> >>>>> 04c4950d5b373ba712d928592e05e73510785bca crashes
> >>>>
> >>>> It looks like the ISA bioset pool isn't being initialized. You should
> >>>> have messages like this in your dmesg:
> >>>>
> >>>> isa pool size: 16 pages
> >>>>
> >>>> (which you do), but also something on the bioset section. Do you have
> >>>> this one:
> >>>>
> >>>> pool size: 64 pages
> >>>>
> >>>> as well?
> >>>>
> >>>
> >>> No, it's not there.
> >>
> >> Can you attach your .config? I'm guessing CONFIG_HIGHMEM* isn't set.
> >>
> > 
> > It is.
> 
> Puzzled... Does this work?
> 
> 
> diff --git a/block/bounce.c b/block/bounce.c
> index b30071ac4ec6..49564a1bfd22 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -35,10 +35,6 @@ static mempool_t page_pool, isa_page_pool;
>  static __init int init_emergency_pool(void)
>  {
>  	int ret;
> -#if defined(CONFIG_HIGHMEM) && !defined(CONFIG_MEMORY_HOTPLUG)
> -	if (max_pfn <= max_low_pfn)
> -		return 0;
> -#endif
>  
>  	ret = mempool_init_page_pool(&page_pool, POOL_SIZE, 0);
>  	BUG_ON(ret);
> 

Yes, it does! 
bounce: pool size: 64 pages
and aha1542 works.

Also added printks for pfn:
max_pfn=65520, max_low_pfn=65520

-- 
Ondrej Zary
