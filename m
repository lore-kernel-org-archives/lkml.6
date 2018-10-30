Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DAAC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAF220827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAF220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeJ3U4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:56:17 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:38428 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3U4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:56:17 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9UC2nCO071248;
        Tue, 30 Oct 2018 21:02:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Tue, 30 Oct 2018 21:02:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9UC2hk3071216
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 30 Oct 2018 21:02:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC PATCH v2 3/3] mm, oom: hand over MMF_OOM_SKIP to exit path
 if it is guranteed to finish
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20181025082403.3806-1-mhocko@kernel.org>
 <20181025082403.3806-4-mhocko@kernel.org>
 <201810300445.w9U4jMhu076672@www262.sakura.ne.jp>
 <20181030063136.GU32673@dhcp22.suse.cz>
 <95cb93ec-2421-3c5d-fd1e-91d9696b0f5a@I-love.SAKURA.ne.jp>
 <20181030113915.GB32673@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ca390ac1-2f10-b734-fff7-56767253e8c5@i-love.sakura.ne.jp>
Date:   Tue, 30 Oct 2018 21:02:40 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030113915.GB32673@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/30 20:39, Michal Hocko wrote:
> On Tue 30-10-18 18:47:43, Tetsuo Handa wrote:
>> On 2018/10/30 15:31, Michal Hocko wrote:
>>> On Tue 30-10-18 13:45:22, Tetsuo Handa wrote:
>>>> Michal Hocko wrote:
>>>>> @@ -3156,6 +3166,13 @@ void exit_mmap(struct mm_struct *mm)
>>>>>                 vma = remove_vma(vma);
>>>>>         }
>>>>>         vm_unacct_memory(nr_accounted);
>>>>> +
>>>>> +       /*
>>>>> +        * Now that the full address space is torn down, make sure the
>>>>> +        * OOM killer skips over this task
>>>>> +        */
>>>>> +       if (oom)
>>>>> +               set_bit(MMF_OOM_SKIP, &mm->flags);
>>>>>  }
>>>>>
>>>>>  /* Insert vm structure into process list sorted by address
>>>>
>>>> I don't like setting MMF_OOF_SKIP after remove_vma() loop. 50 users might
>>>> call vma->vm_ops->close() from remove_vma(). Some of them are doing fs
>>>> writeback, some of them might be doing GFP_KERNEL allocation from
>>>> vma->vm_ops->open() with a lock also held by vma->vm_ops->close().
>>>>
>>>> I don't think that waiting for completion of remove_vma() loop is safe.
>>>
>>> What do you mean by 'safe' here?
>>>
>>
>> safe = "Does not cause OOM lockup."
>>
>> remove_vma() is allowed to sleep, and some users might depend on memory
>> allocation when the OOM killer is waiting for remove_vma() to complete.
> 
> But MMF_OOF_SKIP is set after we are done with remove_vma. In fact it is
> the very last thing in exit_mmap. So I do not follow what you mean.
> 

So what? Think the worst case. Quite obvious bug here.

What happens if memory reclaimed by up to __free_pgtables() was consumed by somebody
else, and then some vma->vm_ops->close() started waiting for memory allocation due to
dependency? It is called "OOM lockup" because the OOM killer cannot be enabled because
MMF_OOM_SKIP cannot be set because vma->vm_ops->close() is waiting for the OOM killer
due to memory allocation dependency in vma->vm_ops->close() from remove_vma()...
