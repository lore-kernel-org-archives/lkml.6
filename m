Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A6AC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041CD2075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041CD2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJIOSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 10:18:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57949 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbeJIOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 10:18:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9972V2c935461
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 00:02:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9972Vt3935458;
        Tue, 9 Oct 2018 00:02:31 -0700
Date:   Tue, 9 Oct 2018 00:02:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-e5f3530c391105fdd6174852e3ea6136d073b45a@git.kernel.org>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, jithu.joseph@intel.com,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        reinette.chatre@intel.com
Reply-To: tglx@linutronix.de, fenghua.yu@intel.com, jithu.joseph@intel.com,
          hpa@zytor.com, reinette.chatre@intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <e538b7f56f7ca15963dce2e00ac3be8edb8a68e1.1538603665.git.reinette.chatre@intel.com>
References: <e538b7f56f7ca15963dce2e00ac3be8edb8a68e1.1538603665.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: CBM overlap should also check for
 overlap with CDP peer
Git-Commit-ID: e5f3530c391105fdd6174852e3ea6136d073b45a
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

Commit-ID:  e5f3530c391105fdd6174852e3ea6136d073b45a
Gitweb:     https://git.kernel.org/tip/e5f3530c391105fdd6174852e3ea6136d073b45a
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Wed, 3 Oct 2018 15:17:02 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 9 Oct 2018 08:50:43 +0200

x86/intel_rdt: CBM overlap should also check for overlap with CDP peer

The CBM overlap test is used to manage the allocations of RDT resources
where overlap is possible between resource groups. When a resource group
is in exclusive mode then there should be no overlap between resource
groups.

The current overlap test only considers overlap between the same
resources, for example, that usage of a RDT_RESOURCE_L2DATA resource
in one resource group does not overlap with usage of a RDT_RESOURCE_L2DATA
resource in another resource group. The problem with this is that it
allows overlap between a RDT_RESOURCE_L2DATA resource in one resource
group with a RDT_RESOURCE_L2CODE resource in another resource group -
even if both resource groups are in exclusive mode. This is a problem
because even though these appear to be different resources they end up
sharing the same underlying hardware and thus does not fulfill the
user's request for exclusive use of hardware resources.

Fix this by including the CDP peer (if there is one) in every CBM
overlap test. This does not impact the overlap between resources
within the same exclusive resource group that is allowed.

Fixes: 49f7b4efa110 ("x86/intel_rdt: Enable setting of exclusive mode")
Reported-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jithu Joseph <jithu.joseph@intel.com>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
Cc: tony.luck@intel.com
Cc: gavin.hindman@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/e538b7f56f7ca15963dce2e00ac3be8edb8a68e1.1538603665.git.reinette.chatre@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 48 +++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 9d59ee1c444e..49c479822844 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -983,10 +983,9 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
  *         If a CDP peer was found, @r_cdp will point to the peer RDT resource
  *         and @d_cdp will point to the peer RDT domain.
  */
-static int __attribute__((unused)) rdt_cdp_peer_get(struct rdt_resource *r,
-						    struct rdt_domain *d,
-						    struct rdt_resource **r_cdp,
-						    struct rdt_domain **d_cdp)
+static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
+			    struct rdt_resource **r_cdp,
+			    struct rdt_domain **d_cdp)
 {
 	struct rdt_resource *_r_cdp = NULL;
 	struct rdt_domain *_d_cdp = NULL;
@@ -1033,7 +1032,7 @@ out:
 }
 
 /**
- * rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
+ * __rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
  * @r: Resource to which domain instance @d belongs.
  * @d: The domain instance for which @closid is being tested.
  * @cbm: Capacity bitmask being tested.
@@ -1052,8 +1051,8 @@ out:
  *
  * Return: false if CBM does not overlap, true if it does.
  */
-bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
-			   unsigned long cbm, int closid, bool exclusive)
+static bool __rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+				    unsigned long cbm, int closid, bool exclusive)
 {
 	enum rdtgrp_mode mode;
 	unsigned long ctrl_b;
@@ -1088,6 +1087,41 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
 	return false;
 }
 
+/**
+ * rdtgroup_cbm_overlaps - Does CBM overlap with other use of hardware
+ * @r: Resource to which domain instance @d belongs.
+ * @d: The domain instance for which @closid is being tested.
+ * @cbm: Capacity bitmask being tested.
+ * @closid: Intended closid for @cbm.
+ * @exclusive: Only check if overlaps with exclusive resource groups
+ *
+ * Resources that can be allocated using a CBM can use the CBM to control
+ * the overlap of these allocations. rdtgroup_cmb_overlaps() is the test
+ * for overlap. Overlap test is not limited to the specific resource for
+ * which the CBM is intended though - when dealing with CDP resources that
+ * share the underlying hardware the overlap check should be performed on
+ * the CDP resource sharing the hardware also.
+ *
+ * Refer to description of __rdtgroup_cbm_overlaps() for the details of the
+ * overlap test.
+ *
+ * Return: true if CBM overlap detected, false if there is no overlap
+ */
+bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+			   unsigned long cbm, int closid, bool exclusive)
+{
+	struct rdt_resource *r_cdp;
+	struct rdt_domain *d_cdp;
+
+	if (__rdtgroup_cbm_overlaps(r, d, cbm, closid, exclusive))
+		return true;
+
+	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) < 0)
+		return false;
+
+	return  __rdtgroup_cbm_overlaps(r_cdp, d_cdp, cbm, closid, exclusive);
+}
+
 /**
  * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusive
  *
