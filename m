Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9ACC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCB921473
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="M3IGn9JG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCB921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeHUVY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:24:57 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:24416 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727027AbeHUVY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:24:57 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie2.idc.renesas.com with ESMTP; 22 Aug 2018 03:03:44 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id ACB2A48460;
        Wed, 22 Aug 2018 03:03:44 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,270,1531753200"; 
   d="scan'208";a="288676222"
Received: from mail-os2jpn01lp0147.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([23.103.139.147])
  by relmlii1.idc.renesas.com with ESMTP/TLS/AES256-SHA256; 22 Aug 2018 03:03:44 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxgMjYbZwBs2Uro+yx2vZInHpzzAG7AwBOtCStUvbhc=;
 b=M3IGn9JGHWosJcOc0kASpk8A/DHsJwWShh8r1TRbci6C8WbqrcNJ8TtDOn/X+HJ3i5vfIia7/j5940KoXF0mCfuaDbyWiTrvWJWgtp52ebIiMVI3DuPei1qhIh5dHhzXgaYlM8wCwJRRfCUMC8qXkJoiAbdE6+MQUk5OOQsBNk0=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB0222.jpnprd01.prod.outlook.com (10.161.135.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.13; Tue, 21 Aug 2018 18:03:25 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::51b4:b6eb:46a3:a6b]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::51b4:b6eb:46a3:a6b%5]) with mapi id 15.20.1059.023; Tue, 21 Aug 2018
 18:03:25 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        =?iso-8859-2?Q?=A3ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "cdall@linaro.org" <cdall@linaro.org>
Subject: RE: [RFC PATCH] ARM: Debug kernel copy by printing
Thread-Topic: [RFC PATCH] ARM: Debug kernel copy by printing
Thread-Index: AQHUDVhP3BDImVXdyUOu+9yOi2yPYKSNDKNQgAbo74CANs5iIIAAAvSAgAAPy2A=
Date:   Tue, 21 Aug 2018 18:03:25 +0000
Message-ID: <TY1PR01MB1770D9DACFC1635FA380EC34C0310@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1530022595-6806-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR01MB177010920A6FC7FC1B61358BC0580@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <nycvar.YSQ.7.76.1807171552380.20892@knanqh.ubzr>
 <TY1PR01MB1770DD78CD0DC472245FA6E9C0310@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <20180821170252.GA30658@n2100.armlinux.org.uk>
In-Reply-To: <20180821170252.GA30658@n2100.armlinux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB0222;20:SVwobLhm56JDGcKoKUAzZhK2duqjJMyWLcFyID1Z8JiV3kemwJzna02qAsy5KQ/nTkVCjv0XfdOO9SPChZp0DfaIELKi/pamCcXmp0IHcnFfm+PQr7nZyhn/4+nWPOqmq4ohD0FaEeL7t4Rsi1HHQmzAXnSPbV/Bg53I5MMqHjo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 674664ea-7a96-410d-3b87-08d607906422
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB0222;
x-ms-traffictypediagnostic: TY1PR01MB0222:
x-microsoft-antispam-prvs: <TY1PR01MB022294E47BBCE86C4681D26CC0310@TY1PR01MB0222.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(150197165057710);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:TY1PR01MB0222;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB0222;
x-forefront-prvs: 0771670921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(366004)(136003)(396003)(189003)(199004)(7736002)(8676002)(53936002)(81156014)(305945005)(9686003)(6306002)(229853002)(6436002)(55016002)(8936002)(74316002)(81166006)(68736007)(2906002)(6116002)(106356001)(3846002)(66066001)(33656002)(105586002)(97736004)(99286004)(5250100002)(76176011)(2900100001)(486006)(6506007)(25786009)(7696005)(256004)(102836004)(7416002)(478600001)(476003)(93886005)(6246003)(4326008)(44832011)(6916009)(54906003)(966005)(14454004)(114624004)(316002)(5660300001)(86362001)(26005)(11346002)(446003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB0222;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: uOfiobRH6nyIR/ENKPmVAxD0HaNgYtZ2lp/ayw3ARrs7cmpUypPK1bZjSZoXkntIZe2PovWZy22vE8Vm6Cpnl2SM6pYo9r8KeJEQCPnx5wmycYSqtkF1/LCttHDgziDO7ihwuNgMwl/LdmIKyaz2znbs92zgnUCrTfMEXbIzC/FuD3g8hJZhMt97zW426dvoYn7GFLgZaLboZDKa1u7l2URM7/vmNda3jwWnj2UvQpTNYiT6y/vpmgK+x5LOpYkZk28Ujwwn8SiSoicZWc+aEmJcVgjwdXjtlVVPdREAmMjFZowweHzx/kXX3F+1ZwXY5fW+SnjgGrhd4oZRbufRUU68bdFMo0WXQAQiTEtfX6k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674664ea-7a96-410d-3b87-08d607906422
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2018 18:03:25.1760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB0222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [RFC PATCH] ARM: Debug kernel copy by printing
>
> On Tue, Aug 21, 2018 at 04:56:19PM +0000, Fabrizio Castro wrote:
> > Thank you Nicolas.
> >
> > Russel, does it look ok to you? Do you think you can apply this patch?
>        ^^
> Grr, please be more careful in the future, thanks.

Oooops, I am very sorry Russell! I'll be more careful the next time.

>
> Patches need to end up in my patch system, otherwise they're likely to
> be lost.  Details in my signature below.  Thanks.

I have put the patch on your system now.

Thank you,
Fab

>
> --
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbp=
s up
> According to speedtest.net: 13Mbps down 490kbps up



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, B=
uckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered=
 No. 04586709.
