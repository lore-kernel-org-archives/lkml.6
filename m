Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA08C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3A42086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3A42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeLKVQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:16:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33273 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKVQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:16:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBLFvHJ4154914
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 13:15:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBLFvAZ4154911;
        Tue, 11 Dec 2018 13:15:57 -0800
Date:   Tue, 11 Dec 2018 13:15:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-52eb74339a6233c69f4e3794b69ea7c98eeeae1b@git.kernel.org>
Cc:     bp@suse.de, tony.luck@intel.com, reinette.chatre@intel.com,
        hpa@zytor.com, mingo@kernel.org, x86@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: reinette.chatre@intel.com, bp@suse.de, tony.luck@intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@redhat.com, hpa@zytor.com, mingo@kernel.org, x86@kernel.org
In-Reply-To: <b88cd4ff6a75995bf8db9b0ea546908fe50f69f3.1544479852.git.reinette.chatre@intel.com>
References: <b88cd4ff6a75995bf8db9b0ea546908fe50f69f3.1544479852.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Fix rdt_find_domain() return value and
 checks
Git-Commit-ID: 52eb74339a6233c69f4e3794b69ea7c98eeeae1b
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

Commit-ID:  52eb74339a6233c69f4e3794b69ea7c98eeeae1b
Gitweb:     https://git.kernel.org/tip/52eb74339a6233c69f4e3794b69ea7c98eeeae1b
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Mon, 10 Dec 2018 14:31:13 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 11 Dec 2018 22:09:28 +0100

x86/resctrl: Fix rdt_find_domain() return value and checks

rdt_find_domain() returns an ERR_PTR() that is generated from a provided
domain id when the value is negative.

Care needs to be taken when creating an ERR_PTR() from this value
because a subsequent check using IS_ERR() expects the error to
be within the MAX_ERRNO range. Using an invalid domain id as an
ERR_PTR() does work at this time since this is currently always -1.
Using this undocumented assumption is fragile since future users of
rdt_find_domain() may not be aware of thus assumption.

Two related issues are addressed:

- Ensure that rdt_find_domain() always returns a valid error value by
forcing the error to be -ENODEV when a negative domain id is provided.

- In a few instances the return value of rdt_find_domain() is just
checked for NULL - fix these to include a check of ERR_PTR.

Fixes: d89b7379015f ("x86/intel_rdt/cqm: Add mon_data")
Fixes: 521348b011d6 ("x86/intel_rdt: Introduce utility to obtain CDP peer")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: fenghua.yu@intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/b88cd4ff6a75995bf8db9b0ea546908fe50f69f3.1544479852.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c        | 2 +-
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 2ec252be4ed9..c3a9dc63edf2 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -454,7 +454,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	struct list_head *l;
 
 	if (id < 0)
-		return ERR_PTR(id);
+		return ERR_PTR(-ENODEV);
 
 	list_for_each(l, &r->domains) {
 		d = list_entry(l, struct rdt_domain, list);
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index ba11f54f5ab8..3b943ace786c 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -534,7 +534,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 	r = &rdt_resources_all[resid];
 	d = rdt_find_domain(r, domid, NULL);
-	if (!d) {
+	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 017505017bdb..8388adf241b2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1029,7 +1029,7 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 	 * peer RDT CDP resource. Hence the WARN.
 	 */
 	_d_cdp = rdt_find_domain(_r_cdp, d->id, NULL);
-	if (WARN_ON(!_d_cdp)) {
+	if (WARN_ON(IS_ERR_OR_NULL(_d_cdp))) {
 		_r_cdp = NULL;
 		ret = -EINVAL;
 	}
