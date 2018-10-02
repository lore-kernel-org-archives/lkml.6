Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD11EC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969ED2064D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZolOyceA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 969ED2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeJCCDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:03:20 -0400
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:51904
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbeJCCDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwQB065iBAKFCpWZ1+W/+89oBYo2EzrtxoVXM8wf3lo=;
 b=ZolOyceAreSC4+o+EClJlKuLR2kHK+KifzhOAQT5oPg5F/YGEx5oq9PHoEV7RO6BUOLeEAbCV5jQ4WvA/Q3kQU6v7/1zZ0x5gS51CqpN6tWYLpOQEED8cB+9aR4UVC8j3e7fZ1fy7UjeYevaNpJInnD4PyC6JbTr0xbsfmNnxR8=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4593.eurprd04.prod.outlook.com (52.135.149.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Tue, 2 Oct 2018 19:18:23 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 19:18:23 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] crypto: mxs-dcp - Add support for dcp clk
Thread-Topic: [PATCH 2/3] crypto: mxs-dcp - Add support for dcp clk
Thread-Index: AQHUWoSva62qIPN4P0W3wS2G4g6ZzA==
Date:   Tue, 2 Oct 2018 19:18:22 +0000
Message-ID: <1a0036896822e49557fa4de9d3e76227f45508d9.1538507155.git.leonard.crestez@nxp.com>
References: <cover.1538507155.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1538507155.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0502CA0009.eurprd05.prod.outlook.com
 (2603:10a6:203:91::19) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4593;6:TX6IfGr436fad42lAe/TQci8aXUTAFQR6yuBzyCW+2chN/aT4QhP3SsqGwpPGroPD/PQSxiob0acrJeOcvy7CIJS3jBVc2MSILXNhclfZv7icTeTkxKIjlkipCjmf0MMysurP5tZWKW21s+hkGYvejLWqEf1tfBVZA/tz4+HJPgCvFMFD/idnIwseMYLsqqJpjNNCwkZJr+evnqdESeXbimRgmesCVmtkQrg2trzsgnNwz2iPwQ8zshlyeIr3kC1ORiVbTFqX8s0qS+8CD6spsBSl1e9aKjxh33M/9xa8eQ1uLU845uIFriJM9D1fX/Mc7ngtdPb4gs8GiGnQbvceUiaTi3tD+KqWa+jhQrSFSWmXeGPsf4dgRedORgShyf2WBbXIouxoHgw8oBkRhItpES/NmZDnqoGDqbvvQYM5dEYZtoMegemWlq5LoDXvOFjsectlBunAeiEsvgunjq2zQ==;5:7UmwPo88+FTruZjDJ1n0mBaylIKlAoox9GmhlP9viKnVnIKReCX9BBkHiQv92GFhQ+FlmbYgmVi+1qFvRer7YKEC7A0mGtuhULHELag0aQ86YgEM1PsefYUpC7gLEmqjn/fTFEpFm6VTBICQ7ONO4UJF9j7nnn/bgta2PbWYFWc=;7:DWn5PbYDB47EspLixxbHJG8Guqwn1bcy5d92tmFBw5SWrHno+0GfocsnvTISD8L9LLUS19AQD3CNkVLWillmDw3UmglcT34/K+J5CGw/q5dR2NDYduRDa2AgrfX/2d9UMN/sS9wnBG10eyD/rb+XYCR79townAdCAg6XHcIgkv8F5CUcY+7r2O9b6iUiAtmIdkK8GFlzwvcmjEurqtIPZYYbwEotPwrpRUxvmPMb3J44fIEdbU0rdNB6dB6xuB3J
