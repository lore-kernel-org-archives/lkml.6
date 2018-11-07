Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBCFC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E211E2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E211E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbeKGLa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 06:30:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388747AbeKGLa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 06:30:59 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0D91150BAE96D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 10:02:43 +0800 (CST)
Received: from huawei.com (10.175.104.244) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Wed, 7 Nov 2018
 10:02:33 +0800
From:   Hui Wang <john.wanghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>
CC:     <guijianfeng@huawei.com>, <wencongyang2@huawei.com>,
        <douliyang1@huawei.com>, <qiaonuohan@huawei.com>
Subject: [PATCH] x86/topology: use total_cpus for max logical packages calculation
Date:   Wed, 7 Nov 2018 10:36:43 +0800
Message-ID: <20181107023643.22174-1-john.wanghui@huawei.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.244]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

While start kdump kernel with option nr_cpus=16, and panic was triggered on one
of the cpus 24-31 eg. 26, then online cpu will be 1-15, 26(cpu 0 was disabled in
kdump), ncpus will be 16 and __max_logical_packages will be 1, but actually two
packages were booted on.

This issue can reproduced by set kdump option nr_cpus=<real physical core
numbers>, and then trigger panic on last socket's thread, for example:

taskset -c 26 echo c > /proc/sysrq-trigger

Use total_cpus which will not be limited by nr_cpus command line to calculate
the value of __max_logical_packages.

Signed-off-by: Hui Wang <john.wanghui@huawei.com>
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
 
-- 
2.17.0

