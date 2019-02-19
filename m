Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED33BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B296E21479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mjmK9fgJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IcF4E8Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfBSLoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:44:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56749 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfBSLo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550576682; x=1582112682;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OkNd0albMXCu/6bNLZBnLKHSz20KkoWIDBVW8jdKQQ4=;
  b=mjmK9fgJsPq0zHahVRwEjoyLty9SHDgUXfgGXBavDpeKx1mGOzdnhTDH
   O9hw1u5ogHWh8T6b2bT+jBUBKFyuWgUXqJxW/HBVvMYgMtHXfL0ix1pdr
   H+xmf+43USIO/YgLk8JaImCFHrvgQ7o1jqicRaE0VaxbozN8RYLseNNso
   icTBSpUzIY9q7goVSMP2uJdW8rhZ0IfyiFfHvXUmEJ0Q1GnNxY2maHMfg
   OtP8OOW7zcI+/taAsAtOLT6pAzOOxSmumXrfVRlXS8XHzbhJYdqBhuuOh
   BUFV+F2BCManXpkfha0KRoA3Wpha1ySsTYwpvwIe7KB6dlfZ6ap10+h5d
   g==;
X-IronPort-AV: E=Sophos;i="5.58,388,1544457600"; 
   d="scan'208";a="199919471"
Received: from mail-bn3nam01lp2059.outbound.protection.outlook.com (HELO NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.59])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2019 19:44:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okB+PPXxFgPtPmgVaa1TXrNzCKzBo7jxdZ9Ou7pgU1g=;
 b=IcF4E8UoB/fDzZQ0uP4z+EeK4zmjDko18VtESzoHiK48Ny6WhK1LMRqz+ifDUdxvmmJzgm55qSe+bX0flBcPPdJhHoU2x5LM4prVZ6jR6ABA3bH1FBYdxUn4KaG4nMolitPVFfp+2Z/gOo4vazQ2D7XbR6G+pPK1W6PhqJie0Xg=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4174.namprd04.prod.outlook.com (52.135.71.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 11:44:27 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::d8c:1204:e64c:daa0%3]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 11:44:27 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Evan Green <evgreen@chromium.org>
