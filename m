Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37048C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BFF24BD6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BFF24BD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbeFWMQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:16:22 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43269 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751771AbeFWMQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:16:18 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWhSY-0005Gx-3c; Sat, 23 Jun 2018 14:16:06 +0200
Date:   Sat, 23 Jun 2018 14:16:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     fenghua.yu@intel.com, Tony Luck <tony.luck@intel.com>,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH V7 00/41] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
Message-ID: <alpine.DEB.2.21.1806231402500.8650@nanos.tec.linutronix.de>
References: <cover.1529706536.git.reinette.chatre@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reinette!

On Fri, 22 Jun 2018, Reinette Chatre wrote:
> The Cache Pseudo-Locking enabling series that was recently merged to the
> x86/cache branch of tip was found to conflict with the new kernfs support
> for mounting with fs_context.
> 
> In preparation for a conflict-free merge between the two repos some no-op
> hooks are created within the RDT mount function being changed by
> the two features. The goal is for this commit to be placed on a minimal
> no-rebase branch to be consumed by both features.

Thanks for doing this so quick! I've picked up the lot and slightly
modified the first patch by moving the stubs to the header file to get them
completely out of the conflicting area.

The immutable branch for David to pull is:

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git for-vfs

I've also created a branch based on Davids mount-context branch, applied
the cleanup patch below to it and merged the for-vfs branch on top.

David feel free to pull the result from

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git for-vfs-merged

or pick up the patch below and do the merge and conflict resolution yourself.

The x86/cache branch is rebased and merges cleanly with for-vfs-merged. The
last two patches are dropped; I folded them back to the patches they fix.

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache

Reinette, can you please verify that x86/cache + for-vfs-merged are doing
the right thing?

Thanks,

	tglx

8<----------------------------
Subject: x86/intel_rdt: Mop up the fs_context conversion
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sat, 23 Jun 2018 12:27:32 +0200

 - Stick the struct into the local header file and not at some random place in
   the source.

 - Get rid of the fugly camel case

 - Move the enablement into a separate function

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Howells <dhowells@redhat.com>
---
 arch/x86/kernel/cpu/intel_rdt.h          |   15 ++++++++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c |   54 ++++++++++++-------------------
 2 files changed, 36 insertions(+), 33 deletions(-)

--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -33,6 +33,21 @@
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
 
+
+struct rdt_fs_context {
+	struct kernfs_fs_context	kfc;
+	bool				enable_cdpl2;
+	bool				enable_cdpl3;
+	bool				enable_mba_mbps;
+};
+
+static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
+{
+	struct kernfs_fs_context *kfc = fc->fs_private;
+
+	return container_of(kfc, struct rdt_fs_context, kfc);
+}
+
 DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
 
 /**
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -36,20 +36,6 @@
 #include <asm/intel_rdt_sched.h>
 #include "intel_rdt.h"
 
-struct rdt_fs_context {
-	struct kernfs_fs_context kfc;
-	bool	enable_cdpl2;
-	bool	enable_cdpl3;
-	bool	enable_mba_MBps;
-};
-
-static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
-{
-	struct kernfs_fs_context *kfc = fc->fs_private;
-
-	return container_of(kfc, struct rdt_fs_context, kfc);
-}
-
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
@@ -1213,6 +1199,22 @@ static int mkdir_mondata_all(struct kern
 			     struct rdtgroup *prgrp,
 			     struct kernfs_node **mon_data_kn);
 
+static int rdt_enable_ctx(struct rdt_fs_context *ctx)
+{
+	int ret = 0;
+
+	if (ctx->enable_cdpl2)
+		ret = cdpl2_enable();
+
+	if (!ret && ctx->enable_cdpl3)
+		ret = cdpl3_enable();
+
+	if (!ret && ctx->enable_mba_mbps)
+		ret = set_mba_sc(true);
+
+	return ret;
+}
+
 static int rdt_get_tree(struct fs_context *fc)
 {
 	struct rdt_fs_context *ctx = rdt_fc2context(fc);
@@ -1230,24 +1232,10 @@ static int rdt_get_tree(struct fs_contex
 		goto out;
 	}
 
-	if (ctx->enable_cdpl2) {
-		ret = cdpl2_enable();
-		if (ret < 0)
-			goto out_cdp;
-	}
-
-	if (ctx->enable_cdpl3) {
-		ret = cdpl3_enable();
-		if (ret < 0)
-			goto out_cdp;
-	}
+	ret = rdt_enable_ctx(ctx);
+	if (ret < 0)
+		goto out_cdp;
 
-	if (ctx->enable_mba_MBps) {
-		ret = set_mba_sc(true);
-		if (ret < 0)
-			goto out_cdp;
-	}
-	
 	closid_init();
 
 	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
@@ -1299,7 +1287,7 @@ static int rdt_get_tree(struct fs_contex
 out_info:
 	kernfs_remove(kn_info);
 out_mba:
-	if (ctx->enable_mba_MBps)
+	if (ctx->enable_mba_mbps)
 		set_mba_sc(false);
 out_cdp:
 	cdp_disable_all();
@@ -1323,7 +1311,7 @@ static int rdt_parse_option(struct fs_co
 		return 0;
 	}
 	if (strcmp(opt, "mba_MBps") == 0) {
-		ctx->enable_mba_MBps = true;
+		ctx->enable_mba_mbps = true;
 		return 0;
 	}
 


