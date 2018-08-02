Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330A2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B93208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B93208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732286AbeHBNoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:44:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62448 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbeHBNoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:44:14 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w72BrM44096101;
        Thu, 2 Aug 2018 20:53:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Thu, 02 Aug 2018 20:53:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w72BrHsH096055
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 2 Aug 2018 20:53:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2 3/3] mm, oom: introduce memory.oom.group
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
References: <20180802003201.817-1-guro@fb.com>
 <20180802003201.817-4-guro@fb.com>
 <879f1767-8b15-4e83-d9ef-d8df0e8b4d83@i-love.sakura.ne.jp>
 <20180802112114.GG10808@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <712a319f-c9da-230a-f2cb-af980daff704@i-love.sakura.ne.jp>
Date:   Thu, 2 Aug 2018 20:53:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802112114.GG10808@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/02 20:21, Michal Hocko wrote:
> On Thu 02-08-18 19:53:13, Tetsuo Handa wrote:
>> On 2018/08/02 9:32, Roman Gushchin wrote:
> [...]
>>> +struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
>>> +					    struct mem_cgroup *oom_domain)
>>> +{
>>> +	struct mem_cgroup *oom_group = NULL;
>>> +	struct mem_cgroup *memcg;
>>> +
>>> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>>> +		return NULL;
>>> +
>>> +	if (!oom_domain)
>>> +		oom_domain = root_mem_cgroup;
>>> +
>>> +	rcu_read_lock();
>>> +
>>> +	memcg = mem_cgroup_from_task(victim);
>>
>> Isn't this racy? I guess that memcg of this "victim" can change to
>> somewhere else from the one as of determining the final candidate.
> 
> How is this any different from the existing code? We select a victim and
> then kill it. The victim might move away and won't be part of the oom
> memcg anymore but we will still kill it. I do not remember this ever
> being a problem. Migration is a privileged operation. If you loose this
> restriction you shouldn't allow to move outside of the oom domain.

The existing code kills one process (plus other processes sharing mm if any).
But oom_cgroup kills multiple processes. Thus, whether we made decision based
on correct memcg becomes important.

> 
>> This "victim" might have already passed exit_mm()/cgroup_exit() from do_exit().
> 
> Why does this matter? The victim hasn't been killed yet so if it exists
> by its own I do not think we really have to tear the whole cgroup down.

The existing code does not send SIGKILL if find_lock_task_mm() failed. Who can
guarantee that the victim is not inside do_exit() yet when this code is executed?

