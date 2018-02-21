Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeBUTr2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 14:47:28 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41028 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751053AbeBUTr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 14:47:26 -0500
X-Google-Smtp-Source: AH8x227wIPewAGw1VBiklYOhveNGCuE+h3DrXoatIRgnuvP5E09J3G6rszTiW1snpgiln7exfb5aDQ==
Date: Wed, 21 Feb 2018 11:47:22 -0800
From: Tejun Heo <tj@kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        kernel-team@fb.com
Subject: [PATCH cgroup/for-4.16-fixes] cgroup: fix rule checking for threaded
 mode switching
Message-ID: <20180221194722.GF170644@devbig577.frc2.facebook.com>
References: <CAKgNAkgEa9ZEHzoRWv7Y71eFVuFsy8Z4zSazZv9u7NRrx3xG9Q@mail.gmail.com>
 <20180220193547.GB170644@devbig577.frc2.facebook.com>
 <20180220230136.GD170644@devbig577.frc2.facebook.com>
 <CAKgNAkhMqq=VRKrLp89f5RR_gmsLSrd5W+qN8jv5C_ZVwzFs_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkhMqq=VRKrLp89f5RR_gmsLSrd5W+qN8jv5C_ZVwzFs_Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From d1897c9538edafd4ae6bbd03cc075962ddde2c21 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 21 Feb 2018 11:39:22 -0800

A domain cgroup isn't allowed to be turned threaded if its subtree is
populated or domain controllers are enabled.  cgroup_enable_threaded()
depended on cgroup_can_be_thread_root() test to enforce this rule.  A
parent which has populated domain descendants or have domain
controllers enabled can't become a thread root, so the above rules are
enforced automatically.

However, for the root cgroup which can host mixed domain and threaded
children, cgroup_can_be_thread_root() doesn't check any of those
conditions and thus first level cgroups ends up escaping those rules.

This patch fixes the bug by adding explicit checks for those rules in
cgroup_enable_threaded().

Reported-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 8cfd8147df67 ("cgroup: implement cgroup v2 thread support")
Cc: stable@vger.kernel.org # v4.14+
---
 kernel/cgroup/cgroup.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8cda3bc..4bfb290 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3183,6 +3183,16 @@ static int cgroup_enable_threaded(struct cgroup *cgrp)
 	if (cgroup_is_threaded(cgrp))
 		return 0;
 
+	/*
+	 * If @cgroup is populated or has domain controllers enabled, it
+	 * can't be switched.  While the below cgroup_can_be_thread_root()
+	 * test can catch the same conditions, that's only when @parent is
+	 * not mixable, so let's check it explicitly.
+	 */
+	if (cgroup_is_populated(cgrp) ||
+	    cgrp->subtree_control & ~cgrp_dfl_threaded_ss_mask)
+		return -EOPNOTSUPP;
+
 	/* we're joining the parent's domain, ensure its validity */
 	if (!cgroup_is_valid_domain(dom_cgrp) ||
 	    !cgroup_can_be_thread_root(dom_cgrp))
-- 
2.9.5
