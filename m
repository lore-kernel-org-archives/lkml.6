Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646FBECE562
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C22521521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 02:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="CByruXM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C22521521
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbeITI3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 04:29:01 -0400
Received: from mail-eopbgr700094.outbound.protection.outlook.com ([40.107.70.94]:25376
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387719AbeITI3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 04:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5s82SZxOG+WLmwHSXxTF6Xt24uI0ZGgLIK89ulx88bU=;
 b=CByruXM7+/5GGiVeiOZxynyHSRcbHy9vXfEknYZm8/4+oy97be2S1RhQlFVWu3lNzMnbj9+FlDZDH2Dm9D043RR3RP1tSN9qwmUlVo9BPan3GwxvSfGj6yyCnavUzYCT/tvxAW+K2P29ZxcghbKXpOMUD9joWILn4ydiX6pxzIs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.6; Thu, 20 Sep 2018 02:47:47 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.010; Thu, 20 Sep 2018
 02:47:47 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Huazhong Tan <tanhuazhong@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 26/56] net: hns3: fix page_offset overflow when
 CONFIG_ARM64_64K_PAGES
Thread-Topic: [PATCH AUTOSEL 4.18 26/56] net: hns3: fix page_offset overflow
 when CONFIG_ARM64_64K_PAGES
Thread-Index: AQHUUIxPFJqLEon8CEm41ZlmR3vBhw==
Date:   Thu, 20 Sep 2018 02:47:45 +0000
Message-ID: <20180920024716.58490-26-alexander.levin@microsoft.com>
References: <20180920024716.58490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180920024716.58490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:lRF4cl1vO70SMn9O/n3W6ihcuZpT3u1qFt6DKJr0tnBBCkL0j+buL4btw7/B66MiHuyxCtREQPl9tHZ2n829Fk61dVfGLJmC93EKEDG6zRH0RGYziVHwR9eBSUZ+r+lGjnAAh2rJrWYn7/cZwmBMWrL5sfhEmxXpSxfVgy7z4pAJl/a78v7jlhMQIAV7zVmw6bth6wRlYYqYBtMiVIgAK+0shKg8Txrd0UxtSLHnBgmHcyVHU1TmbeKHvlCnjMPpnsDV4/gGZ6Rf/cQWESR60VgnfMzqXXqAnDBNG8mZjAYSA8LEv65y0JIZOe9Sb5LHk5LdkUY4FpCAYgqfApYIBU+IoTOco8/iLk/jI/Hp6L3hhgVasxthELKtOUHlBtsbw0iFLXRHSCK0I8CI++9T46UyIIQBC0rVk7Gs1EoIPIKuYVrw+zpyHy0kzjBdrlYROVCCkcEZm/0c7bFFxuUwAw==;5:UQFpF7A8Ef5XK5NBUWaWMLh5EWNXoKUbQWDGIhx13uWRUqaDO8Td0uPj5Bh7KfhC8yxU1Pprekqq9ckH/WmZV9LWSqtkmj4ArBoUGHE3LyTxuekMZcn/6H0iqXhFrSBv45iqK74MyIx3KL1kH5zpESTX0gglsqmlphF1ASgD84Q=;7:Xutw6mw7XpyAb01WCIr7x8pux5w7S47wcgd3xAuakBlTz78Pi5z7a31C3/kMk5D8xlSjqWrrm6wzMuPkdaQh6fGAtyWgIKMQk7EqNRNgkRBt/LBM1iguzrBSTz9Wiwm3/mXpTtjTeTe485e3s9PR4YZq/VFbRUv2/lSpDrhrnL9ZZQWO14sZsc50uzdc0PJlB7iHCw0TfM3q8ZP+OpjCyey2022W5Q+n5phL+ji1kbXm96uRGVX70u2g+GeUidFL
x-ms-office365-filtering-correlation-id: 0b2dc3ef-c904-45ec-fc3a-08d61ea37299
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
x-microsoft-antispam-prvs: <CY4PR21MB0822A2F8EFEECEC49325C4A4FB130@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(50582790962513)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0801F2E62B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(136003)(39860400002)(199004)(189003)(10290500003)(6512007)(54906003)(110136005)(2501003)(2900100001)(86612001)(446003)(6116002)(15760500003)(316002)(81156014)(81166006)(1076002)(26005)(8936002)(22452003)(86362001)(575784001)(2906002)(107886003)(2616005)(486006)(256004)(99286004)(66066001)(5660300001)(6506007)(217873002)(5250100002)(102836004)(186003)(3846002)(4326008)(6436002)(11346002)(25786009)(68736007)(71190400001)(71200400001)(8676002)(476003)(6346003)(6486002)(36756003)(14454004)(106356001)(10090500001)(53936002)(305945005)(72206003)(76176011)(7736002)(97736004)(478600001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: B6G8Vv+lUDlDHJRJCzbQ2WnFi4xGfFJ1IgemfSzXN8wFHpsKRjGZFmuamqVE90KCV8gkgfbVf6Bro84cdGT1t/5DgYd3ECh6T8MSrFDRAZAx5CnAlgga4KdLb/jKEz46UHDp+oA9euOhj9R3XyLl0mVGuB2IbBQHZf+DoiAZg0oKe4j6+JAS8QIyE2BtAAVtSqKOg/tPY5pA2kNCaLZRUblizyKO5Kie3pAvpAZQjAV/Kmuh9ltf4J96NPi2CDuTW/jlT8+GGWeUme7JwGmQguBbX8z/a7AarjWFeFbU/veKMnDwOWrV7xBoG6geci+vZtnUb2u/Dq0m7h4iZQU7mmWRG+09KpNHXCLLvIcjJ1Q=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2dc3ef-c904-45ec-fc3a-08d61ea37299
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2018 02:47:45.5232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit 27a5959308559fa6afcaa4e6cd81d25bcb2dda7c ]

When enable the config item "CONFIG_ARM64_64K_PAGES", the size of
PAGE_SIZE is 65536(64K). But the type of page_offset is u16, it will
overflow. So change it to u32, when "CONFIG_ARM64_64K_PAGES" enabled.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hi=
p08 SoC")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/=
ethernet/hisilicon/hns3/hns3_enet.h
index 3b083d5ae9ce..c84c09053640 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -290,11 +290,11 @@ struct hns3_desc_cb {
=20
 	/* priv data for the desc, e.g. skb when use with ip stack*/
 	void *priv;
-	u16 page_offset;
-	u16 reuse_flag;
-
+	u32 page_offset;
 	u32 length;     /* length of the buffer */
=20
+	u16 reuse_flag;
+
        /* desc type, used by the ring user to mark the type of the priv da=
ta */
 	u16 type;
 };
--=20
2.17.1
