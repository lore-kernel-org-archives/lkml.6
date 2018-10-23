Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE5BC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7207F20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b5/LovL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7207F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbeJWRav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:30:51 -0400
Received: from mail-db5eur01on0059.outbound.protection.outlook.com ([104.47.2.59]:44064
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727763AbeJWRav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feD7iqQXFCKsYW1uQnh09+eNNvZxPbIhDGjoxvwLX58=;
 b=b5/LovL+dCJOuRWhTuu/GP6nTVUucEANZmHK6UQYov6AF3/R+m3MIeLzz9mq4VmHfyZXHuEJz4ojmiBzWMSV6k66VgkUfYQi9NchVGFGUyAcRdYCXbKoBVCAKTZ8Z76AzMXGPtbO+cEn2mCfKRfDGWXDmpNS6yHf2qjYIBPsgNg=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB0925.eurprd04.prod.outlook.com (10.161.106.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:05:24 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 09:05:23 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "Cristian.Birsan@microchip.com" <Cristian.Birsan@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "richard@nod.at" <richard@nod.at>, Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@microchip.com" <cyrille.pitchen@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Topic: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAACWwgIAHmPMggAA4ZoCAAAyv0IAABzqAgAAC3GCAAAKVgIAAAdOAgAACLYCAAAvpAIAAAL7QgAABtoCAARoEIIAAEEQAgAAqy8CAAAnsgIAAA5wAgAAAe9A=
Date:   Tue, 23 Oct 2018 09:05:23 +0000
Message-ID: <VI1PR04MB103882359E835334D19177E299F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
        <20181017115237.07310b74@bbrezillon>
        <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022111543.2a607efc@bbrezillon>
        <VI1PR04MB1038EF892921194D1BFDE6FC99F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022122659.0675942e@bbrezillon>
        <VI1PR04MB1038E92FFAB03E07048FD8B499F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022124627.2c6c3b93@bbrezillon>    <20181022125259.42df83ea@bbrezillon>
        <VI1PR04MB1038C9C889185F2A700220F299F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022134324.2c1bd248@bbrezillon>
        <VI1PR04MB1038E072BFFD09C7C19AD2F899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181022135211.1978c25d@bbrezillon>
        <VI1PR04MB1038B9A5A8C59E6CB0863FF599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181023073946.138b287e@bbrezillon>
        <VI1PR04MB10381C2DC4052E636BA26ADA99F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
        <20181023104827.77e7775b@bbrezillon> <20181023110122.27f73100@bbrezillon>
In-Reply-To: <20181023110122.27f73100@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB0925;6:DuUYD1KTxW4dGVElqfXlmVKEaRbQUDpXjd1qm9J7HVS7LhqotxaG+Z1Ga1g0YN5NKVFzQamqtgkUQWyXDrG5TysFQGF1c3wCNV+rpfIMaN3nnURMWDLbZdTqUo2wmtcfgKcoprPjFztntWRF0LVk5B1H8p/kBqbvJ0Z4adQkHwhvBjMOnsHQaiOB4UwqzzRe9SM2mKertWNOPct3iFHCU1rtAW/scHDzkzfuT0NPN6v310iJHsX35gwXrPFdcHhv8JfgASkevqI/7xjhgrn+mX5ar3GAwk3eTWMyuLUV8qvQDRkgiX7KXlhB1QitxkAAREIxyfDLr6hQghgcPhSva3Zm1YfC1mL4qnRp0dy0m8CIZf2Ft7u4oAfnexUPMpJ2rxlP/VsVyVWulekEgyZtoFnjxVaqdBH3KprNsjHGBihpCHVTaLQlMnaoZ/s1O7KfzEwjEUxOsAv4D2YdfsTdBw==;5:U2W+gFYwwy6CgtSAjzl7Y2Tr0DP+3TZi0+atTbh3usRFntzPozVWOiNCljzcBKu3IA0SxN7cHsLtRzKSVFHK4JNvjUID9pYHm3X2satY7RvDZx/dl2UyT89GJBQ4Yaggodg5V0Lwtp4zYoGwc2PXVabdqNmICcgDwoaXi7ZJb1Y=;7:yxJmEKPyr4XIQ4RlX+mF7Q9EvxX4+RZCiZe9TVibc9LBG7oHc/e4MG2HfQO0TImh5FBjJ02w7DKXwN4CXActIfyMtGTTUWPVaLFo/xk9TgzmftXUy4aV+9+IXosfkVJTl+P3CNwQpSFqigydrHAL0Nq8LfBWGEudOkA5BvSy4eX4hOmWRqZWkB6FzFmTtGXBlaDFpfdTZWULovzPtQi4pq6VhGB61ApzmHvpwoczqe+dxxadwV15c0jteb8uGqYt
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5537213a-2436-486b-42cc-08d638c6aab9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB0925;
x-ms-traffictypediagnostic: VI1PR04MB0925:
x-microsoft-antispam-prvs: <VI1PR04MB09257F605D01C6C845E1435E99F50@VI1PR04MB0925.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB0925;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB0925;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(136003)(376002)(13464003)(199004)(189003)(229853002)(8936002)(55236004)(102836004)(6916009)(446003)(53546011)(71200400001)(53936002)(4326008)(33656002)(6246003)(39060400002)(68736007)(14454004)(6506007)(105586002)(3846002)(25786009)(478600001)(6116002)(256004)(5250100002)(305945005)(106356001)(7736002)(78486010)(26005)(2900100001)(66066001)(97736004)(5660300001)(2906002)(7416002)(54906003)(76176011)(9686003)(186003)(86362001)(55016002)(93886005)(7696005)(99286004)(217873002)(316002)(476003)(71190400001)(74316002)(6436002)(8676002)(11346002)(81156014)(486006)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB0925;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xEsLKeZ8V3/RKdq7XtXj9o5Q/hPhAQR7n40CGmeFJWadoV0MTufAHWumuQZgUZAbP3zxol7QrcLgSESdvEdWxGD65eSurT9Pc4aThQOPU4RDXj7yi/SUJHkHUooZGciHul0cs1J9rQNGmGdWfJiV7Xfe6qMohaIIXSu6J/NC/J2yTliyLhwuTx9F7ZXK06FidEFpfULLmP7OPj/2ajwEVk+OdkeaWMJTxi1D0raFVhlyMJK7LSpyqppbbQQDglwc16x+2QX6uDyJdBNcrGLXmjgDq46e/eHIPIKYZLW2XuRW/rgYlxPTtli0Ap/VFLZskeTWxJyzP1lQZ74aNv1Wsn2+S3oZTLYO+JRTwXZRwLY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5537213a-2436-486b-42cc-08d638c6aab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:05:23.6190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB0925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, October 23, 2018 2:31 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: Cristian.Birsan@microchip.com; Tudor Ambarus
> <tudor.ambarus@microchip.com>; richard@nod.at; Mark Brown
> <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org; Cyrille Pit=
chen
> <cyrille.pitchen@wedev4u.fr>; computersforpeace@gmail.com;
> dwmw2@infradead.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP=
 SPI
> NOR flash memories
>=20
> On Tue, 23 Oct 2018 10:48:27 +0200
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>=20
> > On Tue, 23 Oct 2018 08:18:35 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >
> > >
> > > I have added the prints in m25p80_read() and in flexspi controller pr=
epare_lut
> and read_rxfifo() func.
> > > In these have added prints for data variable of struct op and data wh=
ich
> being read by the controller from the flash.
> > >
> > > [    2.091467] smpt[0]=3D[addr_width:00000003, read_dumy:00000008,
> read_opcode:00000065, data_mask:00000008]
> > > [    2.099113] m25p80_read, nor[op:00000065 addr_width:00000003,
> dummy:00000008, len:00000001
> > > [    2.107367] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbyte=
s:3,
> bwidth:1]
> > > [    2.114753] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1,
> nbytes:1]
> > > [    2.121706] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:=
4,
> nbytes:3, bwidth:1]
> > > [    2.129786] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1=
]
> > > [    2.136132] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465
> 1:24003008      2:0     3:0]
> > > [    2.144223] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]
> > > [    2.151004] smpt_read[1] addr[00000004], data_byte[00000000]
> err:00000000
> > >
> > >
> > > [    2.157782] smpt[2]=3D[addr_width:00000003, read_dumy:00000008,
> read_opcode:00000065, data_mask:00000004]
> > > [    2.165429] m25p80_read, nor[op:00000065 addr_width:00000003,
> dummy:00000008, len:00000001
> > > [    2.173683] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:2, nbyte=
s:3,
> bwidth:1]
> > > [    2.181068] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1,
> nbytes:1]
> > > [    2.188021] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:=
2,
> nbytes:3, bwidth:1]
> > > [    2.196101] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1=
]
> > > [    2.202447] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465
> 1:24003008      2:0     3:0]
> > > [    2.210539] nxp_fspi_read_rxfifo, ReadData op.buf[0x02]
> > > [    2.217319] smpt_read[3] addr[00000002], data_byte[00000002]
> err:00000000
> > >
> > >
> > > [    2.224098] smpt[4]=3D[addr_width:00000003, read_dumy:00000008,
> read_opcode:00000065, data_mask:00000002]
> > > [    2.231744] m25p80_read, nor[op:00000065 addr_width:00000003,
> dummy:00000008, len:00000001
> > > [    2.239998] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbyte=
s:3,
> bwidth:1]
> > > [    2.247383] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1,
> nbytes:1]
> > > [    2.254336] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:=
4,
> nbytes:3, bwidth:1]
> > > [    2.262416] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1=
]
> > > [    2.268762] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465
> 1:24003008      2:0     3:0]
> > > [    2.276854] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]
> > > [    2.283634] smpt_read[5] addr[00000004], data_byte[00000000]
> err:00000000
> > >
> > >
> > > [    2.290412] spi_nor_get_map_in_use:2915 map_id=3D0 smpt_len:16 i=
=3D:6
> > > [    2.296496] End [addr_width:00000003, read_dumy:00000008,
> read_opcode:00000065] ReturnVal:00000000
> > > [    2.305444] spi_nor_parse_smpt:3065
> > > [    2.308924] m25p80 spi0.0: failed to parse SMPT (err =3D -22)
> > >
> > >
> > > >
> > > > Next thing you can do is read the CR2NV reg (using the RDAR command=
)
> and
> > > > check the RL (Read Latency) and AL (Address Length) values.
> > >
> > > Please let me know how to read CR2NV register.
> >
> > Actually, RDAR is already what you use to read the map_id, and we need
> > to use it to read the register that contains the number of dummy
> > cycles and the number of address bytes to use for RDAR operations.
> > Looks like we have a chicken and egg situation here :-).
> >
> > Let's try something else:
> >
> > 1/ create an u8 array of 16 entries named data_bytes
> >
> > for each loop iteration (the first for loop):
> > 2/ set ->addr_width to 3 and ->read_dummy to 0 3/ call
> > spi_nor_read_raw(nor, addr, ARRAY_SIZE(data_bytes), data_bytes) 4/
> > dump the data_bytes buf 5/ set ->addr_width to 4 6/ call
> > spi_nor_read_raw(nor, addr, ARRAY_SIZE(data_bytes), data_bytes) 7/
> > dump the data_bytes buf
> >
> > If the SPI driver is working correctly, we should be able to figure
> > out the right value for ->addr_width and ->read_dummy.
>=20
> Also, can you add traces in nxp_fspi_read_rxfifo() to print the value ret=
urned by
> f->read(base + FSPI_RFDR + j * 4) (there are 2 of them).

I have added this and printing the data content, all 4 bytes, after each f-=
>read(base + FSPI_RFDR + j * 4);
This I have shown in the logs, only 1 byte i.e. as we are reading only 1 by=
te so I have deleted content of rest 3 bytes when sending the logs in mail.

--
Regards
Yogesh gaur
