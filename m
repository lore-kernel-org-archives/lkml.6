Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9754EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BAF219E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 19:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BAF219E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733079AbeHFV4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 17:56:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:60112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732945AbeHFV4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 17:56:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B4DEAE0B;
        Mon,  6 Aug 2018 19:45:55 +0000 (UTC)
Date:   Mon, 6 Aug 2018 21:45:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>
Cc:     cgroups@vger.kernel.org, dvyukov@google.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penguin-kernel@I-love.SAKURA.ne.jp,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
Subject: Re: WARNING in try_charge
Message-ID: <20180806194553.GH10003@dhcp22.suse.cz>
References: <20180806185554.GG10003@dhcp22.suse.cz>
 <0000000000006986c30572c90de3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006986c30572c90de3@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing Greg - the email thread starts here
http://lkml.kernel.org/r/0000000000005e979605729c1564@google.com]

On Mon 06-08-18 12:12:02, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:

OK, this is reassuring. Btw Greg has pointed out this potential case
http://lkml.kernel.org/r/xr93in62jy8k.fsf@gthelen.svl.corp.google.com
but I simply didn't get what he meant. He was suggesting MMF_OOM_SKIP
but I didn't get why that matters. I didn't think about a race.

So how about this patch:
From 74d980f8d066d06ada657ebf9b586dbf5668ed26 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Mon, 6 Aug 2018 21:21:24 +0200
Subject: [PATCH] memcg, oom: be careful about races when warning about no
 reclaimable task

"memcg, oom: move out_of_memory back to the charge path" has added a
warning triggered when the oom killer cannot find any eligible task
and so there is no way to reclaim the oom memcg under its hard limit.
Further charges for such a memcg are forced and therefore the hard limit
isolation is weakened.

The current warning is however too eager to trigger  even when we are not
really hitting the above condition. Syzbot and Greg Thelen have noticed
that we can hit this condition even when there is still oom victim
pending. E.g. the following race is possible:

memcg has two tasks taskA, taskB.

CPU1 (taskA)			CPU2			CPU3 (taskB)
try_charge
  mem_cgroup_out_of_memory				try_charge
      select_bad_process(taskB)
      oom_kill_process		oom_reap_task
				# No real memory reaped
    				  			  mem_cgroup_out_of_memory
				# set taskB -> MMF_OOM_SKIP
  # retry charge
  mem_cgroup_out_of_memory
    oom_lock						    oom_lock
    select_bad_process(self)
    oom_kill_process(self)
    oom_unlock
							    # no eligible task

In fact syzbot test triggered this situation by placing multiple tasks
into a memcg with hard limit set to 0. So no task really had any memory
charged to the memcg

: Memory cgroup stats for /ile0: cache:0KB rss:0KB rss_huge:0KB shmem:0KB mapped_file:0KB dirty:0KB writeback:0KB swap:0KB inactive_anon:0KB active_anon:0KB inactive_file:0KB active_file:0KB unevictable:0KB
: Tasks state (memory values in pages):
: [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
: [   6569]     0  6562     9427        1    53248        0             0 syz-executor0
: [   6576]     0  6576     9426        0    61440        0             0 syz-executor6
: [   6578]     0  6578     9426      534    61440        0             0 syz-executor4
: [   6579]     0  6579     9426        0    57344        0             0 syz-executor5
: [   6582]     0  6582     9426        0    61440        0             0 syz-executor7
: [   6584]     0  6584     9426        0    57344        0             0 syz-executor1

so in principle there is indeed nothing reclaimable in this memcg and
this looks like a misconfiguration. On the other hand we can clearly
kill all those tasks so it is a bit early to warn and scare users. Do
that by checking that the current is the oom victim and bypass the
warning then. The victim is allowed to force charge and terminate to
release its temporal charge along the way.

Fixes: "memcg, oom: move out_of_memory back to the charge path"
Noticed-by: Greg Thelen <gthelen@google.com>
Reported-and-tested-by: syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4603ad75c9a9..1b6eed1bc404 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1703,7 +1703,8 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 		return OOM_ASYNC;
 	}
 
-	if (mem_cgroup_out_of_memory(memcg, mask, order))
+	if (mem_cgroup_out_of_memory(memcg, mask, order) ||
+			tsk_is_oom_victim(current))
 		return OOM_SUCCESS;
 
 	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
-- 
2.18.0

-- 
Michal Hocko
SUSE Labs
