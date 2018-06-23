Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C29C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990DD24BAF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 12:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990DD24BAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeFWMLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 08:11:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35713 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbeFWMLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 08:11:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5NCBPA4463670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Jun 2018 05:11:25 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5NCBPKm463667;
        Sat, 23 Jun 2018 05:11:25 -0700
Date:   Sat, 23 Jun 2018 05:11:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-414dd2b4732949ddc972c2592a13c799434249c6@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, reinette.chatre@intel.com
Reply-To: tglx@linutronix.de, reinette.chatre@intel.com, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <f6d24672a4280fe3b24cd2da9b5f50214439c1af.1529706536.git.reinette.chatre@intel.com>
References: <f6d24672a4280fe3b24cd2da9b5f50214439c1af.1529706536.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Introduce new "exclusive" mode
Git-Commit-ID: 414dd2b4732949ddc972c2592a13c799434249c6
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

Commit-ID:  414dd2b4732949ddc972c2592a13c799434249c6
Gitweb:     https://git.kernel.org/tip/414dd2b4732949ddc972c2592a13c799434249c6
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Fri, 22 Jun 2018 15:42:00 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Jun 2018 13:03:42 +0200

x86/intel_rdt: Introduce new "exclusive" mode

At the moment all allocations are shareable. There is no way for a user to
designate that an allocation associated with a resource group cannot be
shared by another.

Introduce the new mode "exclusive". When a resource group is marked as such
it implies that no overlap is allowed between its allocation and that of
another resource group.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/f6d24672a4280fe3b24cd2da9b5f50214439c1af.1529706536.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h          | 2 ++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index f2fbf4059b3f..c9033fd774d5 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -83,6 +83,7 @@ enum rdt_group_type {
 /**
  * enum rdtgrp_mode - Mode of a RDT resource group
  * @RDT_MODE_SHAREABLE: This resource group allows sharing of its allocations
+ * @RDT_MODE_EXCLUSIVE: No sharing of this resource group's allocations allowed
  *
  * The mode of a resource group enables control over the allowed overlap
  * between allocations associated with different resource groups (classes
@@ -91,6 +92,7 @@ enum rdt_group_type {
  */
 enum rdtgrp_mode {
 	RDT_MODE_SHAREABLE = 0,
+	RDT_MODE_EXCLUSIVE,
 
 	/* Must be last */
 	RDT_NUM_MODES,
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 80ac09cf978b..910febef55e8 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -161,6 +161,7 @@ enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
 
 static const char * const rdt_mode_str[] = {
 	[RDT_MODE_SHAREABLE]	= "shareable",
+	[RDT_MODE_EXCLUSIVE]	= "exclusive",
 };
 
 /**
