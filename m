Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AC7C46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE4D2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE4D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbeKUEWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:22:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58796 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729563AbeKUEWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:22:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B1BD58E47;
        Tue, 20 Nov 2018 17:52:11 +0000 (UTC)
Received: from llong.com (ovpn-120-174.rdu2.redhat.com [10.10.120.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DD7B648A8;
        Tue, 20 Nov 2018 17:52:09 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 1/5] cgroup: subtree_control bypass mode for bypassable controllers
Date:   Tue, 20 Nov 2018 12:51:25 -0500
Message-Id: <1542736289-31338-2-git-send-email-longman@redhat.com>
In-Reply-To: <1542736289-31338-1-git-send-email-longman@redhat.com>
References: <1542736289-31338-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 20 Nov 2018 17:52:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A controller in the default hierarchy is bypassable if the bypassable
flag is set in its cgroup_subsys structure.  The special prefix '#'
attached to a bypassable controller name can now be written into the
cgroup.subtree_control file to set that controller in bypass mode in
all the child cgroups. The controller will show up in the children's
cgroup.controllers file, but the corresponding control knobs will be
absent. However, that controller can be enabled or bypassed in its
children by writing to their respective subtree_control files.

In term of resource control, a bypassed cgroup was lumped into its
nearest non-bypassed ancestor. So all the tasks in that ancestor as
well as those in its bypassed direct descendants are controlled by the
same set of control knobs.

This mode is useful to those bypassable controllers where there are
costs to each additional layer of hierarchy. This mode will also allow
more freedom in how each controller can shape its effective hierarchy
independent of the others.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h |  19 ++++--
 kernel/cgroup/cgroup.c      | 149 +++++++++++++++++++++++++++++---------------
 2 files changed, 113 insertions(+), 55 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8fcbae1..5bff798 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -375,16 +375,18 @@ struct cgroup {
 	struct cgroup_file events_file;	/* handle for "cgroup.events" */
 
 	/*
-	 * The bitmask of subsystems enabled on the child cgroups.
-	 * ->subtree_control is the one configured through
-	 * "cgroup.subtree_control" while ->child_ss_mask is the effective
-	 * one which may have more subsystems enabled.  Controller knobs
-	 * are made available iff it's enabled in ->subtree_control.
+	 * The bitmask of subsystems enabled or bypassed on the child cgroups.
+	 * ->subtree_control and ->subtree_bypass are the one configured
+	 * through "cgroup.subtree_control" while ->subtree_ss_mask is the
+	 * effective one which may have more subsystems enabled.  Controller
+	 * knobs are made available iff it's enabled in ->subtree_ss_mask.
 	 */
 	u16 subtree_control;
 	u16 subtree_ss_mask;
+	u16 subtree_bypass;
 	u16 old_subtree_control;
 	u16 old_subtree_ss_mask;
+	u16 old_subtree_bypass;
 
 	/* Private pointers for each registered subsystem */
 	struct cgroup_subsys_state __rcu *subsys[CGROUP_SUBSYS_COUNT];
@@ -647,6 +649,13 @@ struct cgroup_subsys {
 	bool broken_hierarchy:1;
 	bool warned_broken_hierarchy:1;
 
+	/*
+	 * If %true, the controller, on the default hierarchy, can be
+	 * bypassable. IOW, it can have a virtual hierarchy that is
+	 * different from the default hierarchy.
+	 */
+	bool bypassable:1;
+
 	/* the following two fields are initialized automtically during boot */
 	int id;
 	const char *name;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e06994f..a361c10 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -175,6 +175,9 @@ struct cgroup_subsys *cgroup_subsys[] = {
 /* some controllers can be threaded on the default hierarchy */
 static u16 cgrp_dfl_threaded_ss_mask;
 
+/* some controllers can be bypassable on the default hierarchy */
+static u16 cgrp_dfl_bypass_ss_mask;
+
 /* The list of hierarchy roots */
 LIST_HEAD(cgroup_roots);
 static int cgroup_root_count;
@@ -366,7 +369,8 @@ static bool cgroup_can_be_thread_root(struct cgroup *cgrp)
 		return false;
 
 	/* and no domain controllers can be enabled */
-	if (cgrp->subtree_control & ~cgrp_dfl_threaded_ss_mask)
+	if ((cgrp->subtree_control|cgrp->subtree_bypass) &
+	    ~cgrp_dfl_threaded_ss_mask)
 		return false;
 
 	return true;
@@ -388,7 +392,8 @@ bool cgroup_is_thread_root(struct cgroup *cgrp)
 	 * enabled is a thread root.
 	 */
 	if (cgroup_has_tasks(cgrp) &&
-	    (cgrp->subtree_control & cgrp_dfl_threaded_ss_mask))
+	   ((cgrp->subtree_control|cgrp->subtree_bypass)
+	   & cgrp_dfl_threaded_ss_mask))
 		return true;
 
 	return false;
@@ -413,7 +418,7 @@ static bool cgroup_is_valid_domain(struct cgroup *cgrp)
 }
 
 /* subsystems visibly enabled on a cgroup */
-static u16 cgroup_control(struct cgroup *cgrp)
+static u16 cgroup_control(struct cgroup *cgrp, bool show_bypass)
 {
 	struct cgroup *parent = cgroup_parent(cgrp);
 	u16 root_ss_mask = cgrp->root->subsys_mask;
@@ -421,6 +426,9 @@ static u16 cgroup_control(struct cgroup *cgrp)
 	if (parent) {
 		u16 ss_mask = parent->subtree_control;
 
+		if (show_bypass)
+			ss_mask |= parent->subtree_bypass;
+
 		/* threaded cgroups can only have threaded controllers */
 		if (cgroup_is_threaded(cgrp))
 			ss_mask &= cgrp_dfl_threaded_ss_mask;
@@ -434,13 +442,17 @@ static u16 cgroup_control(struct cgroup *cgrp)
 }
 
 /* subsystems enabled on a cgroup */
-static u16 cgroup_ss_mask(struct cgroup *cgrp)
+static u16 cgroup_ss_mask(struct cgroup *cgrp, bool show_bypass)
 {
 	struct cgroup *parent = cgroup_parent(cgrp);
 
 	if (parent) {
 		u16 ss_mask = parent->subtree_ss_mask;
 
+
+		if (show_bypass)
+			ss_mask |= parent->subtree_bypass;
+
 		/* threaded cgroups can only have threaded controllers */
 		if (cgroup_is_threaded(cgrp))
 			ss_mask &= cgrp_dfl_threaded_ss_mask;
@@ -515,7 +527,7 @@ static struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
 	 * This function is used while updating css associations and thus
 	 * can't test the csses directly.  Test ss_mask.
 	 */
-	while (!(cgroup_ss_mask(cgrp) & (1 << ss->id))) {
+	while (!(cgroup_ss_mask(cgrp, false) & (1 << ss->id))) {
 		cgrp = cgroup_parent(cgrp);
 		if (!cgrp)
 			return NULL;
@@ -2414,7 +2426,7 @@ int cgroup_migrate_vet_dst(struct cgroup *dst_cgrp)
 		return 0;
 
 	/* apply no-internal-process constraint */
-	if (dst_cgrp->subtree_control)
+	if (dst_cgrp->subtree_control|dst_cgrp->subtree_bypass)
 		return -EBUSY;
 
 	return 0;
@@ -2712,15 +2724,18 @@ void cgroup_procs_write_finish(struct task_struct *task)
 			ss->post_attach();
 }
 
-static void cgroup_print_ss_mask(struct seq_file *seq, u16 ss_mask)
+static void cgroup_print_ss_mask(struct seq_file *seq, u16 ss_mask,
+				 u16 bypass_mask)
 {
 	struct cgroup_subsys *ss;
 	bool printed = false;
 	int ssid;
 
-	do_each_subsys_mask(ss, ssid, ss_mask) {
+	do_each_subsys_mask(ss, ssid, ss_mask|bypass_mask) {
 		if (printed)
 			seq_putc(seq, ' ');
+		if (!(ss_mask & (1 << ssid)))
+			seq_putc(seq, '#');
 		seq_printf(seq, "%s", ss->name);
 		printed = true;
 	} while_each_subsys_mask();
@@ -2732,8 +2747,10 @@ static void cgroup_print_ss_mask(struct seq_file *seq, u16 ss_mask)
 static int cgroup_controllers_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	struct cgroup *parent = cgroup_parent(cgrp);
+	u16 bypass = parent ? parent->subtree_bypass : 0;
 
-	cgroup_print_ss_mask(seq, cgroup_control(cgrp));
+	cgroup_print_ss_mask(seq, cgroup_control(cgrp, false), bypass);
 	return 0;
 }
 
@@ -2742,7 +2759,7 @@ static int cgroup_subtree_control_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
 
-	cgroup_print_ss_mask(seq, cgrp->subtree_control);
+	cgroup_print_ss_mask(seq, cgrp->subtree_control, cgrp->subtree_bypass);
 	return 0;
 }
 
@@ -2856,6 +2873,7 @@ static void cgroup_save_control(struct cgroup *cgrp)
 	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
 		dsct->old_subtree_control = dsct->subtree_control;
 		dsct->old_subtree_ss_mask = dsct->subtree_ss_mask;
+		dsct->old_subtree_bypass  = dsct->subtree_bypass;
 		dsct->old_dom_cgrp = dsct->dom_cgrp;
 	}
 }
@@ -2874,10 +2892,13 @@ static void cgroup_propagate_control(struct cgroup *cgrp)
 	struct cgroup_subsys_state *d_css;
 
 	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
-		dsct->subtree_control &= cgroup_control(dsct);
+		u16 mask = cgroup_control(dsct, true);
+
+		dsct->subtree_control &= mask;
+		dsct->subtree_bypass  &= mask;
 		dsct->subtree_ss_mask =
 			cgroup_calc_subtree_ss_mask(dsct->subtree_control,
-						    cgroup_ss_mask(dsct));
+						cgroup_ss_mask(dsct, true));
 	}
 }
 
@@ -2897,6 +2918,7 @@ static void cgroup_restore_control(struct cgroup *cgrp)
 	cgroup_for_each_live_descendant_post(dsct, d_css, cgrp) {
 		dsct->subtree_control = dsct->old_subtree_control;
 		dsct->subtree_ss_mask = dsct->old_subtree_ss_mask;
+		dsct->subtree_bypass  = dsct->old_subtree_bypass;
 		dsct->dom_cgrp = dsct->old_dom_cgrp;
 	}
 }
