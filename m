Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A27C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B5D20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B5D20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754115AbeFTAQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:16:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34799 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751955AbeFTAQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:16:55 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0GpGp3296646
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:16:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0GowM3296643;
        Tue, 19 Jun 2018 17:16:50 -0700
Date:   Tue, 19 Jun 2018 17:16:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-bc61c3ef346945e87fa6312748fd1665c16200b3@git.kernel.org>
Cc:     reinette.chatre@intel.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          reinette.chatre@intel.com, tglx@linutronix.de
In-Reply-To: <cea76188c5b30cffaf89ad5c7efd66a3e7f105d4.1527593970.git.reinette.chatre@intel.com>
References: <cea76188c5b30cffaf89ad5c7efd66a3e7f105d4.1527593970.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Introduce new "exclusive" mode
Git-Commit-ID: bc61c3ef346945e87fa6312748fd1665c16200b3
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

Commit-ID:  bc61c3ef346945e87fa6312748fd1665c16200b3
Gitweb:     https://git.kernel.org/tip/bc61c3ef346945e87fa6312748fd1665c16200b3
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:33 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:29 +0200

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
Link: https://lkml.kernel.org/r/cea76188c5b30cffaf89ad5c7efd66a3e7f105d4.1527593970.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt.h          | 2 ++
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 5f3915c2e599..399bb94e865b 100644
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
index e59c8751293b..43b532bea735 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -161,6 +161,7 @@ enum rdtgrp_mode rdtgroup_mode_by_closid(int closid)
 
 static const char * const rdt_mode_str[] = {
 	[RDT_MODE_SHAREABLE]	= "shareable",
+	[RDT_MODE_EXCLUSIVE]	= "exclusive",
 };
 
 /**
