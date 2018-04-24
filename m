Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeDXTyi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:54:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750735AbeDXTyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:54:37 -0400
Date: Tue, 24 Apr 2018 21:54:29 +0200
From: Jesper Dangaard Brouer <brouer@redhat.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: brouer@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Ahern <dsa@cumulusnetworks.com>
Subject: Boot failures with net-next after rebase to v4.17.0-rc1
Message-ID: <20180424215429.1de8b1b3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm experiencing boot failures with net-next git-tree after it got
rebased/merged with Linus'es tree at v4.17.0-rc1.

The boot problem only occurs for certain kernel configs. I've bisected
the config problem down to enabling CONFIG_PREEMPT=y and resulting
dependencies in below diff.

Is this a know problem?
Have others experienced this too?

This happens for me on two different (x86_64) testlab machines...
I also tested on Linus'es tree at v4.17-rc2, and problem also exists
for me there.
-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer


--- config21-steps-works        2018-04-24 21:33:42.353751894 +0200
+++ config20-steps-bad  2018-04-24 21:27:19.852654328 +0200
@@ -131,7 +131,7 @@
 #
 # RCU Subsystem
 #
-CONFIG_TREE_RCU=y
+CONFIG_PREEMPT_RCU=y
 # CONFIG_RCU_EXPERT is not set
 CONFIG_SRCU=y
 CONFIG_TREE_SRCU=y
@@ -421,11 +421,7 @@
 CONFIG_BFQ_GROUP_IOSCHED=y
 CONFIG_PREEMPT_NOTIFIERS=y
 CONFIG_ASN1=y
-CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
-CONFIG_INLINE_READ_UNLOCK=y
-CONFIG_INLINE_READ_UNLOCK_IRQ=y
-CONFIG_INLINE_WRITE_UNLOCK=y
-CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
+CONFIG_UNINLINE_SPIN_UNLOCK=y
 CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
 CONFIG_MUTEX_SPIN_ON_OWNER=y
 CONFIG_RWSEM_SPIN_ON_OWNER=y
@@ -497,9 +493,10 @@
 CONFIG_SCHED_SMT=y
 CONFIG_SCHED_MC=y
 CONFIG_SCHED_MC_PRIO=y
-CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_NONE is not set
 # CONFIG_PREEMPT_VOLUNTARY is not set
-# CONFIG_PREEMPT is not set
+CONFIG_PREEMPT=y
+CONFIG_PREEMPT_COUNT=y
 CONFIG_X86_LOCAL_APIC=y
 CONFIG_X86_IO_APIC=y
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
@@ -3931,6 +3928,7 @@
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_SCHED_STACK_END_CHECK is not set
 # CONFIG_DEBUG_TIMEKEEPING is not set
+# CONFIG_DEBUG_PREEMPT is not set
 
 #
 # Lock Debugging (spinlocks, mutexes, etc...)
@@ -3996,6 +3994,7 @@
 CONFIG_FUNCTION_GRAPH_TRACER=y
 # CONFIG_PREEMPTIRQ_EVENTS is not set
 # CONFIG_IRQSOFF_TRACER is not set
+# CONFIG_PREEMPT_TRACER is not set
 # CONFIG_SCHED_TRACER is not set
 CONFIG_HWLAT_TRACER=y
 # CONFIG_FTRACE_SYSCALLS is not set
