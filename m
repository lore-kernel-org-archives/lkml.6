Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BD8C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A52D222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MTKDj4CX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OzaTj33T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbfBMHtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:49:42 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37979 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfBMHtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550044182; x=1581580182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=10LKNl0rya7UiDduqXXjWfStYMavURyHQmrOFPcRTvo=;
  b=MTKDj4CXw/lRbxCEA8Xu8yK07N39+6XqFSv+IP9NaORP2EVbu83DzNbn
   aC9IQw6GJWSR5TU/tpsO00CmI2Zq08LP9L2aI5hMKg6OYNDOZ7GJkQ0EH
   f3Ei3nHm6ge/H6uaQbNEbAH6Nf6HnLlLplGrNWBLmnsDmgK7SZ+L61azl
   A9U0fL5z2yOFJ92AJltBs8fU/NcxAFRE2NWlgLUvUHAmVFb4BuTfCW6Ld
   97oKhlS04iGeFH6StX6v6yxYSGtkBIS/EQl0+XyGb9I+jhZIsPqvDrjAh
   g+Ej0T78fxz/ZEGM8M4vIoD0gunOWDEU/2r3K+5LrnUUIHlNMKnZtNPJR
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,365,1544457600"; 
   d="scan'208";a="102867437"
Received: from mail-by2nam05lp2055.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.55])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2019 15:49:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMct5sjsE/LEJf6skM2WjLnLw0RFLIEMPAOzaCMIZG8=;
 b=OzaTj33TxroT+L0VIaboey36tGONmqqTLFioKAUHZmjeA1PyXa4UQALvLq0QGsi/F/D5RAtb5Y8eztQZBjnULtR8lWblWJQnX/Pc+gsMFF93CoPlTaeEp0eYG+VeSFSmnxDGsAi1FUqR8ItDguDjN3JmCT+Gb6mf+/whIQzKKaw=
Received: from DM6PR04MB6059.namprd04.prod.outlook.com (20.178.226.89) by
 DM6PR04MB5849.namprd04.prod.outlook.com (20.179.51.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Wed, 13 Feb 2019 07:49:39 +0000
Received: from DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c]) by DM6PR04MB6059.namprd04.prod.outlook.com
 ([fe80::d006:5be7:c3f:ba6c%2]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 07:49:39 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 6/6] RISC-V: Free-up initrd in free_initrd_mem()
Thread-Topic: [PATCH v4 6/6] RISC-V: Free-up initrd in free_initrd_mem()
Thread-Index: AQHUw2XhneCVLsk8fkmL4zO8eU0wjqXdSEuAgAAPKgCAAALWoA==
Date:   Wed, 13 Feb 2019 07:49:39 +0000
Message-ID: <DM6PR04MB60598585C233303817F4793B8D660@DM6PR04MB6059.namprd04.prod.outlook.com>
References: <20190213063127.28703-1-anup.patel@wdc.com>
 <20190213063127.28703-7-anup.patel@wdc.com>
 <20190213064419.GA27012@infradead.org> <20190213073835.GA18267@rapoport-lnx>
