Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CDFC6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E66D2088F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kT8LGnGG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E66D2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJHIQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 04:16:43 -0400
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:5856
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725760AbeJHIQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 04:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMFof8N3A/mvklB6tgkNxk7aUToBJpCfOnEgnukcS9Y=;
 b=kT8LGnGGg88pvhGHDv7wmnKsAiVDd8ruiuxXABV5pD6OukL5mlyjSs9h0vVt3LnDi69ffRZywir1yJKxKVRxwt0hQg9fD3U6017u2/njV5p2Lqp1OdbRWPZV99IJD7X1y/FCD+QVflZYPGu2wAcUsIfgIEdeOGObXpK5tZD/pZc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Mon, 8 Oct 2018 01:07:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071%2]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 01:07:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 2/2] cpufreq: imx6q: read OCOTP through nvmem for
 imx6ul/imx6ull
Thread-Topic: [PATCH V2 2/2] cpufreq: imx6q: read OCOTP through nvmem for
 imx6ul/imx6ull
Thread-Index: AQHUTjXFdtjRc6HhGUubGmLN7W1tBaUJ+uwAgAqu/1A=
Date:   Mon, 8 Oct 2018 01:07:28 +0000
Message-ID: <DB3PR0402MB39167CF31C5D50FA57986DFDF5E60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1537154264-23252-1-git-send-email-Anson.Huang@nxp.com>
 <1537154264-23252-2-git-send-email-Anson.Huang@nxp.com>
 <20181001055744.a3caymeppg3ttayw@vireshk-i7>
In-Reply-To: <20181001055744.a3caymeppg3ttayw@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3754;6:37C0H3bU1hEjHwOYKLwbisA0V0Cu9V0rmWUEbndnCdkgCQZEI6nKN4aPvE3CkOim+UFNK1yRE+UpLOeZh3nGYNdax6PwP1MKmblyl4vt0js9SOuybs9vKigTMmLtqW4yFDXwEcJ2+/geMYaZttB8W15YNzEM1Rs8rjQW84gQ2VTVXQkMYy+JzJqdPY8rHtrdYh2mtvp7dOYy5evIGfp6EdWytKtp7+CpFlps566vVZsqFKhq+30bePcw9cEnXOlbiv+p7P0X9QqzAcxw5/BBvzO+P6Op7/kzgIsnigoZZZK2lUc+wNKv357lgMAKibTZY3CuA2Kreo/XLOK5mrlfcWs5lBvXWEWhVkGCveORQlKS1VetPPeQoGogLmMBrzi3bN6YL/MbSuBuJxAx//0LV39HcX5ycA0FmJlaxqTztz3+QUarGm+quADv5nXu7FTYhAvmfUXHtiTUpbIyYqWmsQ==;5:Hw063XOdySV1Ux+hPiHn6qVnwZYjetYqvFjyi4wiqWZmunm9jDWB0GxxFYkppTuEtCAL9cJSV9hESbo0JaVUl4JzXWrh3f0Qv63ubMuhKumgm6tc/NxhZp0B8GYGkXGiFurAn+ygSXjIoXRdgFR86qwVeof5+Hc3Ch+rTBldunk=;7:TBLP5xIsOgVWEItT+U6I+ssHKCZZmfJvYsoMh9fjDig0yRzYt5+85B8rQ59zR4n8IgZAnzm3OsW5CYhR7Qlw15VFOCrDIowmYxzip8ew/+ziBpf05MPPJK/5n+Fzt8eJvexfeEuDbOeVoI+uX8RxheZptlfOoCkHnaats9yh8S6yZI0/6L0hDxZS8hqEgpvoEyCnyiyfEvEmbHoRayve9OpVqu+X1frXI35+cSBJQlXC0SE35NXnZRWGB/+ucZIa
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 58ac7e08-1052-45e6-3fc6-08d62cba6b10
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <DB3PR0402MB3754D025C78714522F5BDBDCF5E60@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(258649278758335)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991055);SRVR:DB3PR0402MB3754;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3754;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(376002)(396003)(366004)(13464003)(189003)(199004)(53546011)(6506007)(7696005)(186003)(76176011)(99286004)(4326008)(86362001)(14454004)(575784001)(97736004)(478600001)(5250100002)(2900100001)(256004)(6246003)(54906003)(26005)(2906002)(476003)(11346002)(102836004)(446003)(486006)(44832011)(33656002)(9686003)(106356001)(105586002)(53936002)(55016002)(6436002)(66066001)(229853002)(71200400001)(68736007)(71190400001)(3846002)(6116002)(74316002)(6916009)(305945005)(316002)(81156014)(81166006)(8676002)(5660300001)(7416002)(7736002)(8936002)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v+1ISNqwSpMU5spcLU45EzJVjilpZ2LvL3REsChXQq18oKuKY/ci8zIYDnFY8Iw52BsT5vYeb2FC5LNKYoduGIg79FMRmrYlwTka20XkawsUAucz0UAvhx4YrUW6cNtqopmIIuhrnieQTahmjCEzaQ3OvrVApxqi60jy9Kv25V7MG1Raj7aBcSQaiLo/P1/aKcOM3s57VDhkTGUSIFniUuZ09q5ssdtQfTKh+R4j6zHeO0vF9ttrCDfRwDOmeKhT8Bd9AqAjwZyxBF2DOil4mErtVymV32ktWWeWDeyEUv4oTHlaG0tuwA53u/8wH6u3oYd8V5DPBbwe7xK70jbF6DkO9gvyL/g+w0oiPJAwk7w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ac7e08-1052-45e6-3fc6-08d62cba6b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 01:07:29.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Viresh

