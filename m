Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9746ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45F820685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="z6yE0fSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45F820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeKHUms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 15:42:48 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:14785 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeKHUmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 15:42:47 -0500
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="20108336"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2018 04:07:43 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 8 Nov 2018 04:07:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBUlYBhb+c6yBav8ojSC75619eNKq+mFFk4RSE+K3rU=;
 b=z6yE0fSiDN/fd/4FGjW6XclnQzY8ze0ONgZIA9AsXxKwxIFxwB9+6EOLs67T3x/yv95Mixldv7IPNEXXE4bJjL95CVzY0m6I27ig9h28R2Ued4iJ0qOZfJCxM3czjpx1dboJGVnB9/vEKqJ7QbCn8QDqlxUK7gN7Ts39tWd3igY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1987.namprd11.prod.outlook.com (10.173.32.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Thu, 8 Nov 2018 11:07:14 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 11:07:13 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 4/7] mtd: spi-nor: don't overwrite errno in
 spi_nor_get_map_in_use()
Thread-Topic: [PATCH 4/7] mtd: spi-nor: don't overwrite errno in
 spi_nor_get_map_in_use()
Thread-Index: AQHUd1MzYZpAB0RHpkqXRQYYdH27Nw==
Date:   Thu, 8 Nov 2018 11:07:13 +0000
Message-ID: <20181108110653.21063-5-tudor.ambarus@microchip.com>
References: <20181108110653.21063-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181108110653.21063-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0401CA0009.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::19) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1987;6:J9e+5kwPZRpu5IwxKiwCaWVsTbat1qnkJ8qqW/Qo/k3zyJ8jY+0t/LEWDS//P5MGHyxUyR+3N55NWXAMgISPJydtQo2MGo36J+/9kuR11tULxhcNZbhL32jQuMLitGKuDZhWUIAdxysx254S+q1XyUNvkGJSO5nQW6jRupp5eROD0bsHuPJo0SNw1ZDM7PujltfCPDrs82TcWVaolcGeFymyZxsCEfonqoEN6EJOChLA0h4XEbwFKunG1VzV8UgQs1jCwYDTx2WCvgNxrMULZ/tgMn28cQ2HFDA+Z/aHxfHhFiofcmXR6jOK0RycODgYGoXKoPOBv8Sh+cmbKYNSdFaomhbw4TbTrBgocFItE0CQbT/ykBeZ/egfbzDNJZ33RZ0RGipj6kLFOnW+txbxBmr5vH5bsSXo51kF2m2UXoLQ3h5B8ik3WfzPF0jhyo0xBxHA+1w/0lZUv/ECC7qHHg==;5:K+kHRZhIZP52buk2Kajv8freY6tPRzWviLvdAKZiTIBqlo5tSyJbWA9XIQhgyG/uehFhvSN3+gcL7rMFpbkieoEK+4pAKaNlbp9RCCZlbobR+YwrsWHAyarOazTdhS2QiwT4fuaXjs+zZvnclWB5wvwNpOf9M6jsJ/QfssSEaus=;7:tO5SDMdkXL2gyzMCtWoMmiA34QiwLrYd9IdcbSFfzXspnL2r2wLvyBL8wgHIlo7JitWrjfoGB98hfPa5zNOW/6TsomCQUKwuBn3ZiVqI39AxLry9d8aZOMD28NpdknRzXKVEKQI8xCq7GI2bsSPk5Q==
x-ms-office365-filtering-correlation-id: 49a1ca5e-ddf4-4255-9bd8-08d6456a5642
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1987;
x-ms-traffictypediagnostic: BN6PR11MB1987:
x-microsoft-antispam-prvs: <BN6PR11MB19875A718F402C9554617F68F0C50@BN6PR11MB1987.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1987;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1987;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(396003)(366004)(376002)(189003)(199004)(72206003)(8676002)(81166006)(5660300001)(81156014)(102836004)(14454004)(68736007)(305945005)(26005)(86362001)(1076002)(2201001)(39060400002)(7736002)(8936002)(2906002)(2900100001)(36756003)(3846002)(6116002)(71200400001)(71190400001)(107886003)(97736004)(6436002)(6486002)(110136005)(54906003)(2501003)(2616005)(11346002)(446003)(99286004)(53936002)(6512007)(256004)(4326008)(478600001)(66066001)(52116002)(386003)(6506007)(186003)(25786009)(316002)(105586002)(76176011)(476003)(486006)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1987;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: CR9o7z4gP5lzBvzXAR0/840aQscHbxa8lXe36CuvxByDEU8+86EoJr02BID4wSs2sZjsc3kO1T5t98dMdI8i1/mt3HVvOpivLlFyhFvYiRD5yc4NSM6CFkMztLp5zKGgl3gB0G1kVTlNnLMh45LXH1ONswSpHa2X79w0eSlNf8s9MizgNu1bOjpcX1g+OsJ9nosUZdW7AUYbyLAXahOihSmfVPJyB0bYdDrV8EQaVOTN/kE7DzmEftWFaFTfYlcEHsRk3bUhVs52ZSTc5RkSMwKYm7mrbSX8GZIf7aWiY7e6Jcw9cQM7jNw6SU+tnkJjEz0D7imKWBauJW7vkuU1om3B0LnSJmZjvNtN6kn0MDk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a1ca5e-ddf4-4255-9bd8-08d6456a5642
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 11:07:13.8692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1987
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't overwrite the errno from spi_nor_read_raw().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index bd1866d714f2..79ca1102faed 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2861,11 +2861,13 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_=
nor *nor, const u32 settings)
  * @nor:	pointer to a 'struct spi_nor'
  * @smpt:	pointer to the sector map parameter table
  * @smpt_len:	sector map parameter table length
+ *
+ * Return: pointer to the map in use, ERR_PTR(-errno) otherwise.
  */
 static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *s=
mpt,
 					 u8 smpt_len)
 {
-	const u32 *ret =3D NULL;
+	const u32 *ret;
 	u32 addr;
 	int err;
 	u8 i, ncmds, nmaps;
@@ -2889,8 +2891,10 @@ static const u32 *spi_nor_get_map_in_use(struct spi_=
nor *nor, const u32 *smpt,
 		addr =3D smpt[i + 1];
=20
 		err =3D spi_nor_read_raw(nor, addr, 1, &data_byte);
-		if (err)
+		if (err) {
+			ret =3D ERR_PTR(err);
 			goto out;
+		}
=20
 		/*
 		 * Build an index value that is used to select the Sector Map
@@ -2907,6 +2911,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_n=
or *nor, const u32 *smpt,
 	 *
 	 * Find the matching configuration map.
 	 */
+	ret =3D ERR_PTR(-EINVAL);
 	for (nmaps =3D 0; i < smpt_len; nmaps++) {
 		/*
 		 * The map selector is limited to a maximum of 8 bits, allowing
@@ -3056,8 +3061,8 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
 		smpt[i] =3D le32_to_cpu(smpt[i]);
=20
 	sector_map =3D spi_nor_get_map_in_use(nor, smpt, smpt_header->length);
-	if (!sector_map) {
-		ret =3D -EINVAL;
+	if (IS_ERR(sector_map)) {
+		ret =3D PTR_ERR(sector_map);
 		goto out;
 	}
=20
--=20
2.9.4

