Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC988C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BA0214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hZvWX285"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BA0214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeJJRyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:54:24 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:56128
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726656AbeJJRyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBvi5kNkxvH/JYUIePBirBIN2plZY5WvxF7BhBF0quo=;
 b=hZvWX285u8tH1C45nSWMuwhohdGYADP2+D/gss+n2JfZKGrogEhuskJoXhSRWQo7jt6ihjhBZGsAU/ym/RV6kG0tXaCSrDKn5XFdtMzmWBA216mGFuq/gJKIRZeoJ6BwVPecNVfmnOgGq9TYBvTZP4iMsA0E5sBtZybinI/p788=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB4592.eurprd04.prod.outlook.com (20.177.56.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Wed, 10 Oct 2018 10:32:48 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::b0a6:19e5:90b1:5831]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::b0a6:19e5:90b1:5831%2]) with mapi id 15.20.1207.029; Wed, 10 Oct 2018
 10:32:48 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v1 3/3] spi: imx: use PIO mode if size is small
Thread-Topic: [PATCH v1 3/3] spi: imx: use PIO mode if size is small
Thread-Index: AQHUYISWx8cky8wBdES2x8EQHfAKVg==
Date:   Wed, 10 Oct 2018 10:32:48 +0000
Message-ID: <1539196453-8704-4-git-send-email-yibin.gong@nxp.com>
References: <1539196453-8704-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1539196453-8704-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:203:36::34) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4592;6:jGBO83GHp8h27wq19gdDE2gZrhype6JUB+9JKIHTcgVlDzpjK82LSEUuyO8go+zXF1T8rFQZ6VeKPLQ23gg2OOMhU9Cu0bl69Iqm+z1L718cGFqeE1Szd2rkSLH0NIrG/1+0D9AzboWiYXH3HPjeSJn56PLQk7NLRuymc3b9MtFAUa6N87l/ZNtSN0MNS+CstshAqB/OwnQvp7kRvoALAgCslPeTl0xARn/7gNPnnizzLsg+hCVPxTKgWLqsxXVhZAaEyAv0S5WO98IkuGFT/WiraINatmi8Bs3DNZr20LFKL/VD/EMLERsLwSWXwlUC37wsVTHS5wDuihA/NVSd5jUzpHVf4eMzokkGjlk6EWfSNDXCtWK+HdS0sc2n9/iOzyYJoFmGDH51tJJai6mjw7h5Tlf9GbSRm5nCWaCOp6ps2ZlEK7MENGyh7KI1pR3KRbIf2WcKBbnbBVYJdr/itg==;5:u1aRWqXXQbf4UnZK5PgF/wqd1nSjHNC3R90hBSmQiaukIbvGdPWU5XcKjlDZkuJxYezZ/0XVQlyYvfOmBmzWc8ScfYs0UbUfom4ayYZXH0KaZhSnqqTRWaXhkpDPghRtbDrt3tuJsN752OvYF8stLKrA+ohsM+OArZHoXYWrO38=;7:u+2ZglJwXNrlCfnqcy6Wunj6nooqREIZbH4hyyOl/FFMFbkGQr18tMJ5PucJCBB0z00ghN9H/CEoy4OlHC3F6BR9+kTY7eaoW6xXDMZGq9Tu2npQKEHnpMTSvTJT0aicqSZwioGgOT0o8SP0dgmvhuGmR5cc3LwAWfjLRUwNrchcHlSdADN7RF7NQLv8RGyJ9wpc25+Q/4mTWLFm+TKSMcWo7f1wza3LWfZf1nXzsDQ380d7hLgYsLagPTnpgTR0
x-ms-office365-filtering-correlation-id: 68739d0b-b71f-438c-28c0-08d62e9bb90f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4592;
x-ms-traffictypediagnostic: VI1PR04MB4592:
x-microsoft-antispam-prvs: <VI1PR04MB45921FC1FD2A80F3599D1B0889E00@VI1PR04MB4592.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR04MB4592;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4592;
x-forefront-prvs: 08213D42D3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(396003)(136003)(376002)(199004)(189003)(86362001)(6436002)(5640700003)(6512007)(486006)(71190400001)(71200400001)(446003)(2616005)(476003)(11346002)(7736002)(305945005)(102836004)(26005)(186003)(6486002)(66066001)(2900100001)(25786009)(4326008)(3846002)(6116002)(105586002)(106356001)(2906002)(478600001)(99286004)(54906003)(14454004)(2351001)(76176011)(52116002)(6506007)(386003)(2501003)(5250100002)(97736004)(316002)(50226002)(8676002)(1730700003)(81156014)(81166006)(8936002)(68736007)(6916009)(36756003)(5660300001)(53936002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4592;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MbPzkoeAIlDqnhnn2PxWTwyin8wdSAwCrWkhfdtdJOlYpcqxN1ng/GFiUlz8tyrM56q83KrerWzTrGrfJlbFD9TBEnshw8XfIzXn9B4pZ4WnyyDxQ7cr5eTiI6xzxI9A6I7oSkGUaKzHabfTO6kbp0lBX6kJ34gWODjH7oq+HNVAO7B2tPkIsYPf8tmGBQqIcUpSfKjuBUROMybMgBI+qPwJ7p77d/eCiG0HDJxaw/fDvud82Sjq+YH7JBy+jorXdd64bcujwaTLh6d+HFv/zSxoWmFqpvHdaBkbdBoKPsSNCut2sUvetkd6REoE+cQ9RkDLWX5P492XWOxKTBDs/4i4Pgklsgp48iTyrvNz+hg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68739d0b-b71f-438c-28c0-08d62e9bb90f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2018 10:32:48.4872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PIO mode instead if size is smaller than fifo size, since
dma may be less efficient.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 drivers/spi/spi-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 037abbb..dd1ce12 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -224,6 +224,9 @@ static bool spi_imx_can_dma(struct spi_master *master, =
struct spi_device *spi,
 	if (spi_imx->slave_mode)
 		return false;
=20
+	if (transfer->len < spi_imx->devtype_data->fifo_size)
+		return false;
+
 	spi_imx->dynamic_burst =3D 0;
=20
 	return true;
--=20
2.7.4

