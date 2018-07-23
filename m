Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE265ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DB520854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DB520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbeGWWw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:52:57 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:58257 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388139AbeGWWw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:52:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T5BhbnK_1532382574;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T5BhbnK_1532382574)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 24 Jul 2018 05:49:37 +0800
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
To:     David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kirill@shutemov.name,
        hughd@google.com, aaron.lu@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180720123243.6dfc95ba061cd06e05c0262e@linux-foundation.org>
 <alpine.DEB.2.21.1807201300290.224013@chino.kir.corp.google.com>
 <3238b5d2-fd89-a6be-0382-027a24a4d3ad@linux.alibaba.com>
 <alpine.DEB.2.21.1807201401390.231119@chino.kir.corp.google.com>
 <20180722035156.GA12125@bombadil.infradead.org>
 <alpine.DEB.2.21.1807231323460.105582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1807231427550.103523@chino.kir.corp.google.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <7d96258c-2973-2df5-08d4-828875058be1@linux.alibaba.com>
Date:   Mon, 23 Jul 2018 14:49:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807231427550.103523@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/18 2:33 PM, David Rientjes wrote:
> On Mon, 23 Jul 2018, David Rientjes wrote:
>
>>>> The huge zero page can be reclaimed under memory pressure and, if it is,
>>>> it is attempted to be allocted again with gfp flags that attempt memory
>>>> compaction that can become expensive.  If we are constantly under memory
>>>> pressure, it gets freed and reallocated millions of times always trying to
>>>> compact memory both directly and by kicking kcompactd in the background.
>>>>
>>>> It likely should also be per node.
>>> Have you benchmarked making the non-huge zero page per-node?
>>>
>> Not since we disable it :)  I will, though.  The more concerning issue for
>> us, modulo CVE-2017-1000405, is the cpu cost of constantly directly
>> compacting memory for allocating the hzp in real time after it has been
>> reclaimed.  We've observed this happening tens or hundreds of thousands
>> of times on some systems.  It will be 2MB per node on x86 if the data
>> suggests we should make it NUMA aware, I don't think the cost is too high
>> to leave it persistently available even under memory pressure if
>> use_zero_page is enabled.
>>
> Measuring access latency to 4GB of memory on Naples I observe ~6.7%
> slower access latency intrasocket and ~14% slower intersocket.
>
> use_zero_page is currently a simple thp flag, meaning it rejects writes
> where val != !!val, so perhaps it would be best to overload it with
> additional options?  I can imagine 0x2 defining persistent allocation so
> that the hzp is not freed when the refcount goes to 0 and 0x4 defining if
> the hzp should be per node.  Implementing persistent allocation fixes our
> concern with it, so I'd like to start there.  Comments?

Sounds worth trying to me :-)  It might be worth making it persistent by 
default. Keeping 2MB memory unreclaimable sounds not harmful for the use 
case which prefer to use THP.


