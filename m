Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeDJQVi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:21:38 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:57464 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751504AbeDJQVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:21:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T-zOUsd_1523377282;
Subject: Re: [v3 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
To: Cyrill Gorcunov <gorcunov@gmail.com>, Michal Hocko <mhocko@kernel.org>
Cc: adobriyan@gmail.com, willy@infradead.org, mguzik@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1523310774-40300-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180410090917.GZ21835@dhcp22.suse.cz> <20180410094047.GB2041@uranus.lan>
 <20180410104215.GB21835@dhcp22.suse.cz> <20180410110242.GC2041@uranus.lan>
 <20180410111001.GD21835@dhcp22.suse.cz> <20180410122804.GD2041@uranus.lan>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <097488c7-ab18-367b-c435-7c26d149c619@linux.alibaba.com>
Date: Tue, 10 Apr 2018 09:21:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410122804.GD2041@uranus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/18 5:28 AM, Cyrill Gorcunov wrote:
> On Tue, Apr 10, 2018 at 01:10:01PM +0200, Michal Hocko wrote:
>>> Because do_brk does vma manipulations, for this reason it's
>>> running under down_write_killable(&mm->mmap_sem). Or you
>>> mean something else?
>> Yes, all we need the new lock for is to get a consistent view on brk
>> values. I am simply asking whether there is something fundamentally
>> wrong by doing the update inside the new lock while keeping the original
>> mmap_sem locking in the brk path. That would allow us to drop the
>> mmap_sem lock in the proc path when looking at brk values.
> Michal gimme some time. I guess  we might do so, but I need some
> spare time to take more precise look into the code, hopefully today
> evening. Also I've a suspicion that we've wracked check_data_rlimit
> with this new lock in prctl. Need to verify it again.

I see you guys points. We might be able to move the drop of mmap_sem 
before setting mm->brk in sys_brk since mmap_sem should be used to 
protect vma manipulation only, then protect the value modify with the 
new arg_lock. Then we can eliminate mmap_sem stuff in prctl path, and it 
also prevents from wrecking check_data_rlimit.

At the first glance, it looks feasible to me. Will look into deeper later.

Thanks,
Yang
