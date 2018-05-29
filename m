Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935252AbeE2OWd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:22:33 -0400
Received: from smtp4.ccs.ornl.gov ([160.91.203.40]:38208 "EHLO
        smtp4.ccs.ornl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935220AbeE2OWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:22:30 -0400
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lustre Development List <lustre-devel@lists.lustre.org>,
        Dmitry Eremin <dmitry.eremin@intel.com>,
        James Simmons <jsimmons@infradead.org>
Subject: [PATCH v2 14/25] staging: lustre: libcfs: use int type for CPT identification.
Date: Tue, 29 May 2018 10:21:54 -0400
Message-Id: <1527603725-30560-15-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
References: <1527603725-30560-1-git-send-email-jsimmons@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Eremin <dmitry.eremin@intel.com>

Use int type for CPT identification to match the linux kernel
CPU identification.

Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-8703
Reviewed-on: https://review.whamcloud.com/23304
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Reviewed-by: Doug Oucharek <dougso@me.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
Changelog:

v1) Initial patch
v2) Rebased patch to handle recent libcfs changes

 drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h |  8 ++++----
 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c          | 14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
index 2c97adf..9f4ba9d 100644
--- a/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
+++ b/drivers/staging/lustre/include/linux/libcfs/libcfs_cpu.h
@@ -90,7 +90,7 @@ struct cfs_cpu_partition {
 	/* NUMA distance between CPTs */
 	unsigned int			*cpt_distance;
 	/* spread rotor for NUMA allocator */
-	unsigned int			cpt_spread_rotor;
+	int				cpt_spread_rotor;
 };
 #endif /* CONFIG_SMP */
 
@@ -98,11 +98,11 @@ struct cfs_cpu_partition {
 struct cfs_cpt_table {
 #ifdef CONFIG_SMP
 	/* spread rotor for NUMA allocator */
-	unsigned int			ctb_spread_rotor;
+	int				ctb_spread_rotor;
 	/* maximum NUMA distance between all nodes in table */
 	unsigned int			ctb_distance;
 	/* # of CPU partitions */
-	unsigned int			ctb_nparts;
+	int				ctb_nparts;
 	/* partitions tables */
 	struct cfs_cpu_partition	*ctb_parts;
 	/* shadow HW CPU to CPU partition ID */
@@ -128,7 +128,7 @@ struct cfs_cpt_table {
 /**
  * create a cfs_cpt_table with \a ncpt number of partitions
  */
-struct cfs_cpt_table *cfs_cpt_table_alloc(unsigned int ncpt);
+struct cfs_cpt_table *cfs_cpt_table_alloc(int ncpt);
 /**
  * return cpumask of CPU partition \a cpt
  */
diff --git a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
index fab6675..14d5791 100644
--- a/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
+++ b/drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c
@@ -69,7 +69,7 @@
 module_param(cpu_pattern, charp, 0444);
 MODULE_PARM_DESC(cpu_pattern, "CPU partitions pattern");
 
-struct cfs_cpt_table *cfs_cpt_table_alloc(unsigned int ncpt)
+struct cfs_cpt_table *cfs_cpt_table_alloc(int ncpt)
 {
 	struct cfs_cpt_table *cptab;
 	int i;
@@ -784,13 +784,13 @@ static int cfs_cpt_choose_ncpus(struct cfs_cpt_table *cptab, int cpt,
 	return rc;
 }
 
-#define CPT_WEIGHT_MIN  4u
+#define CPT_WEIGHT_MIN 4
 
-static unsigned int cfs_cpt_num_estimate(void)
+static int cfs_cpt_num_estimate(void)
 {
-	unsigned int nnode = num_online_nodes();
-	unsigned int ncpu = num_online_cpus();
-	unsigned int ncpt;
+	int nnode = num_online_nodes();
+	int ncpu = num_online_cpus();
+	int ncpt;
 
 	if (ncpu <= CPT_WEIGHT_MIN) {
 		ncpt = 1;
@@ -820,7 +820,7 @@ static unsigned int cfs_cpt_num_estimate(void)
 	/* config many CPU partitions on 32-bit system could consume
 	 * too much memory
 	 */
-	ncpt = min(2U, ncpt);
+	ncpt = min(2, ncpt);
 #endif
 	while (ncpu % ncpt)
 		ncpt--; /* worst case is 1 */
-- 
1.8.3.1
