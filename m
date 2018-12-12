Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54125C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161EC20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FGfRtFCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161EC20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbeLLCP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:15:56 -0500
Received: from mail-eopbgr40087.outbound.protection.outlook.com ([40.107.4.87]:9468
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbeLLCP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9Fxo1i2lLXaZrBhVFAUTk+6Xga7PNKRtqF8hkFbMQM=;
 b=FGfRtFCIcG507lF0dXCxjjZqslSgZgmgzwzS7CfwTDHLNoCGMYc1gjoAUgp+TMSP9d8XNlwPJDQlOHoOBi8pAdN+DBoFbZdjvvefGrfUHyCRw8IIba4khiNp+8uZ/Y366pB7BNuakMCOGDpPowGxZZc+g5v8OkogAxbSnwdhK00=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4488.eurprd04.prod.outlook.com (20.176.242.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.23; Wed, 12 Dec 2018 02:15:52 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 02:15:52 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: lpspi: enable runtime pm for lpspi
Thread-Topic: [PATCH] spi: lpspi: enable runtime pm for lpspi
Thread-Index: AQHUi5lbAahFdcVEeUKVpS14WP0PHqV5pFCAgADEtaA=
Date:   Wed, 12 Dec 2018 02:15:52 +0000
Message-ID: <AM6PR04MB5016DBDB10579AF52B4C6A0CF3A70@AM6PR04MB5016.eurprd04.prod.outlook.com>
References: <20181204061904.28567-1-xiaoning.wang@nxp.com>
 <20181211142817.GH6686@sirena.org.uk>
In-Reply-To: <20181211142817.GH6686@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4488;6:J4KGYywSwezeMpWzoHnyO/Ivxkdt+fkEPDFwOe/0dRShnVFmJcc7PHfrNOc5Pfr75vj19/iuWMDx3mSTdYpk8NZ5XTPj1WnB3r2vwTw58OUrWcWYAybg+e4e990bBfIx005y+JcwNvJJ2SXzUqe2oPiytoIbOkczVryRhYsj74D0sxw8B42wiPiatGXPRmH+IY6Hh478rD0JDCyps9Q6KuulG+Am8SJjPyq8cAuYx4Nkx3HsgHCaorBTh21hTKPj5HXUuKkfzHDbDBYqKFRj3ztKSC4qTxbztIMTpBpfqAHM44G7n4mgfaScpXe/HLAVY/tzSIFJNV0NioTzsABWioiFTarKzlY1O8HXCOEIzoMWO5x/8AUfU6e/XKHbFbsqnrcdenmcV+cmZ5vKHVTUz0L05EkJMJqznIvBDeSlBMydefNm3jaj0ztS6xJYPv5L5iV7R3Z9xHq3mNiEgSZqwg==;5:XEsAYoIx81NQZmfSRD074t0ZPaESGpxPBioqxqofI/aVhvVv1pOLshPhh2nmUNEEpxfzYqjWHIWLLPbY5IK9wwYtl9rrf7aQ54xXgB10PKPspR+ySKBqT4Ibo36whJsXjGBp8h8iDxzuM8xIjb/fRQztBl7fFvdIGEDlgtduwCM=;7:KzHT8f8/maBMXj5CpXIpp/IzmX9YZIZMpSvx8zOhl1DlkVzuU10jlmGDfm3btIIi8jlwJ+bZnA2M3v2NOstfoqoTCine7+6iYq4QIJcYUuM1YgsVWta6fDN4x5Itork+tGFbpiSAFf1p6/L5RPihRg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6e3a8cfb-2521-4ad6-4c3c-08d65fd7bdc7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4488;
x-ms-traffictypediagnostic: AM6PR04MB4488:
x-microsoft-antispam-prvs: <AM6PR04MB448896BA2C37E99D8FE40288F3A70@AM6PR04MB4488.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4488;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4488;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(136003)(39860400002)(396003)(13464003)(199004)(189003)(6116002)(102836004)(55016002)(6506007)(229853002)(6916009)(186003)(6246003)(476003)(26005)(478600001)(106356001)(316002)(99286004)(446003)(68736007)(486006)(11346002)(5660300001)(105586002)(53546011)(66066001)(256004)(14454004)(7736002)(71200400001)(54906003)(71190400001)(7696005)(76176011)(4326008)(25786009)(305945005)(33656002)(81166006)(8936002)(8676002)(81156014)(9686003)(2906002)(86362001)(3846002)(53936002)(74316002)(6436002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4488;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mzmWZukVU8E67smLFyN7MkBETFh5Csb7mG/xKlQN8Wu4ZiOXxKkt7IXqCZ+FrrHZAWvDsIw7G5E1Cv1F4vrLiyzWH4RleLBi5Pg9nLTJTWnCr9mcUH87tzBoqLhckgOVTIv/ZUeCTZTnkgIFYQqiOtrZhhtidgo8taaTiA5N5VFYRfwpAO5bsMbhNDM7fliDcvASpg3faocaZFGZYxaIid5aiBrsrcP4skUlNpUCrIPC0LYlB6Z3OBbYyHHwBuD/NYUIp5bgY/Yi02oAAkuh54QHAF7hMmuBx4iZ+ea4uHcO9VE2ADiUZMHJsy32plX3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3a8cfb-2521-4ad6-4c3c-08d65fd7bdc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 02:15:52.4615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, December 11, 2018 22:28
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] spi: lpspi: enable runtime pm for lpspi
>=20
> On Tue, Dec 04, 2018 at 06:19:48AM +0000, Clark Wang wrote:
> > 	From: Han Xu <han.xu@nxp.com>
> >
> > 	Enable the runtime power management for lpspi module.
> >
> > Signed-off-by: Han Xu <han.xu@nxp.com>
> > Reviewed-by: Frank Li <frank.li@nxp.com>
> > ---
>=20
> There's no signed-off-by from you here?  These are required, please see
> submitting-patches.rst.

Oh, there should have my signed-off-by here. For the big changes with 4.9 i=
n our git branch, I did some adaptation work.

Regards,
Clark Wang
