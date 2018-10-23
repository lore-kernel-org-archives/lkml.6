Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA3C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8EF20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vxIXeA46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8EF20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeJWRiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:38:25 -0400
Received: from mail-db5eur01on0086.outbound.protection.outlook.com ([104.47.2.86]:58804
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727714AbeJWRiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03i+6GLhh39f729JgjiaHSF0m/AAxIJSg9xic1rHRrA=;
 b=vxIXeA46wDpCRnmK0TNgBEv1kO/9VtNGyC0z+XLxakzpAw0JJ8OWU+1rljKywO4SxgbI6NuyTms1nnNeqa4wFG5UNKKAlkljaTgvSG/JH5e4ZhA+jkM9lGqVQKEAdqb3jx6Z9FmBC/b6Dk2X3yBbmyFd00xKC1aWWjVI7mAlcHk=
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com (10.161.109.144) by
 VI1PR04MB5342.eurprd04.prod.outlook.com (52.134.123.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 09:15:44 +0000
Received: from VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123]) by VI1PR04MB1038.eurprd04.prod.outlook.com
 ([fe80::d887:3c96:479a:4123%3]) with mapi id 15.20.1228.032; Tue, 23 Oct 2018
 09:15:44 +0000
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
Thread-Index: AQHUSeYwGQ074lVuqESxUXlBIHGe8qUh1lUwgABb2gCAABY6gIAAnHVQgABXcQCAAADvgIAABUuAgAACP9CAACWwgIAHmPMggAA4ZoCAAAyv0IAABzqAgAAC3GCAAAKVgIAAAdOAgAACLYCAAAvpAIAAAL7QgAABtoCAARoEIIAAEEQAgAAqy8CAAAnsgIAAA5wAgAAAe9CAAAIPgIAAAQ4Q
Date:   Tue, 23 Oct 2018 09:15:43 +0000
Message-ID: <VI1PR04MB10384D634262DBEBA4F4711E99F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
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
        <20181023104827.77e7775b@bbrezillon>    <20181023110122.27f73100@bbrezillon>
        <VI1PR04MB103882359E835334D19177E299F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181023111027.54df8650@bbrezillon>
