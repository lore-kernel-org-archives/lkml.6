Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA8DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A5B218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oBgWkGZC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ix4h6eQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbfBMDna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 22:43:30 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11110 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfBMDn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 22:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550029409; x=1581565409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Dsk08b4BjhTECz94FDeT7jmFU/7hAUhfKh7TQ1CbB0c=;
  b=oBgWkGZCUeYhccnPbzORb2KAJGyTb94YUcqMi78hUWljj/iXnHR3it4l
   LtRiOdpP17VSq8P3Au99pCF4BzPXEmqxb2/wZSxUH9vUnwxP1HDVkQM9b
   TD6BMZSkEmne1mmlVSwKtLL42x9kicugViVjMQtI1Vq6Y7RhOs0NLOGuT
   wJJJTxlgkvcU+RjtzV32+XiSOka1rtF6s4OiMQr+OqtM5WJ+E/TaS2k7Y
   YsEAC8+GqYirA6YhFFf5BTidNWQ3fLvPE5IVhLpoEUADV27wSMY0+Lxml
   LHJOa2aUbiFbUh97bm9fA2ChrQ9ybu9JxTVFrLrzqkUW/AP5IhUAZyI1p
   g==;
X-IronPort-AV: E=Sophos;i="5.58,364,1544457600"; 
   d="scan'208";a="101061603"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 11:43:28 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5mLVIlyq3+7gsH0enD0DJ35+/Yw9cRuWnTt6HiD/zg=;
 b=Ix4h6eQKv5yynKYuQ4aJ8bgtgB525QaOlr0rfU+FifFr/bi10EjCKa6z6Lj93khSGlbIOh1b9I7s959EbuqhZGotPl9TXTX7921voA334HUxSzV4iOHQA0DQdvOJ1HAi4iSKT38TWjq2oTOZpFrsFX0kgthimS4J3YP6w3wFtro=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.247.148) by
 MN2PR04MB5822.namprd04.prod.outlook.com (20.179.22.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 03:43:06 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::2cdb:c465:af57:8be1%7]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 03:43:06 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v2 6/6] RISC-V: Implement keepinitrd kernel parameter
Thread-Topic: [PATCH v2 6/6] RISC-V: Implement keepinitrd kernel parameter
Thread-Index: AQHUr/rvNlD18fFOHEuGvgVx64rC4aXb43KAgAA2jICAAIwvgIAAlc7g
Date:   Wed, 13 Feb 2019 03:43:06 +0000
Message-ID: <MN2PR04MB60615E8737B56B1B213B5FA58D660@MN2PR04MB6061.namprd04.prod.outlook.com>
References: <20190119132650.9978-1-anup.patel@wdc.com>
 <20190119132650.9978-7-anup.patel@wdc.com>
 <20190212070807.GD26747@infradead.org>
 <CAAhSdy1NED22YyYrAJDqPkDqT1c2ms2QC9OjHP0qLwHT+o2zvg@mail.gmail.com>
 <20190212184505.GA10984@infradead.org>
In-Reply-To: <20190212184505.GA10984@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b78e866-5a5b-4398-6d7b-08d691655d78
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR04MB5822;
x-ms-traffictypediagnostic: MN2PR04MB5822:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MN2PR04MB5822;23:4FoqXf5wojY+u5Pi+bNE8NmxU7e1M2lUK1/CBfdNH?=
 =?us-ascii?Q?hp3EfQ/lMXGyyKqmz7xlbYOfxufBVZoee6MDG+y9MGLUI+7RtkdzyxFy9P/n?=
 =?us-ascii?Q?+ThDwVYXxECmNswaeoPjbrqTfZBp8KZP+OWORqcYYybR/1JUWBkqgkG8sRue?=
 =?us-ascii?Q?B0K45zDeUN3UIJAe/QWbogF4fGzXKwSYr7b3Lb2veUYo5d+nU+OXncd6JQpZ?=
 =?us-ascii?Q?qFXILlgkOjZFmaujTCiW2CWhoCKlN/989cLHXvtq9jz1wYtX9x/8hULbPvAd?=
 =?us-ascii?Q?kJWNaZl84HT8ASG6daR1o6vUMXC78NfaVTGQ4sepgm4C947hzUBj3R1o1TIg?=
 =?us-ascii?Q?MOGPY+d4y+WRkrIu7JbEahglI0E0QSxl2wHtpjmfCvRkyAohDyXuhI2/W8rA?=
 =?us-ascii?Q?fVieoI+fjF+cSm2zytdHN7vcAwChvZEDDFYe+8UGwswRAtZefQu/3fGaHfbt?=
 =?us-ascii?Q?U2zfzYYU6aCLEpAuwUIlHCiQVuowENldZ1R4dxGYyCePyr0XySSe0t5Iq0mT?=
 =?us-ascii?Q?2LlFZNRc4j2fDCxuXnpjw+/QdhPhYK5jpvqu4LoOK7OKT2AZ8GaMqYWQDnDT?=
 =?us-ascii?Q?6/hO3LAIoIXqOPFbjWX9uIXg41MqGdHZO1DeAAlB5KbgfCt17UA8dj+w7ndZ?=
 =?us-ascii?Q?l1pmkXHersxOAV0z0LECamKw0pOvbSkkq1UgRveDX39ih/PWJEqT7qdsrwYU?=
 =?us-ascii?Q?tS6y/GNL1GIHPYmup4O01Yk2nCzGmrMWn1EDwPBML+AT/E1kyKAXbX7KkTBA?=
 =?us-ascii?Q?NUG8h+ROiuSrs6cJpTVNMRdZnIEtlcj6ru1JqD7m4bw+Q1KpyqufpPtufKY3?=
 =?us-ascii?Q?M+vszakB+vwSmPQxSWSVrjM3nt6pKroeFk/F60HHilHZw/jI+guV7BVl6ajH?=
 =?us-ascii?Q?x3syG5ALSBFd3MzLJ+/0fHDIdfX/4OcuJGI349fwsQRFvzM0iefUG9Y4cEVs?=
 =?us-ascii?Q?q6DRUwkx2yxTfmcfUZ1GNsSb8kv3dthk5EPXvY5ZP5cSSyEgI5bXWxklCDSp?=
 =?us-ascii?Q?fWt14Qn8KhQbeuQnCCSybd+fSHs01l4GoZjKiAFmCY3XsoMDjEE0JTm5kKN8?=
 =?us-ascii?Q?yBFONfyaZCS7BmJfH5UoEacAhbiBKR8PSo7iHor8F1hx+cHD7cj+WMsjSNeL?=
 =?us-ascii?Q?QT3dfRDswLTaGBqk7GuK0OrzIhUZi+7XI0/NuFVLUNcX2Am4ZS3CtovlMdPv?=
 =?us-ascii?Q?/kdXQ3ykTZ4+pRn2t4F6B3mSj3zq9Am5LlWeZYEV+fEHssfQS22JSYI/EOvl?=
 =?us-ascii?Q?6xLBHWu7TyZEUNMZkmPqMraFzFAAHyHl8G9vj+G?=
