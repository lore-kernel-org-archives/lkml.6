Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeEVTh6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:37:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:16707 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752498AbeEVTcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:32:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="226406365"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V4 10/38] x86/intel_rdt: Making CBM name and type more explicit
Date: Tue, 22 May 2018 04:28:58 -0700
Message-Id: <d08cc1fa859f5751fd815ed8ef5499170badc9e5.1526987654.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
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
index 2c23bb136ccc..b3da5b981dd8 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -87,7 +87,7 @@ int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d)
  *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
  * Additionally Haswell requires at least two bits set.
  */
-static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 {
 	unsigned long first_bit, zero_bit, val;
 	unsigned int cbm_len = r->cache.cbm_len;
@@ -128,16 +128,17 @@ static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
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
