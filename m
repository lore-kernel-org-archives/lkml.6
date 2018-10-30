Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972F2C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D1B2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D1B2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbeJ3Sks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:40:48 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52237 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbeJ3Sks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:40:48 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9U9lokj078821;
        Tue, 30 Oct 2018 18:47:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Tue, 30 Oct 2018 18:47:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9U9lkfg078796
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 30 Oct 2018 18:47:50 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <95cb93ec-2421-3c5d-fd1e-91d9696b0f5a@I-love.SAKURA.ne.jp>
Date:   Tue, 30 Oct 2018 18:47:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181030063136.GU32673@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/30 15:31, Michal Hocko wrote:
> On Tue 30-10-18 13:45:22, Tetsuo Handa wrote:
>> Michal Hocko wrote:
>>> @@ -3156,6 +3166,13 @@ void exit_mmap(struct mm_struct *mm)
>>>                 vma = remove_vma(vma);
>>>         }
>>>         vm_unacct_memory(nr_accounted);
>>> +
>>> +       /*
>>> +        * Now that the full address space is torn down, make sure the
>>> +        * OOM killer skips over this task
>>> +        */
>>> +       if (oom)
>>> +               set_bit(MMF_OOM_SKIP, &mm->flags);
>>>  }
>>>
>>>  /* Insert vm structure into process list sorted by address
>>
>> I don't like setting MMF_OOF_SKIP after remove_vma() loop. 50 users might
>> call vma->vm_ops->close() from remove_vma(). Some of them are doing fs
>> writeback, some of them might be doing GFP_KERNEL allocation from
>> vma->vm_ops->open() with a lock also held by vma->vm_ops->close().
>>
>> I don't think that waiting for completion of remove_vma() loop is safe.
> 
> What do you mean by 'safe' here?
> 

safe = "Does not cause OOM lockup."

remove_vma() is allowed to sleep, and some users might depend on memory
allocation when the OOM killer is waiting for remove_vma() to complete.
