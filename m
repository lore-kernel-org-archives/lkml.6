Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935357AbeE2OW5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:22:57 -0400
Received: from smtp4.ccs.ornl.gov ([160.91.203.40]:38208 "EHLO
        smtp4.ccs.ornl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935325AbeE2OWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:22:46 -0400
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>,
        Dmitry Eremin <dmitry.eremin@intel.com>,
        James Simmons <jsimmons@infradead.org>
Subject: [PATCH v2 25/25] staging: lustre: ptlrpc: use current CPU instead of hardcoded 0
Date: Tue, 29 May 2018 10:22:05 -0400
Message-Id: <1527603725-30560-26-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Eremin <dmitry.eremin@intel.com>

fix crash if CPU 0 disabled.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8710
Reviewed-on: https://review.whamcloud.com/23305
Reviewed-by: Doug Oucharek <doug.s.oucharek@intel.com>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
Changelog:

v1) New patch to address crash in ptlrpc

 drivers/staging/lustre/lustre/ptlrpc/service.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/lustre/lustre/ptlrpc/service.c b/drivers/staging/lustre/lustre/ptlrpc/service.c
index 3fd8c74..8e74a45 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/service.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/service.c
@@ -421,7 +421,7 @@ static void ptlrpc_at_timer(struct timer_list *t)
 		 * there are.
 		 */
 		/* weight is # of HTs */
-		if (cpumask_weight(topology_sibling_cpumask(0)) > 1) {
+		if (cpumask_weight(topology_sibling_cpumask(smp_processor_id())) > 1) {
 			/* depress thread factor for hyper-thread */
 			factor = factor - (factor >> 1) + (factor >> 3);
 		}
@@ -2221,15 +2221,16 @@ static int ptlrpc_hr_main(void *arg)
 	struct ptlrpc_hr_thread	*hrt = arg;
 	struct ptlrpc_hr_partition *hrp = hrt->hrt_partition;
 	LIST_HEAD(replies);
-	char threadname[20];
 	int rc;
 
-	snprintf(threadname, sizeof(threadname), "ptlrpc_hr%02d_%03d",
-		 hrp->hrp_cpt, hrt->hrt_id);
 	unshare_fs_struct();
 
 	rc = cfs_cpt_bind(ptlrpc_hr.hr_cpt_table, hrp->hrp_cpt);
 	if (rc != 0) {
+		char threadname[20];
+
+		snprintf(threadname, sizeof(threadname), "ptlrpc_hr%02d_%03d",
+			 hrp->hrp_cpt, hrt->hrt_id);
 		CWARN("Failed to bind %s on CPT %d of CPT table %p: rc = %d\n",
 		      threadname, hrp->hrp_cpt, ptlrpc_hr.hr_cpt_table, rc);
 	}
@@ -2528,7 +2529,7 @@ int ptlrpc_hr_init(void)
 
 	init_waitqueue_head(&ptlrpc_hr.hr_waitq);
 
-	weight = cpumask_weight(topology_sibling_cpumask(0));
+	weight = cpumask_weight(topology_sibling_cpumask(smp_processor_id()));
 
 	cfs_percpt_for_each(hrp, i, ptlrpc_hr.hr_partitions) {
 		hrp->hrp_cpt = i;
-- 
1.8.3.1
