Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28A3C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A541E249C5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A541E249C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933992AbeGCQuu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:50:50 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45964 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933569AbeGCQut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:50:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0T3vavFn_1530636621;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T3vavFn_1530636621)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Jul 2018 00:50:27 +0800
Subject: Re: [RFC v3 PATCH 5/5] x86: check VM_DEAD flag in page fault
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Laurent Dufour <ldufour@linux.vnet.ibm.com>, willy@infradead.org,
        akpm@linux-foundation.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-mm@kvack.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <1530311985-31251-6-git-send-email-yang.shi@linux.alibaba.com>
 <84eba553-2e0b-1a90-d543-6b22c1b3c5f8@linux.vnet.ibm.com>
 <20180702121528.GM19043@dhcp22.suse.cz>
 <80406cbd-67f4-ca4c-cd54-aeb305579a72@linux.vnet.ibm.com>
 <20180702124558.GP19043@dhcp22.suse.cz>
 <e6f8d0e2-48c1-f610-c00b-d05d4bd0d9eb@linux.vnet.ibm.com>
 <20180702133733.GU19043@dhcp22.suse.cz>
 <6fd4eb3d-ef66-7a37-4adb-05c22ac51d95@linux.alibaba.com>
 <20180702175749.GG19043@dhcp22.suse.cz>
 <a5b4888c-6518-df47-bc0d-d4173984daa9@linux.alibaba.com>
 <20180703061713.GB16767@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <472ce7f9-be53-c741-6bad-f46ec9dfbb8a@linux.alibaba.com>
Date:   Tue, 3 Jul 2018 09:50:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180703061713.GB16767@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/18 11:17 PM, Michal Hocko wrote:
> On Mon 02-07-18 11:10:23, Yang Shi wrote:
>> On 7/2/18 10:57 AM, Michal Hocko wrote:
> [...]
>>> Why would you even care about shared mappings?
>> Just thought about we are dealing with VM_DEAD, which means the vma will be
>> tore down soon regardless it is shared or non-shared.
>>
>> MMF_UNSTABLE doesn't care about !shared case.

Sorry, this is a typo, it should be "shared".

> Let me clarify some more. MMF_UNSTABLE is there to prevent from
> unexpected page faults when the mm is torn down by the oom reaper. And
> oom reaper only cares about private mappings because we do not touch
> shared ones. Disk based shared mappings should be a non-issue for
> VM_DEAD because even if you race and refault a page back then you know
> it is the same one you have seen before. Memory backed shared mappings
> are a different story because you can get a fresh new page. oom_reaper
> doesn't care because it doesn't tear those down. You would have to but
> my primary point was that we already have MMF_UNSTABLE so all you need
> is to extend it to memory backed shared mappings (shmem and hugetlb).

Yes, sure. I think I got your point. Thanks for the elaboration.

Yang

>

