Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298ABC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861A82152D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="TFEmht7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861A82152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeHOVZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:25:14 -0400
Received: from mail-dm3nam03on0108.outbound.protection.outlook.com ([104.47.41.108]:5618
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbeHOVZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwQ4asgHLHeWhZNGxySO4F5wZelX46VMMUtJpI/qliM=;
 b=TFEmht7qEfQ2duPylc9zO0okK+VDo+Rjxu8PNGKuSO3Fe+ZhRUegIA5exd5Js1qQ+7pWrrYnRfvLIXnSF3+FDIDPTugLrJiwuOuMk4aEFsaQKfzGF2NVd9etp0yhFW8PL06JdvTa3GL4SiHrgSWEBDJbfWw4J8zMW3HxJ/nf3Zo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=hoan.tran@amperecomputing.com; 
Received: from T3400_localhost.amperecomputing.com (4.28.13.142) by
 CY1PR0101MB1564.prod.exchangelabs.com (2a01:111:e400:5315::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.25; Wed, 15 Aug 2018 18:31:53 +0000
From:   Hoan Tran <hoan.tran@amperecomputing.com>
To:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        loc.ho@amperecomputing.com, khuong.dinh@amperecomputing.com
Cc:     Tai Nguyen <ttnguyen@amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hoan Tran <hoan.tran@amperecomputing.com>
Subject: [PATCH] perf: xgene: Add CPU hotplug support
Date:   Wed, 15 Aug 2018 11:31:35 -0700
Message-Id: <1534357895-19031-1-git-send-email-hoan.tran@amperecomputing.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [4.28.13.142]
X-ClientProxiedBy: SN1PR12CA0087.namprd12.prod.outlook.com
 (2603:10b6:802:21::22) To CY1PR0101MB1564.prod.exchangelabs.com
 (2a01:111:e400:5315::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe0d4c2b-68bc-4c78-2e81-08d602dd6026
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0101MB1564;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0101MB1564;3:VgZAhbP6KZjrYuPB8HgQzQP6QaJoHkXFOBuY2M1V1q8mVhPcqwwFxFvrVKhEMsQvyw50FmypUO25aYgaoGTYL4jYeJARR6o4HYNRxoHIfFCUECx3Ae6HFl/ZctXvJrVzWPYZA1kHFz4tEbiUC76MBmStdpiqj8q4R6WEWQmlOUxS/UU4DQaE6n2ZYAc2c9RcYkpJzkHb4wDnAhBCVoGQRHL6ARF8HCDgBEogJK+c911Pcy67+EtTUE6uwahG2qxv;25:wI7srI9iAjTlARTsQovLWjlJR5TKhcfKaj2r06tGEbGTAhpHyjWKyemLJ7WaDsNmeEpvQxu2VTV9+jJMDZBVdXlv0XYWDqjA37snp5XwUwJHDjKSPbaFcle8XUa0OJK4eqg4KHGvNRzsc9Vqj6428jHtgisQPEkn9/F2zHpefA1TvOgU/fKH9UDOLaeT7QLm3LS+wS7pcTzadX0ZcmrphV6m2NnMs9fjTvQd2N5xZHh/YBflrHWTfn+BBf8FdXLblj+/YCXutcctjURueufLxuB6ud86H+5t625Jk9j4nrqmKsmftC8d1Are4lE9saVsDAq/GxESDe/C6P7HpEHNOA==;31:7VJkjHdMLizOhPi7cywSiTQKVIfbu2wjIS0aUmcNWPWeosReg+/uzLJ7OLfqajyBz2Kd3T9pKBoEpSgHbYuT0S41eLiLKxluaw89Yj0sgduZSimhAs/Loh7EJs6x574Qc84zSqqjVHyH0dAg9gdeF1VWyFnbM+ANpJNQdXfN/gM4S5syBxIMzcUCHjUJ/YTLDGmjTk7DLKZxqRIsz+SgweG9zHjsYMdfuAdQxLtaWCI=
X-MS-TrafficTypeDiagnostic: CY1PR0101MB1564:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0101MB1564;20:AjX9oX59N1PVq61BaNKmKJb/lf/1fYjSwnuSEzWBktW44SWevnR0Z8Fx4qf0HFt4uxqWqojNjlDQT2P9CdS3qXXwUm9+lHzFRHELh2dB+9ZWDv0j0N4bXAs7xoLYExIpvyLP5lgxKrwZHklKpmU+x+Lu18C2HHOIQMXxj6IGiqg=;4:700FgVGR1hITA955gIzf0xmNPJRGBNL22fBiXJBjUM3+mbQYekFxOSIp1BcnlP3Ugk1oBazHjkW1wZP6D9eidlvGedPK3yRX33RmGbyydGF7RrSoN9IBKWM7vdhmKpyFQdfw880A6cZ/xORLhO3p0y+qzWOXYv65OwwwQvFIMZjQkoxu4rInaV9J/E0RBsCpb7xHgzP/bcBpi1K+Ha3/00L1SzOEz+BKX4KV1K4ChRpY0+O6CIs67gdFgR0wYyQ8wTXZLXzfXus41yXUHp3Y7CxWHeZWb1YbwrqvIxJmMLr17CQ0ssOuh38GYuseM3SG
X-Microsoft-Antispam-PRVS: <CY1PR0101MB156447885EB140AED2BE465FE43F0@CY1PR0101MB1564.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(209352067349851);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0101MB1564;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0101MB1564;
X-Forefront-PRVS: 07658B8EA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(136003)(366004)(396003)(39840400004)(376002)(346002)(189003)(199004)(8676002)(44832011)(6486002)(53416004)(7736002)(14444005)(8936002)(81156014)(106356001)(305945005)(105586002)(81166006)(4326008)(26005)(25786009)(97736004)(386003)(107886003)(66066001)(47776003)(36756003)(2906002)(6666003)(6636002)(48376002)(478600001)(50466002)(50226002)(68736007)(37156001)(476003)(5660300001)(486006)(956004)(2616005)(3846002)(6116002)(86362001)(69596002)(316002)(54906003)(110136005)(16586007)(53936002)(7696005)(52116002)(51416003)(1857600001)(186003)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0101MB1564;H:T3400_localhost.amperecomputing.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0101MB1564;23:s69sWTlN373dFuiVEzWFiEWClVTml7H7KMVuPmz?=
 =?us-ascii?Q?Ex++xExyrqVU0CcF0wsmMqBdMCqecGYh6ZhNJcpFFERQzWu1qo/UA4lE6+2r?=
 =?us-ascii?Q?nmXoIaaUmZwGr7rPpmyAR4bZkToFXGrYytAU8xust93IeK/TQklhwZC4wPUF?=
 =?us-ascii?Q?jNa2MtakgXAh2S5TFJLzqduX/je5E4RqxP1h2eEb8utzeimb1+V60Zi7TX64?=
 =?us-ascii?Q?1dFtMddW6RS5M4rgpuIU4X3m2uV7qzb368L4pOuqF7gSSJe//deGjVDLbUw2?=
 =?us-ascii?Q?gdj7Y4HWMxpNijswGawvqAS22zNmVoSJ3nkPtpMJzFY5FJRlI7yrdLre4w3q?=
 =?us-ascii?Q?iw9EalRooxplpp9nPM6kK6SlvmCl2XQKW0Tbfp+rNm9/B1XzC19UJMyxiJzY?=
 =?us-ascii?Q?6r3bWy1bD79LjSt/rGbenK2tSxydlTMb4tPwyznA8bSzKDpw1p1umWHSrwiD?=
 =?us-ascii?Q?rjui9cy586pRZ2UGx+Vlx3fwYhjnfgCqZtCyA1MsuR/RqCRKm6t6x0cNdv3q?=
 =?us-ascii?Q?mBGuEpHhZ/B1ugJu8wlbjop6EJNWYhmNlJXcFtjCwhQCA4nnv84bh9H0g1G0?=
 =?us-ascii?Q?j40Mdiv06wrq1Vz+owCSgpN0w3RB7u/K99Tn9U7Q/mIpssvqfdVk00n3I+G+?=
 =?us-ascii?Q?9B30r9awJWamwuSyUwoREzy2eFhyL5YUcoXYwqcYsFUGGsGftLFNBpA1HSsA?=
 =?us-ascii?Q?efcMIELmPeCnpM8xJrTN9oQ7QUkbAGW7v3TDBLA6xLIDbST53Urve1WL4qcQ?=
 =?us-ascii?Q?P/ISOJhQ5Nfi2u3Mg1260ObZobowx8zEIUapxdIOVBVUY5PENhn24h3bA9Xp?=
 =?us-ascii?Q?Jj9SP7p4MdC4rxfcj1+D4bSaDDnyKC0wTln3/Yg+ENh4Iw0rwAex3k+aiIx/?=
 =?us-ascii?Q?N0ob/QqK9BV2e5sY1Iwc6mruYuBUTafqgM6ZYPfHlEpBj6D9kx1o4Fj/MgX3?=
 =?us-ascii?Q?mFvwl6d5ARc52QFbEluVkD43wiQrS6kjs7YqTOq1A/ief+RkhX5H3OiXORHX?=
 =?us-ascii?Q?p03wbTRHptofh5niZsTkpjUwZliE7dHwI254kpXGjMnu3D6WDIOTsHMb68BW?=
 =?us-ascii?Q?ta3lSJcNdmS5Q7BjGCRomt5xuFRxjuEFoH3gXcGYOCVx8qbIuyOiuMRdBfEb?=
 =?us-ascii?Q?Tmqvyaz5TWqaaKedhW1QV0hQ4N5Tyqjb6hTpSx749lsFCi0tA7T24TsYJdqx?=
 =?us-ascii?Q?pPhg3KTNuuw+cKi2mR0DGeUJmc57fwwa4aBZJ732HmBj9Jikuy85oGbPN3fY?=
 =?us-ascii?Q?dTf2ve88K0SYL/Ii963FDdzgQnz7vQMpUHHAGUmKHuBrp3DZu4y3QjgagyaW?=
 =?us-ascii?Q?odX7/yBEf3piaXB5RNuw4xqg=3D?=
X-Microsoft-Antispam-Message-Info: AjF0MV7AXh1pft4MeQS5EG3zUs9SrxpbgOi5sXSNGq5RBwCAfNK7815O4IpEKavZhT6zueX/mwrLaITuvikCDJ3d6MWlufNHQJu3MnvP9vAhemKNEi52eLaaQKkiZbg37Sp8cWh+hYjfLxx7A3DaNAMhtt+psYDqQ4qt2zih69uXGhMbSVjkwNQ3E7RT9vBuciIsIcgajesNbd1T3zi8LduGOnBLrIX1MnEoYZC1q5OuIIyT9RZGV+pbMdGkRweJd9wVdDO04K4/dvwLgY7DaRhP3Bsa/GnVYRd+eSmyMl6ZdUnHRb6sXBX1mwfAz3yQS4BUzxwLglWfcD7nI4ocfHlebxi45diHP+WJxfgtLlw=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0101MB1564;6:7AnEABDlT3GqgWM4ywg/JQbbPtOV65qBcOp9qoOW64mOOcqtJxStWtzLgCkFFU6xsMs0rtxtvTM/toReHuSYLAR/N5QSC8EDOQHGuSw0njFsJQIadpU0fBZrDdONxZh1ZZhuI8DBiAl0EhA2p/hRyXVQsK/vrPUtHl+2gArorg//iOC8fk6N6guMhfkMbCIlG1V+7AnYwkCTHVIWWwbvJuBy7Gh+0Tq6amAkT+0Lmrtkj4l6kJVZU3ZwXrTfFAf9ZrsYi0JaQ3Au6P4FoksB4DULE1UsuEDZAoQCz4ek4qnjmWiG8ZAeDJ2nCge5k6XkbiY1UQS2RY6Al7MasiWVqk4DaOGfSO/aA4Qmx+KqDjbHw+JF/mOLE8TCQehGC14Vpya8CgTzOMPDuM7j+qylCEXI/QgvlfVjjIetGO/R9huTYztZGWfWj8wcIpXJstibYNiOnz+2YV7Kyh5ESKQWng==;5:iByo2X1HbU1bVKtkhp0IXRRZC8aRid8l1WdHtnYY5hJxBzHEADQvkFfUhdEWjQ38LIA9laYg4g49bV6UU2qISXpGS9sBSo5zGaJMJ5F367MSpLDquuVRfiRCsb4zFAW3AacbwOY3Le2UL3yI7RhOkwe2IYQN5tm/i6yKwOWLCVM=;7:SOPcsbeiZhduLzRmfwlKJHlyHk3kYQ348e/+C9ejmPLfx+Nkl3sl0+Hh7DcmGYGN1GCFgi9ieSNz5wMJ0kzQiFz7q7RYsCC1D/lOi04bUkj+1tQVQnnffYoERQRr39zDq8cBunzyh/AR3zzBuQlYCqxaTLcgBKNGoRWt8cZXvv9+eDjZxWIILEaczSSUi+x5geWw3kcyr8eyM5wymYGgmrExDKW2eJ2hJjqUt6vxv1q8tG7sow+wutYGLo6mJFfF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2018 18:31:53.6980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0d4c2b-68bc-4c78-2e81-08d602dd6026
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0101MB1564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds CPU hotplug support where the PMU migrates the context to
another online CPU when its CPU is offline.

It fixes the below issue where the user does offline the CPU which is assigned
to this PMU.

Assuming, CPU0 is assigned for this PMU. When the user does offline CPU0
	[root@(none) ~]# echo 0 > /sys/devices/system/cpu/cpu0/online
This PMU does not work anymore and shows the below error.
	[root@(none) ~]# perf stat -a -e l3c0/cycle-count/,l3c0/write/ sleep 1
	Error:
	The sys_perf_event_open() syscall returned with 19 (No such device) for event (l3c0/cycle-count/).
	/bin/dmesg may provide additional information.
	No CONFIG_PERF_EVENTS=y kernel support configured?

With this patch, when CPU0 is offline, PMU migrates to another online CPU and
works on that CPU.

Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>
---
 drivers/perf/xgene_pmu.c   | 71 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/cpuhotplug.h |  1 +
 2 files changed, 66 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 0e31f13..248a3f7 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -21,6 +21,7 @@
 
 #include <linux/acpi.h>
 #include <linux/clk.h>
+#include <linux/cpuhotplug.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -130,12 +131,14 @@ struct xgene_pmu_ops {
 
 struct xgene_pmu {
 	struct device *dev;
+	struct hlist_node node;
 	int version;
 	void __iomem *pcppmu_csr;
 	u32 mcb_active_mask;
 	u32 mc_active_mask;
 	u32 l3c_active_mask;
 	cpumask_t cpu;
+	int irq;
 	raw_spinlock_t lock;
 	const struct xgene_pmu_ops *ops;
 	struct list_head l3cpmus;
@@ -1806,6 +1809,53 @@ static const struct acpi_device_id xgene_pmu_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, xgene_pmu_acpi_match);
 #endif
 
+static int xgene_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct xgene_pmu *xgene_pmu = hlist_entry_safe(node, struct xgene_pmu,
+						       node);
+
+	if (cpumask_empty(&xgene_pmu->cpu))
+		cpumask_set_cpu(cpu, &xgene_pmu->cpu);
+
+	/* Overflow interrupt also should use the same CPU */
+	WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
+
+	return 0;
+}
+
+static int xgene_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct xgene_pmu *xgene_pmu = hlist_entry_safe(node, struct xgene_pmu,
+						       node);
+	struct xgene_pmu_dev_ctx *ctx;
+	unsigned int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &xgene_pmu->cpu))
+		return 0;
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	list_for_each_entry(ctx, &xgene_pmu->mcpmus, next) {
+		perf_pmu_migrate_context(&ctx->pmu_dev->pmu, cpu, target);
+	}
+	list_for_each_entry(ctx, &xgene_pmu->mcbpmus, next) {
+		perf_pmu_migrate_context(&ctx->pmu_dev->pmu, cpu, target);
+	}
+	list_for_each_entry(ctx, &xgene_pmu->l3cpmus, next) {
+		perf_pmu_migrate_context(&ctx->pmu_dev->pmu, cpu, target);
+	}
+	list_for_each_entry(ctx, &xgene_pmu->iobpmus, next) {
+		perf_pmu_migrate_context(&ctx->pmu_dev->pmu, cpu, target);
+	}
+
+	cpumask_set_cpu(target, &xgene_pmu->cpu);
+	/* Overflow interrupt also should use the same CPU */
+	WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
+
+	return 0;
+}
+
 static int xgene_pmu_probe(struct platform_device *pdev)
 {
 	const struct xgene_pmu_data *dev_data;
@@ -1815,6 +1865,14 @@ static int xgene_pmu_probe(struct platform_device *pdev)
 	int irq, rc;
 	int version;
 
+	/* Install a hook to update the reader CPU in case it goes offline */
+	rc = cpuhp_setup_state_multi(CPUHP_AP_PERF_XGENE_ONLINE,
+				      "CPUHP_AP_PERF_XGENE_ONLINE",
+				      xgene_pmu_online_cpu,
+				      xgene_pmu_offline_cpu);
+	if (rc)
+		return rc;
+
 	xgene_pmu = devm_kzalloc(&pdev->dev, sizeof(*xgene_pmu), GFP_KERNEL);
 	if (!xgene_pmu)
 		return -ENOMEM;
@@ -1865,6 +1923,7 @@ static int xgene_pmu_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "No IRQ resource\n");
 		return -EINVAL;
 	}