x-microsoft-antispam-prvs: <MN2PR04MB582223CA0A715EA1AB1158628D660@MN2PR04MB5822.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(13464003)(189003)(81166006)(478600001)(186003)(11346002)(446003)(8936002)(97736004)(81156014)(6506007)(26005)(66066001)(53546011)(4326008)(93886005)(14444005)(102836004)(8676002)(256004)(105586002)(55016002)(6246003)(9686003)(6116002)(3846002)(86362001)(71200400001)(6436002)(99286004)(71190400001)(53936002)(7696005)(229853002)(25786009)(54906003)(110136005)(7736002)(305945005)(68736007)(476003)(486006)(316002)(14454004)(74316002)(33656002)(2906002)(106356001)(76176011)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB5822;H:MN2PR04MB6061.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8sHM5KJXChe0kNUjeCvLJ8TlRtbYtaSpOsnXI5bzKmGMuZb5Lv9FCYg1rgO8Ar7mXXorxoSWko6NQiC0UrAFe2BEWd8km1tjXoP7HEn/lBN9vBWYnqBxLj1M+V2pWZWZrghzi3+ffzqBU4eixt0L/Cj6ZbyEqj1XOjHb+CSA5Ytvk+LRPzkqpjwbOxts0qu+PlrQxhInrUwjFlM8eGrqdbvoyXoePLaYpIHtCXHbEwVmStsvPuc18k/X5xIEGHeaCmG6fy8700WkGI7YKPI8pTXc07z2Ohsw4DQwIRqRfZLial8QK9zh9XBioFi7PB5lNbQmvxH6hzUmrn5DW28xiR5NnvCilmFTHZqvZzlSg/uD5KcLB6ubdf7/bbuL6YgtTcTeFR7BIDhLKW95UH5ja8n3+tyF+eRNt5GSC6ngTp8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b78e866-5a5b-4398-6d7b-08d691655d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 03:43:06.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Christoph Hellwig
> Sent: Wednesday, February 13, 2019 12:15 AM
> To: Anup Patel <anup@brainfault.org>
> Cc: Christoph Hellwig <hch@infradead.org>; Palmer Dabbelt
> <palmer@sifive.com>; Anup Patel <Anup.Patel@wdc.com>; linux-
> kernel@vger.kernel.org; Atish Patra <Atish.Patra@wdc.com>; Albert Ou
> <aou@eecs.berkeley.edu>; Paul Walmsley <paul.walmsley@sifive.com>;
> linux-riscv@lists.infradead.org
> Subject: Re: [PATCH v2 6/6] RISC-V: Implement keepinitrd kernel parameter
>=20
> On Tue, Feb 12, 2019 at 03:53:21PM +0530, Anup Patel wrote:
> > If it is initramfs (i.e. CPIO image) then contents of CPIO archive are
> > extracted to create a ramfs instance.
> >
> > If it is initrd (i.e. some filesystem image) then RAM block device is
> > created in-place at initrd location. (Please correct me if I am wrong
> > about initrd here).
>=20
> No.  If it is an initrd image we still copy it into the rootfs first, and=
 then load it
> into a ram disk.  Take a look at
> init/initramfs.c:populate_rootfs() and
> init/do_mounts_initrd.c:initrd_load().
>=20
> > So in case of initrd we might not want to free-up the RAM but we can
> > certainly free-up in case of initramfs.
>=20
> No, in either case we do not need the original initramfs/initrd memory.  =
I
> suspect arm has this as a workaround for some weird legacy boot issue, bu=
t I
> can't see any reason why we would not want to free the memory on riscv.

Sure, the keepinitrd=3D0 by default so it will always free-up initrd by def=
ault.
Please look at v3 patchset.

Of course, we need separate patch to update documentation of keepinitrd.

Regards,
Anup
