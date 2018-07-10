Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AD6C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DCE2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 10:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4pgWc5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DCE2089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754501AbeGJKUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 06:20:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37892 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbeGJKUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 06:20:05 -0400
Received: by mail-pf0-f196.google.com with SMTP id x13-v6so5847029pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x/MBL0tIfUBBDNjUvuXx8NnFcaBIN8co3DbDxNitGGc=;
        b=j4pgWc5KeEB12wrDfls/XZTYh5etoSpD17AoPwHqD9ppTvA+ZMDVARpeoItLImfH0f
         EK2Hj5PzIGmoxEFZ2was9F0ytvf7S7EOx+qVcixYXpWrLEJ41fNP39PoHAdwZzrmAv3A
         0fHm5EcV3+MFq3fCenJJDs/lE22cFjpEqDR7Nr7jXZGfCxtPXX60b2IsMHWzti2HLoXG
         MeTcsQnXUIrn+krGWkdJiPlA8pz9TJoDrMQBkhrS7g560g0krwCuMKn1jilateKmLbLq
         8eLlSfS4VC1o5AuNjajyLaeILHbi5heSmYDXgNvFEhd8/fp7qdKD8n6RrD+Od422MaJI
         BiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x/MBL0tIfUBBDNjUvuXx8NnFcaBIN8co3DbDxNitGGc=;
        b=q9dzxHhzFP7hOZ7KfVYb+aPSStS+YjUSArFtXOei4sl8Nw7+dkiT8lt5dSVx/VHw6D
         uc++Fgs9Yv7fQEJ4disRGewTPX8N3/wcMDdS4x47EiaC2ucBCg1vJmEer/sGGjFgratD
         fjfpqj2kCs4sQZD4lwfRIrk+omSDqDmEWOqv+HGUkSq5uwoTPeVmQRLUrM/Vzao5gcrs
         ubfsg7r7ZeCmO8imHmJHTlM0wzmsyYGLTVBpKfyMYfltNUphsGRslHaOv3GeCtYKYBbY
         RnaRY3gyxjUX44AK2gQQnhDBZY41S8g4+rLRby4mqcRjMWVtNM5SUoaE41vi8GJDNHrR
         wjXA==
X-Gm-Message-State: APt69E3cUeVOQ/gGxLqqW2fHruoKEsrkYwurcmNsMWaq09PgKWQJr4TG
        4ObfMPzLgUfJ98IEdktC0gQ=
X-Google-Smtp-Source: AAOMgpeQHSD0Bwz08towpSVzC8NL8eW6L6u5VFKrRgT6z7htIeSsf5R0dEvofkA4a7a5n2+ZtQ2/Qw==
X-Received: by 2002:a62:8917:: with SMTP id v23-v6mr25236473pfd.127.1531218005030;
        Tue, 10 Jul 2018 03:20:05 -0700 (PDT)
Received: from dest.didichuxing.com ([168.63.150.120])
        by smtp.gmail.com with ESMTPSA id k4-v6sm24213518pgo.49.2018.07.10.03.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 03:20:04 -0700 (PDT)
From:   ufo19890607@gmail.com
To:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhoujian@didichuxing.com
Subject: [PATCH v13 2/2] Add oom victim's memcg to the oom context information
Date:   Tue, 10 Jul 2018 18:19:48 +0800
Message-Id: <1531217988-33940-2-git-send-email-ufo19890607@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531217988-33940-1-git-send-email-ufo19890607@gmail.com>
References: <1531217988-33940-1-git-send-email-ufo19890607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

The current oom report doesn't display victim's memcg context during the
global OOM situation. While this information is not strictly needed, it
can be really helpful for containerized environments to locate which
container has lost a process. Now that we have a single line for the oom
context, we can trivially add both the oom memcg (this can be either
global_oom or a specific memcg which hits its hard limits) and task_memcg
which is the victim's memcg.

