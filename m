Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbeCWTr2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:47:28 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35300 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeCWTr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:47:26 -0400
X-Google-Smtp-Source: AG47ELsIlIC1TjlUyWMyE2ZZaIgAAsxWAxoUiSh8avagSGGXNs887BIQE5SVmNuTy9TUCZjIHOtVIA==
Date: Fri, 23 Mar 2018 12:47:22 -0700
From: Tejun Heo <tj@kernel.org>
To: Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH cgroup/for-4.17 1/2] cgroup: Explicitly remove core interface
 files
Message-ID: <20180323194722.GE2149215@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "cgroup." core interface files bypass the usual interface removal
path and get removed recursively along with the cgroup itself.  While
this works now, the subtle discrepancy gets in the way of implementing
common mechanisms.

This patch updates cgroup core interface file handling so that it's
consistent with controller interface files.  When added, the css is
marked CSS_VISIBLE and they're explicitly removed before the cgroup is
destroyed.

This doesn't cause user-visible behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/cgroup/cgroup.c |   35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1573,8 +1573,17 @@ static void css_clear_dir(struct cgroup_
 
 	css->flags &= ~CSS_VISIBLE;
 
-	list_for_each_entry(cfts, &css->ss->cfts, node)
+	if (!css->ss) {
+		if (cgroup_on_dfl(cgrp))
+			cfts = cgroup_base_files;
+		else
+			cfts = cgroup1_base_files;
+
 		cgroup_addrm_files(css, cgrp, cfts, false);
+	} else {
+		list_for_each_entry(cfts, &css->ss->cfts, node)
+			cgroup_addrm_files(css, cgrp, cfts, false);
+	}
 }
 
 /**
@@ -1598,14 +1607,16 @@ static int css_populate_dir(struct cgrou
 		else
 			cfts = cgroup1_base_files;
 
-		return cgroup_addrm_files(&cgrp->self, cgrp, cfts, true);
-	}
-
-	list_for_each_entry(cfts, &css->ss->cfts, node) {
-		ret = cgroup_addrm_files(css, cgrp, cfts, true);
-		if (ret < 0) {
-			failed_cfts = cfts;
-			goto err;
+		ret = cgroup_addrm_files(&cgrp->self, cgrp, cfts, true);
+		if (ret < 0)
+			return ret;
+	} else {
+		list_for_each_entry(cfts, &css->ss->cfts, node) {
+			ret = cgroup_addrm_files(css, cgrp, cfts, true);
+			if (ret < 0) {
+				failed_cfts = cfts;
+				goto err;
+			}
 		}
 	}
 
@@ -5097,10 +5108,8 @@ static int cgroup_destroy_locked(struct
 	for_each_css(css, ssid, cgrp)
 		kill_css(css);
 
-	/*
-	 * Remove @cgrp directory along with the base files.  @cgrp has an
-	 * extra ref on its kn.
-	 */
+	/* clear and remove @cgrp dir, @cgrp has an extra ref on its kn */
+	css_clear_dir(&cgrp->self);
 	kernfs_remove(cgrp->kn);
 
 	if (parent && cgroup_is_threaded(cgrp))