x-ms-office365-filtering-correlation-id: 9bd8bcb8-0aeb-4ec7-f47c-08d6289bd1eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4593;
x-ms-traffictypediagnostic: AM0PR04MB4593:
x-microsoft-antispam-prvs: <AM0PR04MB45938D2DA581148940B5D461EEE80@AM0PR04MB4593.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:AM0PR04MB4593;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4593;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(6486002)(54906003)(8676002)(81166006)(478600001)(5660300001)(6436002)(3846002)(81156014)(486006)(110136005)(97736004)(44832011)(53936002)(5250100002)(6512007)(6116002)(2906002)(8936002)(68736007)(39060400002)(186003)(7736002)(305945005)(36756003)(50226002)(26005)(76176011)(71200400001)(386003)(6506007)(14454004)(316002)(71190400001)(2900100001)(118296001)(11346002)(106356001)(2616005)(66066001)(476003)(6346003)(446003)(102836004)(99286004)(105586002)(86362001)(4326008)(256004)(25786009)(52116002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4593;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-microsoft-antispam-message-info: ccxF0T+OTIucUj/4UVjIO3vADO5CcmnKs9HY4h5LhIjpLC26ekYhIYUfp863r0iIvIXZZmmvJ2oLWTo6zWr/F5UUNjT9k316CUa3dtjfyFFXGzmpNw2BFTtYGsCQITy+aE5hlDla8BO4Kv5iuI5AZSBfcAscVewsNOS5FukIwxcUQdxzn+1HKyx6gjBpVRBKREheeP1uNYUk9N3+Rpdfpl2sW/3yWrKYaLXqp/k6juPwmGqROcTpxF+0mqnM8f7umjIt4xymewK6RKVEfKx3MKu77QdGXl52vTvSzzq9Wf4Gp3vLpeMi5N2IxjlppmSdf7PBZsengp1t66J0bjj4RYStaIZvn6Ad0a26mBpTzdI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd8bcb8-0aeb-4ec7-f47c-08d6289bd1eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 19:18:22.9839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6ull and 6sll the DCP block has a clock which needs to be explicitly
enabled.

Add minimal handling for this at probe/remove time.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/crypto/mxs-dcp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 56bd28174f52..4b2b8129cf35 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -18,10 +18,11 @@
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/stmp_device.h>
+#include <linux/clk.h>
=20
 #include <crypto/aes.h>
 #include <crypto/sha.h>
 #include <crypto/internal/hash.h>
 #include <crypto/internal/skcipher.h>
@@ -64,10 +65,11 @@ struct dcp {
=20
 	struct completion		completion[DCP_MAX_CHANS];
 	spinlock_t			lock[DCP_MAX_CHANS];
 	struct task_struct		*thread[DCP_MAX_CHANS];
 	struct crypto_queue		queue[DCP_MAX_CHANS];
+	struct clk *dcp_clk;
 };
=20
 enum dcp_chan {
 	DCP_CHAN_HASH_SHA	=3D 0,
 	DCP_CHAN_CRYPTO		=3D 2,
@@ -947,10 +949,24 @@ static int mxs_dcp_probe(struct platform_device *pdev=
)
 	sdcp->dev =3D dev;
 	sdcp->base =3D devm_ioremap_resource(dev, iores);
 	if (IS_ERR(sdcp->base))
 		return PTR_ERR(sdcp->base);
=20
+	/* DCP clock is optional, only used on some SOCs */
+	sdcp->dcp_clk =3D devm_clk_get(dev, "dcp");
+	if (IS_ERR(sdcp->dcp_clk)) {
+		if (sdcp->dcp_clk !=3D ERR_PTR(-ENOENT))
+			return PTR_ERR(sdcp->dcp_clk);
+		sdcp->dcp_clk =3D NULL;
+	}
+
+	ret =3D clk_prepare(sdcp->dcp_clk);
+	if (ret)
+		return ret;
+	ret =3D clk_enable(sdcp->dcp_clk);
+	if (ret)
+		return ret;
=20
 	ret =3D devm_request_irq(dev, dcp_vmi_irq, mxs_dcp_irq, 0,
 			       "dcp-vmi-irq", sdcp);
 	if (ret) {
 		dev_err(dev, "Failed to claim DCP VMI IRQ!\n");
@@ -1088,10 +1104,12 @@ static int mxs_dcp_remove(struct platform_device *p=
dev)
 		crypto_unregister_algs(dcp_aes_algs, ARRAY_SIZE(dcp_aes_algs));
=20
 	kthread_stop(sdcp->thread[DCP_CHAN_HASH_SHA]);
 	kthread_stop(sdcp->thread[DCP_CHAN_CRYPTO]);
=20
+	clk_disable(sdcp->dcp_clk);
+
 	platform_set_drvdata(pdev, NULL);
=20
 	global_sdcp =3D NULL;
=20
 	return 0;
--=20
2.17.1

