Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbeDJTd4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:33:56 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:60775 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751991AbeDJTdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:33:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T-zSYy5_1523388816;
Subject: Re: [v3 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>, adobriyan@gmail.com,
        willy@infradead.org, mguzik@redhat.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1523310774-40300-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180410090917.GZ21835@dhcp22.suse.cz> <20180410094047.GB2041@uranus.lan>
 <20180410104215.GB21835@dhcp22.suse.cz> <20180410110242.GC2041@uranus.lan>
 <20180410111001.GD21835@dhcp22.suse.cz> <20180410122804.GD2041@uranus.lan>
 <097488c7-ab18-367b-c435-7c26d149c619@linux.alibaba.com>
 <8c19f1fb-7baf-fef3-032d-4e93cfc63932@linux.alibaba.com>
 <20180410191742.GE2041@uranus.lan>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <e868b50d-88a3-a649-d998-b7f2bb2c40aa@linux.alibaba.com>
Date: Tue, 10 Apr 2018 12:33:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410191742.GE2041@uranus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/18 12:17 PM, Cyrill Gorcunov wrote:
> On Tue, Apr 10, 2018 at 11:28:13AM -0700, Yang Shi wrote:
>>> At the first glance, it looks feasible to me. Will look into deeper
>>> later.
>> A further look told me this might be *not* feasible.
>>
>> It looks the new lock will not break check_data_rlimit since in my patch
>> both start_brk and brk is protected by mmap_sem. The code flow might look
>> like below:
>>
>> CPU A                             CPU B
>> --------                       --------
>> prctl                               sys_brk
>>                                        down_write
>> check_data_rlimit           check_data_rlimit (need mm->start_brk)
>>                                        set brk
>> down_write                    up_write
>> set start_brk
>> set brk
>> up_write
>>
>> If CPU A gets the mmap_sem first, it will set start_brk and brk, then CPU B
>> will check with the new start_brk. And, prctl doesn't care if sys_brk is run
>> before it since it gets the new start_brk and brk from parameter.
>>
>> If we protect start_brk and brk with the new lock, sys_brk might get old
>> start_brk, then sys_brk might break rlimit check silently, is that right?
>>
>> So, it looks using new lock in prctl and keeping mmap_sem in brk path has
>> race condition.
> I fear so. The check_data_rlimit implies that all elements involved into
> validation (brk, start_brk, start_data, end_data) are not changed unpredicably
> until written back into mm. In turn if we guard start_brk,brk only (as
> it is done in the patch) the check_data_rlimit may pass on wrong data
> I think. And as you mentioned the race above exact the example of such
> situation. I think for prctl case we can simply left use of mmap_sem
> as it were before the patch, after all this syscall is really in cold
> path all the time.

The race condition is just valid when protecting start_brk, brk, 
start_data and end_data with the new lock, but keep using mmap_sem in 
brk path.

So, we should just need make a little tweak to have mmap_sem protect 
start_brk, brk, start_data and end_data, then have the new lock protect 
others so that we still can remove mmap_sem in proc as the patch is 
aimed to do.

Yang

>
> 	Cyrill
