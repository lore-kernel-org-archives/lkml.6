Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756535AbeDYS11 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:27:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:41714 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755993AbeDYSMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,327,1520924400";
   d="scan'208";a="35243657"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 10/39] x86/intel_rdt: Making CBM name and type more explicit
Date: Wed, 25 Apr 2018 03:09:46 -0700
Message-Id: <bcefd0a827b703a71f221ac577960bf814227c20.1524649902.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1524649902.git.reinette.chatre@intel.com>
References: <cover.1524649902.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cbm_validate() receives a pointer to the variable that will be
initialized with a validated capacity bitmask. The pointer points to a
variable of type unsigned long that is immediately assigned to a
variable of type u32 by the caller on return from cbm_validate().

Let cbm_validate() initialize a variable of type u32 directly.

At this time also change tha variable name "data" within parse_cbm() to
a name more reflective of the content: "cbm_val". This frees up the
generic "data" to be used later when it is indeed used for a collection
of input.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 9e1a455e4d9b..3bd45e6cc9ae 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -86,7 +86,7 @@ int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d)
  *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
  * Additionally Haswell requires at least two bits set.
  */
-static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
 	unsigned long first_bit, zero_bit, val;
 	unsigned int cbm_len = r->cache.cbm_len;
@@ -127,16 +127,17 @@ static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
  */
 int parse_cbm(char *buf, struct rdt_resource *r, struct rdt_domain *d)
 {
-	unsigned long data;
+	u32 cbm_val;
 
 	if (d->have_new_ctrl) {
 		rdt_last_cmd_printf("duplicate domain %d\n", d->id);
 		return -EINVAL;
 	}
 
-	if(!cbm_validate(buf, &data, r))
+	if (!cbm_validate(buf, &cbm_val, r))
 		return -EINVAL;
-	d->new_ctrl = data;
+
+	d->new_ctrl = cbm_val;
 	d->have_new_ctrl = true;
 
 	return 0;
-- 
2.13.6