+
 	rc = devm_request_irq(&pdev->dev, irq, xgene_pmu_isr,
 				IRQF_NOBALANCING | IRQF_NO_THREAD,
 				dev_name(&pdev->dev), xgene_pmu);
@@ -1873,6 +1932,8 @@ static int xgene_pmu_probe(struct platform_device *pdev)
 		return rc;
 	}
 
+	xgene_pmu->irq = irq;
+
 	raw_spin_lock_init(&xgene_pmu->lock);
 
 	/* Check for active MCBs and MCUs */
@@ -1883,13 +1944,11 @@ static int xgene_pmu_probe(struct platform_device *pdev)
 		xgene_pmu->mc_active_mask = 0x1;
 	}
 
-	/* Pick one core to use for cpumask attributes */
-	cpumask_set_cpu(smp_processor_id(), &xgene_pmu->cpu);
-
-	/* Make sure that the overflow interrupt is handled by this CPU */
-	rc = irq_set_affinity(irq, &xgene_pmu->cpu);
+	/* Add this instance to the list used by the hotplug callback */
+	rc = cpuhp_state_add_instance(CPUHP_AP_PERF_XGENE_ONLINE,
+				      &xgene_pmu->node);
 	if (rc) {
-		dev_err(&pdev->dev, "Failed to set interrupt affinity!\n");
+		dev_err(&pdev->dev, "Error %d registering hotplug", rc);
 		return rc;
 	}
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 8796ba3..afefca8a 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -164,6 +164,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_POWERPC_NEST_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_CORE_IMC_ONLINE,
 	CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
+	CPUHP_AP_PERF_XGENE_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
 	CPUHP_AP_RCUTREE_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
-- 
2.7.4

