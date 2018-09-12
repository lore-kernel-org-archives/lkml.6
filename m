Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81300C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C430520880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C430520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeILHHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 03:07:44 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45253 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbeILHHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 03:07:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=chengdong.li@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T8Td610_1536717927;
Received: from ChengdongdeMacBook-Pro.local(mailfrom:chengdong.li@linux.alibaba.com fp:SMTPD_---0T8Td610_1536717927)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Sep 2018 10:05:28 +0800
Subject: Re: Question: How to switch a process namespace by nsfs "device" and
 inode number directly?
To:     Andi Kleen <ak@linux.intel.com>
Cc:     ebiederm@xmission.com, peterz@infradead.org,
        kjlx@templeofstupid.com, hbathini@linux.vnet.ibm.com,
        brendan.d.gregg@gmail.com, linux-kernel@vger.kernel.org,
        chengdong.licd@alibaba-inc.com
References: <0eb9ec62-1c1b-5903-2db6-43ca571580b9@linux.alibaba.com>
 <20180910160201.GV27886@tassilo.jf.intel.com>
From:   Chengdong Li <chengdong.li@linux.alibaba.com>
Message-ID: <52b34c00-fb4d-7490-5a40-0b7328895ad1@linux.alibaba.com>
Date:   Wed, 12 Sep 2018 10:05:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180910160201.GV27886@tassilo.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Andi!

Yes, that's a situation, also it's an important one I guess.

Another case is that a process running inside a container has exited but 
the container still alive.I think this is also a common case. The 
potential fix solutions I am thinking are following:

- Using nsfs "device" and inum. This is why I am asking for your help. 
As we already have nsfs "device" and inum of each thread at least.

- If the current thread has exited, it's probably the parent thread and 
the leader thread of that container are still alive. If we could have 
those threads' pid, then we could use setns.


If the first item is not doable, I would like to try the second one.


Thanks,

Chengdong

在 2018/9/11 上午12:02, Andi Kleen 写道:
> On Mon, Sep 10, 2018 at 04:50:42PM +0800, Chengdong Li wrote:
>> Hi folks,
>>
>> I am getting stuck by the lack of approach to switch process namespace by
>> nsfs "device" and inode number in user-space,  for example (mnt: 0xf0000000)
>>
>>  From my best understanding, the normal way to do that is by setns system
>> call. But setns only accept fd that refer to a opened namespace, sometimes
>> we couldn't get it.
>>
>> For example:  After perf record, perf report couldn't work well once the
>> process that runs inside a container has exited, as the /proc/pid/ns doesn't
>> exist anymore after process exit.
> The kernel name space doesn't exist anymore at this point, so there is simply no way
> to reconstruct it.
>
> Perhaps would need some higher level side band data for perf, similar as what
> is done for JITed code. Somehow the container run time needs to tell perf
> where to find the code.
>
> -Andi