Subject: RE: [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
Thread-Topic: [PATCH v4 3/3] scsi: ufs-bsg: Allow reading descriptors
Thread-Index: AQHUtg8jpd6bmkKdmkCBoLq0HKAzQaXFBk8AgAwjyaCAA0g2EIAACCHegBKqLtA=
Date:   Tue, 19 Feb 2019 11:44:27 +0000
Message-ID: <SN6PR04MB4925FBBBAC3356886A02F46FFC7C0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1548572868-12589-1-git-send-email-avri.altman@wdc.com>
        <1548572868-12589-4-git-send-email-avri.altman@wdc.com>
        <CAE=gft6mLsW-iEBZ9pFRWWyDQz_gCs20_4JBoBzxL1tYv0rbYg@mail.gmail.com>
        <SN6PR04MB49259233067FBEC4AFA35963FC680@SN6PR04MB4925.namprd04.prod.outlook.com>
 <yq1bm3nzmmu.fsf@oracle.com>
In-Reply-To: <yq1bm3nzmmu.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2675d310-abef-4978-55f7-08d6965f9a71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4174;
x-ms-traffictypediagnostic: SN6PR04MB4174:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SN6PR04MB4174;23:jLcxPkCka0IZQ/xpPraWQ2z0EYQx3cBhdUnenT6dn?=
 =?us-ascii?Q?/5MaUmEKIaB1SjUXNV3x30RFcjHDv4oxHu7gCZ5KRPAzytsSH7tI7L2NZ9RG?=
 =?us-ascii?Q?YT0jxPE0c2bExMtNu9lrz2govZDJ0eDEwm/5GJkIAyrD1xNgCazZvL0heh1/?=
 =?us-ascii?Q?zK3EmEDimExgtK1IlRf0noX4IbBilFB4ySe+uT8oxfi2//qWdhrCxkG7iTUt?=
 =?us-ascii?Q?wzz+WWRSfInSLSHFzgVMokRdYirdrKhwh+et0tvtrsYwI0Vt0ZGYUmOYguhi?=
 =?us-ascii?Q?XcaaYpxK7sF2T3G3JFLIqnTjUTaG7e0esaG0BHls2g2/LqO8hddqZiJJM0IH?=
 =?us-ascii?Q?Kb/s/SzbwlI7n5fVurGxf81fo+eAb10NrWNEK2EzN3YHMwg0ALKrMBnXIj2A?=
 =?us-ascii?Q?nWULHELHiFbeDmNxDwvIC0ScHmWMrYEt2GgDdDIoqRmNFZi1hHKC7CR2nwmt?=
 =?us-ascii?Q?hcbtl1lmVRtx9kw2hC1zMa1/0m7f1Bqdt9rvroh8/yTr+2iHPe7FI2lK8H+h?=
 =?us-ascii?Q?hCfm4oGlGjDUEkGJtjwEArL/8L1ThMyxG3S331p5vYQWinYPw6oJhoKwqufN?=
 =?us-ascii?Q?sH3HkdLyeT2Cx+TbzeQCdpZr0irlm3ClHVHJ2cUvkm7JzoO1aAv+f5QjxAve?=
 =?us-ascii?Q?hjtonNydVS//eV8ckZ/7CmMa8Zx88CpNhbKxjtkaRqfFpBNzkkTHjsVlvI2x?=
 =?us-ascii?Q?DN21IfxlqcUrBSLnMGtJjDQvWbUNmZIiQos4l1dAjy6HbbQ63ZtzBS89ViVk?=
 =?us-ascii?Q?3YR9cmgO2wkLE0502BaJuqXNW18zdbPDgHfbSd4kJ8weqKuj//MkdpYPGFAZ?=
 =?us-ascii?Q?97951Uqhh6tSf+D9ZrWKEzot6tVLF+0+hIV69ByAcHUE5zU/biaEIxLp+0hT?=
 =?us-ascii?Q?emSrr6wWugOOmy7ZKV+wTyz8nAnIUNIJbq7Uv4K+1msUtFla57dLlOq/gDW4?=
 =?us-ascii?Q?dpjLoM9xHzPDutSOzjWd4vYEp8LtxEIJ+8FpN1orHLIrn4coeFex5d4aU1j0?=
 =?us-ascii?Q?s+S5HRLjYD1NoCoGOQT9O+DusI/ke479wpwreZFdkI4HtkjvRTxoGykHilsm?=
 =?us-ascii?Q?/BSKpdXIUhx88l1ycKhEc3uRMdDeVYp8mtzvYi71v+ymqnTbi9YvX6eOVYzK?=
 =?us-ascii?Q?sanuhdeZqqKjozB8OMfDAf4bCSM7ForZah8aOJjatsm195n2fZS9q/uijHT0?=
 =?us-ascii?Q?LaKmAwp7wkbFgYt1RPDwWT1khOTnRzeAjaqmMCD0ap3ZxbQ/hDeBedpByjmi?=
 =?us-ascii?Q?KSQa6VRSyJCMZnHv5AO5Pke9Yu+qb5rlF/QjvL6?=
x-microsoft-antispam-prvs: <SN6PR04MB4174916269D9BF3E01302425FC7C0@SN6PR04MB4174.namprd04.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(55016002)(229853002)(97736004)(8676002)(74316002)(9686003)(81156014)(81166006)(26005)(8936002)(33656002)(486006)(102836004)(6436002)(93886005)(11346002)(446003)(7736002)(66066001)(6916009)(68736007)(71190400001)(71200400001)(305945005)(6506007)(476003)(186003)(76176011)(2906002)(256004)(14444005)(106356001)(5660300002)(105586002)(558084003)(72206003)(6246003)(316002)(14454004)(7696005)(6116002)(86362001)(25786009)(54906003)(3846002)(53936002)(478600001)(99286004)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4174;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hyG/eL8DAXx2jv+k/EnDpx/pdAI9Gq01ZaPVlRuA4b2B4spXH6lTlVkycxnm7PiPScSnER12TstWDah4Ubn0oX+MLOu4ErA4+MZ112mpdTEBLL0qKxFWHAjVWdjEiEOJAKPTpzeAynG/QcpOpxs9sm1IcfvqZNghvo9kPlu1OzQIAqrQlD6HoAhqOf0pCclhTkGOM8/tG36luqdxOK0NCk3SR+6B9pzBz4Wiu2WRvmn1gXn4mauT1cEJC7gXLn1sW8GIQkBybV53j9Ifz8nVz+R9wzdG4huwZMkxgb5WpbLOWYNDipJqCXME3BFaUphocXjbjU77nCdEhSqgAD83jSLxl3Z4zU0rusThFfskjhH9BH2bzpsnZMyiJfrza3qRwDbtz7vewe4ldcXiskhjwNcM+65y4atS6jA+0D6q9Ww=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2675d310-abef-4978-55f7-08d6965f9a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 11:44:27.5341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Avri,
>=20
> > Is there any reason why this sires is not applied for 5.1?
>=20
> I haven't had time to review it yet. I'll get there...
A kind reminder.

Thanks,
Avri

>=20
> --
> Martin K. Petersen	Oracle Linux Engineering
