Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeDMB2J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 21:28:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751803AbeDMB2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 21:28:08 -0400
Subject: Re: [PATCH] f2fs: enlarge block plug coverage
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20180404085404.82184-1-yuchao0@huawei.com>
 <20180405035115.GC50337@jaegeuk-macbookpro.roam.corp.google.com>
 <03c21c2f-cb0e-dbd4-b48a-95c2678964d1@huawei.com>
 <20180409180241.GC17558@jaegeuk-macbookpro.roam.corp.google.com>
 <967b8819-da9a-b609-6a22-db8df5c7ec6c@huawei.com>
 <20180410041033.GE47598@jaegeuk-macbookpro.roam.corp.google.com>
 <ff3990f2-5785-045e-30c5-62a9f8352d74@huawei.com>
 <20180413010615.GA53401@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <fd5b56ef-4f27-65b7-d3a2-71ef4425b452@huawei.com>
Date: Fri, 13 Apr 2018 09:27:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180413010615.GA53401@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/13 9:06, Jaegeuk Kim wrote:
> On 04/10, Chao Yu wrote:
>> On 2018/4/10 12:10, Jaegeuk Kim wrote:
>>> On 04/10, Chao Yu wrote:
>>>> On 2018/4/10 2:02, Jaegeuk Kim wrote:
>>>>> On 04/08, Chao Yu wrote:
>>>>>> On 2018/4/5 11:51, Jaegeuk Kim wrote:
>>>>>>> On 04/04, Chao Yu wrote:
>>>>>>>> This patch enlarges block plug coverage in __issue_discard_cmd, in
>>>>>>>> order to collect more pending bios before issuing them, to avoid
>>>>>>>> being disturbed by previous discard I/O in IO aware discard mode.
>>>>>>>
>>>>>>> Hmm, then we need to wait for huge discard IO for over 10 secs, which
>>>>>>
>>>>>> We found that total discard latency is rely on total discard number we issued
>>>>>> last time instead of range or length discard covered. IMO, if we don't change
>>>>>> .max_requests value, we will not suffer longer latency.
>>>>>>
>>>>>>> will affect following read/write IOs accordingly. In order to avoid that,
>>>>>>> we actually need to limit the discard size.
>>>>
>>>> Do you mean limit discard count or discard length?
>>>
>>> Both of them.
>>>
>>>>
>>>>>>
>>>>>> If you are worry about I/O interference in between discard and rw, I suggest to
>>>>>> decrease .max_requests value.
>>>>>
>>>>> What do you mean? This will produce more pending requests in the queue?
>>>>
>>>> I mean after applying this patch, we can queue more discard IOs in plug inside
>>>> task, otherwise, previous issued discard in block layer can make is_idle() be false,
>>>> then it can stop IO awared user to issue pending discard command.
>>>
>>> Then, unplug will issue lots of discard commands, which affects the following rw
>>> latencies. My preference would be issuing discard commands one by one as much as
>>> possible.
>>
>> Hmm.. for you concern, we can turn down IO priority of discard from background?
> 
> That makes much more sense to me. :P

Then, this patch which enlarge plug coverage will not still a problem, right? ;)

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Thanks,
>>>>
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>>>>>> ---
>>>>>>>>  fs/f2fs/segment.c | 7 +++++--
>>>>>>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>>>>>>>> index 8f0b5ba46315..4287e208c040 100644
>>>>>>>> --- a/fs/f2fs/segment.c
>>>>>>>> +++ b/fs/f2fs/segment.c
>>>>>>>> @@ -1208,10 +1208,12 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>>>>>  		pend_list = &dcc->pend_list[i];
>>>>>>>>  
>>>>>>>>  		mutex_lock(&dcc->cmd_lock);
>>>>>>>> +
>>>>>>>> +		blk_start_plug(&plug);
>>>>>>>> +
>>>>>>>>  		if (list_empty(pend_list))
>>>>>>>>  			goto next;
>>>>>>>>  		f2fs_bug_on(sbi, !__check_rb_tree_consistence(sbi, &dcc->root));
>>>>>>>> -		blk_start_plug(&plug);
>>>>>>>>  		list_for_each_entry_safe(dc, tmp, pend_list, list) {
>>>>>>>>  			f2fs_bug_on(sbi, dc->state != D_PREP);
>>>>>>>>  
>>>>>>>> @@ -1227,8 +1229,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
>>>>>>>>  			if (++iter >= dpolicy->max_requests)
>>>>>>>>  				break;
>>>>>>>>  		}
>>>>>>>> -		blk_finish_plug(&plug);
>>>>>>>>  next:
>>>>>>>> +		blk_finish_plug(&plug);
>>>>>>>> +
>>>>>>>>  		mutex_unlock(&dcc->cmd_lock);
>>>>>>>>  
>>>>>>>>  		if (iter >= dpolicy->max_requests)
>>>>>>>> -- 
>>>>>>>> 2.15.0.55.gc2ece9dc4de6
>>>>>>>
>>>>>>> .
>>>>>>>
>>>>>
>>>>> .
>>>>>
>>>
>>> .
>>>
> 
> .
> 
