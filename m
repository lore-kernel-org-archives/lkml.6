Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbeBWCkK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 21:40:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:47173 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751274AbeBWCkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 21:40:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,381,1515484800";
   d="scan'208";a="206298548"
From: "Fenghua Yu" <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Tony Luck" <tony.luck@intel.com>,
        "Shivappa, Vikas" <vikas.shivappa@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Xiaochen Shen" <xiaochen.shen@intel.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>, "x86" <x86@kernel.org>,
        Wang Hui <john.wanghui@huawei.com>,
        Zhang Yanfei <yanfei.zhang@huawei.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] x86/intel_rdt: Fix incorrect returned value when creating rdgroup sub-directory in resctrl file system
Date: Thu, 22 Feb 2018 19:26:03 -0800
Message-Id: <1519356363-133085-1-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hui <john.wanghui@huawei.com>

If no monitoring feature is detected because all monitoring features are
disabled during boot time or there is no monitoring feature in hardware,
creating rdtgroup sub-directory by "mkdir" command reports error:

#mkdir /sys/fs/resctrl/p1
mkdir: cannot create directory ‘/sys/fs/resctrl/p1’: No such file or
directory

But the sub-directory actually is generated and content is correct:

#ls /sys/fs/resctrl/p1
cpus  cpus_list  schemata  tasks

The error is because rdtgroup_mkdir_ctrl_mon() returns non zero value after
the sub-directory is created and the returned value is reported as an error
to user.

Clear the returned value to report to user that the sub-directory is
actually created successfully.

Signed-off-by: Wang Hui <john.wanghui@huawei.com>
Signed-off-by: Zhang Yanfei <yanfei.zhang@huawei.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
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
-- 
2.5.0
