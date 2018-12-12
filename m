Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E6AC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA7E20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ntZBPD4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA7E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeLLCMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:12:13 -0500
Received: from mail-eopbgr130047.outbound.protection.outlook.com ([40.107.13.47]:46355
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbeLLCMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brd+NZhPHybrNU96XkUsQ5BqfJw6cA+Z9DWSaQNIfAs=;
 b=ntZBPD4h2tQwY/VS17l5znNgpP6ixE28ogO71tx6vOjrpBb0COX7gUcxJxuaVwqlXtrPAw8hxRUgvRBCoWFY0bRUViq5VAz1fdL0kyL6LCmMLWLdWMD7540FhIaFLv4/YwShqAjQCUcCBySsbjhXrWFOvLPS1la5LpZaB3DgNUM=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4008.eurprd04.prod.outlook.com (52.135.160.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Wed, 12 Dec 2018 02:12:10 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 02:12:10 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: lpspi: Add cs-gpio support
Thread-Topic: [PATCH] spi: lpspi: Add cs-gpio support
Thread-Index: AQHUi5oV18iLHkPhlEO5KoZOnZS+lKV5o7mAgADE7RA=
Date:   Wed, 12 Dec 2018 02:12:10 +0000
Message-ID: <AM6PR04MB50167EFBFCF970403B4EF90DF3A70@AM6PR04MB5016.eurprd04.prod.outlook.com>
References: <20181204062313.28942-1-xiaoning.wang@nxp.com>
 <20181211142611.GF6686@sirena.org.uk>
In-Reply-To: <20181211142611.GF6686@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4008;6:sj+bA/LJJLytnoAxNWth78EwRmkC6/GL70gYxKorHcKeDT1dcjTM9R9Fva5kX8wFYMFlFmRquwDWNZtOrNjuJnESqGu/JBvDyhGmCZ3U+87KUYSDGE6nHvO5USRZP35th52W8vBsTKJIW0AJcx1vTn0o77IzELgiTozJIW068Bg8j7KsY3wvRMkc5IcA0a+tGeYRepJzUH5dYI4lfA3iAiGsWlQ3s4Jx1v5i82YO+QpzOwlobZKTLgU4uIoY56ji+ZfHomi/GxGMda4tx0qdEQjuMN/NMjocmuQo5cS4WZU7J5hhvh9VpmdxI+8e6hD+xTQ3XUWXLUXUKs9cPQSpbGcw0OKt872bGbwvd4QsXmGM3J61vAIVahXPF+t6K5kvm1AFL2d0DJnKc+1FQ7OwlsBxoJPTs5kn6ixjaW1JeulFkmvb9qqydLSSGNPbC9qW55VCblJagkIsjfnb8kK9NQ==;5:A3CTRrgXzJoV5+lFuGRTYamo6V8tPPFe/DcnE82z30qo6CQByk947yXKSn13CBUTJ4Kca09h6xPLqyrs7MLydL52Ruh7Aewz16+pJfgFul64rqKn5gCWqqlSj2t935LeR+tU4eCdRYpsCIbZicrUYJmwHu8EKCI3x1MvX9AznQE=;7:uJdPCmo22+62wFDNJqyWrMkZdpNC/9OUKFUCEoKVxrkNYQRKO57TUohLlvcha1m/U6kmIoY5Fe9TNie1SpcANf+opR2MLXEkwuDfj4IuepQN6SOlMHpJK/k2XDgwWIxroTMJBxwFQXXTN/kgL/ARGA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: facc7cbf-14e7-48ee-a112-08d65fd7398b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4008;
x-ms-traffictypediagnostic: AM6PR04MB4008:
x-microsoft-antispam-prvs: <AM6PR04MB40087CAAC61EE714B03EB076F3A70@AM6PR04MB4008.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231472)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4008;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4008;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(189003)(199004)(13464003)(76176011)(7736002)(4326008)(256004)(229853002)(305945005)(476003)(6116002)(8936002)(14454004)(71200400001)(105586002)(86362001)(71190400001)(74316002)(99286004)(6506007)(106356001)(478600001)(316002)(53546011)(8676002)(68736007)(81166006)(102836004)(54906003)(81156014)(6916009)(186003)(7696005)(6436002)(9686003)(11346002)(446003)(33656002)(55016002)(53936002)(3846002)(26005)(2906002)(6246003)(486006)(25786009)(5660300001)(66066001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4008;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YBh6G+xw27Xn3Yyju6m/04ZLT9k9i0NtJVAake0HWZ3hEaDvo/Wk3PLJxr8MZGidVGirJ0g7J9j+Rs8TSRVsL1opv7W1Z1Eet+bDOu9BEHAP+Iltm+Fv+dGQBfC+WloC6sYMXc7CjwbsE9zAlFZbVb/nqnd3ulXrupShRP6CNpLxHkvbEnPgOKg5e5EYlvlXREYtEDRdA51gs5iDFli2ZtI7nQTQXW3/4ww/0dbqsavTOO+uyzaGelMGoGcqVtrgTN6neiyYq+jH2rLChWPkXX0notcAUpB2fM4ibiLQH5UMIgDt9KugILuk92nCcU2x
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facc7cbf-14e7-48ee-a112-08d65fd7398b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 02:12:10.6562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, December 11, 2018 22:26
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] spi: lpspi: Add cs-gpio support
>=20
> On Tue, Dec 04, 2018 at 06:24:59AM +0000, Clark Wang wrote:
>=20
> > Add cs-gpio feature for LPSPI. Use fsl_lpspi_prepare_message() and
> > fsl_lpspi_unprepare_message() to enable and control cs line.
> > These two functions will be only called at the beginning and the
> > ending of a message transfer.
>=20
> > Still support using the mode without cs-gpio. It depends on if
> > attribute cs-gpio has been configured in dts file.
>=20
> Why is this not using the core support for GPIO chip selects?  Note that =
you
> can't just implement chip select in the prepare and unprepare, drivers ca=
n
> toggle chip select within a message so the code should be looking at the
> individual transfers to see if cs_change is set and acting accordingly.

Ok, I will try to use the core support for GPIO chip selects.

Regards,
Clark Wang
