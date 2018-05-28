Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031876AbeE1KSu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968610AbeE1KSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:18:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, jgross@suse.com, luto@kernel.org,
        prarit@redhat.com, vkuznets@redhat.com, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 104/268] x86/topology: Update the cpu cores field in /proc/cpuinfo correctly across CPU hotplug operations
Date: Mon, 28 May 2018 12:01:18 +0200
Message-Id: <20180528100213.970408848@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samuel Neves <sneves@dei.uc.pt>

[ Upstream commit 4596749339e06dc7a424fc08a15eded850ed78b7 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/smpboot.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1344,6 +1344,7 @@ static void remove_siblinginfo(int cpu)
 	cpumask_clear(topology_core_cpumask(cpu));
 	c->phys_proc_id = 0;
 	c->cpu_core_id = 0;
+	c->booted_cores = 0;
 	cpumask_clear_cpu(cpu, cpu_sibling_setup_mask);
 }
 
