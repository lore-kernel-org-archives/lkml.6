Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B9BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18ACF2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nBq4Zmrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18ACF2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbeIQI2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:28:05 -0400
Received: from mail-by2nam03on0117.outbound.protection.outlook.com ([104.47.42.117]:22121
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729476AbeIQI2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NczKxADZiENzzyqysbH094OhDxmuoBJ8QmrNoseeEmk=;
 b=nBq4ZmrgCFXN7L5u4XAv41l35MFZcYkIarVu9xZpJzJi4ayZ9Bi1ToiaCiICNuplJ8lhZlKM3RHMAnWSepyMp3Vr6arzZlyaPdk33Ak+DtWLYfpFtkI8zS7Ifd/Hj/vztahHHaB5k8tu5jUf6pnwTojt+iJGhaQ1dPaVE0B4syk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0168.namprd21.prod.outlook.com (10.173.192.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:02:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 110/136] scsi: hisi_sas: Fix the conflict between
 dev gone and host reset
Thread-Topic: [PATCH AUTOSEL 4.18 110/136] scsi: hisi_sas: Fix the conflict
 between dev gone and host reset
Thread-Index: AQHUTjK2BzzfewSzb0Cq+0svjqZHQA==
Date:   Mon, 17 Sep 2018 03:01:21 +0000
Message-ID: <20180917030006.245495-110-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0168;6:l7l2hRtHcrrbJetf6r+J6Fnd12jgFwA2ndjSuhD1NjJeGtHAR04zFrISPGWKqlc6F04Hd4bW//7/BgccbFNMrYT0X1NTaAQiRCA5vBjurzwH597lKeLvidQkbq0EO/1rqLOaIepQzY1OQPCH1L63s9fyQPCRv6c5ZWeDiazJL7Y7qL9VcWA7BwBR1BAMtgvSBlhV7fIitlPIl3JDXL9shyfYr6xV/GQ7P9AdZa/TR4hltYSP/t35kiWNvRzT4mWPQ6/wjjE0WXHWrp8GJiDQXRtXonGH4zZtiPTfyGrh31lU5PJ+2I/LtoiNQNJMHYlwgSKALVZB4U6aWmr7mV6oJ77emUW3UdJQEL1/I044tYv+Sy5xevHLIVyJf38tX/SK2VrFOK5z87D8xdBMLp7to36Rs4fPoYjFdzB2fbsUFV+nG7heitqSq8iFZPWxUx+8W5rRTcJc7Q68g6vI+AAoKg==;5:eliRdM0BErasDP8yCqpnhEmBWq8b6vyAGtVS/AY+zq6qD+KDQLqJZPfJ5GhPxFwJvAKXPy1M3Vh3B7Qw+QHGrHUGsQqpM83Nf3mAEj0jZxt8rHY+cO9YQsbaCF1QIYYbkJR++EbkNU39bJFOpzNmKnjcLRgttt4Z+Jm/KZHaNzI=;7:H4ZtmhGkpU8zAyXmhwet8zmY5gCm1B1fZJ+K5P9lv6tt6GbXF/55NpC+/prA/+Fq/6AZTHuFDj73/p3H0lOyUX0b2XC8AXUwcgDsoO/BRRY3l6hLe4SsgrdzpGAjaAd800l4Rxs6tvrzcBMMcs5MxjA7P2nEEF6XqUeCY/7OnDL27zP81zfjNMD5U6FJsTq6wLHQLuOtkH3AKBLXcZZA2aRO5bAAUmov4YEjCqRnfLf3KQ3ibMJQePdQvugnhdI+
x-ms-office365-filtering-correlation-id: e302ee54-5652-445f-a3c7-08d61c4a0a6f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0168;
x-ms-traffictypediagnostic: CY4PR21MB0168:
x-microsoft-antispam-prvs: <CY4PR21MB01682159E841527DAD22893CFB1E0@CY4PR21MB0168.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(50582790962513)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0168;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0168;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(136003)(199004)(189003)(11346002)(4326008)(105586002)(106356001)(486006)(446003)(6436002)(2616005)(22452003)(107886003)(10090500001)(25786009)(476003)(14454004)(110136005)(54906003)(316002)(2906002)(76176011)(99286004)(36756003)(186003)(26005)(6346003)(5660300001)(7736002)(305945005)(10290500003)(8676002)(81156014)(81166006)(6486002)(68736007)(6666003)(102836004)(6116002)(3846002)(1076002)(53936002)(217873002)(72206003)(97736004)(6506007)(8936002)(86362001)(256004)(6512007)(2501003)(5250100002)(2900100001)(14444005)(478600001)(66066001)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0168;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: mzCSXc20CI4zCyNqvYP7FyRo77flwlPNcVdeD7XOiWuk68pZdHs8tkDX07bWbPFpluaVcno+3HWL8NbeEnGOihxjverny05zrGZpkdJaHA1aQ8Pqzd+J5zm4m4aynANlUcigZSn50PsGpfKUP+VfdftXwtlUS8JWM+aBfPDAHP8eyYso6ZoJFPbAV9JYhVOuL+Qqc5nOPkuYnfxVGxm/JohNL62dXnHEZR+abzzEyXG6DRnrnqVrW+P+/+RuyH0c8e8HT2JpORWfiI8nnwHlvpRD9wlvFJmez2T9JHARbMhkWcSU6d+BVfkdwWik8dhXmboIVt9/9suiMyBQfWVbogr8hsaiKP6Sh8nB+SI5k0M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e302ee54-5652-445f-a3c7-08d61c4a0a6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:21.5885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

[ Upstream commit d2fc401e47529d9ffd2673a5395d56002e31ad98 ]

There is a possible conflict when a device is removed and host reset occurs
concurrently.

The reason is that then the device is notified as gone, we try to clear the
ITCT, which is notified via an interrupt. The dev gone function pends on
this event with a completion, which is completed when the ITCT interrupt
occurs.

But host reset will disable all interrupts, the wait_for_completion() may
wait indefinitely.

This patch adds an semaphore to synchronise this two processes. The
semaphore is taken by the host reset as the basis of synchronising.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h      | 1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_=
sas.h
index 7052a5d45f7f..78e5a9254143 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -277,6 +277,7 @@ struct hisi_hba {
=20
 	int n_phy;
 	spinlock_t lock;
+	struct semaphore sem;
=20
 	struct timer_list timer;
 	struct workqueue_struct *wq;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/=
hisi_sas_main.c
index 6f562974f8f6..bfbd2fb7e69e 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -914,7 +914,9 @@ static void hisi_sas_dev_gone(struct domain_device *dev=
ice)
=20
 		hisi_sas_dereg_device(hisi_hba, device);
=20
+		down(&hisi_hba->sem);
 		hisi_hba->hw->clear_itct(hisi_hba, sas_dev);
+		up(&hisi_hba->sem);
 		device->lldd_dev =3D NULL;
 	}
=20
@@ -1364,6 +1366,7 @@ static int hisi_sas_controller_reset(struct hisi_hba =
*hisi_hba)
 	if (test_and_set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
 		return -1;
=20
+	down(&hisi_hba->sem);
 	dev_info(dev, "controller resetting...\n");
 	old_state =3D hisi_hba->hw->get_phys_state(hisi_hba);
=20
@@ -1378,6 +1381,7 @@ static int hisi_sas_controller_reset(struct hisi_hba =
*hisi_hba)
 	if (rc) {
 		dev_warn(dev, "controller reset failed (%d)\n", rc);
 		clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
+		up(&hisi_hba->sem);
 		scsi_unblock_requests(shost);
 		goto out;
 	}
@@ -1388,6 +1392,7 @@ static int hisi_sas_controller_reset(struct hisi_hba =
*hisi_hba)
 	hisi_hba->hw->phys_init(hisi_hba);
 	msleep(1000);
 	hisi_sas_refresh_port_id(hisi_hba);
+	up(&hisi_hba->sem);
=20
 	if (hisi_hba->reject_stp_links_msk)
 		hisi_sas_terminate_stp_reject(hisi_hba);
@@ -2016,6 +2021,7 @@ int hisi_sas_alloc(struct hisi_hba *hisi_hba, struct =
Scsi_Host *shost)
 	struct device *dev =3D hisi_hba->dev;
 	int i, s, max_command_entries =3D hisi_hba->hw->max_command_entries;
=20
+	sema_init(&hisi_hba->sem, 1);
 	spin_lock_init(&hisi_hba->lock);
 	for (i =3D 0; i < hisi_hba->n_phy; i++) {
 		hisi_sas_phy_init(hisi_hba, i);
--=20
2.17.1
