Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeEQTD6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:03:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33207 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeEQTD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:03:56 -0400
Date: Thu, 17 May 2018 12:03:46 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-fed71f7d98795ed0fa1d431910787f0f4a68324f@git.kernel.org>
Cc: hpa@zytor.com, rick@microway.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: rick@microway.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <alpine.DEB.2.21.1805171418210.1947@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1805171418210.1947@nanos.tec.linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/apic/x2apic: Initialize cluster ID properly
Git-Commit-ID: fed71f7d98795ed0fa1d431910787f0f4a68324f
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

Commit-ID:  fed71f7d98795ed0fa1d431910787f0f4a68324f
Gitweb:     https://git.kernel.org/tip/fed71f7d98795ed0fa1d431910787f0f4a68324f
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 17 May 2018 14:36:39 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 17 May 2018 21:00:12 +0200

x86/apic/x2apic: Initialize cluster ID properly

Rick bisected a regression on large systems which use the x2apic cluster
mode for interrupt delivery to the commit wich reworked the cluster
management.

The problem is caused by a missing initialization of the clusterid field
in the shared cluster data structures. So all structures end up with
cluster ID 0 which only allows sharing between all CPUs which belong to
cluster 0. All other CPUs with a cluster ID > 0 cannot share the data
structure because they cannot find existing data with their cluster
ID. This causes malfunction with IPIs because IPIs are sent to the wrong
cluster and the caller waits for ever that the target CPU handles the IPI.

Add the missing initialization when a upcoming CPU is the first in a
cluster so that the later booting CPUs can find the data and share it for
proper operation.

Fixes: 023a611748fd ("x86/apic/x2apic: Simplify cluster management")
Reported-by: Rick Warner <rick@microway.com>
Bisected-by: Rick Warner <rick@microway.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Rick Warner <rick@microway.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1805171418210.1947@nanos.tec.linutronix.de
---
 arch/x86/kernel/apic/x2apic_cluster.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 8b04234e010b..7685444a106b 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -116,6 +116,7 @@ static void init_x2apic_ldr(void)
 			goto update;
 	}
 	cmsk = cluster_hotplug_mask;
+	cmsk->clusterid = cluster;
 	cluster_hotplug_mask = NULL;
 update:
 	this_cpu_write(cluster_masks, cmsk);