In-Reply-To: <20190213073835.GA18267@rapoport-lnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-originating-ip: [129.253.179.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6efb6ebd-775f-4fd8-cd86-08d69187ce92
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5849;
x-ms-traffictypediagnostic: DM6PR04MB5849:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM6PR04MB5849;23:9CYY7RQ4Zkqdnu6yBmgjNiQrNfIB6uGw74Gdjhl5h?=
 =?us-ascii?Q?hvi4xBj5c7HqH52tBQCuqBB6E9r0mn5nidHNb/4P0wROl75tKcgWdJ8WZw2Y?=
 =?us-ascii?Q?ANO3Bz+BUhr170z2oh4HSdFUkHULzhQP1IOkoUGQySK9KO2dRqO7hrdq+H/e?=
 =?us-ascii?Q?2PIvTVrt8R8EulqkT1KS9luzPhFdzuKx7jlBYsGwydum/S7EXr8hsOaizfeS?=
 =?us-ascii?Q?8MeU6350pX8r8itW9vhX2TfM0fV351yuEaAlPHW1abgYDEoQ2j06ADeahZ7O?=
 =?us-ascii?Q?FYfOLP7DA5z3S0NADq3Na4WrPNA92YdUYGA4CT5D+/IE9Y6AVzTXwsqjUnOn?=
 =?us-ascii?Q?j9BtDzevaKApLBp+biNagaLD2GN5CFXtoJAdhzLyM+0da+5HYauU0+AsFSSC?=
 =?us-ascii?Q?kXeA7YCEovafL2D8fLtsTQHuoQOqwyJ7sNkYrAVZmoPRRWJWiScLp/81XCxK?=
 =?us-ascii?Q?5iYzuvL/ATvHnCq+k2VldR+kql/yQIFAOIls4plv5O978hL3CY+s9cSufunu?=
 =?us-ascii?Q?da6w5OSlKKnGizK+QIGcUFqWZwxjZr3v9yAMACeFNJ6GhoHCeLHBVi4b6R17?=
 =?us-ascii?Q?Af2mKgU3Dkneyphn3jgRmYpxbQeuHZy46j0cRKSX/pX+D7PLKKTiE9imugpz?=
 =?us-ascii?Q?M3AIEnht+fuWoy/US7rf77Q/Mh1XkiLMUzhY3hdUuPO9IsRzxgT4mW4LoZoF?=
 =?us-ascii?Q?UCPFzwUMSIW5AqS+OQMHtJOf/lmlk6/QHE9WRGX8BlepHjsRYRcmgjfxVK0F?=
 =?us-ascii?Q?J5H60WI4xPzlF143dqQJ48sX91TftVrUR+KZLGr/DJqMHyawzpi0bo9OQ0Kj?=
 =?us-ascii?Q?OcTjs8DcNGQeI0EoGm4BaULma371akWeSk8UXFSBBBk85K7cxArJh0qVRnvt?=
 =?us-ascii?Q?oD5aa4sqCvIpeCYGIOkX/Xv/XxkmKmg5cGE9GlKpXdzBRwYZNqyAetEFZDtl?=
 =?us-ascii?Q?Qn1OMdSVdn7vl+46kOb29QeEHyIvxMnpYOUzsk5cbGemEUmk04dRACoHqcep?=
 =?us-ascii?Q?oiyUKjoBn8vXTpEWRuvF0pvPflYRIac9TvdrrwQkXyM/0KoOLtbfwWwgqF/u?=
 =?us-ascii?Q?SF69l3KKaYyZjqxQt8xNUXMnW0JPOtA8qnkwUR0rXXmYah10VMkXOozXb3fL?=
 =?us-ascii?Q?gzJGprAvO5BM66+YPKzi0iKpyXrVXjDdX8oWU/rqVFmRLARraoVCWX7pIsu/?=
 =?us-ascii?Q?Wa8ExowhFj4GUv1aPTNTwPxDc/i6dOacT92nmOi4Ophq8JLPlmEXklc5zXQJ?=
 =?us-ascii?Q?t83EFScJtyzaTfLLcjj6yQ/BEe2nsnBDqA9rs+xLAkInQLXZH1BzxNpzfMwm?=
 =?us-ascii?B?QT09?=
x-microsoft-antispam-prvs: <DM6PR04MB5849162141700B47F66550028D660@DM6PR04MB5849.namprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(346002)(396003)(376002)(13464003)(189003)(199004)(51914003)(6246003)(68736007)(305945005)(229853002)(81166006)(74316002)(6116002)(8676002)(81156014)(256004)(14444005)(7736002)(3846002)(106356001)(8936002)(105586002)(6436002)(316002)(97736004)(2906002)(53936002)(86362001)(54906003)(110136005)(9686003)(99286004)(55016002)(11346002)(446003)(76176011)(66066001)(486006)(14454004)(478600001)(7696005)(102836004)(186003)(72206003)(53546011)(93886005)(71190400001)(33656002)(6506007)(25786009)(71200400001)(4326008)(26005)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5849;H:DM6PR04MB6059.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: odDcxrD0/dzXEHIjbHITVaUI7JewdazFIyPaZRZ/ZiZ7GaSn08upieLID2/rJsOYwy+i0TKm+9+cOpR86ehUqvH10/rV4Fqb/enGqhC39Cf1PEowDwlIiRCgWH0KDGhCigsnq7wyMEGRxfRBQqe0xATR542E9fgwU8C/4ZHooRyTrRGIbvyX3TloR+c0gQzBe/sxNBegl2QHkKaZIDn+oIQyrgMBN/jeoUcAq/WCdyWMuthGjoNaFIL0/Wg0gPpChsVFSNGhVk00jqig8hCPVNTWNPcnX4pbj9aMwQa5tlsrBdmnJxeFVNYLsFZsyirQ8PmTo+km7yVrueYCmB2t2PslduMv3u3FJq2+BjyRdTOjNABzPLHDUWthcFInA0/tMDE2kGAc3wZ2Aqz3v+V6R9b01LS9DiYAWzeaneqz+z4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efb6ebd-775f-4fd8-cd86-08d69187ce92
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 07:49:39.0602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5849
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mike Rapoport [mailto:rppt@linux.ibm.com]
> Sent: Wednesday, February 13, 2019 1:09 PM
> To: Christoph Hellwig <hch@infradead.org>
> Cc: Anup Patel <Anup.Patel@wdc.com>; Palmer Dabbelt
> <palmer@sifive.com>; Albert Ou <aou@eecs.berkeley.edu>; Atish Patra
> <Atish.Patra@wdc.com>; Paul Walmsley <paul.walmsley@sifive.com>; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v4 6/6] RISC-V: Free-up initrd in free_initrd_mem()
>=20
> Hi,
>=20
> On Tue, Feb 12, 2019 at 10:44:19PM -0800, Christoph Hellwig wrote:
> > On Wed, Feb 13, 2019 at 06:32:24AM +0000, Anup Patel wrote:
> > > index 9cd583b6d1cd..c22b873de856 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -97,8 +97,9 @@ static void __init setup_initrd(void)
> > >  	initrd_end =3D 0;
> > >  }
> > >
> > > -void free_initrd_mem(unsigned long start, unsigned long end)
> > > +void __init free_initrd_mem(unsigned long start, unsigned long end)
> > >  {
> > > +	memblock_free(__pa(start), end - start);
> >
> > I'm pretty sure this should be a call to free_reserved_area instead.
> >
> > All regions reserved using memblock_reserved and not freed before
> > initializing the MM are marked reserved and don't have valid page
> > counts, etc.
> >
> > So we need the actions in free_reserved_area to actually make the
> > memory useful.  Now every other architecture except for arm64 seems to
> > do fine without a memblock_free.  I'm not an expert on memblock (but
> > I've CCed one), but I guess the reason is that once the kernel has
> > booted we don't really care about freeing memblock area.
>=20
> This late in the boot process there should be a call to
> free_reserved_area() to give pages to the buddy allocator.
>=20
> memblock_free() is has no real effect at this point, no idea why arm64 ca=
lls it.

Thanks for the info. I will update this patch to use free_reserved_area().

Regards,
Anup
