Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B48C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED86B21521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amperecomputing.com header.i=@amperecomputing.com header.b="G4HhsB8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED86B21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amperecomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbeITAXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:23:53 -0400
Received: from mail-eopbgr690097.outbound.protection.outlook.com ([40.107.69.97]:38503
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732435AbeITAXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amperecomputing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vGUGjDUgHxSVKnW9jotOjowmkgT8xZKa/f4s29SRtk=;
 b=G4HhsB8wWZlv9n7z3tyzZdfgH8tUi2WWGFPuC9A3BXuw9UwmhrIkirKCLHuo1fzYPasFfjWMn6jSJiW+yPuNkBBRHs6lR+JNKFQpA+AAuRIHyyhifeOGoe3SwAsvO6z/hU1Z7AyGjxPdQzGh3/xAFP3CR5zC7RGVVZ5McodEW50=
Received: from SN1PR0101MB1567.prod.exchangelabs.com (10.163.128.25) by
 SN1PR0101MB1453.prod.exchangelabs.com (10.163.128.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 18:44:30 +0000
Received: from SN1PR0101MB1567.prod.exchangelabs.com
 ([fe80::c445:3e01:80ab:a944]) by SN1PR0101MB1567.prod.exchangelabs.com
 ([fe80::c445:3e01:80ab:a944%2]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 18:44:30 +0000
From:   Hoan Tran <hoan.tran@amperecomputing.com>
To:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Tai Nguyen <ttnguyen@amperecomputing.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Hoan Tran <hoan.tran@amperecomputing.com>
Subject: [PATCH v2] perf: xgene: Add CPU hotplug support
Thread-Topic: [PATCH v2] perf: xgene: Add CPU hotplug support
Thread-Index: AQHUUEjL6iCB7dX6uku+nmQs71SmFw==
Date:   Wed, 19 Sep 2018 18:44:30 +0000
Message-ID: <1537382649-17266-1-git-send-email-hoan.tran@amperecomputing.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0085.namprd12.prod.outlook.com
 (2603:10b6:802:21::20) To SN1PR0101MB1567.prod.exchangelabs.com
 (2a01:111:e400:5301::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hoan.tran@amperecomputing.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.28.13.142]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR0101MB1453;6:O1Y1+ZZ4joqGUOcyoOxyX3I7navQz+60iLe/d2FKflztDvVL2+4oEE21VKzy+d53jHxilC7Awh7BMzfVATxVDJpfSV61KP0AMw3T0j9XiEZhjIgLo0RCTmTpsiYK7OzyixYJMtN17S1ZSf8NNFcpcP/cTArNOdd43taer7cWmCbO5y80QnV5UNaOHfBFUg9HewEwOop27rS66WA0vZAGxw7oJUJEKTFEYwPWju4+/4BWLB4u53/Mi5fkKMiTGCD6QkFOF0zwPHWgGVUIOY7hkxtx2+MMHsv7oslHotnxZQ28A1mAcAWCLaMtD+l6O0AGnzLKqjKMVGsfcutpvVhOh9Y2f72WQ25aSNd0ZxMEA8WsbNogNPGYleSfGJ0OKt9z2ggQD5xCNvaH9Po9GYfHtYaHcLNLfJW7gqPlNQ7xNshBzD9nUBa0Qvuu+a8z8dW4zQYJA0n8uy7OtrOInPOl3Q==;5:LcldkItY9K/SAixxKBDLlhHR9aGzv/DVz6gAtCs3BSoLvbkx3z7lohsgmGLX+rmWKfODAhMvLR+mHQAGi42LnMeiMsOJWfuBkxP3SPBkJMDY37A6mL8sqDYexkktUnFYeUydp8S2hOE4k02E3bo2/eNRWOk8AHa9yH+bLeMp89g=;7:pAExKJDSQbLUj7yR6P4bkdRd0+GZJeyOZkIGNmYf7CEz6ZdWe2BBayPGYIWWMBX7vHF8AGfO70wDmRU5KMAGZewEuxeYvsfZvodw8FnquOOmjnbSLDsIiLZ2NtRQ9aMBxwuuEzYTf/RnJjWndHhsPQHGHbL3GNs0XZlHr5FtogfRoBlRgdnICMhn1kbx/29Cy9RXyJ1EAbbhf0gaCzgWyDZDaWaUaJmMBV5aD5p+NeHnxYGiNMbs0QcZnMbXDT6A
x-ms-office365-filtering-correlation-id: 1ad35710-a498-4f66-b777-08d61e5fed34
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR0101MB1453;
x-ms-traffictypediagnostic: SN1PR0101MB1453:
x-microsoft-antispam-prvs: <SN1PR0101MB1453B0F1170B15AA61EF8FB9E41C0@SN1PR0101MB1453.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(209352067349851);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:SN1PR0101MB1453;BCL:0;PCL:0;RULEID:;SRVR:SN1PR0101MB1453;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39850400004)(136003)(189003)(199004)(6512007)(6116002)(68736007)(2900100001)(186003)(106356001)(8676002)(52116002)(25786009)(5250100002)(105586002)(5660300001)(102836004)(386003)(99286004)(6436002)(26005)(14444005)(476003)(2906002)(256004)(6506007)(2616005)(6486002)(36756003)(54906003)(316002)(110136005)(3846002)(478600001)(81166006)(81156014)(305945005)(86362001)(53936002)(66066001)(4326008)(14454004)(44832011)(107886003)(97736004)(486006)(7736002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR0101MB1453;H:SN1PR0101MB1567.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amperecomputing.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: NFYjT+9Y5lNdmCITAm9wzF3BOmR11PS9aO3dxiNxpWrfn+R43K84iHgOknBjv7JvJp0lYfqbxQxbddIeT2EAqjZ6u1TFhKMQYub9kGV7zW7OOeKJqCZp4FhNDPW7PQfBIu6NRoMHdceO6UXyuzHPoRwr5Fjy3ixtRaTIp3cH7DybYRSd9CDeAEOUz0qAiub3mPTlIogZf4uBHgdKzl9dN0uaLVeWPv2ALFtkxcaq1Xb4atLrVtdybO1VEDHAaadZqkk9nVCr2n3s7dEfuIDHd2UCAuYopS++mf3O7eGlSr2WS/CKGHoiB1afDv1jbgFYPZXrMIB1T6cTGUKM2bWj6Eu4t/6xFtuo1M7LRb1s9Go=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ad35710-a498-4f66-b777-08d61e5fed34
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 18:44:30.6288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR0101MB1453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds CPU hotplug support where the PMU migrates the context to
another online CPU when its CPU is offline.

It fixes the below issue where the user does offline the CPU which is assig=
ned
to this PMU.

Assuming, CPU0 is assigned for this PMU. When the user does offline CPU0
	[root@(none) ~]# echo 0 > /sys/devices/system/cpu/cpu0/online
This PMU does not work anymore and shows the below error.
	[root@(none) ~]# perf stat -a -e l3c0/cycle-count/,l3c0/write/ sleep 1
	Error:
	The sys_perf_event_open() syscall returned with 19 (No such device) for ev=
ent (l3c0/cycle-count/).
	/bin/dmesg may provide additional information.
	No CONFIG_PERF_EVENTS=3Dy kernel support configured?

With this patch, when CPU0 is offline, PMU migrates to another online CPU a=
nd
works on that CPU.

Signed-off-by: Hoan Tran <hoan.tran@amperecomputing.com>
---
v2:
 * Remove the cpuhp instance when unregistering the PMU

 drivers/perf/xgene_pmu.c   | 80 ++++++++++++++++++++++++++++++++++++++++++=
----
 include/linux/cpuhotplug.h |  1 +
 2 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 0e31f13..796fcb5 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -21,6 +21,7 @@
=20
 #include <linux/acpi.h>
 #include <linux/clk.h>
+#include <linux/cpuhotplug.h>
 #include <linux/cpumask.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -130,12 +131,14 @@ struct xgene_pmu_ops {
=20
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
@@ -1806,6 +1809,53 @@ static const struct acpi_device_id xgene_pmu_acpi_ma=
tch[] =3D {
 MODULE_DEVICE_TABLE(acpi, xgene_pmu_acpi_match);
 #endif
=20
+static int xgene_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct xgene_pmu *xgene_pmu =3D hlist_entry_safe(node, struct xgene_pmu,
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
+static int xgene_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node=
)
+{
+	struct xgene_pmu *xgene_pmu =3D hlist_entry_safe(node, struct xgene_pmu,
+						       node);
+	struct xgene_pmu_dev_ctx *ctx;
+	unsigned int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &xgene_pmu->cpu))
+		return 0;
+	target =3D cpumask_any_but(cpu_online_mask, cpu);
+	if (target >=3D nr_cpu_ids)
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
@@ -1815,6 +1865,14 @@ static int xgene_pmu_probe(struct platform_device *p=
dev)
 	int irq, rc;
 	int version;
=20
+	/* Install a hook to update the reader CPU in case it goes offline */
+	rc =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_XGENE_ONLINE,
+				      "CPUHP_AP_PERF_XGENE_ONLINE",
+				      xgene_pmu_online_cpu,
+				      xgene_pmu_offline_cpu);
+	if (rc)
+		return rc;
+
 	xgene_pmu =3D devm_kzalloc(&pdev->dev, sizeof(*xgene_pmu), GFP_KERNEL);
 	if (!xgene_pmu)
 		return -ENOMEM;
@@ -1865,6 +1923,7 @@ static int xgene_pmu_probe(struct platform_device *pd=
ev)
 		dev_err(&pdev->dev, "No IRQ resource\n");
 		return -EINVAL;
 	}
+
 	rc =3D devm_request_irq(&pdev->dev, irq, xgene_pmu_isr,
 				IRQF_NOBALANCING | IRQF_NO_THREAD,
 				dev_name(&pdev->dev), xgene_pmu);
@@ -1873,6 +1932,8 @@ static int xgene_pmu_probe(struct platform_device *pd=
ev)
 		return rc;
 	}
