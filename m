Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E76FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABE6217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hUmKJ7HC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfBEPnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:43:46 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:50755 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfBEPnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:43:41 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="27303269"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 08:43:40 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 5 Feb 2019 08:43:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joIVhM9b+PqxgwnPkEbLpKOWa2HEntvOrxe+OUNSUTo=;
 b=hUmKJ7HCsPVVWH900hwy1HAp2mX7S4vfqUkTdD+Hr1I1b8uBy+oXWnXMGBLqNWk2fssqo8tnY5kLlJtWGLi+7o9VQLaRUTfR9Bv4xNwAWJkIEf4JQzZwnkppDeOD1DQQ9T0YXQohncivJUMrJfDu0fzwoyRU3TeYoFubO1Zc91Y=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1409.namprd11.prod.outlook.com (10.173.31.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Tue, 5 Feb 2019 15:43:38 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 15:43:38 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <bbrezillon@kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <bugalski.piotr@gmail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH v5 06/13] spi: atmel-quadspi: return appropriate error code
Thread-Topic: [PATCH v5 06/13] spi: atmel-quadspi: return appropriate error
 code
Thread-Index: AQHUvWmPl459xGqU+ky1vaJR1i7Rsw==
Date:   Tue, 5 Feb 2019 15:43:38 +0000
Message-ID: <20190205154257.29529-7-tudor.ambarus@microchip.com>
References: <20190205154257.29529-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190205154257.29529-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::30) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1409;6:fz5U8L6mUwr5arw9t9ZZqLw/kPGwAqsjhUyCuEicCgJudarFTncdksYnT/U0USOFpgFNWW1t3LYXlbU2P5LYRbBqLv8PwE4n1xi4f5jM4Cbi47r7yEQG3ukWyaMO1l8WB4MdRPo2GNsthu95dihapx0AkVdAosPgNUCclK8sKyBt2lazuzaCMz7/+Sxmk6dhMudBUpU+5mFzjRmpCn/bQLVd5gFpE2rttvCE+lRmnu0RreNhvd6oRZ4f7U5H5nmcax7Vx22r2TOnoyeSd5Sx/Lw8swDxYCZKwdKTZfZy912ye4Jw+RXlyAJ7k7/BEOUytE9pf1i7WL4/yuRQv+D48vAGyu2ilF+mh3WYINvZaURtrtWa4FJ8mGvoikpNVyIY1E42/zz0LRZDPE2juSgYw18AUe94jyNc7GrlALd1PWQpuLLGYK8myJfH3uD0NiHlKOjjAnxBvVxsEcL9IuVkAA==;5:4KFCDviqQw2x8pbampGnOemfpwD3O2WwoFSpyn+xWna8L2jNUpibqsxDYBEL1qvPuyB/K7uZaYP+Xtw/8lfFlOiEElDd77KR1qediqoZ9/QhreQ/uatRSs2oVuTDLu5L3I7hGR1NUO9jyV0IgdxZoBK+IiqkVL6nS6ABCwBp0aZdbrJMNrZpCJTB4QkcelpTq7+0h1rpyx2kylr07/2U0w==;7:Nex5h22WRwL+6RUhe5pz2j5bOFXjUhEaFrH224eajSZsAa49xFvQDlaQnaw7CExz5j965HgniXhL5jqTHjp9s7F4qm8NehrElWmISpW3GMPJdjPRC2BtMJj2KjKcyEy6ks8a+yLK4u18dlYLsHTlEQ==
x-ms-office365-filtering-correlation-id: 9d8284d9-9841-4c28-b7c5-08d68b80b1eb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1409;
x-ms-traffictypediagnostic: BN6PR11MB1409:
x-microsoft-antispam-prvs: <BN6PR11MB14091D5C9A718AAA60E6AA5FF06E0@BN6PR11MB1409.namprd11.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(136003)(39860400002)(189003)(199004)(97736004)(105586002)(106356001)(2501003)(26005)(6506007)(386003)(186003)(71190400001)(71200400001)(11346002)(446003)(4326008)(25786009)(316002)(2616005)(2906002)(102836004)(476003)(7416002)(110136005)(54906003)(86362001)(486006)(256004)(6436002)(99286004)(72206003)(478600001)(7736002)(68736007)(36756003)(14454004)(76176011)(52116002)(4744005)(50226002)(3846002)(53936002)(81156014)(6116002)(66066001)(6486002)(8676002)(305945005)(81166006)(6512007)(8936002)(1076003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1409;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s2EzG494o9pVyEedawtsaVqisioV7RXe8r2LoKuOpiecoFe8FD6wIE77KctovEHVbnDfFu8I6FZABm2/WbpLApyyb9feuVglduN/l+Fij2mvJK4SZsPz9ycjd6D7DnVK4kEu8VaRprPOINB5rolAr1WgKjACYCREa3YJf7No2kQWHbVwT4HfkcmSw3YNLcHZ6kMycmUpUtrtAmQOFLJX5EyeXbxJhtmnw83lYEm9uwACPugdDWl6o66HoqDCRST5m0kf2piirVgePCLlWDTksJqasTPvwhU1oSiEpkHwG2qABPNNPnLdN4IVlgwPbrCOhqDWaCL1JE106G24uwImFs6AKPP4GVNMTmdOrDVwCJ12mnWeSVTCGO5pDgKKahX3mJEyMix6UWv5C15JQMkOBOyh7kp5qctoste+OKkU64w=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8284d9-9841-4c28-b7c5-08d68b80b1eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 15:43:35.1903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1409
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Return -ENOTSUPP when atmel_qspi_find_mode() fails. Propagate
the error in atmel_qspi_exec_op().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---
v5: no change
v4: no change
v3: no change
v2: collect R-b

 drivers/spi/atmel-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index be7f87fd5ac7..06c31830d07b 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -198,7 +198,7 @@ static int atmel_qspi_find_mode(const struct spi_mem_op=
 *op)
 		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
 			return i;
=20
-	return -1;
+	return -ENOTSUPP;
 }
=20
 static bool atmel_qspi_supports_op(struct spi_mem *mem,
@@ -238,7 +238,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, cons=
t struct spi_mem_op *op)
=20
 	mode =3D atmel_qspi_find_mode(op);
 	if (mode < 0)
-		return -ENOTSUPP;
+		return mode;
=20
 	ifr |=3D sama5d2_qspi_modes[mode].config;
=20
--=20
2.9.5

