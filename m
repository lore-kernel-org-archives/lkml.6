Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E71ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657612147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="m8gB/gWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657612147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbeIQIZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:25:48 -0400
Received: from mail-eopbgr730129.outbound.protection.outlook.com ([40.107.73.129]:39303
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728603AbeIQIZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXDqGA58exTUVLMsI4lOk6xp4SAvvmkB82nMFlN6aNo=;
 b=m8gB/gWS/F+iK20DlqtofXmXRmYp1JlpJCRlc8WNJKxZpGXoLhptoXVaLYubOMsvYI7DpKPnIyxq2FDHTAhHGti/zDj24nkM2qQ00EbN+SwuapXfSxURQ3LaQvW8K1VmG7r6Kvl/BDNkaHZccX3g+KkjMp1Ewf7fZCXf2T8Cux0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.13; Mon, 17 Sep 2018 03:00:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:00:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 030/136] RDMA/i40w: Hold read semaphore while
 looking after VMA
Thread-Topic: [PATCH AUTOSEL 4.18 030/136] RDMA/i40w: Hold read semaphore
 while looking after VMA
Thread-Index: AQHUTjKYYBbULfqBBECc0DyDObwFXA==
Date:   Mon, 17 Sep 2018 03:00:31 +0000
Message-ID: <20180917030006.245495-30-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:KcAemVv4Tf2qjsTyzXtza9RTTfs+mzUN4koxc303A4oLi6eaDR19FyisS7iPmEFWiWp+kJa4gXgQey6uT10SdkjaD7NhNEigxIqx07z3ViQUxY2ZxaWXh4rGINxzWI1Ro2U5JY4dygFDu+jfBo9LfQyTJTJG+asdv1IL+T1Kth9gH2h58dF5Boq/VVMuBUAp12nPHot/mFwhpV+ZoxQ1iCN57Jsn3LU00fQ9Ir49prPe2I56Bo4qlY/hsl2KDYZitF1gBuTuOLAL3GYZeNkYHZQSoIkxx1C6SJh1XDQVzGffoUbrs1Mg6wW62R+aobtUwau4hqBvnSnBsn2LXoiksZV+QAdj4XXJg6V74ykrPt1Agj/oseVYt/Kg4zXccYey6jldKaKKi6hr7L9sXMbRczQ4qS0CF+RW81vp4SzJ9W679cXQHlWfPXMBZm2esNnZ71gbKg/OF6UwhB10n1zIKA==;5:qhS68SLE31ba9EkwUNN/rCCp5RIfXrvKTTePm634QdBxO2EYpmRGjvSbr7yzODdePK1UDngJt7Tqdw+dlWZCekD5ENkhgqBDT74Egqm5WAaxAtVYj4+1o523YxyDIlrJ+zCfwqPNi86dPcK4IEI+0FByLoa7awlkhZEtXOXtFJQ=;7:8VwEKxCmYkAUFsV2LmsgkMXXRwIPmbnOXVbIeIgmrCts9e3mboXxFxSKTNsRsTusQFJd4e4JMJiM4gNf/Hllbyf/qViswlfmZZbU7eAVFC5dULYNNXTCc1N2ZA/rYJAV0zUuwnhFJfJIMoq/K/sdEpyPiC+VD41a9j3QkQ2rDMQhblO+9hV8/wz505NhUELO5TgqlG6Tu0cNRyS0BoNe3bhVxzcNxW9ceVT9uV2/mApnahGtTrXLB/5oOWywF4sv
x-ms-office365-filtering-correlation-id: 52d7eb16-3336-4e88-3dd8-08d61c49baf5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0629D4129DD87968118AFE58FB1E0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(366004)(39860400002)(376002)(396003)(136003)(189003)(199004)(76176011)(1076002)(86612001)(105586002)(22452003)(5250100002)(7736002)(68736007)(4326008)(86362001)(575784001)(2501003)(99286004)(6116002)(3846002)(36756003)(107886003)(72206003)(25786009)(106356001)(14454004)(6436002)(5660300001)(10290500003)(486006)(2616005)(446003)(6506007)(11346002)(97736004)(256004)(476003)(478600001)(305945005)(217873002)(81166006)(102836004)(6512007)(8676002)(6486002)(2906002)(66066001)(2900100001)(186003)(26005)(54906003)(316002)(53936002)(8936002)(10090500001)(81156014)(110136005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wfGHvbQDy06+ZwCYqEKD7Eccm84GkIOIPjHq0W4+IF8vzZlJGqTjSV3T704sHo9JT6J3caUR6Q+5vgacHz8KlpTpoLMe6upd3YytoFbcVCBFR7TL5ESTz4LR4t2456vTsxYSFyhdbo1YIi73AujmMzDxXeukISKwiAEZPIAZGQSLv/VGKA7joEGlNLMfUWaHedGBzDq4rEm01lgyVFEcqZaFYUDw7Z/v/uv499e2ZtCcUnJ5807K0lvppvoETP14lHL62Jqa/NeE+X783CkUlbL3/fHdoVk8IaWMDZ/TEzJXQHyRSDTZYMBveK3PVcbYBROiJ3oI9qbUQH/hIiR2pUwi5n/Jz5W4klM0631Vg60=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d7eb16-3336-4e88-3dd8-08d61c49baf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:00:31.0734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

[ Upstream commit 5d9a2b0e28759e319a623da33940dbb3ce952b7d ]

VMA lookup is supposed to be performed while mmap_sem is held.

Fixes: f26c7c83395b ("i40iw: Add 2MB page support")
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband=
/hw/i40iw/i40iw_verbs.c
index 68679ad4c6da..937899fea01d 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1409,6 +1409,7 @@ static void i40iw_set_hugetlb_values(u64 addr, struct=
 i40iw_mr *iwmr)
 	struct vm_area_struct *vma;
 	struct hstate *h;
=20
+	down_read(&current->mm->mmap_sem);
 	vma =3D find_vma(current->mm, addr);
 	if (vma && is_vm_hugetlb_page(vma)) {
 		h =3D hstate_vma(vma);
@@ -1417,6 +1418,7 @@ static void i40iw_set_hugetlb_values(u64 addr, struct=
 i40iw_mr *iwmr)
 			iwmr->page_msk =3D huge_page_mask(h);
 		}
 	}
+	up_read(&current->mm->mmap_sem);
 }
=20
 /**
--=20
2.17.1
