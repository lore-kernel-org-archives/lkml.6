Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeEODAl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 23:00:41 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.102]:12175 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752009AbeEODAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 23:00:40 -0400
X-Authority-Reason: nr=8
Date: Mon, 14 May 2018 22:00:38 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] kernel: sys: fix potential Spectre v1
Message-ID: <20180515030038.GA11822@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.172.56.86
X-Source-L: No
X-Exim-ID: 1fIQCd-003WyV-LX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.172.56.86]:51020
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resource can be controlled by user-space, hence leading to a
potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

kernel/sys.c:1474 __do_compat_sys_old_getrlimit() warn: potential
spectre issue 'get_current()->signal->rlim' (local cap)
kernel/sys.c:1455 __do_sys_old_getrlimit() warn: potential spectre issue
'get_current()->signal->rlim' (local cap)

Fix this by sanitizing *resource* before using it to index
current->signal->rlim

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 kernel/sys.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sys.c b/kernel/sys.c
index 63ef036..78646e6 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -69,6 +69,9 @@
 #include <asm/io.h>
 #include <asm/unistd.h>
 
+/* Hardening for Spectre-v1 */
+#include <linux/nospec.h>
+
 #include "uid16.h"
 
 #ifndef SET_UNALIGN_CTL
@@ -1451,6 +1454,7 @@ SYSCALL_DEFINE2(old_getrlimit, unsigned int, resource,
 	if (resource >= RLIM_NLIMITS)
 		return -EINVAL;
 
+	resource = array_index_nospec(resource, RLIM_NLIMITS);
 	task_lock(current->group_leader);
 	x = current->signal->rlim[resource];
 	task_unlock(current->group_leader);
@@ -1470,6 +1474,7 @@ COMPAT_SYSCALL_DEFINE2(old_getrlimit, unsigned int, resource,
 	if (resource >= RLIM_NLIMITS)
 		return -EINVAL;
 
+	resource = array_index_nospec(resource, RLIM_NLIMITS);
 	task_lock(current->group_leader);
 	r = current->signal->rlim[resource];
 	task_unlock(current->group_leader);
-- 
2.7.4
