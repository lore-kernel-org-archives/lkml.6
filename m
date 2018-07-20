Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642E0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4BD20673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:47:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4BD20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeGTVhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:37:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:36594 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbeGTVhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:37:38 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w6KKlSdp016274;
        Sat, 21 Jul 2018 05:47:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Sat, 21 Jul 2018 05:47:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w6KKlSjH016271
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 21 Jul 2018 05:47:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch v3] mm, oom: fix unnecessary killing of additional
 processes
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <alpine.DEB.2.21.1806211434420.51095@chino.kir.corp.google.com>
 <d19d44c3-c8cf-70a1-9b15-c98df233d5f0@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807181317540.49359@chino.kir.corp.google.com>
 <a78fb992-ad59-0cdb-3c38-8284b2245f21@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807200133310.119737@chino.kir.corp.google.com>
 <9ab77cc7-2167-0659-a2ad-9cec3b9440e9@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.1807201315580.231119@chino.kir.corp.google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <569cf225-f1d3-f81b-5947-cff7bd21381f@i-love.sakura.ne.jp>
Date:   Sat, 21 Jul 2018 05:47:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1807201315580.231119@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/07/21 5:19, David Rientjes wrote:
> On Fri, 20 Jul 2018, Tetsuo Handa wrote:
> 
>>> Absent oom_lock serialization, this is exactly working as intended.  You 
>>> could argue that once the thread has reached exit_mmap() and begins oom 
>>> reaping that it should be allowed to finish before the oom reaper declares 
>>> MMF_OOM_SKIP.  That could certainly be helpful, I simply haven't 
>>> encountered a usecase where it were needed.  Or, we could restart the oom 
>>> expiration when MMF_UNSTABLE is set and deem that progress is being made 
>>> so it give it some extra time.  In practice, again, we haven't seen this 
>>> needed.  But either of those are very easy to add in as well.  Which would 
>>> you prefer?
>>
>> I don't think we need to introduce user-visible knob interface (even if it is in
>> debugfs), for I think that my approach can solve your problem. Please try OOM lockup
>> (CVE-2016-10723) mitigation patch ( https://marc.info/?l=linux-mm&m=153112243424285&w=4 )
> 
> The issue I am fixing has nothing to do with contention on oom_lock, it 
> has to do with the inability of the oom reaper to free memory for one or 
> more of several reasons: mlock, blockable mmus, ptes, mm->mmap_sem 
> contention, and then the setting of MMF_OOM_SKIP to choose another victim 
> before the original victim even reaches exit_mmap().  Thus, removing 
> oom_lock from exit_mmap() will not fix this issue.
> 
> I agree that oom_lock can be removed from exit_mmap() and it would be 
> helpful to do so, and may address a series of problems that we have yet to 
> encounter, but this would not fix the almost immediate setting of 
> MMF_OOM_SKIP that occurs with minimal memory freeing due to the oom 
> reaper.
> 

Why [PATCH 2/2] in https://marc.info/?l=linux-mm&m=153119509215026&w=4 does not
solve your problem?

