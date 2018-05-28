Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030193AbeE1KQJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967624AbeE1KQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:16:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.4 014/268] kernel/sys.c: fix potential Spectre v1 issue
Date: Mon, 28 May 2018 11:59:48 +0200
Message-Id: <20180528100203.711487090@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit 23d6aef74da86a33fa6bb75f79565e0a16ee97c2 upstream.

`resource' can be controlled by user-space, hence leading to a potential
exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

  kernel/sys.c:1474 __do_compat_sys_old_getrlimit() warn: potential spectre issue 'get_current()->signal->rlim' (local cap)
  kernel/sys.c:1455 __do_sys_old_getrlimit() warn: potential spectre issue 'get_current()->signal->rlim' (local cap)

Fix this by sanitizing *resource* before using it to index
current->signal->rlim

Notice that given that speculation windows are large, the policy is to
kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Link: http://lkml.kernel.org/r/20180515030038.GA11822@embeddedor.com
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sys.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -53,6 +53,8 @@
 #include <linux/uidgid.h>
 #include <linux/cred.h>
 
+#include <linux/nospec.h>
+
 #include <linux/kmsg_dump.h>
 /* Move somewhere else to avoid recompiling? */
 #include <generated/utsrelease.h>
@@ -1311,6 +1313,7 @@ SYSCALL_DEFINE2(old_getrlimit, unsigned
 	if (resource >= RLIM_NLIMITS)
 		return -EINVAL;
 
+	resource = array_index_nospec(resource, RLIM_NLIMITS);
 	task_lock(current->group_leader);
 	x = current->signal->rlim[resource];
 	task_unlock(current->group_leader);