Below is the single line output in the oom report after this patch.
- global oom context information:
oom-kill:constraint=<constraint>,nodemask=<nodemask>,global_oom,task_memcg=<memcg>,task=<comm>,pid=<pid>,uid=<uid>
- memcg oom context information:
oom-kill:constraint=<constraint>,nodemask=<nodemask>,oom_memcg=<memcg>,task_memcg=<memcg>,task=<comm>,pid=<pid>,uid=<uid>
Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 include/linux/memcontrol.h | 14 +++++++++++---
 mm/memcontrol.c            | 36 ++++++++++++++++++++++--------------
 mm/oom_kill.c              |  3 ++-
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6c6fb116e925..96a73f989101 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -491,8 +491,10 @@ void mem_cgroup_handle_over_high(void);
 
 unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg);
 
-void mem_cgroup_print_oom_info(struct mem_cgroup *memcg,
-				struct task_struct *p);
+void mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
+		struct task_struct *p);
+
+void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg);
 
 static inline void mem_cgroup_oom_enable(void)
 {
@@ -903,7 +905,13 @@ static inline unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
 }
 
 static inline void
-mem_cgroup_print_oom_info(struct mem_cgroup *memcg, struct task_struct *p)
+mem_cgroup_print_oom_context(struct mem_cgroup *memcg,
+				struct task_struct *p)
+{
+}
+
+static inline void
+mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e6f0d5ef320a..18deea974cfd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1119,32 +1119,40 @@ static const char *const memcg1_stat_names[] = {
 
 #define K(x) ((x) << (PAGE_SHIFT-10))
 /**
- * mem_cgroup_print_oom_info: Print OOM information relevant to memory controller.
- * @memcg: The memory cgroup that went over limit
+ * mem_cgroup_print_oom_context: Print OOM context information relevant to
+ * memory controller.
+ * @memcg: The origin memory cgroup that went over limit
  * @p: Task that is going to be killed
  *
  * NOTE: @memcg and @p's mem_cgroup can be different when hierarchy is
  * enabled
  */
-void mem_cgroup_print_oom_info(struct mem_cgroup *memcg, struct task_struct *p)
+void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *p)
 {
-	struct mem_cgroup *iter;
-	unsigned int i;
+	struct cgroup *origin_cgrp, *kill_cgrp;
 
 	rcu_read_lock();
-
+	if (memcg) {
+		pr_cont(",oom_memcg=");
+		pr_cont_cgroup_path(memcg->css.cgroup);
+	} else
+		pr_cont(",global_oom");
 	if (p) {
-		pr_info("Task in ");
+		pr_cont(",task_memcg=");
 		pr_cont_cgroup_path(task_cgroup(p, memory_cgrp_id));
-		pr_cont(" killed as a result of limit of ");
-	} else {
-		pr_info("Memory limit reached of cgroup ");
 	}
-
-	pr_cont_cgroup_path(memcg->css.cgroup);
-	pr_cont("\n");
-
 	rcu_read_unlock();
+}
+
+/**
+ * mem_cgroup_print_oom_meminfo: Print OOM memory information relevant to
+ * memory controller.
+ * @memcg: The memory cgroup that went over limit
+ */
+void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *iter;
+	unsigned int i;
 
 	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
 		K((u64)page_counter_read(&memcg->memory)),
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 531b2c86d4db..9e80f6c2eb2e 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -433,11 +433,12 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
 	pr_info("oom-kill:constraint=%s,nodemask=%*pbl",
 			oom_constraint_text[oc->constraint],
 			nodemask_pr_args(oc->nodemask));
+	mem_cgroup_print_oom_context(oc->memcg, p);
 	cpuset_print_current_mems_allowed();
 	pr_cont(",task=%s,pid=%5d,uid=%5d\n", p->comm, p->pid,
 		from_kuid(&init_user_ns, task_uid(p)));
 	if (is_memcg_oom(oc))
-		mem_cgroup_print_oom_info(oc->memcg, p);
+		mem_cgroup_print_oom_meminfo(oc->memcg);
 	else {
 		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask);
 		if (is_dump_unreclaim_slabs())
-- 
2.14.1

