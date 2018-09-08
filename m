Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27759C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCADF2075A
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCADF2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbeIHTCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:02:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57898 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeIHTCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:02:00 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w88EFkYK074322;
        Sat, 8 Sep 2018 23:15:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Sat, 08 Sep 2018 23:15:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w88EFjEO074311
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 8 Sep 2018 23:15:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] mm: memcontrol: print proper OOM header when no eligible
 victim left
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180821160406.22578-1-hannes@cmpxchg.org>
 <b94f9964-c785-20c1-34af-e9013770b89a@I-love.SAKURA.ne.jp>
 <20180908135728.GA17637@cmpxchg.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <1bdda2c0-f01f-a687-ad98-16f0473e3e32@i-love.sakura.ne.jp>
Date:   Sat, 8 Sep 2018 23:15:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180908135728.GA17637@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/08 22:57, Johannes Weiner wrote:
> On Sat, Sep 08, 2018 at 10:36:06PM +0900, Tetsuo Handa wrote:
>> Due to commit d75da004c708c9fc ("oom: improve oom disable handling") and
>> commit 3100dab2aa09dc6e ("mm: memcontrol: print proper OOM header when
>> no eligible victim left"), all
>>
>>   kworker/0:1 invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=-1, oom_score_adj=0
>>   (...snipped...)
>>   Out of memory and no killable processes...
>>   OOM request ignored. No task eligible
>>
>> lines are printed.
> 
> This doesn't explain the context, what you were trying to do here, and
> what you expected to happen. Plus, you (...snipped...) the important
> part to understand why it failed in the first place.

I expect:

  When SysRq-f did not find killable processes, it does not emit
  message other than "OOM request ignored. No task eligible".

There is no point with emitting memory information etc.

> 
>> Let's not emit "invoked oom-killer" lines when SysRq-f failed.
> 
> I disagree. If the user asked for an OOM kill, it makes perfect sense
> to dump the memory context and the outcome of the operation - even if
> the outcome is "I didn't find anything to kill". I'd argue that the
> failure case *in particular* is where I want to know about and have
> all the information that could help me understand why it failed.

How emitting memory information etc. helps you understand why it failed?
"No task eligible" is sufficient for you to understand why, isn't it?

> 
> So NAK on the inferred patch premise, but please include way more
> rationale, reproduction scenario etc. in future patches. It's not at
> all clear *why* you think it should work the way you propose here.
> 

