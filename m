Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6D3C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4910A20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546940403;
	bh=PHIUOyU8EM08ZnzmNoelTGGz+oCrDFD66qWgPeWFyAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tQU+fvjg0d8NUNlf4z7958hCuUHZ1F57FZN7k6C9u7IacF96g8XgYRJCOj9Pxqap6
	 q9B2LYZ1w5kPLpIxULX9YuZfE7JKnAMAgxgDGwmbKcuSMpRg90HpP9WQKYgxLwfFFP
	 sIUxnZgnrNOJIxPHfu5GajkzLQFwiyJszy5JXasM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfAHJkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:40:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:54528 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727001AbfAHJkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:40:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F692ABE4;
        Tue,  8 Jan 2019 09:40:00 +0000 (UTC)
Date:   Tue, 8 Jan 2019 10:39:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-mm@kvack.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] memcg: do not report racy no-eligible OOM tasks
Message-ID: <20190108093959.GQ31793@dhcp22.suse.cz>
References: <20190107143802.16847-3-mhocko@kernel.org>
 <201901081642.Q6tXklr0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201901081642.Q6tXklr0%fengguang.wu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-01-19 16:35:42, kbuild test robot wrote:
[...]
> All warnings (new ones prefixed by >>):
> 
>    include/linux/rcupdate.h:659:9: warning: context imbalance in 'find_lock_task_mm' - wrong count at exit
>    include/linux/sched/mm.h:141:37: warning: dereference of noderef expression
>    mm/oom_kill.c:225:28: warning: context imbalance in 'oom_badness' - unexpected unlock
>    mm/oom_kill.c:406:9: warning: context imbalance in 'dump_tasks' - different lock contexts for basic block
> >> mm/oom_kill.c:918:17: warning: context imbalance in '__oom_kill_process' - unexpected unlock

What exactly does this warning say? I do not see anything wrong about
the code. find_lock_task_mm returns a locked task when t != NULL and
mark_oom_victim doesn't do anything about the locking. Am I missing
something or the warning is just confused?

[...]
> 00508538 Michal Hocko          2019-01-07  915  		t = find_lock_task_mm(p);
> 00508538 Michal Hocko          2019-01-07  916  		if (!t)
> 00508538 Michal Hocko          2019-01-07  917  			continue;
> 00508538 Michal Hocko          2019-01-07 @918  		mark_oom_victim(t);
> 00508538 Michal Hocko          2019-01-07  919  		task_unlock(t);
> 647f2bdf David Rientjes        2012-03-21  920  	}

-- 
Michal Hocko
SUSE Labs
