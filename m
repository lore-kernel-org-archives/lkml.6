Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752373AbeBUU7C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 15:59:02 -0500
Received: from smtp.dei.uc.pt ([193.137.203.253]:43606 "EHLO smtp.dei.uc.pt"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbeBUU7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:59:00 -0500
From: Samuel Neves <sneves@dei.uc.pt>
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        jgross@suse.com, douly.fnst@cn.fujitsu.com, luto@kernel.org,
        prarit@redhat.com, ak@linux.intel.com, vkuznets@redhat.com,
        linux-kernel@vger.kernel.org
Cc: Samuel Neves <sneves@dei.uc.pt>
Subject: [PATCH] smpboot: correctly update number of booted cores
Date: Wed, 21 Feb 2018 20:50:36 +0000
Message-Id: <20180221205036.5244-1-sneves@dei.uc.pt>
X-Mailer: git-send-email 2.14.3
X-FCTUC-DEI-SIC-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-FCTUC-DEI-SIC-MailScanner-ID: w1LKog2l025096
X-FCTUC-DEI-SIC-MailScanner: Found to be clean
X-FCTUC-DEI-SIC-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-60.1, required 3.252, autolearn=not spam, ALL_TRUSTED -10.00,
        BAYES_00 -0.10, L_SMTP_AUTH -50.00)
X-FCTUC-DEI-SIC-MailScanner-From: sneves@dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this fix, /proc/cpuinfo will display an incorrect amount
of CPU cores, after bringing them offline and online again, as
exemplified below:

$ cat /proc/cpuinfo | grep cores
cpu cores	: 4
cpu cores	: 8
cpu cores	: 8
cpu cores	: 20
cpu cores	: 4
cpu cores	: 3
cpu cores	: 2
cpu cores	: 2

This patch fixes this by always zeroing the booted_cores variable
upon turning off a logical CPU.

Signed-off-by: Samuel Neves <sneves@dei.uc.pt>
---
 arch/x86/kernel/smpboot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 9eee25d07586..ff99e2b6fc54 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1437,6 +1437,7 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
 	c->cpu_core_id = 0;
+	c->booted_cores = 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
 	recompute_smt_state();
 }
-- 
2.14.3
