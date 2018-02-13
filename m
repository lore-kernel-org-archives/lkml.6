Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966345AbeBMXu4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:50:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:53398 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966225AbeBMXtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822345"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 15/22] x86/intel_rdt: Prevent new allocations from pseudo-locked regions
Date: Tue, 13 Feb 2018 07:46:59 -0800
Message-Id: <d191d4bad87aa8eed8ab63df923181e25ed2218a.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user requests a new cache allocation we need to enforce that it
does not intersect with an existing pseudo-locked region. An allocation
with a bitmask intersection with a pseudo-locked region will enable
cache allocations to that region and thus evict pseudo-locked data.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 4a11aea3ad2c..4f823d631345 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -136,8 +136,10 @@ static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 }
 
 /*
- * Read one cache bit mask (hex). Check that it is valid for the current
- * resource type.
+ * Read one cache bit mask (hex). Check that it is valid and available for
+ * the current resource type. While CAT allows CBM to overlap amongst
+ * classes of service we do not allow a CBM to overlap with a region that has
+ * been pseudo-locked.
  */
 int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d)
 {
@@ -150,6 +152,8 @@ int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d)
 
 	if(!cbm_validate(buf, &data, r))
 		return -EINVAL;
+	if (cbm_pseudo_locked(data, d))
+		return -EINVAL;
 	d->new_ctrl = data;
 	d->have_new_ctrl = true;
 
-- 
2.13.6
