Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE9CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E6DC20693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="cbXpaFgU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6DC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeFTEaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:30:16 -0400
Received: from mail-he1eur01on0048.outbound.protection.outlook.com ([104.47.0.48]:17792
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750827AbeFTEaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSyAQ2RJ6TmFW1k34khsbkACZXXMIPXK2x6pl9rO0OY=;
 b=cbXpaFgUewlv7DRcMl66tgxcHgTMO1+b3aeR7bBsZxnPJ2s8kndc3E4KiLTHIxL4X8oDn+s+GvIpYHT4mnR+aI6PqpzGJpUnd0EGj+/xSWm+jQGIUS9DvHLh7Ogvcrhmo6EfK0h7e0sFj/xVldq7eu+/Fg67fcs5t5xGognYQSo=
Received: from HE1PR0502MB3753.eurprd05.prod.outlook.com (10.167.127.143) by
 HE1PR0502MB2922.eurprd05.prod.outlook.com (10.175.34.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Wed, 20 Jun 2018 04:30:10 +0000
Received: from HE1PR0502MB3753.eurprd05.prod.outlook.com
 ([fe80::2972:3d1e:ffae:4bc4]) by HE1PR0502MB3753.eurprd05.prod.outlook.com
 ([fe80::2972:3d1e:ffae:4bc4%3]) with mapi id 15.20.0863.016; Wed, 20 Jun 2018
 04:30:10 +0000
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     Darren Hart <dvhart@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        Michael Shych <michaelsh@mellanox.com>,
        "ivecera@redhat.com" <ivecera@redhat.com>
Subject: RE: [PATCH v6 6/8] platform/mellanox: Introduce support for Mellanox
 register access driver
Thread-Topic: [PATCH v6 6/8] platform/mellanox: Introduce support for Mellanox
 register access driver
Thread-Index: AQHUBk6/VXLiq4IGjE+UO1GB1MVxhaRkqnoAgAOh4ICAAEVZIA==
Date:   Wed, 20 Jun 2018 04:30:09 +0000
Message-ID: <HE1PR0502MB37530DD5B696E1AC256E2632A2770@HE1PR0502MB3753.eurprd05.prod.outlook.com>
References: <1529254615-88124-1-git-send-email-vadimp@mellanox.com>
 <b804ccc4-77c3-e7a9-9486-8d12d50ec5f7@infradead.org>
 <20180620002025.GC11460@fury>
In-Reply-To: <20180620002025.GC11460@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com; 
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0502MB2922;7:B0bsU9NQ3PHE8o7XeXhiQHQk01pXY9TOXWSd4bxDqdctNRkJdGh1N8fOXJyfynlvGg64mIvXT3zwRSluT1ov95xzfhp99B3mtwQ4COZSavbUcunjsmvr++PG8p7I+bZojOwrhuLBhJApKcUnNBEC+Bh83BIiXDWCCnn7grXf5wqV9wzi9XO1u2HmlbTB9JTqV3P7wkRrwCq9dKAbL/qvIlzoL2m08nCKBYjZ0i1/M9kS9xMDwyDjzSH7r+QxF57C
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1031cfde-4772-44cb-d93c-08d5d6668215
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB2922;
x-ms-traffictypediagnostic: HE1PR0502MB2922:
x-microsoft-antispam-prvs: <HE1PR0502MB29226301349E34F57C9581ABA2770@HE1PR0502MB2922.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0502MB2922;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB2922;
x-forefront-prvs: 070912876F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(396003)(39860400002)(366004)(346002)(199004)(189003)(13464003)(39060400002)(5250100002)(3660700001)(105586002)(68736007)(3846002)(53936002)(6116002)(106356001)(6246003)(54906003)(2906002)(3280700002)(110136005)(5660300001)(102836004)(4326008)(6506007)(53546011)(86362001)(59450400001)(25786009)(76176011)(97736004)(33656002)(316002)(66066001)(478600001)(26005)(7696005)(8936002)(74316002)(8676002)(81166006)(305945005)(2900100001)(9686003)(81156014)(6436002)(229853002)(11346002)(99286004)(476003)(14454004)(55016002)(486006)(446003)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB2922;H:HE1PR0502MB3753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gspOzTv+QCEa2R1qCTN7ahqNRd6ZVolWux0EO2tRw8Ay5sLDgqaXWKKm/wM+QuLf5d4rDoTwIWEK79CH7cfnsnfi7dCcZotFxXbeAF2xDLAfPxWufMiOfBcEesR8GOosUZiDl2v/DEs9ifnGIHHtN8hndrOe0iCYaTe6mU0o4cnydg46cgXbQ+bOM/Fx1m8v74vZOX4XkdzgBcAsiiNMFL2+79AwK8bwQHNNULQwhyh54EcFHXWKBned7FdvTztYpiiFatajKWn5BrCqyk5bGYvKAAneKhzZxdLPa930NUvpXz1N5xUeXRKsITkKkfMrSWTPqyLq/BnP0OKhICVS6Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1031cfde-4772-44cb-d93c-08d5d6668215
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2018 04:30:09.8700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB2922
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Wednesday, June 20, 2018 3:20 AM
> To: Randy Dunlap <rdunlap@infradead.org>
> Cc: Vadim Pasternak <vadimp@mellanox.com>; andy.shevchenko@gmail.com;
> gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org; platform-driver=
-
> x86@vger.kernel.org; jiri@resnulli.us; Michael Shych
> <michaelsh@mellanox.com>; ivecera@redhat.com
> Subject: Re: [PATCH v6 6/8] platform/mellanox: Introduce support for Mell=
anox
> register access driver
>=20
> On Sun, Jun 17, 2018 at 09:52:16AM -0700, Randy Dunlap wrote:
> > On 06/17/2018 09:56 AM, Vadim Pasternak wrote:
> > > diff --git a/drivers/platform/mellanox/Kconfig
> > > b/drivers/platform/mellanox/Kconfig
> ...
> > > +	  space trough sysfs interface. The sets of registers for sysfs
> > > +access
> >
> > 	        through
> >
> > > +	  are defined per system type bases and includes the registers
> > > +related
> >
> > 	                                    and include the
> >
>=20
> I've taken care of these, thanks Randy, and applied the series to my test=
ing
> queue. Once the builds complete, I'll move these to for-next.
>=20
> Vadim, I see you've already updated the kernel version in the sys documen=
tation
> to 4.19, so I won't attempt to push these into the 4.18 RC cycle.
>=20

Hi Daren,

Thank you very much.
Yes, it's good to push into 4.19.

Thanks,
Vadim.

> --
> Darren Hart
> VMware Open Source Technology Center
