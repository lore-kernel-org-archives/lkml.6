Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C972C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E719720693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E719720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbeFTAQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:16:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeFTAQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:16:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0GI6b3296586
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:16:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0GI7v3296583;
        Tue, 19 Jun 2018 17:16:18 -0700
Date:   Tue, 19 Jun 2018 17:16:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-9b72ac2e7a2345b64fa1311078b473698f13bd49@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        reinette.chatre@intel.com, tglx@linutronix.de, hpa@zytor.com
Reply-To: reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <44af4ecef879e88ec1b74c5decbf5dccaf998866.1528405422.git.reinette.chatre@intel.com>
References: <44af4ecef879e88ec1b74c5decbf5dccaf998866.1528405422.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Initialize new resource group with
 sane defaults
Git-Commit-ID: 9b72ac2e7a2345b64fa1311078b473698f13bd49
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

Commit-ID:  9b72ac2e7a2345b64fa1311078b473698f13bd49
Gitweb:     https://git.kernel.org/tip/9b72ac2e7a2345b64fa1311078b473698f13bd49
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Thu, 7 Jun 2018 14:24:25 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:29 +0200

x86/intel_rdt: Initialize new resource group with sane defaults

Currently when a new resource group is created its allocations would be
those that belonged to the resource group to which its closid belonged
previously.

That is, we can encounter a case like:
mkdir newgroup
cat newgroup/schemata
L2:0=ff;1=ff
echo 'L2:0=0xf0;1=0xf0' > newgroup/schemata
cat newgroup/schemata
L2:0=0xf0;1=0xf0
rmdir newgroup
mkdir newnewgroup
cat newnewgroup/schemata
L2:0=0xf0;1=0xf0

When the new group is created it would be reasonable to expect its
allocations to be initialized with all regions that it can possibly use.
At this time these regions would be all that are shareable by other
resource groups as well as regions that are not currently used.
If the available cache region is found to be non-contiguous the
available region is adjusted to enforce validity.

When a new resource group is created the hardware is initialized with
these new default allocations.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/44af4ecef879e88ec1b74c5decbf5dccaf998866.1528405422.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 115 ++++++++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 35e538eed977..e59c8751293b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -133,7 +133,7 @@ void closid_free(int closid)
  * Return: true if @closid is currently associated with a resource group,
  * false if @closid is free
  */
-static bool __attribute__ ((unused)) closid_allocated(unsigned int closid)
+static bool closid_allocated(unsigned int closid)
 {
 	return (closid_free_map & (1 << closid)) == 0;
 }
@@ -1799,6 +1799,110 @@ out_destroy:
 	return ret;
 }
 
+/**
+ * cbm_ensure_valid - Enforce validity on provided CBM
+ * @_val:	Candidate CBM
+ * @r:		RDT resource to which the CBM belongs
+ *
+ * The provided CBM represents all cache portions available for use. This
+ * may be represented by a bitmap that does not consist of contiguous ones
+ * and thus be an invalid CBM.
+ * Here the provided CBM is forced to be a valid CBM by only considering
+ * the first set of contiguous bits as valid and clearing all bits.
+ * The intention here is to provide a valid default CBM with which a new
+ * resource group is initialized. The user can follow this with a
+ * modification to the CBM if the default does not satisfy the
+ * requirements.
+ */
+static void cbm_ensure_valid(u32 *_val, struct rdt_resource *r)
+{
+	/*
+	 * Convert the u32 _val to an unsigned long required by all the bit
+	 * operations within this function. No more than 32 bits of this
+	 * converted value can be accessed because all bit operations are
+	 * additionally provided with cbm_len that is initialized during
+	 * hardware enumeration using five bits from the EAX register and
+	 * thus never can exceed 32 bits.
+	 */
+	unsigned long *val = (unsigned long *)_val;
+	unsigned int cbm_len = r->cache.cbm_len;
+	unsigned long first_bit, zero_bit;
+
+	if (*val == 0)
+		return;
+
+	first_bit = find_first_bit(val, cbm_len);
+	zero_bit = find_next_zero_bit(val, cbm_len, first_bit);
+
+	/* Clear any remaining bits to ensure contiguous region */
+	bitmap_clear(val, zero_bit, cbm_len - zero_bit);
+}
+
+/**
+ * rdtgroup_init_alloc - Initialize the new RDT group's allocations
+ *
+ * A new RDT group is being created on an allocation capable (CAT)
+ * supporting system. Set this group up to start off with all usable
+ * allocations. That is, all shareable and unused bits.
+ *
+ * All-zero CBM is invalid. If there are no more shareable bits available
+ * on any domain then the entire allocation will fail.
+ */
+static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
+{
+	u32 used_b = 0, unused_b = 0;
+	u32 closid = rdtgrp->closid;
+	struct rdt_resource *r;
+	enum rdtgrp_mode mode;
+	struct rdt_domain *d;
+	int i, ret;
+	u32 *ctrl;
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		list_for_each_entry(d, &r->domains, list) {
+			d->have_new_ctrl = false;
+			d->new_ctrl = r->cache.shareable_bits;
+			used_b = r->cache.shareable_bits;
+			ctrl = d->ctrl_val;
+			for (i = 0; i < r->num_closid; i++, ctrl++) {
+				if (closid_allocated(i) && i != closid) {
+					mode = rdtgroup_mode_by_closid(i);
+					used_b |= *ctrl;
+					if (mode == RDT_MODE_SHAREABLE)
+						d->new_ctrl |= *ctrl;
+				}
+			}
+			unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
+			unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
+			d->new_ctrl |= unused_b;
+			/*
+			 * Force the initial CBM to be valid, user can
+			 * modify the CBM based on system availability.
+			 */
+			cbm_ensure_valid(&d->new_ctrl, r);
+			if (bitmap_weight((unsigned long *) &d->new_ctrl,
+					  r->cache.cbm_len) <
+					r->cache.min_cbm_bits) {
+				rdt_last_cmd_printf("no space on %s:%d\n",
+						    r->name, d->id);
+				return -ENOSPC;
+			}
+			d->have_new_ctrl = true;
+		}
+	}
+
+	for_each_alloc_enabled_rdt_resource(r) {
+		ret = update_domains(r, rdtgrp->closid);
+		if (ret < 0) {
+			rdt_last_cmd_puts("failed to initialize allocations\n");
+			return ret;
+		}
+		rdtgrp->mode = RDT_MODE_SHAREABLE;
+	}
+
+	return 0;
+}
+
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 			     struct kernfs_node *prgrp_kn,
 			     const char *name, umode_t mode,
@@ -1957,6 +2061,10 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	ret = 0;
 
 	rdtgrp->closid = closid;
+	ret = rdtgroup_init_alloc(rdtgrp);
+	if (ret < 0)
+		goto out_id_free;
+
 	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
 
 	if (rdt_mon_capable) {
@@ -1967,15 +2075,16 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 		ret = mongroup_create_dir(kn, NULL, "mon_groups", NULL);
 		if (ret) {
 			rdt_last_cmd_puts("kernfs subdir error\n");
-			goto out_id_free;
+			goto out_del_list;
 		}
 	}
 
 	goto out_unlock;
 
+out_del_list:
+	list_del(&rdtgrp->rdtgroup_list);
 out_id_free:
 	closid_free(closid);
-	list_del(&rdtgrp->rdtgroup_list);
 out_common_fail:
 	mkdir_rdt_prepare_clean(rdtgrp);
 out_unlock:
