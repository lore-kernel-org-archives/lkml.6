Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeEVTkB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:40:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:16706 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752276AbeEVTcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:32:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="226406386"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc: gavin.hindman@intel.com, jithu.joseph@intel.com, dave.hansen@intel.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V4 17/38] x86/intel_rdt: Respect read and write access
Date: Tue, 22 May 2018 04:29:05 -0700
Message-Id: <e0a19c0bf8a9ba4f8acb16386ec18d39f46d735c.1526987654.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1526987654.git.reinette.chatre@intel.com>
References: <cover.1526987654.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, if the opener has CAP_DAC_OVERRIDE, a kernfs file can be
opened regardless of RW permissions. Writing to a kernfs file will thus
succeed even if permissions are 0000.

We would like to restrict the actions that can be performed on a
resource group from userspace based on the mode of the resource group.
This restriction will be done through a modification of the file
permissions. That is, for example, if a resource group is locked then
the user cannot add tasks to the resource group.

For this restriction through file permissions to work we have to ensure
that the permissions are always respected. To do so the resctrl
filesystem is created with the KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK flag
that will result in open(2) failing with -EACCESS regardless of
CAP_DAC_OVERRIDE if the permission does not have the respective read or
write access.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index e6069822f592..7d623d940e49 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -2491,7 +2491,8 @@ static int __init rdtgroup_setup_root(void)
 	int ret;
 
 	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
-				      KERNFS_ROOT_CREATE_DEACTIVATED,
+				      KERNFS_ROOT_CREATE_DEACTIVATED |
+				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
 				      &rdtgroup_default);
 	if (IS_ERR(rdt_root))
 		return PTR_ERR(rdt_root);
-- 
2.13.6
