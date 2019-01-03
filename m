Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D692DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC9F217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbfACQ5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:57:35 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49292 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732412AbfACQ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:57:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0THTEbts_1546534592;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THTEbts_1546534592)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 04 Jan 2019 00:56:34 +0800
Subject: Re: [PATCH 2/3] mm: memcontrol: do not try to do swap when force
 empty
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1546459533-36247-1-git-send-email-yang.shi@linux.alibaba.com>
 <1546459533-36247-3-git-send-email-yang.shi@linux.alibaba.com>
 <CALvZod7X6FOMnZT48Q9Joh_nha6NMXntL3XqMDqRYFZ1ULgh=w@mail.gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <763b97f5-ea9c-e3e6-7fd9-0ab42cf09ca8@linux.alibaba.com>
Date:   Thu, 3 Jan 2019 08:56:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALvZod7X6FOMnZT48Q9Joh_nha6NMXntL3XqMDqRYFZ1ULgh=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/2/19 1:45 PM, Shakeel Butt wrote:
> On Wed, Jan 2, 2019 at 12:06 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>> The typical usecase of force empty is to try to reclaim as much as
>> possible memory before offlining a memcg.  Since there should be no
>> attached tasks to offlining memcg, the tasks anonymous pages would have
>> already been freed or uncharged.
> Anon pages can come from tmpfs files as well.

Yes, but they are charged to swap space as regular anon pages.

>
>> Even though anonymous pages get
>> swapped out, but they still get charged to swap space.  So, it sounds
>> pointless to do swap for force empty.
>>
> I understand that force_empty is typically used before rmdir'ing a
> memcg but it might be used differently by some users. We use this
> interface to test memory reclaim behavior (anon and file).

Thanks for sharing your usecase. So, you uses this for test only?

>
> Anyways, I am not against changing the behavior, we can adapt
> internally but there might be other users using this interface
> differently.

Thanks.

Yang

>
> thanks,
> Shakeel

