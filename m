Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F2DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE7F2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Rfp7dGq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE7F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730029AbeIQI3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:02 -0400
Received: from mail-eopbgr680131.outbound.protection.outlook.com ([40.107.68.131]:11025
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729938AbeIQI27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlSx/xIZIXt2oyb+V8xqZ2cgHkgVdyIGE4Y9wbrjXtY=;
 b=Rfp7dGq98Ibwmq48MXtv3CMVnVU4N155Nzu6gH6qu4cOOSr/Kr7yZpw8MuTHnGgvytmzHONic01IzJJ+2FXli9bMBRwlKhhOCUbqY2TiY1srweBDqn7O3CFGWmhh0QYviZq9ptsU8+6XWEL+ElCNkSdx4Oto6P9wsBkElHlCpHY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:03:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 21/87] RDMA/i40w: Hold read semaphore while
 looking after VMA
Thread-Topic: [PATCH AUTOSEL 4.14 21/87] RDMA/i40w: Hold read semaphore while
 looking after VMA
Thread-Index: AQHUTjLjqjMD1llMRU2dvEcuIhO75A==
Date:   Mon, 17 Sep 2018 03:02:37 +0000
Message-ID: <20180917030220.245686-21-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:hB+N8m24wK0z7Oyo3PGZJWrgiDrYOX0F+EUeskOzArca5aPZabNz84YToxLAANwD5D8VEGtXR0kQWRAnaeTswiKqsqkfcjgr2/pwXARrqGDVNAS7m6SAsXQTWHTRNaxGcOjp+RWMKs11ZSOsFNIrq5etMXhyNub0V4QtCDeae2SfemmY2Kg3AhT5Eix1ztpQB+fQjj8uFJEkb9EdSZRTTCMJqRifF2ahXGvjvuTKHGf5Xbv68sD0DEXSn8jvdabhxNsfS7r3iDI7xj38cUMQtXi3kiWRSCxwwNJM5/vCdniIGKX82dwafhuRCb2HFAWHKRs4NTM+8Y+QtPAvXtKl4ZOv+WydVNCTu/E240N6uYdQBQtJqOMxRCdHrTEStvXPuWc1rao43G+SrtMzvbdNAQJWJsgrpVY72ZCF1Gg+7OtdqJpJnxZQnEZpR5cGlupMHhMtBSt6easklCfsMOCDbA==;5:3qtaLxexIGUB22KYbIA00hezv0bzJrAjx77XK/EwGzLe79Z7s6YZoc/BFIya7rpEpAV5mZSFTHOgWTkgDJ4A47HPRomMKhXB+wVBqAujtCcnC1+1WzR47qK/aKoTUJj/aUIaoeQA+q9PiuE/5JnqftQdUMssV3RXrVDHpnhz82A=;7:gWL7/qygS64ylYwwKm74hDmLTottnViGuhPaQsMNjhxL4otXHR8D1+EOnFYZzq7mG1yTbkysF6lSN6AjoeIPVTFoVHVJwDhOPhlBTDtY/LVmzFsw0+jWe5T+QVdl2yPw3t5DKSDFaT+9f2Qe7HeRq7neBVs21MZ6ZydSJ1P0CF9n8Y5b0g+GTnPZiUPbgl9qUhZjkYpDIRrv4X0C02MFb+NKzj21oBIzOQBREai9fTM9iXGSHhdYJTsMtmMKi3sY
x-ms-office365-filtering-correlation-id: b144d5fd-4b40-40d7-8f8d-08d61c4a29c1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB047000BE20477722D44D7E1CFB1E0@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(1076002)(25786009)(4326008)(107886003)(5660300001)(3846002)(6116002)(54906003)(110136005)(22452003)(316002)(86612001)(76176011)(53936002)(6512007)(68736007)(7736002)(305945005)(86362001)(575784001)(2900100001)(256004)(66066001)(8936002)(11346002)(446003)(10290500003)(6486002)(14454004)(81156014)(486006)(6506007)(2501003)(99286004)(26005)(2906002)(10090500001)(478600001)(72206003)(105586002)(6436002)(102836004)(186003)(8676002)(2616005)(476003)(5250100002)(36756003)(81166006)(106356001)(6346003)(97736004)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 6feAIxQRZHMZHBIGpqj/2iZxhhgC1oeX+cml+OPlt4tDOAUwIPRenYsWPZZP9JbsDKEOoAzRRO8SuNy/nPIfGhDD6D0fsC34131y+SIMmxiAKE9kLU+svc6/d0rWp0W+OIAWK9dlgZPpj+dKHQc/+ZJv/OsUbaKlk8ekcu3xTgh+RBUQCSLVxrdSJLMrHu5k7hL/PcpC4MQakFxiWV1+r8cIFMMBIP38bqHqLaO6jk2jD/+xBImhHIOhJNdSuhr+eWcgZvdrdLp/sKXUWcNo7bbylC5AJhsaJj8aUnKHHUu7ULAqBym+znOlldbxMqPHavpGLMR37uLxVCAPKPsUBDxuEzW7AzM5B/rrj8tB/rk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b144d5fd-4b40-40d7-8f8d-08d61c4a29c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:37.2750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
index b7961f21b555..39398dd074d6 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1408,6 +1408,7 @@ static void i40iw_set_hugetlb_values(u64 addr, struct=
 i40iw_mr *iwmr)
 	struct vm_area_struct *vma;
 	struct hstate *h;
=20
+	down_read(&current->mm->mmap_sem);
 	vma =3D find_vma(current->mm, addr);
 	if (vma && is_vm_hugetlb_page(vma)) {
 		h =3D hstate_vma(vma);
@@ -1416,6 +1417,7 @@ static void i40iw_set_hugetlb_values(u64 addr, struct=
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
