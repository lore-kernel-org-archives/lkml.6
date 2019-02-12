Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28203C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005492184E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfBLQui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:50:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3191 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727986AbfBLQuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:50:37 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C2159F346FEF718CFC8E;
        Wed, 13 Feb 2019 00:50:31 +0800 (CST)
Received: from j00421895-HPW10.huawei.com (10.202.226.61) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Wed, 13 Feb 2019 00:50:22 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <jonathan.cameron@huawei.com>, <linux-mm@kvack.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Michal Hocko <mhocko@kernel.org>, <jcm@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 2/3] arm64: Support Generic Initiator only domains
Date:   Tue, 12 Feb 2019 16:49:25 +0000
Message-ID: <20190212164926.202-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212164926.202-1-Jonathan.Cameron@huawei.com>
References: <20190212164926.202-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The one thing that currently needs doing from an architecture
point of view is associating the GI domain with its nearest
memory domain.  This allows all the standard NUMA aware code
to get a 'reasonable' answer.

A clever driver might elect to do load balancing etc
if there are multiple host / memory domains nearby, but
that's a decision for the driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/arm64/kernel/smp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 1598d6f7200a..871d2d21afb3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -698,6 +698,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int err;
 	unsigned int cpu;
+	unsigned int node;
 	unsigned int this_cpu;
 
 	init_cpu_topology();
@@ -736,6 +737,13 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 		set_cpu_present(cpu, true);
 		numa_store_cpu_info(cpu);
 	}
+
+	/*
+	 * Walk the numa domains and set the node to numa memory reference
+	 * for any that are Generic Initiator Only.
+	 */
+	for_each_node_state(node, N_GENERIC_INITIATOR)
+		set_gi_numa_mem(node, local_memory_node(node));
 }
 
 void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-- 
2.18.0


