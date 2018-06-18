Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372C0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6ED20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="btrxRa37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6ED20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934367AbeFRNcd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:32:33 -0400
Received: from mail-he1eur01on0065.outbound.protection.outlook.com ([104.47.0.65]:26752
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933557AbeFRNcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KNOdCZpNN9VmIBJNNm+pw95emHz+kX6KNNaCphPLrk=;
 b=btrxRa375/ArXghiWZgvsm7oSLo+VKYbqq+9u0b2VYem/MWwIsGVclVBjtG7dClQxFain4VPMZaBO6KtNXlYYsfkd2Yer5nw47s1W0k5qDwD+bNcvO5sqqqFyUD+3NOJIG/K6Pa/9C6Qh2ikLKD/1cOM6B+qmkqAiHlgbC7teZk=
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com (10.172.247.10) by
 DB6PR0402MB2760.eurprd04.prod.outlook.com (10.172.246.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Mon, 18 Jun 2018 13:32:28 +0000
Received: from DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::49a5:1040:801d:2b97]) by DB6PR0402MB2838.eurprd04.prod.outlook.com
 ([fe80::49a5:1040:801d:2b97%2]) with mapi id 15.20.0863.016; Mon, 18 Jun 2018
 13:32:27 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
CC:     "richard@nod.at" <richard@nod.at>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHT+BiB2hXNm2lXyUydyOG4FdlBjqRWHnBAgABANgCABEvZ8IAAFd0AgAAehWCAAAtnAIAAAPSwgAFUQ+CAAAoIAIAAGBOggAT9CYCAAATqYIAADVmAgASumwA=
Date:   Mon, 18 Jun 2018 13:32:27 +0000
Message-ID: <DB6PR0402MB2838C4F67D17337ADBC5D5F899710@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180608145130.09f979f9@bbrezillon>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611094616.5c8f82cf@bbrezillon>
        <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611121618.40f4b609@bbrezillon>
        <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <DB6PR0402MB2838563F1BA71A9A21ABBE01997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180612091328.67734adb@bbrezillon>
        <DB6PR0402MB28387FE79F2742C9BEBD4037997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180615145019.734f23a9@bbrezillon>
        <DB6PR0402MB28382767652782E0CC6C14A0997C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180615155541.4f43e9bb@bbrezillon>
In-Reply-To: <20180615155541.4f43e9bb@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0402MB2760;7:xXYFodu8FZDf0YjLXvOmfXKr+zEG9nmAPIruiTpKklmojiK3KlPRi9+YSrc5qGXAOs4YuEAZVonzWaIjP9GuEp0Rshr7F/NwW7NuXry9pX7JBQ4pG4R1NDN/fZUWnzADwfzvXrE2eCITSIpqYV52a1nmg2ckvUghpZpZ3tfKZzGQoyi6ubq9dTAHzaOXUCCkbqpnEg7BMlBtNXGCaEsE71LkTnNbq/Da9DaRsmWC8jkAnmbRyw9I2t6jpPY6Ov7Y
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8b96215d-6f55-4a55-39a1-08d5d51fef61
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0402MB2760;
x-ms-traffictypediagnostic: DB6PR0402MB2760:
x-microsoft-antispam-prvs: <DB6PR0402MB27601F427EB5015896E99A5A99710@DB6PR0402MB2760.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0402MB2760;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0402MB2760;
x-forefront-prvs: 0707248B64
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(346002)(376002)(39860400002)(396003)(13464003)(189003)(199004)(74316002)(3846002)(6116002)(305945005)(110136005)(54906003)(86362001)(99286004)(2900100001)(97736004)(33656002)(81166006)(8676002)(81156014)(8936002)(551984002)(478600001)(7736002)(2501003)(14454004)(5250100002)(66066001)(76176011)(39060400002)(106356001)(105586002)(316002)(186003)(2906002)(446003)(26005)(3280700002)(25786009)(4326008)(6436002)(55016002)(9686003)(7416002)(53936002)(6246003)(93886005)(476003)(6506007)(3660700001)(55236004)(102836004)(486006)(11346002)(5660300001)(68736007)(229853002)(7696005)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0402MB2760;H:DB6PR0402MB2838.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OIDMKQ6x+lAcKwxWgn0Ww15Jd5LfmyVRSpJc/5OmLS4S7b1TjPqGhGByYpNYa+OHs/YOGrMlO1UQkB7NAOTXbLY5525U97/UHLgWzN/8DsI/rJlx54DF9As1hQqhApO4DQ5gRailnobyhGkIV/rtoMoxLbyb5cEgaaXKjeuny7AD2SJO7SbQZJ2/s+7u7Cg3cZcGoJLM3yhQPz8/5HrQaqGnNkJI6hI7DQjXmmko43fMegNoJQOLgJ3QCSdHoXF4tD5Cq2yo2r9Jm+Nu0QOTOEDDZ+mkRTAlCZ6C1D9Z+TEvAaxe242RuIe8uFEh1jKfvyUnCMFXsswIneIDGRJ3Bg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b96215d-6f55-4a55-39a1-08d5d51fef61
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2018 13:32:27.9153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2760
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Friday, June 15, 2018 7:26 PM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Fabio Estevam <fabio.=
estevam@nxp.com>; David Wolfe <david.wolfe@nxp.com>; dwmw2@infradead.org
Cc: richard@nod.at; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu=
 <han.xu@nxp.com>; linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;=
 marek.vasut@gmail.com; Frieder Schrempf <frieder.schrempf@exceet.de>; broo=
