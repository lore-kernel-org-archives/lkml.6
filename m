Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD02DC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E9024A66
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 01:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E9024A66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934470AbeFWBBg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 21:01:36 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52943 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933773AbeFWBBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 21:01:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0T3CFQK-_1529715669;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3CFQK-_1529715669)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 23 Jun 2018 09:01:15 +0800
Subject: Re: [RFC v2 PATCH 2/2] mm: mmap: zap pages with read mmap_sem for
 large mapping
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     Michal Hocko <mhocko@kernel.org>, Nadav Amit <nadav.amit@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, ldufour@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
References: <1529364856-49589-1-git-send-email-yang.shi@linux.alibaba.com>
 <1529364856-49589-3-git-send-email-yang.shi@linux.alibaba.com>
 <3DDF2672-FCC4-4387-9624-92F33C309CAE@gmail.com>
 <158a4e4c-d290-77c4-a595-71332ede392b@linux.alibaba.com>
 <BFD6A249-B1D7-43D5-8D7C-9FAED4A168A1@gmail.com>
 <20180620071817.GJ13685@dhcp22.suse.cz>
 <c184031d-b1db-503e-1a32-7963b4bf3de0@linux.alibaba.com>
Message-ID: <94bdfcf0-68ea-404c-a60f-362f677884b6@linux.alibaba.com>
Date:   Fri, 22 Jun 2018 18:01:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c184031d-b1db-503e-1a32-7963b4bf3de0@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this is true but I guess what Yang Shi meant was that an userspace
>> access racing with munmap is not well defined. You never know whether
>> you get your data, #PTF or SEGV because it depends on timing. The user
>> visible change might be that you lose content and get zero page instead
>> if you hit the race window while we are unmapping which was not possible
>> before. But whouldn't such an access pattern be buggy anyway? You need
>> some form of external synchronization AFAICS.
>>
>> But maybe some userspace depends on "getting right data or get SEGV"
>> semantic. If we have to preserve that then we can come up with a VM_DEAD
>> flag set before we tear it down and force the SEGV on the #PF path.
>> Something similar we already do for MMF_UNSTABLE.
>
> Set VM_DEAD with read mmap_sem held? It should be ok since this is the 
> only place to set this flag for this unique special case.

BTW, it looks the vm flags have used up in 32 bit. If we really need 
VM_DEAD, it should be for both 32-bit and 64-bit.

Any suggestion?

Thanks,
Yang

>
> Yang
>
>

