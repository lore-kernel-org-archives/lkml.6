Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A50ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B283A208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 10:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B283A208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbeGPLFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:05:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:23958 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbeGPLFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:05:23 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6GAcPbR005887;
        Mon, 16 Jul 2018 19:38:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Mon, 16 Jul 2018 19:38:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6GAcLIZ005857
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 16 Jul 2018 19:38:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch -mm] mm, oom: remove oom_lock from exit_mmap
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.21.1807121432370.170100@chino.kir.corp.google.com>
 <20180713142612.GD19960@dhcp22.suse.cz>
 <44d26c25-6e09-49de-5e90-3c16115eb337@i-love.sakura.ne.jp>
 <20180716061317.GA17280@dhcp22.suse.cz>
 <916d7e1d-66ea-00d9-c943-ef3d2e082584@i-love.sakura.ne.jp>
 <20180716074410.GB17280@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <f648cbc0-fa8f-5cf5-5e2b-d9ee6d721cf2@i-love.sakura.ne.jp>
Date:   Mon, 16 Jul 2018 19:38:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716074410.GB17280@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/16 16:44, Michal Hocko wrote:
>> If setting MMF_OOM_SKIP is guarded by oom_lock, we can enforce
>> last second allocation attempt like below.
>>
>>   CPU 0                                   CPU 1
>>   
>>   mutex_trylock(&oom_lock) in __alloc_pages_may_oom() succeeds.
>>   get_page_from_freelist() fails.
>>   Enters out_of_memory().
>>
>>                                           __oom_reap_task_mm() reclaims some memory.
>>                                           mutex_lock(&oom_lock);
>>
>>   select_bad_process() does not select new victim because MMF_OOM_SKIP is not yet set.
>>   Leaves out_of_memory().
>>   mutex_unlock(&oom_lock) in __alloc_pages_may_oom() is called.
>>
>>                                           Sets MMF_OOM_SKIP.
>>                                           mutex_unlock(&oom_lock);
>>
>>   get_page_from_freelist() likely succeeds before reaching __alloc_pages_may_oom() again.
>>   Saved one OOM victim from being needlessly killed.
>>
>> That is, guarding setting MMF_OOM_SKIP works as if synchronize_rcu(); it waits for anybody
>> who already acquired (or started waiting for) oom_lock to release oom_lock, in order to
>> prevent select_bad_process() from needlessly selecting new OOM victim.
> 
> Hmm, is this a practical problem though? Do we really need to have a
> broader locking context just to defeat this race?

Yes, for you think that select_bad_process() might take long time. It is possible
that MMF_OOM_SKIP is set while the owner of oom_lock is preempted. It is not such
a small window that select_bad_process() finds an mm which got MMF_OOM_SKIP
immediately before examining that mm.

>                                                   How about this goes
> into a separate patch with some data justifying it?
> 

No. We won't be able to get data until we let people test using released
kernels. I don't like again getting reports like
http://lkml.kernel.org/r/1495034780-9520-1-git-send-email-guro@fb.com
by not guarding MMF_OOM_SKIP.
