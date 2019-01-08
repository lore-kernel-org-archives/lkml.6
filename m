Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8535C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966D920827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977862;
	bh=V4xGP7AvQceKMyoNwU1chVCiS2JZFGNHAF3N1QNWmWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=obzzlBheMVKr+pn+6VEl+JqrENUJm09xui+xiK0j7KZ5GwmLe4DvceXqo+N5r35XN
	 jkNrxK6r2m3Sfad4KMF5N6mDDMkQPaUcRPC7zRLTyi+ALMUbg2wMM0GBoux+V6wQqC
	 ozYGgWw9d+vGIAGp2d/Cd2Gag5BNg7sZueZT4gQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfAHT2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:28:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:35464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbfAHT20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:28:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5D7220883;
        Tue,  8 Jan 2019 19:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975705;
        bh=V4xGP7AvQceKMyoNwU1chVCiS2JZFGNHAF3N1QNWmWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=beJvIWWYFN1ZPzPG5mu5f8GhagaTkXE0O0tXyObtvvey8jTf7S/ftiAhOQUNnOJgm
         ITyzT9lPkJ+UKI7DFtcN25taPt+l6HdSbstmlP75syKyK3NqEaLYirMYnhGPrJBfDC
         yiLly917iYdV8672IvuU+52/ifrE1NqJJhpSvuxM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, fenghua.yu@intel.com,
        gavin.hindman@intel.com, jithu.joseph@intel.com,
        x86-ml <x86@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 066/117] x86/resctrl: Fix rdt_find_domain() return value and checks
Date:   Tue,  8 Jan 2019 14:25:34 -0500
Message-Id: <20190108192628.121270-66-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

[ Upstream commit 52eb74339a6233c69f4e3794b69ea7c98eeeae1b ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/intel_rdt.c             | 2 +-
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 2 +-
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 44272b7107ad..2d0a565fd0bb 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -421,7 +421,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
 	struct list_head *l;
 
 	if (id < 0)
-		return ERR_PTR(id);
+		return ERR_PTR(-ENODEV);
 
 	list_for_each(l, &r->domains) {
 		d = list_entry(l, struct rdt_domain, list);
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index efa4a519f5e5..c8b72aff55e0 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -467,7 +467,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 
 	r = &rdt_resources_all[resid];
 	d = rdt_find_domain(r, domid, NULL);
-	if (!d) {
+	if (IS_ERR_OR_NULL(d)) {
 		ret = -ENOENT;
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index f27b8115ffa2..951c61367688 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1029,7 +1029,7 @@ static int rdt_cdp_peer_get(struct rdt_resource *r, struct rdt_domain *d,
 	 * peer RDT CDP resource. Hence the WARN.
 	 */
 	_d_cdp = rdt_find_domain(_r_cdp, d->id, NULL);
-	if (WARN_ON(!_d_cdp)) {
+	if (WARN_ON(IS_ERR_OR_NULL(_d_cdp))) {
 		_r_cdp = NULL;
 		ret = -EINVAL;
 	}
-- 
2.19.1

