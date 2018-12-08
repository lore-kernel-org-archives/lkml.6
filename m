Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D03C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A53F20868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 05:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W0DAHtc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A53F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeLHFmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 00:42:50 -0500
Received: from mail-eopbgr00055.outbound.protection.outlook.com ([40.107.0.55]:12934
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbeLHFmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 00:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQZVQ3KIUP4ZoLTNFIKHbENPY1nF1ShHbLCX3UuwuOg=;
 b=W0DAHtc+fcjcvutaqkpw2oRR8kkdSAK1mtQSamVjccC8oJMWZNjKi79O4R088pPyWCg8d3r8uy2AgKNufInDrwU+VC63lmXqMJZUG7gzLRg4mZ8Ejt5hPEcrypdgKumMUdM61n7qsyv+1Rpn0HG0DCaM1JHNlFs9ynkpKFI6FoA=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5112.eurprd04.prod.outlook.com (20.177.34.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Sat, 8 Dec 2018 05:42:46 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1404.023; Sat, 8 Dec 2018
 05:42:46 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Joe Perches <joe@perches.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 1/4] spi: lpspi: Replace all "master" with "controller"
Thread-Topic: [PATCH V3 1/4] spi: lpspi: Replace all "master" with
 "controller"
Thread-Index: AQHUjdeg0+sBOSEVtEi0nHBu80zSLKV0TgYAgAABIUA=
Date:   Sat, 8 Dec 2018 05:42:46 +0000
Message-ID: <AM6PR04MB5016114544649016E2090094F3AB0@AM6PR04MB5016.eurprd04.prod.outlook.com>
References: <20181207024924.6315-1-xiaoning.wang@nxp.com>
         <20181207024924.6315-2-xiaoning.wang@nxp.com>
 <1bb3bde9a47a3ca8a026fab9e6af420c1ae59f97.camel@perches.com>
In-Reply-To: <1bb3bde9a47a3ca8a026fab9e6af420c1ae59f97.camel@perches.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-originating-ip: [42.244.62.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5112;6:mz4Jk3GWuaFyKuVLeeRDh/gzyLLPSVMtuapeMZdioPsV87alP79XW5PtcFwCIr60vW/zgP/018QIHwvh9Rv7yk07wlNYcTi8qqCSrSI2XNroJrvtR667HVdCPPUVQPNcrJ7Korp/WNCGgr/zM+msUWxgdAIO36YRP7jdaxHxWbRc5/hF4aewZyYEdfzcJgLx4B+qQRDBEB/f3z3ShgSyITsSn9LTcDN4+6/fIQo6rLxerdpO1apC7ZAXKKZjfoqlLliuL8pcdLM6iwlagO+n2p1L5NjNgpH2lKFxKqqkExLr6c8T1NQYtuNnizzd6GvdhBiTgNQGmawcZRBU5UgeChHS9zbESZaA9MifzYwocSTbAmMA1FJ1LpfZJvUqygGkvQcTkKqNedEjRJhkDP7hqi70lMG0o+UNLlXRIQXUwaBkQS0cUcFW67F/dHT26UuPI2R9ax+1Fr8SXWR/yysZ3A==;5:Hia1qvEmZvVobhYvjdEGfu3w1qw+q/Ss+rZ89+Q9eook9bBcUYSfHvqIU2Sz+liYVqS7SQBWPi9qUMC3hJDJJHqAjKiT5o8wDZC6cKaSXSI5wTZFlkWW2O0W61vYp9+kboPjInOvh7ezjSr88+ew6IIP1JSWl3enltrXH4FLo9I=;7:eCo/+SOCfH6I7utFKxSjGv2vf/Jm1JK8BgBspI1HRy/kuKoHI5ibIti/XSFJ2cQHh1iF/bSR8YtOWBG7PE/lkw8Ee0CiTpezTbZYymA96EbCcSCRqnFHfZQVZAvJJoIZ8unYeqbW1ODSyzoahq0mKA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d6fbf191-720d-405a-201f-08d65ccffb9c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5112;
x-ms-traffictypediagnostic: AM6PR04MB5112:
x-microsoft-antispam-prvs: <AM6PR04MB51127CA2793FC9E5DA88970CF3AB0@AM6PR04MB5112.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5112;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5112;
x-forefront-prvs: 0880FB6EC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(189003)(199004)(13464003)(26005)(186003)(68736007)(4326008)(6436002)(76176011)(7696005)(305945005)(14454004)(99286004)(478600001)(53936002)(66066001)(74316002)(2906002)(6246003)(7736002)(53546011)(102836004)(6506007)(476003)(55016002)(33656002)(486006)(9686003)(25786009)(11346002)(71190400001)(446003)(71200400001)(8936002)(105586002)(229853002)(86362001)(14444005)(256004)(316002)(110136005)(97736004)(54906003)(106356001)(3846002)(81166006)(81156014)(5660300001)(8676002)(2501003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5112;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DALEcg4+oQtW8mPeph9vFMbIXwaS+2MEnDiCgInhTR4r8mu8TVXps0zQ+eE0sXK2S15WSIym6sNDVfHVG6jYRK9auR4IUqodieBtoSoFy05HjyCR6SAXOYqNA+xmY83OjC37QzFVtRzTfCRLwWCI/t+hVSk7DUDudi/MkznQBN8oEoyUjMR2FgiYbE7MbEqFUpW+G/THuznJn8ONtqlhut+BAVOuZpGamg+faj4fF/bf8o8DUdz62QzpjKOWh+N9vkgvJFbr6mYdO2z0Antp1K5hLoCx4z1s/fM1Ll4fE1Vued1qOV4mWc2Lq24e/ADL9ektEhYsRElKwqdFv9vsTHcrJ3lBlZUIFIghYmeHYhw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fbf191-720d-405a-201f-08d65ccffb9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2018 05:42:46.8082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

This patch series adds slave mode for lpspi controller. So this driver can =
support both master and slave mode for lpspi controller after apply this pa=
tch series. Currently, both master mode and slave mode share the code in th=
is driver. Therefore, using spi_master to represent the structure of slave =
mode will cause confusion.

When Geert Uytterhoeven add the slave support for spi, he had done " Genera=
lize SPI 'master' to 'controller'" step, too. The commit ID is 8caab75fd2c2=
a92667cbb1cd315720bede3feaa9.

Thank you.

Regards,
Clark Wang

> -----Original Message-----
> From: Joe Perches <joe@perches.com>
> Sent: Saturday, December 8, 2018 13:14
> To: Clark Wang <xiaoning.wang@nxp.com>; broonie@kernel.org
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH V3 1/4] spi: lpspi: Replace all "master" with "contro=
ller"
>=20
> On Fri, 2018-12-07 at 02:50 +0000, Clark Wang wrote:
> > In order to enable the slave mode and make the code more readable,
> > replace all related structure names and object names which is named
> > "master" with "controller".
>=20
> In what sense does this make the code more readable?
>=20

