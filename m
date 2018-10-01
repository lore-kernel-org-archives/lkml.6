Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2FAC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646832083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kozrPJ2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646832083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeJAHNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:13:31 -0400
Received: from mail-by2nam01on0138.outbound.protection.outlook.com ([104.47.34.138]:39861
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728799AbeJAHN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhLOKiQtEQErir6NGBRrRuaBvPDlPQgH3uWfbd6P+mM=;
 b=kozrPJ2xRk82SRs1Pn+DHWyJ3f6Tq8fpJ6YHnyFxQruOHwr7EIz21fOSVfzB99Wyyb/bL/P5sQOx9DY8+XOUlGy2l0ctMtZ1Ptni8zjStHFSX+hhCs6o0khxW0fg3gYNyNoM/HfxVSuf3pywyhNBsoix6/YzDHsVpoYNSVpWdww=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.6; Mon, 1 Oct 2018 00:38:19 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:38:19 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Daniel Jurgens <danielj@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 27/65] net/mlx5: Consider PCI domain in search
 for next dev
Thread-Topic: [PATCH AUTOSEL 4.18 27/65] net/mlx5: Consider PCI domain in
 search for next dev
Thread-Index: AQHUWR8MNQUfzI1OLEuUeYcvdK/qGQ==
Date:   Mon, 1 Oct 2018 00:38:19 +0000
Message-ID: <20181001003754.146961-27-alexander.levin@microsoft.com>
References: <20181001003754.146961-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003754.146961-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:qLnXtHam1v7Soenug3kGkKqmJhstxjp0izh/+SngpLud5GZtmyfNm7O6sc+IALGd9n/Ygb3WIwyXsQTswVBISFl2qRiZQyDF+aH9ogpNQyNllHFiB7/dN93kSxF++pPhDCVzdtH5pF+18r2N7dNq5WYWW55Gihu4X6X8FXEfw8PjnF9y3DfcnO4dD2P3LWTqMCXxmAbhKSPDmxE/PBAvMcX5ZVyseheueciAgpQwkCTpxSUr0docLaw1Y8ph+k2obZQRk9aZ7YeJrFqGGK5QVmBuwkGtsYTxVA/cmbwNaEhwcANBOJssNGYzROvZCq81eDp6X09I6MwHcxY8oHuS+ijrZmJafS88ONMzwIZnW8v0WoTI9hh3pI6BmwQVS05wI2ayjVO9fJdWUgfFEJBiRn5iSt3nAxZey2cLedNHgP24XwD8py3Zq3hdtd+yEaVWiE1eML/gUgL7UyAV2LQoxg==;5:wgc/jciv+2nFvOrCoLyacIwyMyLKZA10G7rt5V54XSYv31GaNM8caIk8gbPk28J+ctCqB9dMpqKSxHSlWpIR0jI8lqaNCKCE+feoWn5AbZYBlS4ygmZCQue116Af0fYd9qTGfuMKg1bIBBzrXKYDduL+T0sjbBnIBb96x+ZCjww=;7:WlHqh2AarhXwrKoLrH+I9PITVrNRuWKOkhBBy7frNIHqYRbIZJ7AU7IXQs3H0DHjNkGOs65ruFYKXYla/DgeBfmOymiv8rtIrsCXU0Jrg2Vz27e5JBG1a9pW+EGyNkfRjrZGOZ6I92xzuxPP0Lw+MUP2+qFSXNcsGOeeXog8s0YkiaIE4tOkZcI1x/uRVt0TJDYjMMl5vab3fsqRW+xt/bTJEjLcvMuI/4U4URUaZe6YyYZhZC1Ui4KMnI+r0Yly
x-ms-office365-filtering-correlation-id: 3edd1be9-1565-462f-e403-08d627362f6a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0181568EB8847193A5900681FBEF0@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(6512007)(71200400001)(71190400001)(6116002)(3846002)(2906002)(6436002)(1076002)(34290500001)(446003)(7736002)(478600001)(11346002)(53936002)(6486002)(66066001)(25786009)(2616005)(4326008)(476003)(81166006)(106356001)(72206003)(102836004)(86612001)(486006)(10290500003)(2900100001)(6506007)(76176011)(256004)(8676002)(217873002)(97736004)(107886003)(105586002)(81156014)(99286004)(54906003)(110136005)(5660300001)(2501003)(14454004)(5250100002)(22452003)(186003)(305945005)(26005)(68736007)(316002)(36756003)(8936002)(86362001)(10090500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uHbUimj7ai16g3Dtec29rSJI4Cv3Ky6+zf4O/Dy/gbeaGzl2siIWlcy4BqMfe6vXbHc2XqUs5kzqbFz44v0Igcl/GMhSYYijIZawGB8bp6KlLfS2NHkYNm5C0RBgk6GAEGi0ulXAqps3Dv85VdTmebBfzDn8xZd830uZXtmFVZ8IVYBPzR2nE+tF6krabDIQLmKbKQRFQKdTSaCMuWxkcy2pAPBNZrY3gAM/mR3jpFhihkdPWRp/odGPDusCidW5VNzHnxRAol5MntzA9uL2oYoAGxVSh/jRFSiiU5mJ/P9FL1ZswpH1FsTn0hR5YdG4q8GoOsDZJgsmGMQyhVWE6YDCtvQ/2r5O7W+7BurOqQ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edd1be9-1565-462f-e403-08d627362f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:38:19.5554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
index 922811fb66e7..37ba7c78859d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -396,16 +396,17 @@ void mlx5_remove_dev_by_protocol(struct mlx5_core_dev=
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
