Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B24C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD01215E6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD01215E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934016AbeFVWnA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:43:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:52517 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933780AbeFVWmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843381"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V7 11/41] x86/intel_rdt: Making CBM name and type more explicit
Date:   Fri, 22 Jun 2018 15:42:02 -0700
Message-Id: <5e29cf0209ea2deac9beacd35cbe5239a50959fb.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cbm_validate() receives a pointer to the variable that will be initialized
with a validated capacity bitmask. The pointer points to a variable of type
unsigned long that is immediately assigned to a variable of type u32 by the
caller on return from cbm_validate().

Let cbm_validate() initialize a variable of type u32 directly.

At this time also change tha variable name "data" within parse_cbm() to a
name more reflective of the content: "cbm_val". This frees up the generic
"data" to be used later when it is indeed used for a collection of input.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/d08cc1fa859f5751fd815ed8ef5499170badc9e5.1527593970.git.reinette.chatre@intel.com
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
2.17.0

