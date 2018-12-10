Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0028FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35D72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35D72082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbeLJVlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:41:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36344 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730045AbeLJVlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:41:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79439C014177;
        Mon, 10 Dec 2018 21:41:11 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA9C25C225;
        Mon, 10 Dec 2018 21:41:09 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 2/5] cgroup: Allow reenabling of controller in bypass mode
Date:   Mon, 10 Dec 2018 16:40:55 -0500
Message-Id: <1544478058-24252-3-git-send-email-longman@redhat.com>
In-Reply-To: <1544478058-24252-1-git-send-email-longman@redhat.com>
References: <1544478058-24252-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 10 Dec 2018 21:41:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bypassable controllers set to bypass mode in the parent's
"cgroup.subtree_control" can now be optionally enabled by writing the
controller name with the '+' prefix to "cgroup.controllers". Using the
'#' prefix will reset it back to the bypass state.

This capability allows a cgroup parent to individually enable bypassable
controllers in a subset of its children instead of either all or none
of them. This increases the flexibility each controller has in shaping
the effective cgroup hierarchy to best suit its need.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h |   7 +++
 kernel/cgroup/cgroup.c      | 109 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 5bff798..ab1b355 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -388,6 +388,13 @@ struct cgroup {
 	u16 old_subtree_ss_mask;
 	u16 old_subtree_bypass;
 
+	/*
+	 * The bitmask of subsystems that are set in its parent's
+	 * ->subtree_bypass and explicitly enabled in this cgroup.
+	 */
+	u16 enable_ss_mask;
+	u16 old_enable_ss_mask;
+
 	/* Private pointers for each registered subsystem */
 	struct cgroup_subsys_state __rcu *subsys[CGROUP_SUBSYS_COUNT];
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8a729e4..7aa77b1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -424,7 +424,7 @@ static u16 cgroup_control(struct cgroup *cgrp, bool show_bypass)
 	u16 root_ss_mask = cgrp->root->subsys_mask;
 
 	if (parent) {
-		u16 ss_mask = parent->subtree_control;
+		u16 ss_mask = parent->subtree_control|cgrp->enable_ss_mask;
 
 		if (show_bypass)
 			ss_mask |= parent->subtree_bypass;
@@ -447,7 +447,7 @@ static u16 cgroup_ss_mask(struct cgroup *cgrp, bool show_bypass)
 	struct cgroup *parent = cgroup_parent(cgrp);
 
 	if (parent) {
-		u16 ss_mask = parent->subtree_ss_mask;
+		u16 ss_mask = parent->subtree_ss_mask|cgrp->enable_ss_mask;
 
 
 		if (show_bypass)
@@ -2874,6 +2874,7 @@ static void cgroup_save_control(struct cgroup *cgrp)
 		dsct->old_subtree_control = dsct->subtree_control;
 		dsct->old_subtree_ss_mask = dsct->subtree_ss_mask;
 		dsct->old_subtree_bypass  = dsct->subtree_bypass;
+		dsct->old_enable_ss_mask  = dsct->enable_ss_mask;
 		dsct->old_dom_cgrp = dsct->dom_cgrp;
 	}
 }
@@ -2919,6 +2920,7 @@ static void cgroup_restore_control(struct cgroup *cgrp)
 		dsct->subtree_control = dsct->old_subtree_control;
 		dsct->subtree_ss_mask = dsct->old_subtree_ss_mask;
 		dsct->subtree_bypass  = dsct->old_subtree_bypass;
+		dsct->enable_ss_mask  = dsct->old_enable_ss_mask;
 		dsct->dom_cgrp = dsct->old_dom_cgrp;
 	}
 }
@@ -3197,7 +3199,8 @@ static ssize_t cgroup_subtree_control_write(struct kernfs_open_file *of,
 	}
 
 	cgroup_for_each_live_child(child, cgrp)
-		child_enable |= child->subtree_control|child->subtree_bypass;
+		child_enable |= child->subtree_control|child->subtree_bypass|
+				child->enable_ss_mask;
 
 	/*
 	 * Cannot change the state of a controller if enabled in children.
@@ -3230,6 +3233,105 @@ static ssize_t cgroup_subtree_control_write(struct kernfs_open_file *of,
 	return ret ?: nbytes;
 }
 
+/*
+ * Change bypass status of controllers for a cgroup in the default hierarchy.
+ */
+static ssize_t cgroup_controllers_write(struct kernfs_open_file *of,
+					char *buf, size_t nbytes,
+					loff_t off)
+{
+	u16 enable = 0, bypass = 0;
+	struct cgroup *cgrp, *parent;
+	struct cgroup_subsys *ss;
+	char *tok;
+	int ssid, ret;
+
+	/*
+	 * Parse input - space separated list of subsystem names prefixed
+	 * with either + or #.
+	 */
+	buf = strstrip(buf);
+	while ((tok = strsep(&buf, " "))) {
+		if (tok[0] == '\0')
+			continue;
+		do_each_subsys_mask(ss, ssid, ~cgrp_dfl_inhibit_ss_mask) {
+			if (!cgroup_ssid_enabled(ssid) ||
+			    strcmp(tok + 1, ss->name))
+				continue;
+
+			if (*tok == '+') {
+				enable |= 1 << ssid;
+				bypass &= ~(1 << ssid);
+			} else if (*tok == '#') {
+				bypass |= 1 << ssid;
+				enable &= ~(1 << ssid);
+			} else {
+				return -EINVAL;
+			}
+			break;
+		} while_each_subsys_mask();
+		if (ssid == CGROUP_SUBSYS_COUNT)
+			return -EINVAL;
+	}
+
+	cgrp = cgroup_kn_lock_live(of->kn, true);
+	if (!cgrp)
+		return -ENODEV;
+
+	/*
+	 * Write to root cgroup's controllers file is not allowed.
+	 */
+	parent = cgroup_parent(cgrp);
+	if (!parent) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/*
+	 * Only controllers set into bypass mode in the parent cgroup
+	 * can be specified here.
+	 */
+	if (~parent->subtree_bypass & (enable|bypass)) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	/*
+	 * Mask off irrelevant bits.
+	 */
+	enable &= ~cgrp->enable_ss_mask;
+	bypass &=  cgrp->enable_ss_mask;
+
+	if (!(enable|bypass)) {
+		ret = 0;
+		goto out_unlock;
+	}
+
+	/*
+	 * We cannot change the bypass state of a controller that is enabled
+	 * in subtree_control.
+	 */
+	if ((cgrp->subtree_control|cgrp->subtree_bypass) & (enable|bypass)) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	/* Save and update control masks and prepare csses */
+	cgroup_save_control(cgrp);
+
+	cgrp->enable_ss_mask |= enable;
+	cgrp->enable_ss_mask &= ~bypass;
+
+	ret = cgroup_apply_control(cgrp);
+	cgroup_finalize_control(cgrp, ret);
+	kernfs_activate(cgrp->kn);
+	ret = 0;
+
+out_unlock:
+	cgroup_kn_unlock(of->kn);
+	return ret ?: nbytes;
+}
+
 /**
  * cgroup_enable_threaded - make @cgrp threaded
  * @cgrp: the target cgroup
@@ -4573,6 +4675,7 @@ static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
 	{
 		.name = "cgroup.controllers",
 		.seq_show = cgroup_controllers_show,
+		.write = cgroup_controllers_write,
 	},
 	{
 		.name = "cgroup.subtree_control",
-- 
1.8.3.1

