Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07729ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A353F208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="iI+wewJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A353F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbeIQI4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:56:33 -0400
Received: from mail-bn3nam01on0109.outbound.protection.outlook.com ([104.47.33.109]:29664
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729322AbeIQI1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmFrpV2WDNm/SsN0mZ9D/HPBuTvGGXqNJYpAhsE3b5Y=;
 b=iI+wewJ9IYbG+hNvGtwRuZzI32tpakLJmUx8OnpmfE+LGwd25P40GDW4330KWpcqPaz/dn9tkVhLnVj24SrxuRyjXOdXW0GOZubV8wT7cW60MlW9oKtT13tg7RkOMUPCvLCRsBJbdQe7Q4l4xybQpY0aE7N2z3NastK6ImNwweY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0502.namprd21.prod.outlook.com (10.172.122.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.7; Mon, 17 Sep 2018 03:01:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:01:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kamal Heib <kamalheib1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 077/136] staging: mt7621-eth: Fix memory leak in
 mtk_add_mac() error path
Thread-Topic: [PATCH AUTOSEL 4.18 077/136] staging: mt7621-eth: Fix memory
 leak in mtk_add_mac() error path
Thread-Index: AQHUTjKpJgUtZtfbl0e+EMADu7UAuQ==
Date:   Mon, 17 Sep 2018 03:01:00 +0000
Message-ID: <20180917030006.245495-77-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0502;6:ghs6YXSRxfowqFmOHRvcaHYKdCME/BbbZvJXXWNVOMsTLc3/3MaLvEJuv796wcdUxEUOSmzQYBWzpLUTqNE1bZU5pLRpA7FVTDgb/lt8PDe9hV4G/80RtZt8c+KU1zmjKN7nOfz8SwgIl71WaBOo49WKx75zRIQ9HR0nxYwTD+cagxg+C47//efxaxa5Ip0LCqsEwpuMx2WXNzgwAdXiQyqdN95mpfXkGnHHNDkRTQjeG72cTxHLpDfEZ9FB8K8pbjxF5YO253HdNAm1lLYNFxSkwa+QkH26pD0XVFRswddU3U4HFQEmWU6zsrmHFISgW2//Htz0PxgCQEvsy6xrJj6nWcuUAuwAaYsNd2wPxswA8GlSkVhK52GB03j/dB8HOit6iddDg9iwKR4fZTdjO0d0JW11rJD/Xj/k3bMIWMuFzKWmdUYF5sfZvtw/bpdGYsTtUf+0y1gtKqnWFTPCEw==;5:lNnC6I0yIAeLkv1Od+gA3SF7EMV6QGTM0ss03wbW3rqT6GzCVuAWcIumDyFoU/KMFnGo/2jUGpbVfXwIwetDlT93buRIfhYYM3eMMoJnAayyLLaNFa/TnPV9mz1jUyArJyUrlVE5HsUM7EK540OaBYiNId4AsZAq8FjqnYiHDag=;7:5r59wiLthcQ6iKB0sFhJUxLZV+GGMqHLCAUDN+5y73CqzgT6hmx1vY4ByqqyoSIPc1D9gzOSH95pNvEyleEHy0uJ6kcMkb2mOYEzSVzoyIDW4xFcZQ7V83Y2pK54QP1uh3Ri8VtP6+uETnfXUoKJg6mXvIYLIIy+YFGrRUvnX503rVGjpK0cHMn5pfebXpceQydRhK1SCLrIRg1ykoi2Vhz4b+9R69fDrdXPBBtXqzbpAeklPtbjRpNenXo7SDBV
x-ms-office365-filtering-correlation-id: 7264fcfc-5709-4380-5d2c-08d61c49ef34
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0502;
x-ms-traffictypediagnostic: CY4PR21MB0502:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB05024DBE5B9FABA57A67DCE1FB1E0@CY4PR21MB0502.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0502;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0502;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(366004)(376002)(189003)(199004)(86362001)(2616005)(99286004)(5660300001)(575784001)(1076002)(6116002)(3846002)(6666003)(10290500003)(39060400002)(2900100001)(72206003)(68736007)(8676002)(22452003)(26005)(217873002)(86612001)(486006)(76176011)(66066001)(102836004)(2906002)(476003)(14444005)(186003)(256004)(6506007)(446003)(11346002)(36756003)(316002)(5250100002)(6512007)(97736004)(2501003)(107886003)(110136005)(54906003)(6486002)(8936002)(53936002)(81156014)(81166006)(10090500001)(25786009)(305945005)(7736002)(105586002)(106356001)(478600001)(4326008)(14454004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0502;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LsBSiaVcbdicC44cFVHlOVNvU+fO55nf0aJ+lpHZpNHQVPSHWBZgmcFwRkkZjS2ECDzefb2nY/EzjkjXD/te6ENcvGw3YFOIAV0wqfE3jf5o4rhrR3V5TezsjENLEzFoWCcc9y0x/YuicaOs9dxdNvUMkuxEJycXG0r0+gxwY25ijlQQNHiLe4wIqnUc8CazdKdR7c5Q7MtzSKpO44Lgf4XH2UYxjdWcJzRrQGgGDyOwcR0zuMs+Qm14D73rjZ/MMv/kXSfNNLubJ6rJCHEbD/6BFRH5+7oS39vhkaEMsWcAAzUKsmf5I2rLFmYuAQ6dLLc/1s/h3KgY6xmpntXo1ibF8b3uReQDNiCIZYi/wSI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7264fcfc-5709-4380-5d2c-08d61c49ef34
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:00.3387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0502
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kamal Heib <kamalheib1@gmail.com>

[ Upstream commit 85e1d42663a0c163002961d2685be952067b0dc2 ]

Fix memory leak in error path of mtk_add_mac() by make sure to free
the allocated netdev.

Fixes: e3cbf478f846 ('staging: mt7621-eth: add the drivers core files')
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/mt7621-eth/mtk_eth_soc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7=
621-eth/mtk_eth_soc.c
index 2c7a2e666bfb..381d9d270bf5 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
@@ -2012,8 +2012,10 @@ static int mtk_add_mac(struct mtk_eth *eth, struct d=
evice_node *np)
 		mac->hw_stats =3D devm_kzalloc(eth->dev,
 					     sizeof(*mac->hw_stats),
 					     GFP_KERNEL);
-		if (!mac->hw_stats)
-			return -ENOMEM;
+		if (!mac->hw_stats) {
+			err =3D -ENOMEM;
+			goto free_netdev;
+		}
 		spin_lock_init(&mac->hw_stats->stats_lock);
 		mac->hw_stats->reg_offset =3D id * MTK_STAT_OFFSET;
 	}
@@ -2037,7 +2039,8 @@ static int mtk_add_mac(struct mtk_eth *eth, struct de=
vice_node *np)
 	err =3D register_netdev(eth->netdev[id]);
 	if (err) {
 		dev_err(eth->dev, "error bringing up device\n");
-		return err;
+		err =3D -ENOMEM;
+		goto free_netdev;
 	}
 	eth->netdev[id]->irq =3D eth->irq;
 	netif_info(eth, probe, eth->netdev[id],
@@ -2045,6 +2048,10 @@ static int mtk_add_mac(struct mtk_eth *eth, struct d=
evice_node *np)
 		   eth->netdev[id]->base_addr, eth->netdev[id]->irq);
=20
 	return 0;
+
+free_netdev:
+	free_netdev(eth->netdev[id]);
+	return err;
 }
=20
 static int mtk_probe(struct platform_device *pdev)
--=20
2.17.1
