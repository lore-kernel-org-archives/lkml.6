Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06015C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAEA2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAEA2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeK1GTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:19:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:55764 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbeK1GTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:19:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 11:20:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="94357239"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga008.fm.intel.com with ESMTP; 27 Nov 2018 11:20:20 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     jithu.joseph@intel.com, mingo@redhat.com, hpa@zytor.com,
        babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V2] x86/resctrl: Fix rdt_last_cmd_printf() usage and typos within
Date:   Tue, 27 Nov 2018 11:19:36 -0800
Message-Id: <f48e46a016d6a5c79f13de8faeca382052189e2e.1543346009.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last_cmd_status seq_buf contains user visible messages (accessed
via /sys/fs/resctrl/info/last_cmd_status) that details any errors
encountered while interacting with the resctrl filesystem.

rdt_last_cmd_puts() and rdt_last_cmd_printf() are the two calls
available to respectively print an unformatted or formatted string
to the last_cmd_status buffer.

A few occurences exist where rdt_last_cmd_printf() is used to print
an unformatted string. Using rdt_last_cmd_printf() to print a simple
string does not result in incorrect result or incorrect behavior, but
rdt_last_cmd_puts() is the function intended to be used in these cases.
Fix these occurences to use rdt_last_cmd_puts() instead. While doing
so fix two typos that were recently introduced into two of these simple
strings.

Fixes: 723f1a0dd8e2 ("x86/resctrl: Fixup the user-visible strings")
Fixes: e0bdfe8e36f3 ("x86/intel_rdt: Support creation/removal of pseudo-locked region")
Fixes: 9ab9aa15c309 ("x86/intel_rdt: Ensure requested schemata respects mode")
Fixes: d48d7a57f718 ("x86/intel_rdt: Introduce resource group's mode resctrl file")
Fixes: dfe9674b04ff ("x86/intel_rdt: Enable entering of pseudo-locksetup mode")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
V2:
- Fix commit message to clarify why rdt_last_cmd_printf() is changed
  to rdt_last_cmd_puts().

 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 8 ++++----
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 43ee3cee6494..03ee13235a45 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -215,7 +215,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	 */
 	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
 	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
-		rdt_last_cmd_printf("Pseudo-locked region in hierarchy\n");
+		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
 		return -EINVAL;
 	}
 
@@ -225,7 +225,7 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
 	     rdtgrp->mode == RDT_MODE_SHAREABLE) &&
 	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
-		rdt_last_cmd_printf("CBM overlaps with pseudo-locked region\n");
+		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
 		return -EINVAL;
 	}
 
@@ -234,14 +234,14 @@ int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
 	 * either is exclusive.
 	 */
 	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, true)) {
-		rdt_last_cmd_printf("Overlaps with exclusive group\n");
+		rdt_last_cmd_puts("Overlaps with exclusive group\n");
 		return -EINVAL;
 	}
 
 	if (rdtgroup_cbm_overlaps(r, d, cbm_val, rdtgrp->closid, false)) {
 		if (rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
 		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
-			rdt_last_cmd_printf("0verlaps with other group\n");
+			rdt_last_cmd_puts("Overlaps with other group\n");
 			return -EINVAL;
 		}
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 61b102dd51a5..017505017bdb 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1206,7 +1206,7 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 		goto out;
 
 	if (mode == RDT_MODE_PSEUDO_LOCKED) {
-		rdt_last_cmd_printf("Cannot change pseudo-locked group\n");
+		rdt_last_cmd_puts("Cannot change pseudo-locked group\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1235,7 +1235,7 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 			goto out;
 		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
 	} else {
-		rdt_last_cmd_printf("Unknown orunsupported mode\n");
+		rdt_last_cmd_puts("Unknown or unsupported mode\n");
 		ret = -EINVAL;
 	}
 
-- 
2.17.0

