Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752728AbeDQLqF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:46:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752580AbeDQLqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:46:04 -0400
Subject: Re: [PATCH] f2fs: set deadline to drop expired inmem pages
From: Chao Yu <yuchao0@huawei.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180408081312.6190-1-yuchao0@huawei.com>
 <09fd3144-d1c5-ca02-178d-b467d6fbe0e1@huawei.com>
 <20180413010433.GB51348@jaegeuk-macbookpro.roam.corp.google.com>
 <bb7d3b60-0629-ea80-c4ae-976a76abb034@huawei.com>
 <20180413040525.GB59368@jaegeuk-macbookpro.roam.corp.google.com>
 <51d2e16a-3a69-71ef-86f5-aee63cd6731c@huawei.com>
 <20180416201603.GA76077@jaegeuk-macbookpro.roam.corp.google.com>
 <b4aba32d-e57a-add4-19d5-7d19a8ccd90c@huawei.com>
Message-ID: <aea6b6f2-e4c4-5818-ab51-fba5f755f4e0@huawei.com>
Date: Tue, 17 Apr 2018 19:45:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <b4aba32d-e57a-add4-19d5-7d19a8ccd90c@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/17 14:44, Chao Yu wrote:
> On 2018/4/17 4:16, Jaegeuk Kim wrote:
>> On 04/13, Chao Yu wrote:
>>> On 2018/4/13 12:05, Jaegeuk Kim wrote:
>>>> On 04/13, Chao Yu wrote:
>>>>> On 2018/4/13 9:04, Jaegeuk Kim wrote:
>>>>>> On 04/10, Chao Yu wrote:
>>>>>>> Hi Jaegeuk,
>>>>>>>
>>>>>>> On 2018/4/8 16:13, Chao Yu wrote:
>>>>>>>> f2fs doesn't allow abuse on atomic write class interface, so except
>>>>>>>> limiting in-mem pages' total memory usage capacity, we need to limit
>>>>>>>> start-commit time as well, otherwise we may run into infinite loop
>>>>>>>> during foreground GC because target blocks in victim segment are
>>>>>>>> belong to atomic opened file for long time.
>>>>>>>>
>>>>>>>> Now, we will check the condition with f2fs_balance_fs_bg in
>>>>>>>> background threads, once if user doesn't commit data exceeding 30
>>>>>>>> seconds, we will drop all cached data, so I expect it can keep our
>>>>>>>> system running safely to prevent Dos attack.
>>>>>>>
>>>>>>> Is it worth to add this patch to avoid abuse on atomic write interface by user?
>>>>>>
>>>>>> Hmm, hope to see a real problem first in this case.
>>>>>
>>>>> I think this can be a more critical security leak instead of a potential issue
>>>>> which we can wait for someone reporting that can be too late.
>>>>>
>>>>> For example, user can simply write a huge file whose data spread in all f2fs
>>>>> segments, once user open that file as atomic, foreground GC will suffer
>>>>> deadloop, causing denying any further service of f2fs.
>>>>
>>>> How can you guarantee it won't happen within 30sec? If you want to avoid that,
>>>
>>> Now the value is smaller than generic hang task threshold in order to avoid
>>> foreground GC helding gc_mutex too long, we can tune that parameter?
>>>
>>>> you have to take a look at foreground gc.
>>>
>>> What do you mean? let GC moves blocks of atomic write opened file?
>>
>> I thought that we first need to detect when foreground GC is stuck by such the
>> huge number of atomic writes. Then, we need to do something like dropping all
>> the atomic writes.
> 
> Yup, that will be reasonable. :)

If we drop all atomic writes, for those atomic write who act very normal, it
will case them losing all cached data without any hint like error return value.
So should we just:

- drop expired inmem pages.
- or set FI_DROP_ATOMIC flag, return -EIO during atomic_commit, and reset the flag.

Thanks,

> 
> Thanks,
> 
>>
>>>
>>> Thanks,
>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>
>>>>>> .
>>>>>>
>>>>
>>>> .
>>>>
>>
>> .
>>
> 
> 
> .
> 
