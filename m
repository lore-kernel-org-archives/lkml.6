Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D5BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48600217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeLRMnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:43:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50575 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeLRMnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:43:04 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBICgqKh2834007
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 04:42:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBICgqer2833999;
        Tue, 18 Dec 2018 04:42:52 -0800
Date:   Tue, 18 Dec 2018 04:42:52 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hui Wang <tipbot@zytor.com>
Message-ID: <tip-aa02ef099cff042c2a9109782ec2bf1bffc955d4@git.kernel.org>
Cc:     qiaonuohan@huawei.com, wencongyang2@huawei.com,
        douliyang1@huawei.com, john.wanghui@huawei.com,
        guijianfeng@huawei.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, guijianfeng@huawei.com,
          john.wanghui@huawei.com, wencongyang2@huawei.com,
          douliyang1@huawei.com, qiaonuohan@huawei.com
In-Reply-To: <20181107023643.22174-1-john.wanghui@huawei.com>
References: <20181107023643.22174-1-john.wanghui@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/topology: Use total_cpus for max logical packages
 calculation
Git-Commit-ID: aa02ef099cff042c2a9109782ec2bf1bffc955d4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  aa02ef099cff042c2a9109782ec2bf1bffc955d4
Gitweb:     https://git.kernel.org/tip/aa02ef099cff042c2a9109782ec2bf1bffc955d4
Author:     Hui Wang <john.wanghui@huawei.com>
AuthorDate: Wed, 7 Nov 2018 10:36:43 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 18 Dec 2018 13:38:37 +0100

x86/topology: Use total_cpus for max logical packages calculation

nr_cpu_ids can be limited on the command line via nr_cpus=. This can break the
logical package management because it results in a smaller number of packages
while in kdump kernel.

Check below case:
There is a two sockets system, each socket has 8 cores, which has 16 logical
cpus while HT was turn on.

 0  1  2  3  4  5  6  7     |    16 17 18 19 20 21 22 23
 cores on socket 0               threads on socket 0
 8  9 10 11 12 13 14 15     |    24 25 26 27 28 29 30 31
 cores on socket 1               threads on socket 1

While starting the kdump kernel with command line option nr_cpus=16 panic
was triggered on one of the cpus 24-31 eg. 26, then online cpu will be
1-15, 26(cpu 0 was disabled in kdump), ncpus will be 16 and
__max_logical_packages will be 1, but actually two packages were booted on.

This issue can reproduced by set kdump option nr_cpus=<real physical core
numbers>, and then trigger panic on last socket's thread, for example:

taskset -c 26 echo c > /proc/sysrq-trigger

Use total_cpus which will not be limited by nr_cpus command line to calculate
the value of __max_logical_packages.

Signed-off-by: Hui Wang <john.wanghui@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <guijianfeng@huawei.com>
Cc: <wencongyang2@huawei.com>
Cc: <douliyang1@huawei.com>
Cc: <qiaonuohan@huawei.com>
Link: https://lkml.kernel.org/r/20181107023643.22174-1-john.wanghui@huawei.com

---
 arch/x86/kernel/smpboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index a9134d1910b9..ccd1f2a8e557 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1347,7 +1347,7 @@ void __init calculate_max_logical_packages(void)
 	 * extrapolate the boot cpu's data to all packages.
 	 */
 	ncpus = cpu_data(0).booted_cores * topology_max_smt_threads();
-	__max_logical_packages = DIV_ROUND_UP(nr_cpu_ids, ncpus);
+	__max_logical_packages = DIV_ROUND_UP(total_cpus, ncpus);
 	pr_info("Max logical packages: %u\n", __max_logical_packages);
 }
 
