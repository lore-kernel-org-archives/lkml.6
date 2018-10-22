Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D256C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F5920652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 11:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F5920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeJVTeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 15:34:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:56268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726946AbeJVTep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 15:34:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5BF9AECD;
        Mon, 22 Oct 2018 11:16:36 +0000 (UTC)
Date:   Mon, 22 Oct 2018 13:16:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 1/2] mm, oom: marks all killed tasks as oom victims
Message-ID: <20181022111636.GA18839@dhcp22.suse.cz>
References: <20181022071323.9550-1-mhocko@kernel.org>
 <20181022071323.9550-2-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022071323.9550-2-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated version

From fdd46ec5dbc0cf571c5a2b9e23a021e0c46b4641 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Mon, 22 Oct 2018 08:52:33 +0200
Subject: [PATCH 1/2] mm, oom: marks all killed tasks as oom victims

Historically we have called mark_oom_victim only to the main task
selected as the oom victim because oom victims have access to memory
reserves and granting the access to all killed tasks could deplete
memory reserves very quickly and cause even larger problems.

Since only a partial access to memory reserves is allowed there is no
longer this risk and so all tasks killed along with the oom victim
can be considered as well.

The primary motivation for that is that process groups which do not
shared signals would behave more like standard thread groups wrt oom
handling (aka tsk_is_oom_victim will work the same way for them).

- Use find_lock_task_mm to stabilize mm as suggested by Tetsuo

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/oom_kill.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index f10aa5360616..6be22a0b0ff2 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -879,6 +879,7 @@ static void __oom_kill_process(struct task_struct *victim)
 	 */
 	rcu_read_lock();
 	for_each_process(p) {
+		struct task_struct *t;
 		if (!process_shares_mm(p, mm))
 			continue;
 		if (same_thread_group(p, victim))
@@ -898,6 +899,11 @@ static void __oom_kill_process(struct task_struct *victim)
 		if (unlikely(p->flags & PF_KTHREAD))
 			continue;
 		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, PIDTYPE_TGID);
+		t = find_lock_task_mm(p);
+		if (!t)
+			continue;
+		mark_oom_victim(t);
+		task_unlock(t);
 	}
 	rcu_read_unlock();
 
-- 
2.19.1

