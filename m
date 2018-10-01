Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33083C004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB3820666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WlfQDMmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB3820666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbeJAHPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:51 -0400
Received: from mail-by2nam03on0129.outbound.protection.outlook.com ([104.47.42.129]:45056
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729864AbeJAHPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMdt/YOp7of5ZtLzbmtHv3Xf/AkMXGAYAcdcC3+NuAM=;
 b=WlfQDMmcEWqcfaFzGlV2uxoSLxGiOZHcwJ4dMALiNP4fKLcu8hOyhRKtgRmRHGnj6U60rlhpNi9oXa6BADzO2aq7ViRb0GQ5zc/QxCL3Lu6C7vn0G37iCSYmm6lnY9MBFMr3GL2TXX0CQApU0rdhchuO+3/ZItS8476f0nCv+ZY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.3; Mon, 1 Oct 2018 00:40:35 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:40:35 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Jurgens <danielj@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 10/26] net/mlx5: Consider PCI domain in search for
 next dev
Thread-Topic: [PATCH AUTOSEL 4.9 10/26] net/mlx5: Consider PCI domain in
 search for next dev
Thread-Index: AQHUWR9dbb6G+9lhVkWSMZYplviTrQ==
Date:   Mon, 1 Oct 2018 00:40:35 +0000
Message-ID: <20181001004026.147201-10-alexander.levin@microsoft.com>
References: <20181001004026.147201-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001004026.147201-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:ygtr/wxjzPobYvduVaW9GXYNKhPga9NcgQQwdy8MKHgZb0XqaDSBx9PyutE9yoY9lapm89Ob4/EmLofPRe9yejygi0srvDpE3XEVav26zJsTSawyL2flTioYT3KiCcxzRv7GVnAmEvh+ieovZCQTy+wUA6lXD0oaxgQrzYLdjMjGOp9RfZdqcBCFpY7Uyd8SCmanKE8V8qgGd9Hd94Shxp6mqpERo38T2jSVozx1BV+t+oyAUbbrdTRxV+SBtTaWqZPILTr3sP6Hv+jVKeQIdNm983ncH+I7jaohZzP/JdbpbZdmmWcooCHVKwaRHhFdXD4lhF3pBQGQx4yhtCsTfHpX7b3LxBEPGUoOA0XMkiOexCwtwp9/Jvw5/t4e18fLfHv/UhZG/uX0HQQpjD6J6A3OjTOifnKGhq3QEc2qJS2ETFh6gd0+GVtq/GlDLRJRKAHqmnqA0aVpj68o5cNGEQ==;5:DrhVc7YuT4nTCrDNHEKWue2K4x4KbyYj9romPoYT4RinSnvJNiyg79stHJNe2ZUrHwc2KP0Ap6Sfi33TX8LTRqfjeqFWr3EpG08dkfWdpS4XRSYNNaDGnej55haTnJS+zL8aX4kkgCps+6UXk0WBOh8QxxeKfeK2wo1uih1E4Rw=;7:HVShd7ZSkwx3PGpvP/M+HDxhvWpHDVbtNosHLvXjVG2InC8I902Ut+5H8XRopzqJEyjU8bPXkkQ2adOTUarwGI28r068Cz3nZ4BidtkOzP24m4ZdF6spe3kUJXZF5ICVFFQGSgFokyVNNNvvyb3rlvLKV2aniSH4LKE3z6GmNkttXBbvgyF27Ln8OdZkkcLyc0RmysIZ7Q0arfzSgPDN5XcaJOBOt0ydeUbgPKNxDfLysFICimIBbfevBsniWdNU
x-ms-office365-filtering-correlation-id: 7e11bbc6-03f4-404e-5603-08d627368057
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
x-microsoft-antispam-prvs: <CY4PR21MB0120D1D2C45CED26776452D9FBEF0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(189003)(86362001)(8936002)(6436002)(99286004)(6512007)(305945005)(76176011)(2616005)(68736007)(53936002)(34290500001)(186003)(10090500001)(105586002)(106356001)(86612001)(6486002)(81156014)(81166006)(8676002)(71200400001)(36756003)(54906003)(5250100002)(2501003)(26005)(110136005)(97736004)(6346003)(6116002)(3846002)(1076002)(5660300001)(102836004)(71190400001)(107886003)(2906002)(486006)(6506007)(2900100001)(4326008)(66066001)(446003)(11346002)(14454004)(7736002)(476003)(25786009)(256004)(478600001)(72206003)(10290500003)(316002)(22452003)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 2SAVFz2nC68EdZBBNVrPo3wviUuist8coQ/3P9a3ajktlUWziLSxgsg9w6ufuljt4uLsOj1IuJRm3suRcn2CNpHg4aS+PANmUuBEMFMYAwiok2vwVZv4tv0KPEHbzP1rGqPVfVpQV9CdXSmaYKoeeMIs/nRz0lfS22HNrpg8tsoVHc2dXaSqVcL8ZJF5vGaJZ6gMzyCUUZIWqD6vHFI3OIsTQQqNY5LnaN8MSRQLNYC0S/fet/kADq8uT0WZTRBwfa/fuaOq2LMtFSR3/ylI0XQ2g8zGoqp6joyZ3SYI1MhLOq/1LyaxsokXE8+hkGOBm0y9YSuAFiNhs+5cQyKqEYsFtvXwAILbkjla0KjI+qg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e11bbc6-03f4-404e-5603-08d627368057
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:40:35.2797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
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
index a9dbc28f6b97..524fff2b3dc6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -288,16 +288,17 @@ void mlx5_remove_dev_by_protocol(struct mlx5_core_dev=
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
