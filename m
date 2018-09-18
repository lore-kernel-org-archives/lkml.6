Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A67C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B794B20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 21:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B794B20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbeISDSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:18:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35679 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeISDSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:18:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8ILhQGv928589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Sep 2018 14:43:26 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8ILhQcr928586;
        Tue, 18 Sep 2018 14:43:26 -0700
Date:   Tue, 18 Sep 2018 14:43:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-f968dc119a159a95628a20de2a2dcc913d0a82d7@git.kernel.org>
Cc:     mingo@kernel.org, xiaochen.shen@intel.com,
        reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, yu.c.chen@intel.com, hpa@zytor.com,
        fenghua.yu@intel.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, xiaochen.shen@intel.com,
          reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
          tony.luck@intel.com, yu.c.chen@intel.com, fenghua.yu@intel.com,
          hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <1537048707-76280-3-git-send-email-fenghua.yu@intel.com>
References: <20180904174614.26682-1-yu.c.chen@intel.com>
        <1537048707-76280-3-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel_rdt: Fix size reporting of MBA resource
Git-Commit-ID: f968dc119a159a95628a20de2a2dcc913d0a82d7
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

Commit-ID:  f968dc119a159a95628a20de2a2dcc913d0a82d7
Gitweb:     https://git.kernel.org/tip/f968dc119a159a95628a20de2a2dcc913d0a82d7
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Sat, 15 Sep 2018 14:58:20 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Sep 2018 23:38:05 +0200

x86/intel_rdt: Fix size reporting of MBA resource

Chen Yu reported a divide-by-zero error when accessing the 'size'
resctrl file when a MBA resource is enabled.

divide error: 0000 [#1] SMP PTI
CPU: 93 PID: 1929 Comm: cat Not tainted 4.19.0-rc2-debug-rdt+ #25
RIP: 0010:rdtgroup_cbm_to_size+0x7e/0xa0
Call Trace:
rdtgroup_size_show+0x11a/0x1d0
seq_read+0xd8/0x3b0

Quoting Chen Yu's report: This is because for MB resource, the
r->cache.cbm_len is zero, thus calculating size in rdtgroup_cbm_to_size()
will trigger the exception.

Fix this issue in the 'size' file by getting correct memory bandwidth value
which is in MBps when MBA software controller is enabled or in percentage
when MBA software controller is disabled.

Fixes: d9b48c86eb38 ("x86/intel_rdt: Display resource groups' allocations in bytes")
Reported-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chen Yu <yu.c.chen@intel.com>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Tony Luck" <tony.luck@intel.com>
Cc: "Xiaochen Shen" <xiaochen.shen@intel.com>
Link: https://lkml.kernel.org/r/20180904174614.26682-1-yu.c.chen@intel.com
Link: https://lkml.kernel.org/r/1537048707-76280-3-git-send-email-fenghua.yu@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index b799c00bef09..32e8bbdf2400 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1155,8 +1155,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	struct rdt_resource *r;
 	struct rdt_domain *d;
 	unsigned int size;
-	bool sep = false;
-	u32 cbm;
+	bool sep;
+	u32 ctrl;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
@@ -1174,6 +1174,7 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 	}
 
 	for_each_alloc_enabled_rdt_resource(r) {
+		sep = false;
 		seq_printf(s, "%*s:", max_name_width, r->name);
 		list_for_each_entry(d, &r->domains, list) {
 			if (sep)
@@ -1181,8 +1182,13 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 			if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 				size = 0;
 			} else {
-				cbm = d->ctrl_val[rdtgrp->closid];
-				size = rdtgroup_cbm_to_size(r, d, cbm);
+				ctrl = (!is_mba_sc(r) ?
+						d->ctrl_val[rdtgrp->closid] :
+						d->mbps_val[rdtgrp->closid]);
+				if (r->rid == RDT_RESOURCE_MBA)
+					size = ctrl;
+				else
+					size = rdtgroup_cbm_to_size(r, d, ctrl);
 			}
 			seq_printf(s, "%d=%u", d->id, size);
 			sep = true;
