Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114F3C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2CB219DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2CB219DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbeHGJjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:39:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34042 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388730AbeHGJjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:39:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id h1-v6so6419422eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 00:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tO17PQk9X6YjtkR0bcBaYTwsQHR3FHpFiZXYXH0V89E=;
        b=KzhwFK2o/mMrue0l6VBHV/wRtizbfBzLLMRKgXNgRh+rThBhA4OSu7sIjNyYYTHHbT
         2JiuWyvx0yAAU36ppGmUcJ1ymAACYYaRUHbxdefIQt92jqmv8wsLgwEOTqcj9K1unCd3
         uHF2vb9Ub5TuSsu4R5TtH3deJmdNs+CK07zFhcK8Bn94Znf3GKi89q62aawIARWLlOjf
         tsA81V5JKN+c6+5uxDbX1vggvxeCu/ccrTejXriMeNT1glSF4VpvqucVgEdIrfC9bBaS
         PJsMwbu2gSQq4q3uIJGiC6kJtvwLN2BUpP98pjfl3YeVLOLzTC5BqtJFCwSFV79Xm1ms
         LdEw==
X-Gm-Message-State: AOUpUlHD9cOWpqimztawxfhai05ZnexH9HOn6ogoJ0V9A8At+FRjGemx
        bUQ82rhEpq5kdVY9hVtXu6E=
X-Google-Smtp-Source: AAOMgpfx/tukHLhaVXmKs3g+zpYfn+QQFB6JWDvSh/Znty4Y0S19A6blIZB+XNdA9bfYycbo32aUdA==
X-Received: by 2002:a50:8cd1:: with SMTP id r17-v6mr21534411edr.113.1533626759309;
        Tue, 07 Aug 2018 00:25:59 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id 40-v6sm591791edz.30.2018.08.07.00.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 00:25:58 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, Greg Thelen <gthelen@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] memcg, oom: be careful about races when warning about no reclaimable task
Date:   Tue,  7 Aug 2018 09:25:53 +0200
Message-Id: <20180807072553.14941-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

"memcg, oom: move out_of_memory back to the charge path" has added a
warning triggered when the oom killer cannot find any eligible task
and so there is no way to reclaim the oom memcg under its hard limit.
Further charges for such a memcg are forced and therefore the hard limit
isolation is weakened.

The current warning is however too eager to trigger  even when we are not
really hitting the above condition. Syzbot[1] and Greg Thelen have noticed
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

[1] http://lkml.kernel.org/r/0000000000005e979605729c1564@google.com
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

