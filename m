Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D47C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD32821708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD32821708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeHHJbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 05:31:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44112 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbeHHJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 05:31:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so638979pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 00:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=li9oVNH3dWPrRH5WhREscgBvq/72ffd5HpSEGay4wBk=;
        b=UmU4qQYlh5fa6Ay+V48NKJb1hjzFCDRtd1hzaQTeQJpU+gMqqg2Q1+Vr8TV7hBTwAB
         uHgWo0agTyHF6VCNKX6MARuJnOFWjkv/z3NgwBsof6I324WHuGhnYUIGxW7pdtbqNiJh
         A/51IoiipUZ+VVqxVgedoYOnGmY105c5auRKmDXzfMbETRNrbJiTmOcuiXRVVG2a5+/D
         JTeLcO01+hGtSiJ0sO6qND69LPodJy10jEkEDpj8xRHeoDZ78d88K3BhpFNpCFRPxmGs
         3E1ZwCG6VLyFOk3DxpPdGblFevYJzFq6f1RkdcNGKuapGFewPvQ3XEr5dKUGVgnpBdWF
         SnqQ==
X-Gm-Message-State: AOUpUlEOaZKA1yb5U1lYHTMbRSWeLC868N4Vt5eo2dpIqgS+Nw/WBhop
        Wf5Jk45KyW6ZRK5ZGacyQL8=
X-Google-Smtp-Source: AA+uWPxRRfgRYoJNNCEUq+BG3YcMdb7eCph5IGgsMKW6YrYYTnsnvPwh7OxCrbrMTuaUcYsdVRO/fg==
X-Received: by 2002:a63:fe02:: with SMTP id p2-v6mr1392087pgh.148.1533712394066;
        Wed, 08 Aug 2018 00:13:14 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n9-v6sm5517945pfg.21.2018.08.08.00.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 00:13:13 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 1/2] memcg, oom: be careful about races when warning about no reclaimable task
Date:   Wed,  8 Aug 2018 09:13:00 +0200
Message-Id: <20180808071301.12478-2-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808071301.12478-1-mhocko@kernel.org>
References: <20180808064414.GA27972@dhcp22.suse.cz>
 <20180808071301.12478-1-mhocko@kernel.org>
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
 mm/memcontrol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4603ad75c9a9..c80e5b6a8e9f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1705,6 +1705,15 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 
 	if (mem_cgroup_out_of_memory(memcg, mask, order))
 		return OOM_SUCCESS;
+	
+	/*
+	 * under rare race the current task might have been selected while
+	 * reaching mem_cgroup_out_of_memory and there is no other oom victim
+	 * left. There is still no reason to warn because this task will
+	 * die and release its bypassed charge eventually.
+	 */
+	if (tsk_is_oom_victim(current))
+		return OOM_SUCCESS;
 
 	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
 		"This looks like a misconfiguration or a kernel bug.");
-- 
2.18.0

