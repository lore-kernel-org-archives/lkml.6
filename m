Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D982EC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FDA213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FDA213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeJDFI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:08:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:62846 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbeJDFI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:08:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 15:18:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,337,1534834800"; 
   d="scan'208";a="91965084"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2018 15:17:42 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc:     jithu.joseph@intel.com, gavin.hindman@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2 1/3] x86/intel_rdt: Introduce utility to obtain CDP peer
Date:   Wed,  3 Oct 2018 15:17:01 -0700
Message-Id: <9b4bc4d59ba2e903b6a3eb17e16ef41a8e7b7c3e.1538603665.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1538603665.git.reinette.chatre@intel.com>
References: <cover.1538603665.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1538603665.git.reinette.chatre@intel.com>
References: <cover.1538603665.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a utility that, when provided with a RDT resource and an
instance of this RDT resource (a RDT domain), would return pointers to
the RDT resource and RDT domain that share the same hardware. This is
specific to the CDP resources that share the same hardware.

For example, if a pointer to the RDT_RESOURCE_L2DATA resource (struct
rdt_resource) and a pointer to an instance of this resource (struct
rdt_domain) is provided, then it will return a pointer to the
RDT_RESOURCE_L2CODE resource as well as the specific instance that
shares the same hardware as the provided rdt_domain.

This utility is created in support of the "exclusive" resource group
mode where overlap of resource allocation between resource groups need
to be avoided. The overlap test need to consider not just the matching
resources, but also the resources that share the same hardware.

Temporarily mark it as unused in support of patch testing to avoid
compile warnings until it is used.

Fixes: 49f7b4efa110 ("x86/intel_rdt: Enable setting of exclusive mode")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Jithu Joseph <jithu.joseph@intel.com>
Acked-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 72 ++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 1b8e86a5d5e1..fe6cad68f814 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -960,6 +960,78 @@ static int rdtgroup_mode_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+/**
+ * rdt_cdp_peer_get - Retrieve CDP peer if it exists
+ * @r: RDT resource to which RDT domain @d belongs
+ * @d: Cache instance for which a CDP peer is requested
+ * @r_cdp: RDT resource that shares hardware with @r (RDT resource peer)
+ *         Used to return the result.
+ * @d_cdp: RDT domain that shares hardware with @d (RDT domain peer)
+ *         Used to return the result.
+ *
+ * RDT resources are managed independently and by extension the RDT domains
+ * (RDT resource instances) are managed independently also. The Code and
+ * Data Prioritization (CDP) RDT resources, while managed independently,
+ * could refer to the same underlying hardware. For example,
+ * RDT_RESOURCE_L2CODE and RDT_RESOURCE_L2DATA both refer to the L2 cache.
+ *
+ * When provided with an RDT resource @r and an instance of that RDT
+ * resource @d rdt_cdp_peer_get() will return if there is a peer RDT
+ * resource and the exact instance that shares the same hardware.
+ *
+ * Return: 0 if a CDP peer was found, <0 on error or if no CDP peer exists.
+ *         If a CDP peer was found, @r_cdp will point to the peer RDT resource
+ *         and @d_cdp will point to the peer RDT domain.
+ */
+static int __attribute__((unused)) rdt_cdp_peer_get(struct rdt_resource *r,
+						    struct rdt_domain *d,
+						    struct rdt_resource **r_cdp,
+						    struct rdt_domain **d_cdp)
+{
+	struct rdt_resource *_r_cdp = NULL;
+	struct rdt_domain *_d_cdp = NULL;
+	int ret = 0;
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L3DATA:
+		_r_cdp = &rdt_resources_all[RDT_RESOURCE_L3CODE];
+		break;
+	case RDT_RESOURCE_L3CODE:
+		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L3DATA];
+		break;
+	case RDT_RESOURCE_L2DATA:
+		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2CODE];
+		break;
+	case RDT_RESOURCE_L2CODE:
+		_r_cdp =  &rdt_resources_all[RDT_RESOURCE_L2DATA];
+		break;
+	default:
+		ret = -ENOENT;
+		goto out;
+	}
+
+	/*
+	 * When a new CPU comes online and CDP is enabled then the new
+	 * RDT domains (if any) associated with both CDP RDT resources
+	 * are added in the same CPU online routine while the
+	 * rdtgroup_mutex is held. It should thus not happen for one
+	 * RDT domain to exist and be associated with its RDT CDP
+	 * resource but there is no RDT domain associated with the
+	 * peer RDT CDP resource. Hence the WARN.
+	 */
+	_d_cdp = rdt_find_domain(_r_cdp, d->id, NULL);
+	if (WARN_ON(!_d_cdp)) {
+		_r_cdp = NULL;
+		ret = -EINVAL;
+	}
+
+out:
+	*r_cdp = _r_cdp;
+	*d_cdp = _d_cdp;
+
+	return ret;
+}
+
 /**
  * rdtgroup_cbm_overlaps - Does CBM for intended closid overlap with other
  * @r: Resource to which domain instance @d belongs.
-- 
2.17.0

