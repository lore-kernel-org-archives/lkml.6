Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06BFC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8588A27FC5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8588A27FC5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965751AbeF2OgJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:36:09 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:45312 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965293AbeF2OgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:36:08 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w5TEZrZw091398;
        Fri, 29 Jun 2018 23:35:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Fri, 29 Jun 2018 23:35:53 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126074194044.bbtec.net [126.74.194.44])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w5TEZmKr091355
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 29 Jun 2018 23:35:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
To:     paulmck@linux.vnet.ibm.com, Michal Hocko <mhocko@kernel.org>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1806201528490.16984@chino.kir.corp.google.com>
 <20180621073142.GA10465@dhcp22.suse.cz>
 <2d8c3056-1bc2-9a32-d745-ab328fd587a1@i-love.sakura.ne.jp>
 <20180626170345.GA3593@linux.vnet.ibm.com>
 <20180627072207.GB32348@dhcp22.suse.cz>
 <20180627143125.GW3593@linux.vnet.ibm.com>
 <20180628113942.GD32348@dhcp22.suse.cz>
 <20180628213105.GP3593@linux.vnet.ibm.com>
 <20180629090419.GD13860@dhcp22.suse.cz>
 <20180629125218.GX3593@linux.vnet.ibm.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <bf76c93d-37d6-5f1e-4e5a-122089997fd9@i-love.sakura.ne.jp>
Date:   Fri, 29 Jun 2018 23:35:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629125218.GX3593@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/06/29 21:52, Paul E. McKenney wrote:
> The effect of RCU's current OOM code is to speed up callback invocation
> by at most a few seconds (assuming no stalled CPUs, in which case
> it is not possible to speed up callback invocation).
> 
> Given that, I should just remove RCU's OOM code entirely?

out_of_memory() will start selecting an OOM victim without calling
get_page_from_freelist() since rcu_oom_notify() does not set non-zero
value to "freed" field.

I think that rcu_oom_notify() needs to wait for completion of callback
invocations (possibly with timeout in case there are stalling CPUs) and
set non-zero value to "freed" field if pending callbacks did release memory.

However, what will be difficult to tell is whether invocation of pending callbacks
did release memory. Lack of last second get_page_from_freelist() call after
blocking_notifier_call_chain(&oom_notify_list, 0, &freed) forces rcu_oom_notify()
to set appropriate value (i.e. zero or non-zero) to "freed" field.

We have tried to move really last second get_page_from_freelist() call to inside
out_of_memory() after blocking_notifier_call_chain(&oom_notify_list, 0, &freed).
But that proposal was not accepted...

We could move blocking_notifier_call_chain(&oom_notify_list, 0, &freed) to
before last second get_page_from_freelist() call (and this is what this patch
is trying to do) which would allow rcu_oom_notify() to always return 0...
or update rcu_oom_notify() to use shrinker API...