nie@kernel.org; linux-mtd@lists.infradead.org; miquel.raynal@bootlin.com; c=
omputersforpeace@gmail.com
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI =
controller

On Fri, 15 Jun 2018 13:42:12 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Boris,
>=20
> I am still debugging the issue.
> With some analysis, able to check that proper values are not being writte=
n for QUADSPI_SFA2AD/ QUADSPI_SFB1AD/ QUADSPI_SFB2AD register.
>=20
> In current code, value of map_addr are being assigned to these register.
>              map_addr =3D q->memmap_phy +
>                         2 * q->devtype_data->ahb_buf_size;
>=20
>      qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));
>=20
> But instead of "q->devtype_data->ahb_buf_size" it should be flash size.

No, because we're only using 2 * ->ahb_buf_size in the direct mapping for e=
ach device, and we're modifying the mapping dynamically based on the select=
ed device. Maybe we got the logic wrong though.

Yes, for register QUADSPI_SFA2AD/ QUADSPI_SFB1AD/ QUADSPI_SFB2AD, we need t=
o save starting actual address from where this flash is getting started.
Thus, if my first flash size is 64MB, then register QUADSPI_SFA2AD would ha=
ve value of q->memmap_phy + 0x4000000 i.e. (QUADSPI_SFA1AD + sizeof First F=
lash)
If second flash is of size 32MB, then register QUADSPI_SFB1AD would have va=
lue of value of QUADSPI_SFA2AD + sizeof second flash.

> For my case flash size is 0x4000000 and with this hard coded value I am a=
ble to perform Write and Erase operation.
> One more change, I have to do is adding the flash_size when writing the b=
ase_address in SFAR register for case when "mem->spi->chip_select =3D=3D 1"
> 	qspi_writel(q, q->memmap_phy + 0x4000000, base + QUADSPI_SFAR);

I don't want to expose the full device in the direct mapping yet (that's pa=
rt of the direct-mapping API I posted here [1]). What this version of the d=
river does is, map only 2 time the ahb_size so that we can bypass the inter=
nal cache of the QSPI engine.

To perform any operation on second flash, we need to provide it's base addr=
ess should be saved in SFAR register for this particular operation.
Exposing only 2 time of ahb_size is design decision but value in SFAR regis=
ter should be correct.

>=20
> Thus, there should be mechanism or the entry in structure where we can ha=
ve the information of the size of the connected slave device.

Because that's exactly the kind of thing I'd like to avoid. What if the dev=
ice is bigger than the reserved memory region? What if the sum of all devic=
es does not fit in there? Here I tried to support all cases by just mapping=
 the portion of memory we need.

So IMO, there should be mechanism to have value of start address of each sl=
ave device. This might can be done from DTS entry of each slave device conn=
ected to the controller.
