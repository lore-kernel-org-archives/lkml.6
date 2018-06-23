Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42E8C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ED6240DD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79ED6240DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751977AbeFWMNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:13:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58281 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeFWMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:13:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCDWWK463994
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:13:32 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCDWtl463991;
        Sat, 23 Jun 2018 05:13:32 -0700
Date:   Sat, 23 Jun 2018 05:13:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-9ab9aa15c3096000678891b61f7309c8729928e0@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        reinette.chatre@intel.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, reinette.chatre@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <b0c05b21110d3040fff45f4c1d2cfda8dba3f207.1529706536.git.reinette.chatre@intel.com>
References: <b0c05b21110d3040fff45f4c1d2cfda8dba3f207.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Ensure requested schemata respects
 mode
Git-Commit-ID: 9ab9aa15c3096000678891b61f7309c8729928e0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9ab9aa15c3096000678891b61f7309c8729928e0
Gitweb:     https://git.kernel.org/tip/9ab9aa15c3096000678891b61f7309c8729928e0
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:04 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:43 +0200

x86/intel_rdt: Ensure requested schemata respects mode

When the administrator requests a change in a resource group's schemata
we have to ensure that the new schemata respects the current resource
group as well as the other active resource groups' schemata.

The new schemata is not allowed to overlap with the schemata of any
exclusive resource groups. Similarly, if the resource group being
changed is exclusive then its new schemata is not allowed to overlap
with any schemata of any other active resource group.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/b0c05b21110d3040fff45f4c1d2cfda8dba3f207.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h             |  2 ++
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 49 ++++++++++++++++++++++-------
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    |  4 +--
 3 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index b2b2864150aa..362c8fe695f3 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -465,6 +465,8 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off);
 int rdtgroup_schemata_show(struct kernfs_open_file *of,
 			   struct seq_file *s, void *v);
+bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+			   u32 _cbm, int closid, bool exclusive);
 enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index ab4bb8731825..0e6210a043f0 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -123,13 +123,19 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 	return true;
 }
 
+struct rdt_cbm_parse_data {
+	struct rdtgroup		*rdtgrp;
+	char			*buf;
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
@@ -137,8 +143,24 @@ int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
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
@@ -152,8 +174,10 @@ int parse_cbm(void *_data, struct rdt_resource *r, struct rdt_domain *d)
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
@@ -170,7 +194,9 @@ next:
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
@@ -223,13 +249,14 @@ done:
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
@@ -242,7 +269,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	struct rdt_domain *dom;
 	struct rdt_resource *r;
 	char *tok, *resname;
-	int closid, ret = 0;
+	int ret = 0;
 
 	/* Valid input requires a trailing newline */
 	if (nbytes == 0 || buf[nbytes - 1] != '\n')
@@ -256,8 +283,6 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 	}
 	rdt_last_cmd_clear();
 
-	closid = rdtgrp->closid;
-
 	for_each_alloc_enabled_rdt_resource(r) {
 		list_for_each_entry(dom, &r->domains, list)
 			dom->have_new_ctrl = false;
@@ -275,13 +300,13 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
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
index ba1410ced420..75a43f8b400e 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -829,8 +829,8 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
  *
  * Return: false if CBM does not overlap, true if it does.
  */
-static bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
-				  u32 _cbm, int closid, bool exclusive)
+bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+			   u32 _cbm, int closid, bool exclusive)
 {
 	unsigned long *cbm = (unsigned long *)&_cbm;
 	unsigned long *ctrl_b;