Anson Huang
Best Regards!


> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Monday, October 1, 2018 1:58 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> Fabio Estevam <fabio.estevam@nxp.com>; robh+dt@kernel.org;
> mark.rutland@arm.com; rjw@rjwysocki.net;
> linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-pm@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH V2 2/2] cpufreq: imx6q: read OCOTP through nvmem for
> imx6ul/imx6ull
>=20
> On 17-09-18, 11:17, Anson Huang wrote:
> > On i.MX6UL/i.MX6ULL, accessing OCOTP directly is wrong because the
> > ocotp clock needs to be enabled first. Add support for reading OCOTP
> > through the nvmem API, and keep the old method there to support old
> > dtb.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > changes since V1:
> > 	add old dtb support.
> >  drivers/cpufreq/imx6q-cpufreq.c | 52
> > +++++++++++++++++++++++++++--------------
> >  1 file changed, 35 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c
> > b/drivers/cpufreq/imx6q-cpufreq.c index b2ff423..518386c4 100644
> > --- a/drivers/cpufreq/imx6q-cpufreq.c
> > +++ b/drivers/cpufreq/imx6q-cpufreq.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/cpu_cooling.h>
> >  #include <linux/err.h>
> >  #include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/pm_opp.h>
> > @@ -290,20 +291,32 @@ static void
> imx6q_opp_check_speed_grading(struct device *dev)
> >  #define OCOTP_CFG3_6ULL_SPEED_792MHZ	0x2
> >  #define OCOTP_CFG3_6ULL_SPEED_900MHZ	0x3
> >
> > -static void imx6ul_opp_check_speed_grading(struct device *dev)
> > +static int imx6ul_opp_check_speed_grading(struct device *dev)
> >  {
> > -	struct device_node *np;
> > -	void __iomem *base;
> >  	u32 val;
> > +	int ret =3D 0;
> >
> > -	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
> > -	if (!np)
> > -		return;
> > +	if (of_find_property(dev->of_node, "nvmem-cells", NULL)) {
> > +		ret =3D nvmem_cell_read_u32(dev, "speed_grade", &val);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		struct device_node *np;
> > +		void __iomem *base;
> > +
> > +		np =3D of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
> > +		if (!np)
> > +			return -ENOENT;
> > +
> > +		base =3D of_iomap(np, 0);
> > +		if (!base) {
> > +			dev_err(dev, "failed to map ocotp\n");
> > +			of_node_put(np);
> > +			return -EFAULT;
> > +		}
> >
> > -	base =3D of_iomap(np, 0);
> > -	if (!base) {
> > -		dev_err(dev, "failed to map ocotp\n");
> > -		goto put_node;
> > +		val =3D readl_relaxed(base + OCOTP_CFG3);
> > +		iounmap(base);
>=20
> Don't you need to put the node np here ?
=20
Correct, I should put the node here as well, please help review V3 patch, t=
hanks.

Anson.

>=20
> --
> viresh
