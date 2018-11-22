Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9FEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CED2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Z/J7rMiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CED2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437490AbeKWBQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:16:40 -0500
Received: from mail-eopbgr1410100.outbound.protection.outlook.com ([40.107.141.100]:29462
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2395565AbeKWBQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coS/fMQPkR23/A7HbbtJM6cBr8oyoId0NSvzlbF8quo=;
 b=Z/J7rMiZLhRC6IZRg5j20VGbuq8X2Hu3h2+xtJ6RZL+7R/Nu34yFqHxlQ3kHTcHDLPazdyxQl+HQRii2QcclqPi18uFoYCpjHseYBYzAnecdRtWZWhtf5m0kVqwupjMSsxl14MNvFVeu25q1FPnaqPdb4I7TJsWp3EYjw/jlwVQ=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1802.jpnprd01.prod.outlook.com (52.133.164.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Thu, 22 Nov 2018 14:36:59 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::7484:f2b6:9b32:2c6%5]) with mapi id 15.20.1294.048; Thu, 22 Nov 2018
 14:36:59 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
Thread-Topic: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
Thread-Index: AQHUgCOKwJ2xop+DoEaLvwVyl7+lsaVb2W2AgAAF5bA=
Date:   Thu, 22 Nov 2018 14:36:59 +0000
Message-ID: <TY1PR01MB176930707EE4A5F730F1BF99F5DB0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20181119161838.10610-1-phil.edworthy@renesas.com>
 <20181122140832.qcrhmmybdzbvfv6s@verge.net.au>
In-Reply-To: <20181122140832.qcrhmmybdzbvfv6s@verge.net.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1802;20:ncttgdXO2oS71JB6Dvv0r24hhrh4RGhDDu2rjKq7R2UfQsg7U1HxVmgqC+s7PMcy7QvGGp9B7npb6HMSPw4lagAjBAfc3W4XFnieUUdxlaFnSRVLm/gIXKg7pMxqw+2FGtL2ZcQXGxOOCy5OoIJbVt6kUldYhi9zKIixbPnCzws=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 280ba10c-672b-4779-d508-08d65087f5ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1802;
x-ms-traffictypediagnostic: TY1PR01MB1802:
x-microsoft-antispam-prvs: <TY1PR01MB18020EEBDCB2F32AAF4CE5BBF5DB0@TY1PR01MB1802.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231442)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:TY1PR01MB1802;BCL:0;PCL:0;RULEID:;SRVR:TY1PR01MB1802;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(346002)(39860400002)(376002)(136003)(199004)(189003)(105586002)(575784001)(2906002)(486006)(86362001)(14454004)(476003)(102836004)(53936002)(316002)(76176011)(7696005)(256004)(14444005)(6436002)(446003)(71200400001)(71190400001)(44832011)(11346002)(68736007)(2900100001)(106356001)(478600001)(8676002)(6116002)(186003)(25786009)(97736004)(229853002)(55016002)(4326008)(54906003)(9686003)(3846002)(6916009)(26005)(5660300001)(53546011)(7736002)(33656002)(66066001)(6506007)(8936002)(74316002)(99286004)(305945005)(6246003)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1802;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ql1bbQ9NmILJK8DfbNO5v8fsyMNllMr4NIwJQVUKi72BehijYAFuJwjflKdmB9iKx5ZtSf2GQb5ILjlHVweYz1r8o9aLavIu0QPsaeBWU5o2TT3bvt+FE8n3nCRJqt2m/OZXVPXZmKVZ5gtWyrUN/D2GHbefLP7gxzpeBBc9aVdS+o8WF0fsPAcopLyUzsz5AkRrWHGYYU/rqaHBBtkciPtOcML7JGFizK+wY954L5ZjLrBlCU8XhRCo4raDy0j56vLdSJFUIYltspFYFaGomlZYTGfjbo+3Uhl7wbyulHRHAQV+jsMC0/w/xVYbBLPz/xDkWzJvyCcMsQ6vmQzrun3/A6DmRxUPpz/0spLsqQg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280ba10c-672b-4779-d508-08d65087f5ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 14:36:59.2200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 22 November 2018 14:09 Simon Horman wrote:
> On Mon, Nov 19, 2018 at 04:18:38PM +0000, Phil Edworthy wrote:
> > This fixes the check for unused mdio bus setting and the following
> > static checker warning:
> >  drivers/pinctrl/pinctrl-rzn1.c:198 rzn1_pinctrl_mdio_select()
> >  warn: always true condition '(ipctl->mdio_func[mdio] >=3D 0) =3D> (0-u=
32max
> >=3D 0)'
> >
> > It also fixes the return var when calling of_get_child_count()
> >
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > v2:
> >  - Don't rely on rely on the implicit typecast from -1 to uint
> > ---
> >  drivers/pinctrl/pinctrl-rzn1.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pinctrl/pinctrl-rzn1.c
> > b/drivers/pinctrl/pinctrl-rzn1.c index 57886dcff53d..cc0e5aa9128a
> > 100644
> > --- a/drivers/pinctrl/pinctrl-rzn1.c
> > +++ b/drivers/pinctrl/pinctrl-rzn1.c
> > @@ -112,7 +112,7 @@ struct rzn1_pinctrl {
> >  	struct rzn1_pinctrl_regs __iomem *lev2;
> >  	u32 lev1_protect_phys;
> >  	u32 lev2_protect_phys;
> > -	u32 mdio_func[2];
> > +	int mdio_func[2];
>=20
> Hi Phil,
>=20
> rzn1_pinctrl_mdio_select() assigns values of type u32 to elements of
> mdio_func. Perhaps that warrants cleaning up too?
The source of the 'u32 func' arg is ultimately u32 values read from DT.
The code already ensures that these cannot be bigger than 7, so is fine
I think.

Thanks
Phil


> >  	struct rzn1_pin_group *groups;
> >  	unsigned int ngroups;
> > @@ -810,8 +810,8 @@ static int rzn1_pinctrl_probe_dt(struct
> platform_device *pdev,
> >  	struct device_node *np =3D pdev->dev.of_node;
> >  	struct device_node *child;
> >  	unsigned int maxgroups =3D 0;
> > -	unsigned int nfuncs =3D 0;
> >  	unsigned int i =3D 0;
> > +	int nfuncs =3D 0;
> >  	int ret;
> >
> >  	nfuncs =3D of_get_child_count(np);
> > --
> > 2.17.1
> >
