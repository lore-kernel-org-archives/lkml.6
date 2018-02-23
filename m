Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeBWHUS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:20:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38511 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeBWHUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:20:16 -0500
Date: Thu, 22 Feb 2018 23:19:48 -0800
From: tip-bot for Wang Hui <tipbot@zytor.com>
Message-ID: <tip-36e74d355297dde6e69a39c838d24710e442babe@git.kernel.org>
Cc: ravi.v.shankar@intel.com, tony.luck@intel.com,
        vikas.shivappa@intel.com, yanfei.zhang@huawei.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        xiaochen.shen@intel.com, john.wanghui@huawei.com, hpa@zytor.com,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Reply-To: mingo@kernel.org, xiaochen.shen@intel.com, john.wanghui@huawei.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        peterz@infradead.org, tglx@linutronix.de, ravi.v.shankar@intel.com,
        tony.luck@intel.com, vikas.shivappa@intel.com, yanfei.zhang@huawei.com,
        torvalds@linux-foundation.org
In-Reply-To: <1519356363-133085-1-git-send-email-fenghua.yu@intel.com>
References: <1519356363-133085-1-git-send-email-fenghua.yu@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/intel_rdt: Fix incorrect returned value when
 creating rdgroup sub-directory in resctrl file system
Git-Commit-ID: 36e74d355297dde6e69a39c838d24710e442babe
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  36e74d355297dde6e69a39c838d24710e442babe
Gitweb:     https://git.kernel.org/tip/36e74d355297dde6e69a39c838d24710e442babe
Author:     Wang Hui <john.wanghui@huawei.com>
AuthorDate: Thu, 22 Feb 2018 19:26:03 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Feb 2018 08:03:21 +0100

x86/intel_rdt: Fix incorrect returned value when creating rdgroup sub-directory in resctrl file system

If no monitoring feature is detected because all monitoring features are
disabled during boot time or there is no monitoring feature in hardware,
creating rdtgroup sub-directory by "mkdir" command reports error:

  mkdir: cannot create directory ‘/sys/fs/resctrl/p1’: No such file or directory

But the sub-directory actually is generated and content is correct:

  cpus  cpus_list  schemata  tasks

The error is because rdtgroup_mkdir_ctrl_mon() returns non zero value after
the sub-directory is created and the returned value is reported as an error
to user.

Clear the returned value to report to user that the sub-directory is
actually created successfully.

Signed-off-by: Wang Hui <john.wanghui@huawei.com>
Signed-off-by: Zhang Yanfei <yanfei.zhang@huawei.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vikas <vikas.shivappa@intel.com>
Cc: Xiaochen Shen <xiaochen.shen@intel.com>
Link: http://lkml.kernel.org/r/1519356363-133085-1-git-send-email-fenghua.yu@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/intel_rdt_rdtgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
index bdab7d2f51af..fca759d272a1 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
@@ -1804,6 +1804,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 		goto out_common_fail;
 	}
 	closid = ret;
+	ret = 0;
 
 	rdtgrp->closid = closid;
 	list_add(&rdtgrp->rdtgroup_list, &rdt_all_groups);
