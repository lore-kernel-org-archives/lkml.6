Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932151AbeDWRZv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:25:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:33719 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932076AbeDWRZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:25:50 -0400
Date: Mon, 23 Apr 2018 10:11:31 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        akpm@linux-foundation.org
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180423171131.njs4rfm2yzyeg6do@linux-n805>
References: <20180419051510.GA21898@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180419051510.GA21898@mwanda>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So both smatch and coverity are complaining about sysvipc sems.
They look legit (if the policy is, as peterz describes: "kill
any speculation on the first load and not worry if it can be
completed with a dependent load/store").

On Thu, 19 Apr 2018, Dan Carpenter wrote:
>ipc/sem.c:1359 semctl_setval() warn: potential spectre issue 'sma->sems' (local cap)
>ipc/sem.c:1512 semctl_main() warn: potential spectre issue 'sma->sems' (local cap)


And for this one the below patch already sanitizes semnum to be between
[0, sma->sem_nsems) before calling into count_semcnt().

>ipc/sem.c:1096 count_semcnt() warn: potential spectre issue 'sma->sems'
>ipc/sem.c:2084 do_semtimedop() warn: potential spectre issue 'sma->sems'
>ipc/sem.c:388 sem_lock() warn: potential spectre issue 'sma->sems'
>ipc/sem.c:641 perform_atomic_semop_slow() warn: potential spectre issue 'sma->sems'
>ipc/sem.c:721 perform_atomic_semop() warn: potential spectre issue 'sma->sems'

Thanks,
Davidlohr

----8<--------------------------------------------------
[PATCH] sysvipc/sem: mitigate semnum index against spectre v1.

Both smatch and coverity are reporting potential issues
with spectre variant 1 with the 'semnum' index within the
sma->sems array, ie:

ipc/sem.c:388 sem_lock() warn: potential spectre issue 'sma->sems'
ipc/sem.c:641 perform_atomic_semop_slow() warn: potential spectre issue 'sma->sems'
ipc/sem.c:721 perform_atomic_semop() warn: potential spectre issue 'sma->sems'

Avoid any possible speculation by using array_index_nospec() thus
ensuring the semnum value is bounded to [0, sma->sem_nsems). With
the exception of sem_lock() all of these are slowpaths.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---

 ipc/sem.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 06be75d9217a..df623dcefc92 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -84,6 +84,7 @@
 #include <linux/nsproxy.h>
 #include <linux/ipc_namespace.h>
 #include <linux/sched/wake_q.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include "util.h"
@@ -367,6 +368,7 @@ static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
 			      int nsops)
 {
 	struct sem *sem;
+	int idx;
 
 	if (nsops != 1) {
 		/* Complex operation - acquire a full lock */
@@ -384,7 +386,8 @@ static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
 	 *
 	 * Both facts are tracked by use_global_mode.
 	 */
-	sem = &sma->sems[sops->sem_num];
+	idx = array_index_nospec(sops->sem_num, sma->sem_nsems);
+	sem = &sma->sems[idx];
 
 	/*
 	 * Initial check for use_global_lock. Just an optimization,
@@ -637,7 +640,8 @@ static int perform_atomic_semop_slow(struct sem_array *sma, struct sem_queue *q)
 	un = q->undo;
 
 	for (sop = sops; sop < sops + nsops; sop++) {
-		curr = &sma->sems[sop->sem_num];
+		int idx = array_index_nospec(sop->sem_num, sma->sem_nsems);
+		curr = &sma->sems[idx];
 		sem_op = sop->sem_op;
 		result = curr->semval;
 
@@ -717,7 +721,9 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
 	 * until the operations can go through.
 	 */
 	for (sop = sops; sop < sops + nsops; sop++) {
-		curr = &sma->sems[sop->sem_num];
+		int idx = array_index_nospec(sop->sem_num, sma->sem_nsems);
+
+		curr = &sma->sems[idx];
 		sem_op = sop->sem_op;
 		result = curr->semval;
 
@@ -1349,6 +1355,7 @@ static int semctl_setval(struct ipc_namespace *ns, int semid, int semnum,
 		return -EIDRM;
 	}
 
+	semnum = array_index_nospec(semnum, sma->sem_nsems);
 	curr = &sma->sems[semnum];
 
 	ipc_assert_locked_object(&sma->sem_perm);
@@ -1502,6 +1509,8 @@ static int semctl_main(struct ipc_namespace *ns, int semid, int semnum,
 		err = -EIDRM;
 		goto out_unlock;
 	}
+
+	semnum = array_index_nospec(semnum, nsems);
 	curr = &sma->sems[semnum];
 
 	switch (cmd) {
@@ -2072,7 +2081,8 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	 */
 	if (nsops == 1) {
 		struct sem *curr;
-		curr = &sma->sems[sops->sem_num];
+		int idx = array_index_nospec(sops->sem_num, sma->sem_nsems);
+		curr = &sma->sems[idx];
 
 		if (alter) {
 			if (sma->complex_count) {
-- 
2.13.6