In-Reply-To: <20181023111027.54df8650@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5342;6:jztUV1cM+lcdKqqBRwFbFBOe7+WPkdWgDzTt7IUjOR7eN9gQa4p2z2f1Jqqpmo+oFKP25Bww29nQk38q16F3oURawQU0L1Df1n6TU/EioIEVsxECYj4D8jhaAhnqc6x986G/UD/87L+jR6FvFPmw8jUMUGRjt0qiHsuUHCD9HyC8JXxogxLHwTpvA59Mo8Enl3O1TjLgZ0XqhbCLrlug4Hc7og94Th9L1XTBW7TUg4VzD2ohd20IBhv344Xm2o5mviVxNg4LmVJoJM6GyvSLbNReKMtDoI6fB4RB9t6VhuZp8+IjwgMtkA+ek7Iz4MK9A1Ydtb6dWTRO4MFaJzaPTsn8RywaPYoafNI07QfEac/RmBPRPu4up4M0L9E6W/AzOepCSIXCSg6b3Nmo+h7Uyhqa+NLPT82ybqBQU53vPUQAtafjIL5Bv/OOBYWEvnV5eFO/lyOE/Z+QHut3a9wctg==;5:nTfz4vh0DpTO1e4ULCWRk2yc2g+6yyeEWMcgazc7xwg5KdHWdny94lRf/Wx/QSQP3XKUamPMaovpAczkYI46rsdPIrrAEHWLzTwW7cQFmO2twIFKH0rxsyiRBg3nRoIcibRZjyYREO9ZUfHaZedl1TDsF/DSjo/FqSPcOtvBk7w=;7:8Q/7KHNtzBFMZFfnEFNudjip1orEnmZQYYkZD3WVEHM+Ww1hfK1bhjhJR+vnRxmaFeAgRPLSqbELMyxuGbS+SFwp3JMVVcuPNiwBNeRrvyOmXsOmyiBfP+AqJjYPVbPujbWW9K4wmohj+rh8UnX4Tdy5npv+UZmjxEca3snl1YUWR54qKbOt60EHEW+d3iz8GqFCk+CvNhcpRhtmETmrCz7tr7W0ojwT5Be6g6jLFsLnyHh3hntVIMF+ezlzXP5Z
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 37d6a9bc-e57f-4664-532d-08d638c81c74
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5342;
x-ms-traffictypediagnostic: VI1PR04MB5342:
x-microsoft-antispam-prvs: <VI1PR04MB5342431348F6E028213F159F99F50@VI1PR04MB5342.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(258649278758335)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5342;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5342;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(376002)(346002)(199004)(189003)(13464003)(55236004)(5660300001)(6506007)(76176011)(102836004)(93886005)(74316002)(53546011)(476003)(478600001)(4326008)(5250100002)(7696005)(6916009)(217873002)(316002)(97736004)(186003)(2900100001)(305945005)(54906003)(26005)(256004)(446003)(11346002)(14454004)(99286004)(486006)(55016002)(33656002)(9686003)(2906002)(39060400002)(86362001)(78486010)(229853002)(53936002)(6436002)(71190400001)(105586002)(81166006)(7736002)(68736007)(25786009)(106356001)(6246003)(8936002)(81156014)(8676002)(3846002)(71200400001)(7416002)(6116002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5342;H:VI1PR04MB1038.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sSiKmf9ViJkRhKfq5rsor5tldILMuzMTLc5tfKLz1bCp+3zxM0uXODzJwr/IkVMgAP4jABDe3OAftAOLvakvW9O26nWkA8ZvPlu/UA/ZhWHYJYCKcqkrnVRe9UeorBKq1V00ErF4Fgu3pMcB0YRG2LQfpxtgdewdr9S2ohv8NqgZfwIBYtvwLuo7uyEHyZwREe1LgkbESVptsLxmw2LCmIMuRWpEre7ab5Z5sJrGXTEDwD7vVexiNeR0e56HPAksLb8pIJlrILuYUUANRQnNWqFjMpBhC5xAZa+UNt2IE5csj2iRXfyQ7J/EFGFTd1GGj32yyJwZ1fA/VW50K+6+mGobvJdr0itQA+orSTozmtQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d6a9bc-e57f-4664-532d-08d638c81c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 09:15:43.9682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5342
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Tuesday, October 23, 2018 2:40 PM
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
> On Tue, 23 Oct 2018 09:05:23 +0000
> Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Hi,
> >
> > > -----Original Message-----
> > > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > > Sent: Tuesday, October 23, 2018 2:31 PM
> > > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > > Cc: Cristian.Birsan@microchip.com; Tudor Ambarus
> > > <tudor.ambarus@microchip.com>; richard@nod.at; Mark Brown
> > > <broonie@kernel.org>; linux-kernel@vger.kernel.org;
> > > nicolas.ferre@microchip.com; marek.vasut@gmail.com;
> > > cyrille.pitchen@microchip.com; linux-mtd@lists.infradead.org;
> > > Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>;
> > > computersforpeace@gmail.com; dwmw2@infradead.org;
> > > linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform
> > > SFDP SPI NOR flash memories
> > >
> > > On Tue, 23 Oct 2018 10:48:27 +0200
> > > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > >
> > > > On Tue, 23 Oct 2018 08:18:35 +0000 Yogesh Narayan Gaur
> > > > <yogeshnarayan.gaur@nxp.com> wrote:
> > > >
> > > > >
> > > > > I have added the prints in m25p80_read() and in flexspi
> > > > > controller prepare_lut
> > > and read_rxfifo() func.
> > > > > In these have added prints for data variable of struct op and
> > > > > data which
> > > being read by the controller from the flash.
> > > > >
> > > > > [    2.091467] smpt[0]=3D[addr_width:00000003, read_dumy:00000008=
,
> > > read_opcode:00000065, data_mask:00000008]
> > > > > [    2.099113] m25p80_read, nor[op:00000065 addr_width:00000003,
> > > dummy:00000008, len:00000001
> > > > > [    2.107367] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4,
> nbytes:3,
> > > bwidth:1]
> > > > > [    2.114753] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:=
1,
> > > nbytes:1]
> > > > > [    2.121706] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[=
val:4,
> > > nbytes:3, bwidth:1]
> > > > > [    2.129786] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbyt=
es:1]
> > > > > [    2.136132] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465
> > > 1:24003008      2:0     3:0]
> > > > > [    2.144223] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]
> > > > > [    2.151004] smpt_read[1] addr[00000004], data_byte[00000000]
> > > err:00000000
> > > > >
> > > > >
> > > > > [    2.157782] smpt[2]=3D[addr_width:00000003, read_dumy:00000008=
,
> > > read_opcode:00000065, data_mask:00000004]
> > > > > [    2.165429] m25p80_read, nor[op:00000065 addr_width:00000003,
> > > dummy:00000008, len:00000001
> > > > > [    2.173683] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:2,
> nbytes:3,
> > > bwidth:1]
> > > > > [    2.181068] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:=
1,
> > > nbytes:1]
> > > > > [    2.188021] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[=
val:2,
> > > nbytes:3, bwidth:1]
> > > > > [    2.196101] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbyt=
es:1]
> > > > > [    2.202447] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465
> > > 1:24003008      2:0     3:0]
> > > > > [    2.210539] nxp_fspi_read_rxfifo, ReadData op.buf[0x02]
> > > > > [    2.217319] smpt_read[3] addr[00000002], data_byte[00000002]
> > > err:00000000
> > > > >
> > > > >
> > > > > [    2.224098] smpt[4]=3D[addr_width:00000003, read_dumy:00000008=
,
> > > read_opcode:00000065, data_mask:00000002]
> > > > > [    2.231744] m25p80_read, nor[op:00000065 addr_width:00000003,
> > > dummy:00000008, len:00000001
> > > > > [    2.239998] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4,
> nbytes:3,
> > > bwidth:1]
> > > > > [    2.247383] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:=
1,
> > > nbytes:1]
> > > > > [    2.254336] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[=
val:4,
> > > nbytes:3, bwidth:1]
> > > > > [    2.262416] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbyt=
es:1]
> > > > > [    2.268762] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465
> > > 1:24003008      2:0     3:0]
> > > > > [    2.276854] nxp_fspi_read_rxfifo, ReadData op.buf[0x00]
> > > > > [    2.283634] smpt_read[5] addr[00000004], data_byte[00000000]
> > > err:00000000
> > > > >
> > > > >
> > > > > [    2.290412] spi_nor_get_map_in_use:2915 map_id=3D0 smpt_len:16=
 i=3D:6
