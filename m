Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57628C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4228214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F4228214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeJJWe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:34:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41203 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJJWe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:34:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id x31-v6so5265786edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 08:11:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=33kccVia1YlGhF8vy6H40nEgUB+nCabXE9vEglMNrys=;
        b=F7wvXTOiXN98feOwNRI6aDBPKu38Dh+L/G5ARSRUOB+gIxke2sRoPF+rMAob6EPZuZ
         doktL28RQ1glrQee8TUprRjk8IWS5Ftg9t0NiwWH+KKdjUCLgHTDywS8sv6s+UMxgEf3
         gP8DPw9Wofmo2vPcLwidqzXEkS/N0b//++J36jjTKr6BKveW5UQ1KjWoXQXXiwEGqEl7
         3IXDcXFj/lzrc5QuTWtrMbiuPLvh59f16VsXXSFvd3CU2TUzR7XzLA0YM9aJFnhkYXE/
         tqQsAK8iN66/eaViv/MlUU19u+kekpl16DEJektBElV5PSLBO1+8MUDT3jDbYVMEjMLZ
         ZoSg==
X-Gm-Message-State: ABuFfogtwrPV51lUzScOO1LnXRVDzQuUmKSmbXST9h1dKmAlfjvzFOzY
        pyNMO+/hyWk32KkC4BNmy3U=
X-Google-Smtp-Source: ACcGV60ED4A18OhNQsOQlakjhABE6KSXD+wKRtB3gNFVkXODCjpvzKc0dJP84TARGnge/E3NX1qEfA==
X-Received: by 2002:a50:ae21:: with SMTP id c30-v6mr20969554edd.20.1539184310207;
        Wed, 10 Oct 2018 08:11:50 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-149-132.eurotel.cz. [37.188.149.132])
        by smtp.gmail.com with ESMTPSA id x53-v6sm8129625edx.63.2018.10.10.08.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 08:11:48 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     syzkaller-bugs@googlegroups.com, Michal Hocko <mhocko@suse.com>,
        guro@fb.com, hannes@cmpxchg.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        rientjes@google.com, yang.s@alibaba-inc.com
Subject: [RFC PATCH] memcg, oom: throttle dump_header for memcg ooms without eligible tasks
Date:   Wed, 10 Oct 2018 17:11:35 +0200
Message-Id: <20181010151135.25766-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <000000000000dc48d40577d4a587@google.com>
References: <000000000000dc48d40577d4a587@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

syzbot has noticed that it can trigger RCU stalls from the memcg oom
path:
RIP: 0010:dump_stack+0x358/0x3ab lib/dump_stack.c:118
Code: 74 0c 48 c7 c7 f0 f5 31 89 e8 9f 0e 0e fa 48 83 3d 07 15 7d 01 00 0f
84 63 fe ff ff e8 1c 89 c9 f9 48 8b bd 70 ff ff ff 57 9d <0f> 1f 44 00 00
e8 09 89 c9 f9 48 8b 8d 68 ff ff ff b8 ff ff 37 00
RSP: 0018:ffff88017d3a5c70 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000040000 RBX: 1ffffffff1263ebe RCX: ffffc90001e5a000
RDX: 0000000000040000 RSI: ffffffff87b4e0f4 RDI: 0000000000000246
RBP: ffff88017d3a5d18 R08: ffff8801d7e02480 R09: fffffbfff13da030
R10: fffffbfff13da030 R11: 0000000000000003 R12: 1ffff1002fa74b96
R13: 00000000ffffffff R14: 0000000000000200 R15: 0000000000000000
  dump_header+0x27b/0xf72 mm/oom_kill.c:441
  out_of_memory.cold.30+0xf/0x184 mm/oom_kill.c:1109
  mem_cgroup_out_of_memory+0x15e/0x210 mm/memcontrol.c:1386
  mem_cgroup_oom mm/memcontrol.c:1701 [inline]
  try_charge+0xb7c/0x1710 mm/memcontrol.c:2260
  mem_cgroup_try_charge+0x627/0xe20 mm/memcontrol.c:5892
  mem_cgroup_try_charge_delay+0x1d/0xa0 mm/memcontrol.c:5907
  shmem_getpage_gfp+0x186b/0x4840 mm/shmem.c:1784
  shmem_fault+0x25f/0x960 mm/shmem.c:1982
  __do_fault+0x100/0x6b0 mm/memory.c:2996
  do_read_fault mm/memory.c:3408 [inline]
  do_fault mm/memory.c:3531 [inline]

The primary reason of the stall lies in an expensive printk handling
of oom report flood because a misconfiguration on the syzbot side
caused that there is simply no eligible task because they have
OOM_SCORE_ADJ_MIN set. This generates the oom report for each allocation
from the memcg context.

While normal workloads should be much more careful about potential heavy
memory consumers that are OOM disabled it makes some sense to rate limit
a potentially expensive oom reports for cases when there is no eligible
victim found. Do that by moving the rate limit logic inside dump_header.
We no longer rely on the caller to do that. It was only oom_kill_process
which has been throttling. Other two call sites simply didn't have to
care because one just paniced on the OOM when configured that way and
no eligible task would panic for the global case as well. Memcg changed
the picture because we do not panic and we might have multiple sources
of the same event.

Once we are here, make sure that the reason to trigger the OOM is
printed without ratelimiting because this is really valuable to
debug what happened.

Reported-by: syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com
Cc: guro@fb.com
Cc: hannes@cmpxchg.org
Cc: kirill.shutemov@linux.intel.com
Cc: linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp
Cc: rientjes@google.com
Cc: yang.s@alibaba-inc.com
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa5360616..4ee393c85e27 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -430,6 +430,9 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
 
 static void dump_header(struct oom_control *oc, struct task_struct *p)
 {
+	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
+					      DEFAULT_RATELIMIT_BURST);
+
 	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), nodemask=%*pbl, order=%d, oom_score_adj=%hd\n",
 		current->comm, oc->gfp_mask, &oc->gfp_mask,
 		nodemask_pr_args(oc->nodemask), oc->order,
@@ -437,6 +440,9 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 	if (!IS_ENABLED(CONFIG_COMPACTION) && oc->order)
 		pr_warn("COMPACTION is disabled!!!\n");
 
+	if (!__ratelimit(&oom_rs))
+		return;
+
 	cpuset_print_current_mems_allowed();
 	dump_stack();
 	if (is_memcg_oom(oc))
@@ -931,8 +937,6 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	struct task_struct *t;
 	struct mem_cgroup *oom_group;
 	unsigned int victim_points = 0;
-	static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
-					      DEFAULT_RATELIMIT_BURST);
 
 	/*
 	 * If the task is already exiting, don't alarm the sysadmin or kill
@@ -949,8 +953,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
 	}
 	task_unlock(p);
 
-	if (__ratelimit(&oom_rs))
-		dump_header(oc, p);
+	dump_header(oc, p);
 
 	pr_err("%s: Kill process %d (%s) score %u or sacrifice child\n",
 		message, task_pid_nr(p), p->comm, points);
-- 
2.19.0

