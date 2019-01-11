Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B788C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C31F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfAKAXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:23:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:38525 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727545AbfAKAXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:23:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 16:23:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,463,1539673200"; 
   d="scan'208";a="134873707"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by fmsmga004.fm.intel.com with ESMTP; 10 Jan 2019 16:23:48 -0800
Subject: Re: [kbuild-all] [PATCH 2/2] memcg: do not report racy no-eligible
 OOM tasks
To:     Michal Hocko <mhocko@kernel.org>, kbuild test robot <lkp@intel.com>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        kbuild-all@01.org, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190107143802.16847-3-mhocko@kernel.org>
 <201901081642.Q6tXklr0%fengguang.wu@intel.com>
 <20190108093959.GQ31793@dhcp22.suse.cz>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <a0312c1e-dfed-5cff-c660-e1c1bea9843b@intel.com>
Date:   Fri, 11 Jan 2019 08:23:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20190108093959.GQ31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2019 05:39 PM, Michal Hocko wrote:
> On Tue 08-01-19 16:35:42, kbuild test robot wrote:
> [...]
>> All warnings (new ones prefixed by >>):
>>
>>     include/linux/rcupdate.h:659:9: warning: context imbalance in 'find_lock_task_mm' - wrong count at exit
>>     include/linux/sched/mm.h:141:37: warning: dereference of noderef expression
>>     mm/oom_kill.c:225:28: warning: context imbalance in 'oom_badness' - unexpected unlock
>>     mm/oom_kill.c:406:9: warning: context imbalance in 'dump_tasks' - different lock contexts for basic block
>>>> mm/oom_kill.c:918:17: warning: context imbalance in '__oom_kill_process' - unexpected unlock
> What exactly does this warning say? I do not see anything wrong about
> the code. find_lock_task_mm returns a locked task when t != NULL and
> mark_oom_victim doesn't do anything about the locking. Am I missing
> something or the warning is just confused?

Thanks for your reply. It looks like a false positive. We'll look into it.

Best Regards,
Rong Chen

>
> [...]
>> 00508538 Michal Hocko          2019-01-07  915  		t = find_lock_task_mm(p);
>> 00508538 Michal Hocko          2019-01-07  916  		if (!t)
>> 00508538 Michal Hocko          2019-01-07  917  			continue;
>> 00508538 Michal Hocko          2019-01-07 @918  		mark_oom_victim(t);
>> 00508538 Michal Hocko          2019-01-07  919  		task_unlock(t);
>> 647f2bdf David Rientjes        2012-03-21  920  	}