=20
+	xgene_pmu->irq =3D irq;
+
 	raw_spin_lock_init(&xgene_pmu->lock);
=20
 	/* Check for active MCBs and MCUs */
@@ -1883,13 +1944,11 @@ static int xgene_pmu_probe(struct platform_device *=
pdev)
 		xgene_pmu->mc_active_mask =3D 0x1;
 	}
=20
-	/* Pick one core to use for cpumask attributes */
-	cpumask_set_cpu(smp_processor_id(), &xgene_pmu->cpu);
-
-	/* Make sure that the overflow interrupt is handled by this CPU */
-	rc =3D irq_set_affinity(irq, &xgene_pmu->cpu);
+	/* Add this instance to the list used by the hotplug callback */
+	rc =3D cpuhp_state_add_instance(CPUHP_AP_PERF_XGENE_ONLINE,
+				      &xgene_pmu->node);
 	if (rc) {
-		dev_err(&pdev->dev, "Failed to set interrupt affinity!\n");
+		dev_err(&pdev->dev, "Error %d registering hotplug", rc);
 		return rc;
 	}
=20
@@ -1897,13 +1956,18 @@ static int xgene_pmu_probe(struct platform_device *=
pdev)
 	rc =3D xgene_pmu_probe_pmu_dev(xgene_pmu, pdev);
 	if (rc) {
 		dev_err(&pdev->dev, "No PMU perf devices found!\n");
-		return rc;
+		goto out_unregister;
 	}
=20
 	/* Enable interrupt */
 	xgene_pmu->ops->unmask_int(xgene_pmu);
=20
 	return 0;
+
+out_unregister:
+	cpuhp_state_remove_instance(CPUHP_AP_PERF_XGENE_ONLINE,
+				    &xgene_pmu->node);
+	return rc;
 }
=20
 static void
@@ -1924,6 +1988,8 @@ static int xgene_pmu_remove(struct platform_device *p=
dev)
 	xgene_pmu_dev_cleanup(xgene_pmu, &xgene_pmu->iobpmus);
 	xgene_pmu_dev_cleanup(xgene_pmu, &xgene_pmu->mcbpmus);
 	xgene_pmu_dev_cleanup(xgene_pmu, &xgene_pmu->mcpmus);
+	cpuhp_state_remove_instance(CPUHP_AP_PERF_XGENE_ONLINE,
+				    &xgene_pmu->node);
=20
 	return 0;
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
--=20
2.7.4