@@ -2906,9 +2928,9 @@ static bool css_visible(struct cgroup_subsys_state *css)
 	struct cgroup_subsys *ss = css->ss;
 	struct cgroup *cgrp = css->cgroup;
 
-	if (cgroup_control(cgrp) & (1 << ss->id))
+	if (cgroup_control(cgrp, false) & (1 << ss->id))
 		return true;
-	if (!(cgroup_ss_mask(cgrp) & (1 << ss->id)))
+	if (!(cgroup_ss_mask(cgrp, false) & (1 << ss->id)))
 		return false;
 	return cgroup_on_dfl(cgrp) && ss->implicit_on_dfl;
 }
@@ -2939,7 +2961,7 @@ static int cgroup_apply_control_enable(struct cgroup *cgrp)
 
 			WARN_ON_ONCE(css && percpu_ref_is_dying(&css->refcnt));
 
-			if (!(cgroup_ss_mask(dsct) & (1 << ss->id)))
+			if (!(cgroup_ss_mask(dsct, false) & (1 << ss->id)))
 				continue;
 
 			if (!css) {
@@ -2989,7 +3011,7 @@ static void cgroup_apply_control_disable(struct cgroup *cgrp)
 				continue;
 
 			if (css->parent &&
-			    !(cgroup_ss_mask(dsct) & (1 << ss->id))) {
+			    !(cgroup_ss_mask(dsct, false) & (1 << ss->id))) {
 				kill_css(css);
 			} else if (!css_visible(css)) {
 				css_clear_dir(css);
@@ -3101,7 +3123,8 @@ static ssize_t cgroup_subtree_control_write(struct kernfs_open_file *of,
 					    char *buf, size_t nbytes,
 					    loff_t off)
 {
-	u16 enable = 0, disable = 0;
+	u16 enable = 0, disable = 0, bypass = 0;
+	u16 child_enable = 0;
 	struct cgroup *cgrp, *child;
 	struct cgroup_subsys *ss;
 	char *tok;
@@ -3122,10 +3145,16 @@ static ssize_t cgroup_subtree_control_write(struct kernfs_open_file *of,
 
 			if (*tok == '+') {
 				enable |= 1 << ssid;
+				bypass &= ~(1 << ssid);
 				disable &= ~(1 << ssid);
 			} else if (*tok == '-') {
 				disable |= 1 << ssid;
 				enable &= ~(1 << ssid);
+				bypass &= ~(1 << ssid);
+			} else if (*tok == '#') {
+				bypass |= 1 << ssid;
+				enable &= ~(1 << ssid);
+				disable &= ~(1 << ssid);
 			} else {
 				return -EINVAL;
 			}
@@ -3139,35 +3168,42 @@ static ssize_t cgroup_subtree_control_write(struct kernfs_open_file *of,
 	if (!cgrp)
 		return -ENODEV;
 
-	for_each_subsys(ss, ssid) {
-		if (enable & (1 << ssid)) {
-			if (cgrp->subtree_control & (1 << ssid)) {
-				enable &= ~(1 << ssid);
-				continue;
-			}
+	/*
+	 * Cannot use controllers that aren't allowed.
+	 */
+	if (~cgroup_control(cgrp, true) & (enable|disable|bypass)) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
 
-			if (!(cgroup_control(cgrp) & (1 << ssid))) {
-				ret = -ENOENT;
-				goto out_unlock;
-			}
-		} else if (disable & (1 << ssid)) {
-			if (!(cgrp->subtree_control & (1 << ssid))) {
-				disable &= ~(1 << ssid);
-				continue;
-			}
+	/*
+	 * Strip out redundant bits.
+	 */
+	enable  &= ~cgrp->subtree_control;
+	bypass  &= ~cgrp->subtree_bypass;
+	disable &= (cgrp->subtree_control|cgrp->subtree_bypass);
 
-			/* a child has it enabled? */
-			cgroup_for_each_live_child(child, cgrp) {
-				if (child->subtree_control & (1 << ssid)) {
-					ret = -EBUSY;
-					goto out_unlock;
-				}
-			}
-		}
+	if (!(enable|bypass|disable)) {
+		ret = 0;
+		goto out_unlock;
 	}
 
-	if (!enable && !disable) {
-		ret = 0;
+	/*
+	 * Only bypassable controllers can be bypassed.
+	 */
+	if (bypass & ~cgrp_dfl_bypass_ss_mask) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	cgroup_for_each_live_child(child, cgrp)
+		child_enable |= child->subtree_control|child->subtree_bypass;
+
+	/*
+	 * Cannot change the state of a controller if enabled in children.
+	 */
+	if ((enable|bypass|disable) & child_enable) {
+		ret = -EBUSY;
 		goto out_unlock;
 	}
 
@@ -3179,7 +3215,9 @@ static ssize_t cgroup_subtree_control_write(struct kernfs_open_file *of,
 	cgroup_save_control(cgrp);
 
 	cgrp->subtree_control |= enable;
-	cgrp->subtree_control &= ~disable;
+	cgrp->subtree_control &= ~(bypass|disable);
+	cgrp->subtree_bypass  |= bypass;
+	cgrp->subtree_bypass  &= ~(enable|disable);
 
 	ret = cgroup_apply_control(cgrp);
 	cgroup_finalize_control(cgrp, ret);
@@ -4727,7 +4765,8 @@ static void css_release(struct percpu_ref *ref)
 }
 
 static void init_and_link_css(struct cgroup_subsys_state *css,
-			      struct cgroup_subsys *ss, struct cgroup *cgrp)
+			      struct cgroup_subsys *ss, struct cgroup *cgrp,
+			      struct cgroup_subsys_state *parent_css)
 {
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -4743,8 +4782,8 @@ static void init_and_link_css(struct cgroup_subsys_state *css,
 	css->serial_nr = css_serial_nr_next++;
 	atomic_set(&css->online_cnt, 0);
 
-	if (cgroup_parent(cgrp)) {
-		css->parent = cgroup_css(cgroup_parent(cgrp), ss);
+	if (parent_css) {
+		css->parent = parent_css;
 		css_get(css->parent);
 	}
 
@@ -4807,19 +4846,26 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 					      struct cgroup_subsys *ss)
 {
 	struct cgroup *parent = cgroup_parent(cgrp);
-	struct cgroup_subsys_state *parent_css = cgroup_css(parent, ss);
+	struct cgroup_subsys_state *parent_css = NULL;
 	struct cgroup_subsys_state *css;
 	int err;
 
 	lockdep_assert_held(&cgroup_mutex);
 
+	/*
+	 * As cgroup may be in bypass mode, need to skip over ancestor
+	 * cgroups with NULL CSS.
+	 */
+	for (; parent && !parent_css; parent = cgroup_parent(parent))
+		parent_css = cgroup_css(parent, ss);
+
 	css = ss->css_alloc(parent_css);
 	if (!css)
 		css = ERR_PTR(-ENOMEM);
 	if (IS_ERR(css))
 		return css;
 
-	init_and_link_css(css, ss, cgrp);
+	init_and_link_css(css, ss, cgrp, parent_css);
 
 	err = percpu_ref_init(&css->refcnt, css_release, 0, GFP_KERNEL);
 	if (err)
@@ -4941,7 +4987,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 	 * subtree_control from the parent.  Each is configured manually.
 	 */
 	if (!cgroup_on_dfl(cgrp))
-		cgrp->subtree_control = cgroup_control(cgrp);
+		cgrp->subtree_control = cgroup_control(cgrp, false);
 
 	cgroup_propagate_control(cgrp);
 
@@ -5254,7 +5300,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	css = ss->css_alloc(cgroup_css(&cgrp_dfl_root.cgrp, ss));
 	/* We don't handle early failures gracefully */
 	BUG_ON(IS_ERR(css));
-	init_and_link_css(css, ss, &cgrp_dfl_root.cgrp);
+	init_and_link_css(css, ss, &cgrp_dfl_root.cgrp, NULL);
 
 	/*
 	 * Root csses are never destroyed and we can't initialize
@@ -5412,6 +5458,9 @@ int __init cgroup_init(void)
 		if (ss->threaded)
 			cgrp_dfl_threaded_ss_mask |= 1 << ss->id;
 
+		if (ss->bypassable)
+			cgrp_dfl_bypass_ss_mask |= 1 << ss->id;
+
 		if (ss->dfl_cftypes == ss->legacy_cftypes) {
 			WARN_ON(cgroup_add_cftypes(ss, ss->dfl_cftypes));
 		} else {
-- 
1.8.3.1

