Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2015C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4499620873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4499620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeK1GsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:48:06 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51175 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725752AbeK1GsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:48:06 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wARJmtpw1993297
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 27 Nov 2018 11:48:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wARJmtdQ1993294;
        Tue, 27 Nov 2018 11:48:55 -0800
Date:   Tue, 27 Nov 2018 11:48:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-456824896de2b68df40b3ea5777ef49dc6cc8fda@git.kernel.org>
Cc:     fenghua.yu@intel.com, mingo@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, x86@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, bp@suse.de,
        reinette.chatre@intel.com
Reply-To: mingo@kernel.org, x86@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, mingo@redhat.com, fenghua.yu@intel.com,
          reinette.chatre@intel.com, bp@suse.de, tony.luck@intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <f48e46a016d6a5c79f13de8faeca382052189e2e.1543346009.git.reinette.chatre@intel.com>
References: <f48e46a016d6a5c79f13de8faeca382052189e2e.1543346009.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Use rdt_last_cmd_puts() where possible
Git-Commit-ID: 456824896de2b68df40b3ea5777ef49dc6cc8fda
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

Commit-ID:  456824896de2b68df40b3ea5777ef49dc6cc8fda
Gitweb:     https://git.kernel.org/tip/456824896de2b68df40b3ea5777ef49dc6cc8fda
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 27 Nov 2018 11:19:36 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 27 Nov 2018 20:39:02 +0100

x86/resctrl: Use rdt_last_cmd_puts() where possible

The last_cmd_status sequence buffer contains user-visible messages
(accessed via /sys/fs/resctrl/info/last_cmd_status) that detail any
errors encountered while interacting with the resctrl filesystem.

rdt_last_cmd_printf() and rdt_last_cmd_puts() are the two calls
available to respectively print a string with format specifiers or a
simple one (which contains no format specifiers) to the last_cmd_status
buffer.

A few occurrences exist where rdt_last_cmd_printf() is used to print
a simple string. Doing so does not result in incorrect result or
incorrect behavior, but rdt_last_cmd_puts() is the function intended to
be used in these cases, as it is faster and it doesn't need to do the
vsnprintf() formatting.

Fix these occurrences to use rdt_last_cmd_puts() instead. While doing
so, fix two typos that were recently introduced into two of these simple
strings.

 [ bp: massage commit message and correct typos. ]

Fixes: 723f1a0dd8e2 ("x86/resctrl: Fixup the user-visible strings")
Fixes: e0bdfe8e36f3 ("x86/intel_rdt: Support creation/removal of pseudo-locked region")
Fixes: 9ab9aa15c309 ("x86/intel_rdt: Ensure requested schemata respects mode")
Fixes: d48d7a57f718 ("x86/intel_rdt: Introduce resource group's mode resctrl file")
Fixes: dfe9674b04ff ("x86/intel_rdt: Enable entering of pseudo-locksetup mode")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: babu.moger@amd.com
Cc: jithu.joseph@intel.com
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/f48e46a016d6a5c79f13de8faeca382052189e2e.1543346009.git.reinette.chatre@intel.com
---
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
 
