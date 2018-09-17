Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A37ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D74208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Y+rIsDN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D74208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeIQIZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:53 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:35861
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728603AbeIQIZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrV6RP7izp2Szf+NaQCfJM/2vbaKonKyyaux3vW7Ww0=;
 b=Y+rIsDN+idjl7vYLSiP0CPweOf8NZv6lLllnIXD2wQeclkUzHg4pJYJ7j4yQf/9QGp/cGSg8YvKS5g3CCRZchdPYOBbUiVc99EWIb3k4brrp6PGpY+8bHNa8rsatKD8wQJ/gyDtLAta2MS5zM8oGbiIznxqgLZ1jMZohuLPEqck=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0277.namprd21.prod.outlook.com (10.173.193.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:00:26 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:26 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Niklas Cassel <niklas.cassel@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 022/136] iommu/msm: Don't call
 iommu_device_{,un}link from atomic context
Thread-Topic: [PATCH AUTOSEL 4.18 022/136] iommu/msm: Don't call
 iommu_device_{,un}link from atomic context
Thread-Index: AQHUTjKUi34qJdL9Yk+m/1q8eMFKIg==
Date:   Mon, 17 Sep 2018 03:00:25 +0000
Message-ID: <20180917030006.245495-22-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0277;6:+xvcczahC1wg0cvVqjZBEVhqsxnTfLMaN/lOVD0zl84G4ewds+TapQm5mzGjzzYAyJ973g8/RoeoEUj5/nhCViZmSQuiyLWiN5vRxcmx/OPVi+J5te0hEfIvZ3VU+B0qi49i0HXyXBYcgNJjLmydd8JIiE+ulY+cZVWX4j+vg0gwWVnRox8Oga4w0IfXFhuLYGfid0he4NM7i49I8t2GPcnMAHlIzJjsJTxpt/Dxlr8XDPN741OpGHiGnAT6a/8nEdlmMck5a41Bw/lKatgU4QUOH4NV+C5V6bw8kfoGO0afeMxNgzQy0+DmCtE0b45uS8IWtPMTp2OfD3ZTm3gRDIBE2fV/VFDJqmdW4kZkW5Nj+0nZ2IwPQ3Nv7XODIh2MKIC+JqT+XMjFJ7O/NdZjTgzxB4WbskY56JubwcxPvw6PHqs0KCQFj+vo9DLC10H9yglULL90K/w9r+bq6XrDYw==;5:jjCei3ZQ9xXfDYba5ur8XXWDdvFUJvR3FH/MmTma+M7a0KtV6imOBbhmzAte/Fz/m1gocGHH8R2qZcwHbFaTUJd1it/tegW4AKe0PGSsbjyxdV0T2dKHW8Inp5NupAqRdVUDGRk4aPBcvelQcvXnPu1GPI0UC6uBvlt4vcENR7A=;7:XAAASJ+QVPWpCtxaT9xcAJgMRG2L3C6erRhgMRUjdkAoHJGCz6B1qEPUQrpMEzUR24y0OGFt9CocthA8aqCH8H+WI+6iVyLME+zqj1xsqAbmc1i5qxjCvgrXohTYsLpcz4Aa64xJBOqmBsqHkwBv20iH+nvsBdhq/hZaaGMb5IGNcu0o1xK8zJ8HZxUZrGyRQIgNvXJQu1A1f1Na+0yNBtGWlqizVDk5Oo0M0PxfXW+Zt1AcnFdk1xUVYuLGcTEq
x-ms-office365-filtering-correlation-id: 0cd61067-d5cf-4225-12e0-08d61c49b81e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0277;
x-ms-traffictypediagnostic: CY4PR21MB0277:
x-microsoft-antispam-prvs: <CY4PR21MB0277719E6A7C5DE65C77FFD4FB1E0@CY4PR21MB0277.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0277;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0277;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(376002)(136003)(39860400002)(51234002)(199004)(189003)(446003)(4326008)(2616005)(53936002)(107886003)(11346002)(22452003)(68736007)(486006)(316002)(14454004)(106356001)(476003)(217873002)(25786009)(105586002)(10290500003)(14444005)(5024004)(97736004)(66066001)(6486002)(6436002)(5660300001)(256004)(5250100002)(6512007)(2906002)(2501003)(6346003)(99286004)(72206003)(2900100001)(26005)(6116002)(186003)(1076002)(36756003)(81166006)(6506007)(10090500001)(81156014)(86612001)(102836004)(575784001)(86362001)(8676002)(54906003)(8936002)(110136005)(305945005)(76176011)(478600001)(7736002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0277;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: imsiGgwppUrdCIyLU+mq5KMl7ak1611Z+SJ13WiNMCRgsEaiMJ5OJ1BE6IWFdQ77hPH35TvkWz+u9oLzGHdVW2iSHSH6k/Kt2aAf10DHjfrK5zfBBTQuQeb0I1iecbotNloivF8y+KV0qYYF6IQw9fHzLUaGYWdqO4a+fFMzrauM0kVgcaXL9QvF1ns7AayrIXWUA9wlL2tAFBHeha8EtUECYc92DWaEzpQMPny/rdYA9sbmA5mrDmML7MxfyghrJJvTbsZg5t9Xp4RYMgmVGobiD/tIBeqUpQZmNaN93VjYSQ7QBDGH2yXx7jABI5nK9WqAPi7OhvNjci2XvQ/i3QFZiIJcnofGpUqY/t7THmA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd61067-d5cf-4225-12e0-08d61c49b81e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:25.1048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0277
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>

[ Upstream commit 379521462e4add27f3514da8e4ab1fd7a54fe1c7 ]

Fixes the following splat during boot:

BUG: sleeping function called from invalid context at kernel/locking/mutex.=
c:747
in_atomic(): 1, irqs_disabled(): 128, pid: 77, name: kworker/2:1
4 locks held by kworker/2:1/77:
 #0: (ptrval) ((wq_completion)"events"){+.+.}, at: process_one_work+0x1fc/0=
x8fc
 #1: (ptrval) (deferred_probe_work){+.+.}, at: process_one_work+0x1fc/0x8fc
 #2: (ptrval) (&dev->mutex){....}, at: __device_attach+0x40/0x178
 #3: (ptrval) (msm_iommu_lock){....}, at: msm_iommu_add_device+0x28/0xcc
irq event stamp: 348
hardirqs last  enabled at (347): [<c049dc18>] kfree+0xe0/0x3c0
hardirqs last disabled at (348): [<c0c35cac>] _raw_spin_lock_irqsave+0x2c/0=
x68
softirqs last  enabled at (0): [<c0322fd8>] copy_process.part.5+0x280/0x1a6=
8
softirqs last disabled at (0): [<00000000>]   (null)
Preemption disabled at:
[<00000000>]   (null)
CPU: 2 PID: 77 Comm: kworker/2:1 Not tainted 4.17.0-rc5-wt-ath-01075-gaca05=
16bb4cf #239
Hardware name: Generic DT based system
Workqueue: events deferred_probe_work_func
[<c0314e00>] (unwind_backtrace) from [<c030fc70>] (show_stack+0x20/0x24)
[<c030fc70>] (show_stack) from [<c0c16ad8>] (dump_stack+0xa0/0xcc)
[<c0c16ad8>] (dump_stack) from [<c035a978>] (___might_sleep+0x1f8/0x2d4)
ath10k_sdio mmc2:0001:1: Direct firmware load for ath10k/QCA9377/hw1.0/boar=
d-2.bin failed with error -2
[<c035a978>] (___might_sleep) from [<c035aac4>] (__might_sleep+0x70/0xa8)
[<c035aac4>] (__might_sleep) from [<c0c3066c>] (__mutex_lock+0x50/0xb28)
[<c0c3066c>] (__mutex_lock) from [<c0c31170>] (mutex_lock_nested+0x2c/0x34)
ath10k_sdio mmc2:0001:1: board_file api 1 bmi_id N/A crc32 544289f7
[<c0c31170>] (mutex_lock_nested) from [<c052d798>] (kernfs_find_and_get_ns+=
0x30/0x5c)
[<c052d798>] (kernfs_find_and_get_ns) from [<c0531cc8>] (sysfs_add_link_to_=
group+0x28/0x58)
[<c0531cc8>] (sysfs_add_link_to_group) from [<c07ef75c>] (iommu_device_link=
+0x50/0xb4)
[<c07ef75c>] (iommu_device_link) from [<c07f2288>] (msm_iommu_add_device+0x=
a0/0xcc)
[<c07f2288>] (msm_iommu_add_device) from [<c07ec6d0>] (add_iommu_group+0x3c=
/0x64)
[<c07ec6d0>] (add_iommu_group) from [<c07f9d40>] (bus_for_each_dev+0x84/0xc=
4)
[<c07f9d40>] (bus_for_each_dev) from [<c07ec7c8>] (bus_set_iommu+0xd0/0x10c=
)
[<c07ec7c8>] (bus_set_iommu) from [<c07f1a68>] (msm_iommu_probe+0x5b8/0x66c=
)
[<c07f1a68>] (msm_iommu_probe) from [<c07feaa8>] (platform_drv_probe+0x60/0=
xbc)
[<c07feaa8>] (platform_drv_probe) from [<c07fc1fc>] (driver_probe_device+0x=
30c/0x4cc)
[<c07fc1fc>] (driver_probe_device) from [<c07fc59c>] (__device_attach_drive=
r+0xac/0x14c)
[<c07fc59c>] (__device_attach_driver) from [<c07f9e14>] (bus_for_each_drv+0=
x68/0xc8)
[<c07f9e14>] (bus_for_each_drv) from [<c07fbd3c>] (__device_attach+0xe4/0x1=
78)
[<c07fbd3c>] (__device_attach) from [<c07fc698>] (device_initial_probe+0x1c=
/0x20)
[<c07fc698>] (device_initial_probe) from [<c07faee8>] (bus_probe_device+0x9=
8/0xa0)
[<c07faee8>] (bus_probe_device) from [<c07fb4f4>] (deferred_probe_work_func=
+0x74/0x198)
[<c07fb4f4>] (deferred_probe_work_func) from [<c0348eb4>] (process_one_work=
+0x2c4/0x8fc)
[<c0348eb4>] (process_one_work) from [<c03497b0>] (worker_thread+0x2c4/0x5c=
c)
[<c03497b0>] (worker_thread) from [<c0350d10>] (kthread+0x180/0x188)
[<c0350d10>] (kthread) from [<c03010b4>] (ret_from_fork+0x14/0x20)

Fixes: 42df43b36163 ("iommu/msm: Make use of iommu_device_register interfac=
e")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iommu/msm_iommu.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0d3350463a3f..9a95c9b9d0d8 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -395,20 +395,15 @@ static int msm_iommu_add_device(struct device *dev)
 	struct msm_iommu_dev *iommu;
 	struct iommu_group *group;
 	unsigned long flags;
-	int ret =3D 0;
=20
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-
 	iommu =3D find_iommu_for_dev(dev);
+	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+
 	if (iommu)
 		iommu_device_link(&iommu->iommu, dev);
 	else
-		ret =3D -ENODEV;
-
-	spin_unlock_irqrestore(&msm_iommu_lock, flags);
-
-	if (ret)
-		return ret;
+		return -ENODEV;
=20
 	group =3D iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
@@ -425,13 +420,12 @@ static void msm_iommu_remove_device(struct device *de=
v)
 	unsigned long flags;
=20
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-
 	iommu =3D find_iommu_for_dev(dev);
+	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+
 	if (iommu)
 		iommu_device_unlink(&iommu->iommu, dev);
=20
-	spin_unlock_irqrestore(&msm_iommu_lock, flags);
-
 	iommu_group_remove_device(dev);
 }
=20
--=20
2.17.1
