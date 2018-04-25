Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932276AbeDYSND (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:13:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:41713 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932087AbeDYSMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243668"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 12/39] x86/intel_rdt: Ensure requested schemata respects mode
Date: Wed, 25 Apr 2018 03:09:48 -0700
Message-Id: <7d535bec73940e3e3efa93785bfeda23b902c450.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the administrator requests a change in a resource group's schemata
we have to ensure that the new schemata respects the current resource
group as well as the other active resource groups' schemata.

The new schemata is not allowed to overlap with the schemata of any
exclusive resource groups. Similarly, if the resource group being
changed is exclusive then its new schemata is not allowed to overlap
with any schemata of any other active resource group.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |  2 ++
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 49 ++++++++++++++++++++++-------
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    |  4 +--
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 3eb2616c4254..e48ff4e62757 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -450,6 +450,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
+int rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+			  u32 _cbm, int closid, bool exclusive);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index a55bc0b0e0ac..15291ca02daf 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -122,13 +122,19 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 	return true;
 }
 
+struct rdt_cbm_parse_data {
+	char *buf;
+	struct rdtgroup *rdtgrp;
+};
+
 /*
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
 int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
 {
-	char *buf = _data;
+	struct rdt_cbm_parse_data *data = _data;
+	struct rdtgroup *rdtgrp = data->rdtgrp;
 	u32 cbm_val;
 
 	if (d->have_new_ctrl) {
@@ -136,8 +142,24 @@ int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
 		return -EINVAL;
 	}
 
-	if (!cbm_validate(buf, &cbm_val, r))
+	if (!cbm_validate(data->buf, &cbm_val, r))
+		return -EINVAL;
+
+	/*
+	 * The CBM may not overlap with the CBM of another closid if
+	 * either is exclusive.
+	 */
+	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true)) {
+		rdt_last_cmd_printf("overlaps with exclusive group\n");
 		return -EINVAL;
+	}
+
+	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, false)) {
+		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE) {
+			rdt_last_cmd_printf("overlaps with other group\n");
+			return -EINVAL;
+		}
+	}
 
 	d->new_ctrl = cbm_val;
 	d->have_new_ctrl = true;
@@ -151,8 +173,10 @@ int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
  * separated by ";". The "id" is in decimal, and must match one of
  * the "id"s for this resource.
  */
-static int parse_line(char *line, struct rdt_resource *r)
+static int parse_line(char *line, struct rdt_resource *r,
+		      struct rdtgroup *rdtgrp)
 {
+	struct rdt_cbm_parse_data data;
 	char *dom = NULL, *id;
 	struct rdt_domain *d;
 	unsigned long dom_id;
@@ -169,7 +193,9 @@ static int parse_line(char *line, struct rdt_resource *r)
 	dom = strim(dom);
 	list_for_each_entry(d, &r->domains, list) {
 		if (d->id == dom_id) {
-			if (r->parse_ctrlval(dom, r, d))
+			data.buf = dom;
+			data.rdtgrp = rdtgrp;
+			if (r->parse_ctrlval(&data, r, d))
 				return -EINVAL;
 			goto next;
 		}
@@ -213,13 +239,14 @@ int update_domains(struct rdt_resource *r, int closid)
 	return 0;
 }
 
-static int rdtgroup_parse_resource(char *resname, char *tok, int closid)
+static int rdtgroup_parse_resource(char *resname, char *tok,
+				   struct rdtgroup *rdtgrp)
 {
 	struct rdt_resource *r;
 
 	for_each_alloc_enabled_rdt_resource(r) {
-		if (!strcmp(resname, r->name) && closid < r->num_closid)
-			return parse_line(tok, r);
+		if (!strcmp(resname, r->name) && rdtgrp->closid < r->num_closid)
+			return parse_line(tok, r, rdtgrp);
 	}
 	rdt_last_cmd_printf("unknown/unsupported resource name '%s'\n", resname);
 	return -EINVAL;
@@ -232,7 +259,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	char *tok, *resname;
-	int closid, ret = 0;
+	int ret = 0;
 
 	/* Valid input requires a trailing newline */
 	if (nbytes == 0 || buf[nbytes - 1] != '\n')
@@ -246,8 +273,6 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	}
 	rdt_last_cmd_clear();
 
-	closid = rdtgrp->closid;
-
 	for_each_alloc_enabled_rdt_resource(r) {
 		list_for_each_entry(dom, &r->domains, list)
 			dom->have_new_ctrl = false;
@@ -265,13 +290,13 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 			ret = -EINVAL;
 			goto out;
 		}
-		ret = rdtgroup_parse_resource(resname, tok, closid);
+		ret = rdtgroup_parse_resource(resname, tok, rdtgrp);
 		if (ret)
 			goto out;
 	}
 
 	for_each_alloc_enabled_rdt_resource(r) {
-		ret = update_domains(r, closid);
+		ret = update_domains(r, rdtgrp->closid);
 		if (ret)
 			goto out;
 	}
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 0bacfdb85de1..6cc8384c8edf 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -829,8 +829,8 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
  *
  * Return: 0 if CBM does not overlap, 1 if it does.
  */
-static int rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
-				 u32 _cbm, int closid, bool exclusive)
+int rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+			  u32 _cbm, int closid, bool exclusive)
 {
 	unsigned long *cbm = (unsigned long *)&_cbm;
 	unsigned long *ctrl_b;
-- 
2.13.6
