Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751629AbeBWI3w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 03:29:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49449 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeBWI3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 03:29:50 -0500
Date: Fri, 23 Feb 2018 00:29:17 -0800
From: tip-bot for Samuel Neves <tipbot@zytor.com>
Message-ID: <tip-4596749339e06dc7a424fc08a15eded850ed78b7@git.kernel.org>
Cc: douly.fnst@cn.fujitsu.com, sneves@dei.uc.pt, peterz@infradead.org,
        mingo@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, peterz@infradead.org, sneves@dei.uc.pt,
        douly.fnst@cn.fujitsu.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        hpa@zytor.com
In-Reply-To: <20180221205036.5244-1-sneves@dei.uc.pt>
References: <20180221205036.5244-1-sneves@dei.uc.pt>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/topology: Update the 'cpu cores' field in
 /proc/cpuinfo correctly across CPU hotplug operations
Git-Commit-ID: 4596749339e06dc7a424fc08a15eded850ed78b7
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

Commit-ID:  4596749339e06dc7a424fc08a15eded850ed78b7
Gitweb:     https://git.kernel.org/tip/4596749339e06dc7a424fc08a15eded850ed78b7
Author:     Samuel Neves <sneves@dei.uc.pt>
AuthorDate: Wed, 21 Feb 2018 20:50:36 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 23 Feb 2018 08:47:47 +0100

x86/topology: Update the 'cpu cores' field in /proc/cpuinfo correctly across CPU hotplug operations

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

Tested-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Samuel Neves <sneves@dei.uc.pt>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: jgross@suse.com
Cc: luto@kernel.org
Cc: prarit@redhat.com
Cc: vkuznets@redhat.com
Link: http://lkml.kernel.org/r/20180221205036.5244-1-sneves@dei.uc.pt
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
