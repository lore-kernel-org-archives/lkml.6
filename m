Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751443AbeC3Jyp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:54:45 -0400
Received: from zxshcas1.zhaoxin.com ([180.169.121.91]:11863 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751053AbeC3Jym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:54:42 -0400
From: David Wang <davidwang@zhaoxin.com>
To: <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>,
        David Wang <davidwang@zhaoxin.com>
Subject: [PATCH 1/2] x86/mce: new centaur CPUs support MCE broadcasting
Date: Fri, 30 Mar 2018 17:53:41 +0800
Message-ID: <1522403622-31146-2-git-send-email-davidwang@zhaoxin.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1522403622-31146-1-git-send-email-davidwang@zhaoxin.com>
References: <1522403622-31146-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.29.8.54]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is used to tell the kernel that newer Centaur CPU support MCE
broadcasting.

Signed-off-by: David Wang <davidwang@zhaoxin.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index 7065846..82b25e1 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1688,6 +1688,17 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		if (c->x86 == 6 && c->x86_model == 45)
 			quirk_no_way_out = quirk_sandybridge_ifu;
 	}
+
+	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
+		/*
+		 * All newer centaur CPUs support MCE broadcasting. Enable
+		 * synchronization with a one second timeout.
+		 */
+		if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model == 0xf && c->x86_mask >=0xe)) &&
+			cfg->monarch_timeout < 0)
+			cfg->monarch_timeout = USEC_PER_SEC;
+	}
+
 	if (cfg->monarch_timeout < 0)
 		cfg->monarch_timeout = 0;
 	if (cfg->bootlog != 0)
-- 
1.9.1
