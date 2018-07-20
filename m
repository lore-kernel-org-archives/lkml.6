Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEA6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029B92084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 23:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029B92084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeGUAkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 20:40:22 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48494 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727845AbeGUAkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 20:40:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T50SZ8a_1532130571;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T50SZ8a_1532130571)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 21 Jul 2018 07:49:33 +0800
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kirill@shutemov.name,
        hughd@google.com, aaron.lu@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180720123243.6dfc95ba061cd06e05c0262e@linux-foundation.org>
 <alpine.DEB.2.21.1807201300290.224013@chino.kir.corp.google.com>
 <3238b5d2-fd89-a6be-0382-027a24a4d3ad@linux.alibaba.com>
 <alpine.DEB.2.21.1807201401390.231119@chino.kir.corp.google.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <b258c765-ad71-0dd4-d420-75139c55e7c7@linux.alibaba.com>
Date:   Fri, 20 Jul 2018 16:49:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807201401390.231119@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/18 2:05 PM, David Rientjes wrote:
> On Fri, 20 Jul 2018, Yang Shi wrote:
>
>>> We disable the huge zero page through this interface, there were issues
>>> related to the huge zero page shrinker (probably best to never free a
>>> per-node huge zero page after allocated) and CVE-2017-1000405 for huge
>>> dirty COW.
>> Thanks for the information. It looks the CVE has been resolved by commit
>> a8f97366452ed491d13cf1e44241bc0b5740b1f0 ("mm, thp: Do not make page table
>> dirty unconditionally in touch_p[mu]d()"), which is in 4.15 already.
>>
> For users who run kernels earlier than 4.15 they may choose to mitigate
> the CVE by using this tunable.  It's not something we permanently need to
> have, but it may likely be too early.

Yes, it might be good to keep it around for a while.

>
>> What was the shrinker related issue? I'm supposed it has been resolved, right?
>>
> The huge zero page can be reclaimed under memory pressure and, if it is,
> it is attempted to be allocted again with gfp flags that attempt memory
> compaction that can become expensive.  If we are constantly under memory
> pressure, it gets freed and reallocated millions of times always trying to
> compact memory both directly and by kicking kcompactd in the background.

Even though we don't use huge zero page, we may also run into the 
similar issue under memory pressure. Just save the cost of calling huge 
zero page shrinker, but actually its cost sound not high.

>
> It likely should also be per node.


