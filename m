Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594A8C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DBF20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pWX5KNgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03DBF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeLLCKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:10:51 -0500
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:3440
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbeLLCKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJNLcvjAmPK52HYHxh8V/8yT6e6AQJctpHhBws3lQeg=;
 b=pWX5KNgYQAE5EqXZ7k0ZjgAdjiNIUobo7GAuaHKR1NqAxiHmc0RUartfUZGRktFP5cRRhOlZoesNHG3iG7bwGXFmDzMjfQjlNFhz26geIXmvUfagGVLI6TJF3L4gsRoFA1VSmNvt2NyYeNTBNPbqsazP3iLJpZflyOT7CheELQc=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4008.eurprd04.prod.outlook.com (52.135.160.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Wed, 12 Dec 2018 02:10:46 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::c518:be51:28b2:24c3%5]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 02:10:46 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] spi: lpspi: Fix CLK pin becomes low before one transfer
Thread-Topic: [PATCH] spi: lpspi: Fix CLK pin becomes low before one transfer
Thread-Index: AQHUi5nZC//vtxGbN0eH4Ul4gq7Xk6V5pNCAgAC8eAA=
Date:   Wed, 12 Dec 2018 02:10:46 +0000
Message-ID: <AM6PR04MB5016E6D2220CDD266B2C6C01F3A70@AM6PR04MB5016.eurprd04.prod.outlook.com>
References: <20181204062224.28844-1-xiaoning.wang@nxp.com>
 <20181211143005.GJ6686@sirena.org.uk>
In-Reply-To: <20181211143005.GJ6686@sirena.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4008;6:Z+S25jHDbwWRe3EIDopybVjayTv7MyZSHxhHpUNy5EBpHa+IV2nYkvzkYez+Se3fY5HuMLlCTYWvAJ2vuyqHTddMpAFkMFh6dMCvxtEG7DPfzyXDNSVNbT4trwrlN4QkMYs07qDnEApxW2deEra1c/TamjnHFTusjxl+SAfg1mLI+x7kUzHxSQQxmEbHiyG+5KvImXCp0ne955YjxIZm7tg4wfPGY0+Dtj6o6xQV3jTuFAXxx568NA2Zut517ip2QAzlelup3qY0c7BWSjiIUZv4hC8lEIOL9hkj+BN1tJPhGGIr/XtHuiUgkSrUZ1MfDnqswVjcoiXpiOgWbe56+LkltHRiraxyqF63p1nZWowe3Qgf2tu5SuLSRUwg0b8yT2pzEbswRnIKrk8/zt4sAP2BLdRMYvzn7/cb+Tq3EpA7AyzbzwUyGkPuxfzpl/CfnpO4q3dk5aKDY22hj9Tr6A==;5:zBxFhkUtklJY0SMfdRaiNqJ4ld8zZLIt942FeI1h5O47eaSRUCcYWhgLne7A9txle9ET/XwUqGMgIu0zvc2+iXe6xMOA/R4Obof7iTseQArWgLK3QRSNjFjR07TbhozJWtwt4zMLZ91BrVCSbgDuIG5gMlpIQ6k4akJlek1zlyk=;7:IaklOKvu+RmoxsGYJSEfw/iJPOqWt62hC0yM/+/TB+pkgtiXUvIoHR8M9hJEDxhWjgzDY42H6R0YWyGX5AUtHZ5zmGaN9TeEjM7A9UR64T3GIg8mJbk5mdWi0steo3hRcoC//DF5T/EJ/SRYCnj8aA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9f5a27e3-5174-4d17-aee1-08d65fd70784
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4008;
x-ms-traffictypediagnostic: AM6PR04MB4008:
x-microsoft-antispam-prvs: <AM6PR04MB4008E05087F81D56BAC77AD6F3A70@AM6PR04MB4008.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231472)(944501520)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB4008;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4008;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(189003)(199004)(13464003)(76176011)(7736002)(4326008)(256004)(229853002)(305945005)(476003)(6116002)(8936002)(14454004)(71200400001)(105586002)(86362001)(71190400001)(74316002)(99286004)(6506007)(106356001)(478600001)(316002)(53546011)(8676002)(68736007)(81166006)(102836004)(54906003)(81156014)(6916009)(186003)(7696005)(6436002)(9686003)(11346002)(446003)(33656002)(55016002)(53936002)(3846002)(26005)(2906002)(6246003)(486006)(25786009)(5660300001)(66066001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4008;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JcLY84TP/m5S5vOiq+2a8NW+MhJrSMpzn8VRNPpsz0be1AAsXdGbgShIxEJwWV0QOWM3jDGBWaG2T+869gyj2OwCscuNalpo/ozhWk4IC5w/1uAkjCWfvRCPqvivo3PfJg5vcOUzRJl8OwOnUmVPSOAznXL2HWI3w9Z1sKM3MiwAf8spLlKF0jInFA1G4+1pxIvePj0F3Rjf3YuiyNY3bQnqT10I71vn/Uz9mcb5Y0GLGPoGI1dX9t23s9ws08/W6OMLeWYbdh/xthqy0jN5gro5U6h7H4DwkTdgfHsGzejLAJ8qkqdwQtphTAvlHe1x
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5a27e3-5174-4d17-aee1-08d65fd70784
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 02:10:46.7476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

These five patches are based on patch series spi: lpspi: Add Slave Mode sup=
port for LPSPI. For the patch series make a big change, should I hold these=
 five patches until the patch series are applied in your git branch?

Thanks for your patience.

Regards,
Clark Wang

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, December 11, 2018 22:30
> To: Clark Wang <xiaoning.wang@nxp.com>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] spi: lpspi: Fix CLK pin becomes low before one trans=
fer
>=20
> On Tue, Dec 04, 2018 at 06:23:19AM +0000, Clark Wang wrote:
> > Remove Reset operation in fsl_lpspi_config(). This RST may cause both
> > CLK and CS pins go from high to low level under cs-gpio mode.
> > Add fsl_lpspi_reset() function after one message transfer to clear all
> > flags in use.
>=20
> This doesn't apply against current code, please check and resend.