> > > > > [    2.296496] End [addr_width:00000003, read_dumy:00000008,
> > > read_opcode:00000065] ReturnVal:00000000
> > > > > [    2.305444] spi_nor_parse_smpt:3065
> > > > > [    2.308924] m25p80 spi0.0: failed to parse SMPT (err =3D -22)
> > > > >
> > > > >
> > > > > >
> > > > > > Next thing you can do is read the CR2NV reg (using the RDAR
> > > > > > command)
> > > and
> > > > > > check the RL (Read Latency) and AL (Address Length) values.
> > > > >
> > > > > Please let me know how to read CR2NV register.
> > > >
> > > > Actually, RDAR is already what you use to read the map_id, and we
> > > > need to use it to read the register that contains the number of
> > > > dummy cycles and the number of address bytes to use for RDAR operat=
ions.
> > > > Looks like we have a chicken and egg situation here :-).
> > > >
> > > > Let's try something else:
> > > >
> > > > 1/ create an u8 array of 16 entries named data_bytes
> > > >
> > > > for each loop iteration (the first for loop):
> > > > 2/ set ->addr_width to 3 and ->read_dummy to 0 3/ call
> > > > spi_nor_read_raw(nor, addr, ARRAY_SIZE(data_bytes), data_bytes) 4/
> > > > dump the data_bytes buf 5/ set ->addr_width to 4 6/ call
> > > > spi_nor_read_raw(nor, addr, ARRAY_SIZE(data_bytes), data_bytes) 7/
> > > > dump the data_bytes buf
> > > >
> > > > If the SPI driver is working correctly, we should be able to
> > > > figure out the right value for ->addr_width and ->read_dummy.
> > >
> > > Also, can you add traces in nxp_fspi_read_rxfifo() to print the
> > > value returned by
> > > f->read(base + FSPI_RFDR + j * 4) (there are 2 of them).
> >
> > I have added this and printing the data content, all 4 bytes, after
> > each f->read(base + FSPI_RFDR + j * 4); This I have shown in the logs, =
only 1
> byte i.e. as we are reading only 1 byte so I have deleted content of rest=
 3 bytes
