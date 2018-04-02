Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754512AbeDBVtS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 17:49:18 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:44550 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753256AbeDBVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 17:49:17 -0400
X-Google-Smtp-Source: AIpwx4/YBf/7GVTOxsOsKD12eUFPY9Xor7k93puzQCR2krmdRmqGlJ7q2MSiTJOfJgAzD/tOM4SYCg==
Date: Mon, 2 Apr 2018 14:49:13 -0700
From: Tejun Heo <tj@kernel.org>
To: lizefan@huawei.com, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, guro@fb.com,
        kernel-team@fb.com
Subject: [PATCH] cgroup: Make cgroup_rstat_updated() ready for root cgroup
 usage
Message-ID: <20180402214913.GH388343@devbig577.frc2.facebook.com>
References: <20180323231313.1254142-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323231313.1254142-1-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From b7be022bf811d02605098fa61b7545bc146b78e7 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 2 Apr 2018 14:45:20 -0700

cgroup_rstat_updated() ensures that the cgroup's rstat is linked to
the parent.  If there's no parent, it never gets linked and the
function ends up grabbing and releasing the cgroup_rstat_lock each
time for no reason which can be expensive.

This hasn't been a problem till now because nobody was calling the
function for the root cgroup but rstat is gonna be exposed to
controllers and use cases, so let's get ready.  Make
cgroup_rstat_updated() an no-op for the root cgroup.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello,

This should address the scalability issue reported by kenrel test bot.
All git branches updated accordingly.

Thanks.

 kernel/cgroup/rstat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 0d1d5fc..9a30b51 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -27,6 +27,10 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 	struct cgroup *parent;
 	unsigned long flags;
 
+	/* nothing to do for root */
+	if (!cgroup_parent(cgrp))
+		return;
+
 	/*
 	 * Paired with the one in cgroup_rstat_cpu_pop_upated().  Either we
 	 * see NULL updated_next or they see our updated stat.
-- 
2.9.5
