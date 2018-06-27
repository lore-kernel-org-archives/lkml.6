Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C78C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF92426347
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 10:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF92426347
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753663AbeF0Kwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 06:52:38 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:19938 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbeF0Kwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 06:52:37 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5RAqO8w008963;
        Wed, 27 Jun 2018 19:52:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Wed, 27 Jun 2018 19:52:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5RAqNCD008959
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 27 Jun 2018 19:52:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
To:     paulmck@linux.vnet.ibm.com
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1806201528490.16984@chino.kir.corp.google.com>
 <20180621073142.GA10465@dhcp22.suse.cz>
 <2d8c3056-1bc2-9a32-d745-ab328fd587a1@i-love.sakura.ne.jp>
 <20180626170345.GA3593@linux.vnet.ibm.com>
 <f40d85e0-1d90-2261-99a4-4db315df4860@i-love.sakura.ne.jp>
 <20180626235014.GS3593@linux.vnet.ibm.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c0aeb719-ccb7-46c7-2ad9-b0630bf4d542@i-love.sakura.ne.jp>
Date:   Wed, 27 Jun 2018 19:52:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180626235014.GS3593@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/27 8:50, Paul E. McKenney wrote:
> On Wed, Jun 27, 2018 at 05:10:48AM +0900, Tetsuo Handa wrote:
>> As far as I can see,
>>
>> -	atomic_set(&oom_callback_count, 1);
>> +	atomic_inc(&oom_callback_count);
>>
>> should be sufficient.
> 
> I don't see how that helps.  For example, suppose that two tasks
> invoked rcu_oom_notify() at about the same time.  Then they could
> both see oom_callback_count equal to zero, both atomically increment
> oom_callback_count, then both do the IPI invoking rcu_oom_notify_cpu()
> on each online CPU.
> 
> So far, so good.  But rcu_oom_notify_cpu() enqueues a per-CPU RCU
> callback, and enqueuing the same callback twice in quick succession
> would fatally tangle RCU's callback lists.
> 
> What am I missing here?
> 
> 							Thanx, Paul

You are pointing out that "number of rsp->call() is called" > "number of
rcu_oom_callback() is called" can happen if concurrently called, aren't you?
Then, you are not missing anything. You will need to use something equivalent
to oom_lock even if you can convert rcu_oom_notify() to use shrinkers.
