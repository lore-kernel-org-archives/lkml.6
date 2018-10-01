Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45F0C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795D720666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="h1qE+Na1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795D720666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbeJAHO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:14:59 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:2013
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729495AbeJAHO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti2D4wPCO1RAmcjHw5vbn+GPt5687iuo5HiAhBHQqSQ=;
 b=h1qE+Na1kydaH4bAjGgrJD3Pm36pYvaAhVd/VMT7ZhzWJ42Hoajo1FX2CqKzDEv3LO06B/ShuHT8cE65mULr3tNH5AeifN0Mvcra8BqwbVdHqmRUZZL+VN6xP6eoHYd2gVG+YWCFW7V/X1p1Y1kaxPPmTgQPtihDuoxuQ4yTU4M=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:39:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Jurgens <danielj@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 17/37] net/mlx5: Consider PCI domain in search
 for next dev
Thread-Topic: [PATCH AUTOSEL 4.14 17/37] net/mlx5: Consider PCI domain in
 search for next dev
Thread-Index: AQHUWR8nq4GBsqUn40C2x8s0kwYo3A==
Date:   Mon, 1 Oct 2018 00:39:04 +0000
Message-ID: <20181001003850.147107-17-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:eZQHJxP4KIfwbiBexj0ea2s5Cgl7Yq90SN+x576/4p/UOyx6A6ETdQKR/4LxOZBuWHThSfrBVtmYC9tKVljs5YyswqqIo5Px7cpIo7Pig4mRtNPJVWbGNTjs+EdN6dD91/u6mEZL2QMUsXA/ofeb/Bc5HoAaQqo9mNRk1pFK5ctniYi46KFs6qZXoseV9psF5w7aapWSnqfMM66Nr6S1JQU4KTsbpYoJpFd8nXOO6+4VZXQZarGDx8i4+KMwCpbH7xEzpKbZd0ThFDTU0OpCOwmTjxSdRNJj48qr1GEuhkFWEwUlyMe3BNO9arOdfC0cvozRseYs8OsTG18XuysVa9e+3JoESPfjke/ZYlMhyHIvidz6bB0or0HjtckxhhlNnRxNWVRLkvlihBwxFBKGSZ7MXJ0oGyiceM54gbNB3SHvMSJq3VTNC7knYWWj/3np0sWWRlkKcVzGKiz9wrKdtA==;5:4Yk1KoihuQ+inRH/5l5mLwMhaZfKe82cJ2QFh4i9y0i4rmcHp2999oX9LntM5pc+KLuJoxOlQQzglbyYndi8s1A6z2OTqVdSzF0v/sS7sZoiNl2Awrl28K2QNTfQ+ff8/JEzeUEurSjsATi2vqO5RQzU1D6cXUzfX9AI5U7GGC0=;7:jEzcwKMCjjzZQJ8XAsex6T6jWChwXnZM07lsqt3c//312WFG7C37FbC+vpJhmeaWDfxCIL188fW8/3NA58YM0/lIngC5c3IhDS/kyNAgKmcVpeTSK9vEs6vSsSnp4mC/r417DhN0HHqYLALJnR7AV49z2I++FudDm2j8aK6jkHlOEfvr6zO+Y+t6o5mRqh4zw3n4MstFxcHtnITsYkWd9djDHfoDz63lqX/Xoj/il9JLfTGUDy9oddyesZCvXZNx
x-ms-office365-filtering-correlation-id: b3d413d8-7486-46e6-c4c7-08d62736618d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB0854572499CA521C887DFB47FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: WTl/0vpOpzSEYlN1bVwxYjxPtmB5s/vnlJsSqP2QhiJq3bkGEbiD8EIA1p6duZxhGq6SAM54GbnM6UBmEVSHitPIxwY/A0Ll2RSu/SIJXDMyxJx2h45aaVEfNCkUcPUl/sQTjc9evnA9rTM4kGPMH5C2TMTUI/4vk+34tIuCWf9kT2PV3HJ5R+fujMoSfS5ptDAcHjtt4XLLPoBfKKzka67327w5NuPY7LTUuekQU0yEpCEuGgtkfmH+73BlWgWPgPHKP933shafeWbT88rtVw9G/drrmmYSeO5Mc5xqZL3JlCftTXFE4Zlc7ng+Z1pN56eAqAamTT6ome3Z+dzTvj6bYsY4OCUMEhin/gZUByc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d413d8-7486-46e6-c4c7-08d62736618d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:04.0242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jurgens <danielj@mellanox.com>

[ Upstream commit df7ddb2396cd162e64aaff9401be05e31e438961 ]

The PCI BDF is not unique. PCI domain must also be considered when
searching for the next physical device during lag setup. Example below:

mlx5_core 0000:01:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(128) RxCqeCmprss(0)
mlx5_core 0000:01:00.1: MLX5E: StrdRq(1) RqSz(8) StrdSz(128) RxCqeCmprss(0)
mlx5_core 0001:01:00.0: MLX5E: StrdRq(1) RqSz(8) StrdSz(128) RxCqeCmprss(0)
mlx5_core 0001:01:00.1: MLX5E: StrdRq(1) RqSz(8) StrdSz(128) RxCqeCmprss(0)

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Aviv Heller <avivh@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/et=
hernet/mellanox/mlx5/core/dev.c
index 9f9c9ff10735..07fda3984e10 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -388,16 +388,17 @@ void mlx5_remove_dev_by_protocol(struct mlx5_core_dev=
 *dev, int protocol)
 		}
 }
=20
-static u16 mlx5_gen_pci_id(struct mlx5_core_dev *dev)
+static u32 mlx5_gen_pci_id(struct mlx5_core_dev *dev)
 {
-	return (u16)((dev->pdev->bus->number << 8) |
+	return (u32)((pci_domain_nr(dev->pdev->bus) << 16) |
+		     (dev->pdev->bus->number << 8) |
 		     PCI_SLOT(dev->pdev->devfn));
 }
=20
 /* Must be called with intf_mutex held */
 struct mlx5_core_dev *mlx5_get_next_phys_dev(struct mlx5_core_dev *dev)
 {
-	u16 pci_id =3D mlx5_gen_pci_id(dev);
+	u32 pci_id =3D mlx5_gen_pci_id(dev);
 	struct mlx5_core_dev *res =3D NULL;
 	struct mlx5_core_dev *tmp_dev;
 	struct mlx5_priv *priv;
--=20
2.17.1
