Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502B9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24112081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24112081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbeKFFjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:39:35 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:47171 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730109AbeKFFje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:39:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TCLNr4G_1541449084;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TCLNr4G_1541449084)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Nov 2018 04:18:08 +0800
Subject: Re: [LKP] [mm] 9bc8039e71: will-it-scale.per_thread_ops -64.1%
 regression
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     rong.a.chen@intel.com, vbabka@suse.cz,
        kirill.shutemov@linux.intel.com, mhocko@kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        ldufour@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin King <colin.king@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
References: <20181105050813.GP24195@shao2-debian>
 <CAHk-=wi8BNNTp+Xt4ROz1TqGgFT-c6-Hmmc9yW0B6p2FTFwJTg@mail.gmail.com>
 <4feae9c4-432d-a362-58e4-11e0cb10b24d@linux.alibaba.com>
 <CAHk-=whr2Aio3R49TVWqW3es6heyxXDuxGHcv8Bcc=_kw4vDeQ@mail.gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <51265121-6e54-ff3a-cdfa-e5a2b838268d@linux.alibaba.com>
Date:   Mon, 5 Nov 2018 12:17:59 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whr2Aio3R49TVWqW3es6heyxXDuxGHcv8Bcc=_kw4vDeQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/5/18 10:35 AM, Linus Torvalds wrote:
> On Mon, Nov 5, 2018 at 10:28 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>> Actually, the commit is mainly for optimizing the long stall time caused
>> by holding mmap_sem by write when unmapping or shrinking large mapping.
>> It downgrades write mmap_sem to read when zapping pages. So, it looks
>> the downgrade incurs more context switches. This is kind of expected.
>>
>> However, the test looks just shrink the mapping with one normal 4K page
>> size. It sounds the overhead of context switches outpace the gain in
>> this case at the first glance.
> I'm not seeing why there should be a context switch in the first place.
>
> Even if you have lots of concurrent brk() users, they should all block
> exactly the same way as before (a write lock blocks against a write
> lock, but it *also* blocks against a downgraded read lock).

Yes, it is true. The brk() users will not get waken up. What I can think 
of for now is there might be other helper processes and/or kernel 
threads are waiting for read mmap_sem. They might get waken up by the 
downgrade.

But, I also saw huge increase in cpu idle time and sched_goidle events. 
Not have clue yet for why idle goes up.

20610709 ± 15%   +2376.0%  5.103e+08 ± 34%  cpuidle.C1.time
28753819 ± 39%   +1054.5%  3.319e+08 ± 49%  cpuidle.C3.time

175049 ± 72%    +840.7%    1646720 ± 72%  sched_debug.cpu.sched_goidle.stddev


Thanks,
Yang

>
> So no, I don't want just some limit to hide this problem for that
> particular test. There's something else going on.
>
>                   Linus

