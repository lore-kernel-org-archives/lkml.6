Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A63C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30582098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vb351d9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30582098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbeJQBLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729552AbeJQBLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:11:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DE4D20866;
        Tue, 16 Oct 2018 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710421;
        bh=nzJLxSSL0UcoAM8r7mnekJjnVQ7N1tYNKcJSWlCuFMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vb351d9pYS3/hlVM5oCwgdVcdIZsEdBUlgbmtOIQdM/py4clLXRKFru+5UVAo6qHj
         t8edr/WB+w0BXVxwh46jsg5xy7nsKAaSemrNbh5pkze3GGpl/ovHmwOuUuVPl1NDdH
         x+ojm8J5JfoV4KNZ7ETtwB9ruIeMbNqKoMQNyllQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Amin Jamali <ajamali@pivotal.io>,
        Joao De Almeida Pereira <jpereira@pivotal.io>
Subject: [PATCH 4.14 072/109] cgroup: Fix dom_cgrp propagation when enabling threaded mode
Date:   Tue, 16 Oct 2018 19:05:40 +0200
Message-Id: <20181016170528.712843436@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit 479adb89a97b0a33e5a9d702119872cc82ca21aa upstream.

A cgroup which is already a threaded domain may be converted into a
threaded cgroup if the prerequisite conditions are met.  When this
happens, all threaded descendant should also have their ->dom_cgrp
updated to the new threaded domain cgroup.  Unfortunately, this
propagation was missing leading to the following failure.

  # cd /sys/fs/cgroup/unified
  # cat cgroup.subtree_control    # show that no controllers are enabled

  # mkdir -p mycgrp/a/b/c
  # echo threaded > mycgrp/a/b/cgroup.type

  At this point, the hierarchy looks as follows:

      mycgrp [d]
	  a [dt]
	      b [t]
		  c [inv]

  Now let's make node "a" threaded (and thus "mycgrp" s made "domain threaded"):

  # echo threaded > mycgrp/a/cgroup.type

  By this point, we now have a hierarchy that looks as follows:

      mycgrp [dt]
	  a [t]
	      b [t]
		  c [inv]

  But, when we try to convert the node "c" from "domain invalid" to
  "threaded", we get ENOTSUP on the write():

  # echo threaded > mycgrp/a/b/c/cgroup.type
  sh: echo: write error: Operation not supported

This patch fixes the problem by

* Moving the opencoded ->dom_cgrp save and restoration in
  cgroup_enable_threaded() into cgroup_{save|restore}_control() so
  that mulitple cgroups can be handled.

* Updating all threaded descendants' ->dom_cgrp to point to the new
  dom_cgrp when enabling threaded mode.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-and-tested-by: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Reported-by: Amin Jamali <ajamali@pivotal.io>
Reported-by: Joao De Almeida Pereira <jpereira@pivotal.io>
Link: https://lore.kernel.org/r/CAKgNAkhHYCMn74TCNiMJ=ccLd7DcmXSbvw3CbZ1YREeG7iJM5g@mail.gmail.com
Fixes: 454000adaa2a ("cgroup: introduce cgroup->dom_cgrp and threaded css_set handling")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/cgroup-defs.h |    1 +
 kernel/cgroup/cgroup.c      |   25 ++++++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -353,6 +353,7 @@ struct cgroup {
 	 * specific task are charged to the dom_cgrp.
 	 */
 	struct cgroup *dom_cgrp;
+	struct cgroup *old_dom_cgrp;		/* used while enabling threaded */
 
 	/*
 	 * list of pidlists, up to two for each namespace (one for procs, one
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2780,11 +2780,12 @@ restart:
 }
 
 /**
- * cgroup_save_control - save control masks of a subtree
+ * cgroup_save_control - save control masks and dom_cgrp of a subtree
  * @cgrp: root of the target subtree
  *
- * Save ->subtree_control and ->subtree_ss_mask to the respective old_
- * prefixed fields for @cgrp's subtree including @cgrp itself.
+ * Save ->subtree_control, ->subtree_ss_mask and ->dom_cgrp to the
+ * respective old_ prefixed fields for @cgrp's subtree including @cgrp
+ * itself.
  */
 static void cgroup_save_control(struct cgroup *cgrp)
 {
@@ -2794,6 +2795,7 @@ static void cgroup_save_control(struct c
 	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
 		dsct->old_subtree_control = dsct->subtree_control;
 		dsct->old_subtree_ss_mask = dsct->subtree_ss_mask;
+		dsct->old_dom_cgrp = dsct->dom_cgrp;
 	}
 }
 
@@ -2819,11 +2821,12 @@ static void cgroup_propagate_control(str
 }
 
 /**
- * cgroup_restore_control - restore control masks of a subtree
+ * cgroup_restore_control - restore control masks and dom_cgrp of a subtree
  * @cgrp: root of the target subtree
  *
- * Restore ->subtree_control and ->subtree_ss_mask from the respective old_
- * prefixed fields for @cgrp's subtree including @cgrp itself.
+ * Restore ->subtree_control, ->subtree_ss_mask and ->dom_cgrp from the
+ * respective old_ prefixed fields for @cgrp's subtree including @cgrp
+ * itself.
  */
 static void cgroup_restore_control(struct cgroup *cgrp)
 {
@@ -2833,6 +2836,7 @@ static void cgroup_restore_control(struc
 	cgroup_for_each_live_descendant_post(dsct, d_css, cgrp) {
 		dsct->subtree_control = dsct->old_subtree_control;
 		dsct->subtree_ss_mask = dsct->old_subtree_ss_mask;
+		dsct->dom_cgrp = dsct->old_dom_cgrp;
 	}
 }
 
@@ -3140,6 +3144,8 @@ static int cgroup_enable_threaded(struct
 {
 	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup *dom_cgrp = parent->dom_cgrp;
+	struct cgroup *dsct;
+	struct cgroup_subsys_state *d_css;
 	int ret;
 
 	lockdep_assert_held(&cgroup_mutex);
@@ -3169,12 +3175,13 @@ static int cgroup_enable_threaded(struct
 	 */
 	cgroup_save_control(cgrp);
 
-	cgrp->dom_cgrp = dom_cgrp;
+	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp)
+		if (dsct == cgrp || cgroup_is_threaded(dsct))
+			dsct->dom_cgrp = dom_cgrp;
+
 	ret = cgroup_apply_control(cgrp);
 	if (!ret)
 		parent->nr_threaded_children++;
-	else
-		cgrp->dom_cgrp = cgrp;
 
 	cgroup_finalize_control(cgrp, ret);
 	return ret;


