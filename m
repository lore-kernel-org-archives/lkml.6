Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbeBZPg2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:36:28 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:55829 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751608AbeBZPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:36:27 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
From: Chris Wilson <chris@chris-wilson.co.uk>
To: linux-kernel@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Jean Delvare <khali@linux-fr.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Zhong <zhong@linux.vnet.ibm.com>,
        Petri Latvala <petri.latvala@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH] kernel: Downgrade warning for unsafe parameters
Date: Mon, 26 Feb 2018 15:19:19 +0000
Message-Id: <20180226151919.9674-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.16.2
X-Originating-IP: 78.156.65.138
X-Country: code=GB country="United Kingdom" ip=78.156.65.138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As using an unsafe module parameter is, by its very definition, an
expected user action, emitting a warning is overkill. Nothing has yet
gone wrong, and we add a taint flag for any future oops should
something actually go wrong. So instead of having a user controllable
pr_warn, downgrade it to a pr_notice for "a normal, but significant
condition".

We make use of unsafe kernel parameters in igt (we have not yet
succeeded in removing all such debugging options), which generates a
warning and taints the kernel. The warning is unhelpful as we then need
to filter it out again as we check that every test themselves do not
provoke any kernel warnings.

References: 91f9d330cc14 ("module: make it possible to have unsafe, tainting module params")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Li Zhong <zhong@linux.vnet.ibm.com>
Cc: Petri Latvala <petri.latvala@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 kernel/params.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/params.c b/kernel/params.c
index cc9108c2a1fd..ce89f757e6da 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -111,8 +111,8 @@ bool parameq(const char *a, const char *b)
 static void param_check_unsafe(const struct kernel_param *kp)
 {
 	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
-		pr_warn("Setting dangerous option %s - tainting kernel\n",
-			kp->name);
+		pr_notice("Setting dangerous option %s - tainting kernel\n",
+			  kp->name);
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}
 }
-- 
2.16.2
