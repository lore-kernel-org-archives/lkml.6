Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A57C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55FF2150C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:00:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55FF2150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbeI0BPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:15:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:64733 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbeI0BPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:15:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 12:00:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="76436981"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga008.jf.intel.com with ESMTP; 26 Sep 2018 12:00:39 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc:     jithu.joseph@intel.com, gavin.hindman@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 2/3] x86/intel_rdt: CBM overlap should also check for overlap with CDP peer
Date:   Wed, 26 Sep 2018 11:59:44 -0700
Message-Id: <262e12b66c238517c4766190dd493d937825f563.1537987801.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1537987801.git.reinette.chatre@intel.com>
References: <cover.1537987801.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1537987801.git.reinette.chatre@intel.com>
References: <cover.1537987801.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Tested-by: Jithu Joseph <jithu.joseph@intel.com>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 51 ++++++++++++++++++++----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index c8c02c16d072..3f56b4e624ea 100644
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
@@ -1033,7 +1032,7 @@ static int __attribute__((unused)) rdt_cdp_peer_get(struct rdt_resource *r,
 }
 
 /**
- * rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
+ * _rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
  * @r: Resource to which domain instance @d belongs.
  * @d: The domain instance for which @closid is being tested.
  * @cbm: Capacity bitmask being tested.
@@ -1049,8 +1048,8 @@ static int __attribute__((unused)) rdt_cdp_peer_get(struct rdt_resource *r,
  *
  * Return: false if CBM does not overlap, true if it does.
  */
-bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
-			   u32 _cbm, int closid, bool exclusive)
+static bool _rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+				   u32 _cbm, int closid, bool exclusive)
 {
 	unsigned long *cbm = (unsigned long *)&_cbm;
 	unsigned long *ctrl_b;
@@ -1087,6 +1086,44 @@ bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
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
+ * Refer to description of _rdtgroup_cbm_overlaps() for the details of the
+ * overlap test.
+ *
+ * Return: true if CBM overlap detected, false if there is no overlap
+ */
+bool rdtgroup_cbm_overlaps(struct rdt_resource *r, struct rdt_domain *d,
+			   u32 _cbm, int closid, bool exclusive)
+{
+	struct rdt_resource *r_cdp;
+	struct rdt_domain *d_cdp;
+	bool ret;
+
+	ret = _rdtgroup_cbm_overlaps(r, d, _cbm, closid, exclusive);
+	if (ret)
+		return ret;
+
+	if (rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp) == 0)
+		return _rdtgroup_cbm_overlaps(r_cdp, d_cdp, _cbm,
+					      closid, exclusive);
+
+	return ret;
+}
+
 /**
  * rdtgroup_mode_test_exclusive - Test if this resource group can be exclusive
  *
-- 
2.17.0

