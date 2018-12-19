Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF90EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8798821850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeLSHXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:23:42 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:24051 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbeLSHXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:23:41 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBJ7Nd5x032633;
        Wed, 19 Dec 2018 16:23:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Wed, 19 Dec 2018 16:23:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBJ7NdQE032629;
        Wed, 19 Dec 2018 16:23:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id wBJ7NdkN032628;
        Wed, 19 Dec 2018 16:23:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201812190723.wBJ7NdkN032628@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH v15 2/2] Add oom victim's memcg to the oom context information
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>,
        akpm@linux-foundation.org
Cc:     mhocko@kernel.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
MIME-Version: 1.0
Date:   Wed, 19 Dec 2018 16:23:39 +0900
References: <20181122133954.GI18011@dhcp22.suse.cz> <CAHCio2gdCX3p-7=N0cA22cWTaUmUXRq8WbiMAA2sM2wLVX4GjQ@mail.gmail.com>
In-Reply-To: <CAHCio2gdCX3p-7=N0cA22cWTaUmUXRq8WbiMAA2sM2wLVX4GjQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, will you fold below diff into "mm, oom: add oom victim's memcg to the oom context information" ?

From add1e8daddbfc5186417dbc58e9e11e7614868f8 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 19 Dec 2018 16:09:31 +0900
Subject: [PATCH] mm, oom: Use pr_cont() in mem_cgroup_print_oom_context().

One line summary of the OOM killer context is not one line due to
not using KERN_CONT.

[   23.346650] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0
[   23.346691] ,global_oom,task_memcg=/,task=firewalld,pid=5096,uid=0

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b860dd4f7..4afd597 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1306,10 +1306,10 @@ void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *
 	rcu_read_lock();
 
 	if (memcg) {
-		pr_info(",oom_memcg=");
+		pr_cont(",oom_memcg=");
 		pr_cont_cgroup_path(memcg->css.cgroup);
 	} else
-		pr_info(",global_oom");
+		pr_cont(",global_oom");
 	if (p) {
 		pr_cont(",task_memcg=");
 		pr_cont_cgroup_path(task_cgroup(p, memory_cgrp_id));
-- 
1.8.3.1