> when sending the logs in mail.
>=20
> But I do care about the remaining 3 bytes, otherwise I wouldn't ask you t=
o print
> them. Please print the full reg content using %08x.

Ok, logs with rxbuf content of 4 bytes, please check.
[    2.091412] smpt[0]=3D[addr_width:00000003, read_dumy:00000008, read_opc=
ode:00000065 data_mask:00000008]                       =20
[    2.100708] m25p80_read, nor[op:00000065 addr_width:00000003, dummy:0000=
0008, len:00000001                                   =20
[    2.108962] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3, b=
width:1]                                             =20
[    2.116349] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1, nbytes:=
1]                                                   =20
[    2.123302] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:4, nby=
tes:3, bwidth:1]                                     =20
[    2.131382] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]     =
                                                     =20
[    2.137729] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465        1:=
24003008      2:0     3:0]                           =20
[    2.145821] nxp_fspi_read_rxfifo, ReadData op.buf[0x00, 0x53, 0x46, 0x44=
]                                                    =20
[    2.152602] smpt_read[1] addr[00000004], data_byte[00000000] err:0000000=
0=20

                                                   =20
[    2.159380] smpt[2]=3D[addr_width:00000003, read_dumy:00000008, read_opc=
ode:00000065 data_mask:00000004]                       =20
[    2.168677] m25p80_read, nor[op:00000065 addr_width:00000003, dummy:0000=
0008, len:00000001                                   =20
[    2.176931] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:2, nbytes:3, b=
width:1]                                             =20
[    2.184318] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1, nbytes:=
1]                                                   =20
[    2.191271] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:2, nby=
tes:3, bwidth:1]                                     =20
[    2.199352] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]     =
                                                     =20
[    2.205698] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465        1:=
24003008      2:0     3:0]                           =20
[    2.213792] nxp_fspi_read_rxfifo, ReadData op.buf[0x02, 0x53, 0x46, 0x44=
]                                                    =20
[    2.220573] smpt_read[3] addr[00000002], data_byte[00000002] err:0000000=
0                                                    =20


[    2.227352] smpt[4]=3D[addr_width:00000003, read_dumy:00000008, read_opc=
ode:00000065 data_mask:00000002]                       =20
[    2.236648] m25p80_read, nor[op:00000065 addr_width:00000003, dummy:0000=
0008, len:00000001                                   =20
[    2.244902] m25p80_read, cmd[opcode:65 bwidth:1] aadr[val:4, nbytes:3, b=
width:1]                                             =20
[    2.252288] m25p80_read, dummy[nbytes:1 bwidth:1] data[bwidth:1, nbytes:=
1]                                                   =20
[    2.259242] nxp_fspi_prepare_lut cmd[opcode:65 bwidth:1] aadr[val:4, nby=
tes:3, bwidth:1]                                     =20
[    2.267322] dummy[nbytes:1 bwidth:1] data[dir:0 bwidth:1, nbytes:1]     =
                                                     =20
[    2.273669] nxp-fspi 20c0000.flexspi: CMD[65] lutval[0:8180465        1:=
24003008      2:0     3:0]                           =20
[    2.281761] nxp_fspi_read_rxfifo, ReadData op.buf[0x00, 0x53, 0x46, 0x44=
]                                                    =20
[    2.288541] smpt_read[5] addr[00000004], data_byte[00000000] err:0000000=
0                                                    =20


[    2.295320] spi_nor_get_map_in_use:2915 map_id=3D0 smpt_len:16 i=3D:6   =
                                                         =20
[    2.301405] End [addr_width:00000003, read_dumy:00000008, read_opcode:00=
000065] ReturnVal:00000000                           =20
[    2.310353] spi_nor_parse_smpt:3065                                     =
                                                     =20
[    2.313834] m25p80 spi0.0: failed to parse SMPT (err =3D -22)           =
                                =20
