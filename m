Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE50DC65BAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C95F20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="t2AdwB7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C95F20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeLJIl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:41:28 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:50150 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeLJIlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:41:25 -0500
X-IronPort-AV: E=Sophos;i="5.56,337,1539673200"; 
   d="scan'208";a="24178430"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Dec 2018 01:41:24 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Mon, 10 Dec 2018 01:41:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnViRn5oBm9LC9lDTIuvKSxhGqzYL2LEpIBr3iExtPw=;
 b=t2AdwB7wN32j9i5SKnw21CnOI6bL3CBgpc9iZDGtKJ4wEHq1UlHUyfTatKZ+WUd8W3LfwWfMQpvH9+NRJhWq0/eGJMERrbrNhMKoXllBSS371Ap8wWwMGEH+2NrSpiBdw40wDa6fmvzD5Lr5LEnTnDonViABv3uX6y37hJDMtaI=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1971.namprd11.prod.outlook.com (10.175.100.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 08:41:23 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 08:41:23 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <wsa@the-dreams.de>
CC:     <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 2/2] i2c: at91: Save the bus clock frequency in adapter
Thread-Topic: [PATCH v2 2/2] i2c: at91: Save the bus clock frequency in
 adapter
Thread-Index: AQHUkGQhSABKlEqSJkG+yDuhgPE2wA==
Date:   Mon, 10 Dec 2018 08:41:23 +0000
Message-ID: <20181210084111.6938-3-tudor.ambarus@microchip.com>
References: <20181210084111.6938-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181210084111.6938-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::49) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1971;6:SanVN1aXXnRKUFyT+U0F9VTmG2iIg2w98SLzE2agq81suQwBeeIWDaRrn0aiHXJ7mEgMZ8ySUQJy5Go3BQknMkPyLy7LeyZ96E3BBzDhauPSlxt7jR3A7K1W9SD2Z1g/8D/OnHm8F299Gzm7nm/DhZQJZ9LEOqXBpnI0NbAnoUwgI3AZqeOj5pD05vyNHEzy35dLYs2XrTzwK4lqFb8vSxWddJStg/UWvhAClcY/0sn8J/zZGQUvUnNWeDbt0m3LmI3j7rkfDALMfUjRJJlkcuv52Ce/ivCF107diOJGDkxC291lD1R0DbHUycPGWavZaeHTJWN+ijou5WpXfZHTjzbVy11hPkemPeHJcWDcOKGukxnu8RtPBEiJlr+GpWqT1fkAoKXjwYU6ObFx1DQQTzblmcWAqZ093Rj6jke9lQsWI7YpyNMRDU8GxQQe3pbMRxGL16GsMYmnmFuyTbqh8A==;5:BvXdrCX5lU1kNvuTIRemND01ugs+4PfOjzIm7q5ZrJt/N3d6IQ7WGKaf7Mk40W2gkYoZByoydKwqxI4xCJ9TgdodOilcMNp0cuEkLaqlvBavtYq17qb+jPo71hSBT8yC8MB44B4NFqmrFcfgX/CnmHM/VTfviniVtONaGbdUwmI=;7:jrl3llTgIwHIKq5YjOhPNOy2N6LewZt1IxV/wP9j6ezvxwltS+A4m8LK7DeX5iuWYYrg5f+VcxweixQvOcnif1eE4jIle5JM6ZGLVmD4abQL2OzJVnYjPwG9WJNKwo5agDN2SnWxuMI8KYDI2UHQrw==
x-ms-office365-filtering-correlation-id: 32073412-1403-4332-8bb7-08d65e7b43ac
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1971;
x-ms-traffictypediagnostic: BN6PR11MB1971:
x-microsoft-antispam-prvs: <BN6PR11MB1971AA6686D9DDB2A839E5F2F0A50@BN6PR11MB1971.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3231472)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1971;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1971;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(39860400002)(136003)(199004)(189003)(1076002)(4326008)(5640700003)(107886003)(14454004)(26005)(71200400001)(6512007)(25786009)(54906003)(6486002)(71190400001)(97736004)(81156014)(81166006)(36756003)(6116002)(386003)(3846002)(6506007)(102836004)(1730700003)(8676002)(8936002)(99286004)(5660300001)(53936002)(2501003)(2906002)(76176011)(52116002)(305945005)(446003)(316002)(11346002)(476003)(486006)(2616005)(106356001)(14444005)(2351001)(6436002)(186003)(256004)(105586002)(68736007)(478600001)(66066001)(86362001)(7736002)(72206003)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1971;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AuwI/STbO+CsIZnwg5Zf/AtHI4fE6awNdCT4ixpyEZslWsfpsZ1PmQPIH2Xt9nS0M4hB+pTNanl01+lbfvTsFZpm5P16g9ACttzu23I/z7ENSynoptddCQknPfV/1CMypO+VLVyVhtfv7QBSDNjtz65YKfYP9MkgWj2rEVze3dVAkOzFXWKDlxnfzfqzKRyr4CsfwQzLqbYr4Rvj0N3hQkc4FuH75hPjAyOmR4gf11/MUxhm8CmVXvNn0B+q0fKNJ6TpK/DV4/r3ZnLYixQGMGFHTeHU982ilTrP37IlF5tYgLeISIBGpyX+TaSHqiG5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 32073412-1403-4332-8bb7-08d65e7b43ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 08:41:23.2636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1971
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

The clock-frequency property is not mandatory for the i2c buses. If it's
not present in the device tree, the buses __usually__ assume it's 100kHZ
(see altera, at91, axxia, etc.). Broadcom uses a 375kHZ default
clock-frequency, so the default clock frequency varies from bus to bus.

There are i2c clients that need to know the bus clock frequency in order to
compute their wake token (see atecc508a i2c client).

The clock-frequency value has to be propagated to the i2c clients, otherwis=
e,
if they will not find the i2c bus clock frequency in the device tree, they
will have to make their own assumption of the clock frequency.

Spare the i2c clients of making wrong assumptions of the i2c bus clock
frequency and provide the bus clock frequency in adapter.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
v2: no change

 drivers/i2c/busses/i2c-at91.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 3f3e8b3bf5ff..9aa0937817ac 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -1124,6 +1124,7 @@ static int at91_twi_probe(struct platform_device *pde=
v)
 	dev->adapter.quirks =3D &at91_twi_quirks;
 	dev->adapter.dev.parent =3D dev->dev;
 	dev->adapter.nr =3D pdev->id;
+	dev->adapter.bus_freq_hz =3D bus_clk_rate;
 	dev->adapter.timeout =3D AT91_I2C_TIMEOUT;
 	dev->adapter.dev.of_node =3D pdev->dev.of_node;
=20
--=20
2.9.4

