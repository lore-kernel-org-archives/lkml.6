Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C56C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C6E2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C6E2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754172AbeFTAVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:21:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53479 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752707AbeFTAVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:21:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K0Lc2q3297537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 17:21:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K0LcNV3297534;
        Tue, 19 Jun 2018 17:21:38 -0700
Date:   Tue, 19 Jun 2018 17:21:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-4d6959cf503a2a7395216f4bb14fb5409468fac9@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, reinette.chatre@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          tglx@linutronix.de, reinette.chatre@intel.com
In-Reply-To: <c8b54235b16f40b74fded417f5b6151afe8f27b1.1527593970.git.reinette.chatre@intel.com>
References: <c8b54235b16f40b74fded417f5b6151afe8f27b1.1527593970.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Respect read and write access
Git-Commit-ID: 4d6959cf503a2a7395216f4bb14fb5409468fac9
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

Commit-ID:  4d6959cf503a2a7395216f4bb14fb5409468fac9
Gitweb:     https://git.kernel.org/tip/4d6959cf503a2a7395216f4bb14fb5409468fac9
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 29 May 2018 05:57:42 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 00:56:33 +0200

x86/intel_rdt: Respect read and write access

By default, if the opener has CAP_DAC_OVERRIDE, a kernfs file can be opened
regardless of RW permissions. Writing to a kernfs file will thus succeed
even if permissions are 0000.

It's required to restrict the actions that can be performed on a resource
group from userspace based on the mode of the resource group.  This
restriction will be done through a modification of the file
permissions. That is, for example, if a resource group is locked then the
user cannot add tasks to the resource group.

For this restriction through file permissions to work it has to be ensured
that the permissions are always respected. To do so the resctrl filesystem
is created with the KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK flag that will result
in open(2) failing with -EACCESS regardless of CAP_DAC_OVERRIDE if the
permission does not have the respective read or write access.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com
Cc: jithu.joseph@intel.com
Cc: dave.hansen@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/c8b54235b16f40b74fded417f5b6151afe8f27b1.1527593970.git.reinette.chatre@intel.com

---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index 9e69f4dbc686..0ddb455b126d 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2537,7 +2537,8 @@ static int __init rdtgroup_setup_root(void)
 	int ret;
 
 	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
-				      KERNFS_ROOT_CREATE_DEACTIVATED,
+				      KERNFS_ROOT_CREATE_DEACTIVATED |
+				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
 				      &rdtgroup_default);
 	if (IS_ERR(rdt_root))
 		return PTR_ERR(rdt_root);
