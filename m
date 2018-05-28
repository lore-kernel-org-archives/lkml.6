Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164793AbeE1LAe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164726AbeE1LAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:00:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 390/496] cpufreq: cppc_cpufreq: Fix cppc_cpufreq_init() failure path
Date: Mon, 28 May 2018 12:02:55 +0200
Message-Id: <20180528100336.214312632@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chunyu Hu <chuhu@redhat.com>

[ Upstream commit 55b55abc17f238c61921360e61dde90dd9a326d1 ]

Kmemleak reported the below leak. When cppc_cpufreq_init went into
failure path, the cpu mask is not freed. After fix, this report is
gone. And to avaoid potential NULL pointer reference, check the cpu
value first.

unreferenced object 0xffff800fd5ea4880 (size 128):
  comm "swapper/0", pid 1, jiffies 4294939510 (age 668.680s)
  hex dump (first 32 bytes):
    00 00 00 00 20 00 00 00 00 00 00 00 00 00 00 00  .... ...........
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffff0000082c4ae4>] __kmalloc_node+0x278/0x634
    [<ffff0000088f4a74>] alloc_cpumask_var_node+0x28/0x60
    [<ffff0000088f4af0>] zalloc_cpumask_var+0x14/0x1c
    [<ffff000008d20254>] cppc_cpufreq_init+0xd0/0x19c
    [<ffff000008083828>] do_one_initcall+0xec/0x15c
    [<ffff000008cd1018>] kernel_init_freeable+0x1f4/0x2a4
    [<ffff0000089099b0>] kernel_init+0x18/0x10c
    [<ffff000008084d50>] ret_from_fork+0x10/0x18
    [<ffffffffffffffff>] 0xffffffffffffffff

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cppc_cpufreq.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -243,8 +243,13 @@ static int __init cppc_cpufreq_init(void
 	return ret;
 
 out:
-	for_each_possible_cpu(i)
-		kfree(all_cpu_data[i]);
+	for_each_possible_cpu(i) {
+		cpu = all_cpu_data[i];
+		if (!cpu)
+			break;
+		free_cpumask_var(cpu->shared_cpu_map);
+		kfree(cpu);
+	}
 
 	kfree(all_cpu_data);
 	return -ENODEV;
