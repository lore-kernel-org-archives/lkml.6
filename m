Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B20DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241AE2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RpIW150B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241AE2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeJHNX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:23:27 -0400
Received: from mail-he1eur01on0052.outbound.protection.outlook.com ([104.47.0.52]:39168
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbeJHNX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=377+9s94No5ywoKbP4P5G0yYQdgTHhWDy2L/qS3bJi0=;
 b=RpIW150BkJEud/bzgoUT+yMvvjdRJS7t6TfJD4D5tmJUW1oxc5vgM/lyT76rHFXjWvoxzaInl8cpZEwyvcAuB7Iu7/KxibOKNeF0ZTkxvRX66wwF6Jcz/JowXvNiVuYcFH1hVq5oTAwok637J8A+Wq5FmQEd055iPJlX6yzkDBk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3866.eurprd04.prod.outlook.com (52.134.71.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Mon, 8 Oct 2018 06:13:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5c30:b387:c71a:7071%2]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 06:13:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3] cpufreq: imx6q: read OCOTP through nvmem for
 imx6ul/imx6ull
Thread-Topic: [PATCH V3] cpufreq: imx6q: read OCOTP through nvmem for
 imx6ul/imx6ull
Thread-Index: AQHUXqRZUOa7zfBgskeI0Pg4D0kQtaUU3DyAgAACR/A=
Date:   Mon, 8 Oct 2018 06:13:06 +0000
Message-ID: <DB3PR0402MB391676A53645F0E1C68BAA85F5E60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1538961000-2109-1-git-send-email-Anson.Huang@nxp.com>
 <20181008060423.cz5qrxfoz2seo2e3@vireshk-i7>
In-Reply-To: <20181008060423.cz5qrxfoz2seo2e3@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3866;6:3jjip4Ldkq2z47n6xQASj1dAMYrTTcqFMd1OWlQ4LWnfClcejJfyOf5j7BXYJYAFrUoGhA16YfsctBMJZ3o/u0oHqnzG3NZP+DM/nU9r/yI3HbR7G449cEYlPMobmYPvDCKgdpir2cpO5cquHUduYHtea8XGb/4LUXvVDk5PN1cVQpZoCWgiPlp5w8HTo+EYLJBomU1AY1qmP7ZrC3MYKM1ZWV+Y83+zocaJulSX3AvozSrhG11AVOTQecvjltBwvFRkTiKj7MWlcRf31YyvQxjwmYY+xLn7EIH3U5mrGk+ndrnCygDIsztTznCbRaVRz0jGHPfZu9nHNOxgHkSu0hJ3zelJKle+CX3NbccWCoUSSU7PA+KPAEgB2wsyP3VE3AQAtL8XvK2zZ0O+inyVHRbpCUWTi8xeUvfeebPbcNsio/CAC1jZqcnw+dEbS2hthrUq4rlcK5DxRuIWS07L+Q==;5:3uqWSKwwepc0Em5RoCS6jz7Eq7jmwcR5tVQosFNidvhxLUTRcBefDuium+H1W13Uywt0PJAgRIeb74mTcfG78sbCzsgaCjHimbN2m41tj9X4yn3viiwQAW+Pl2dt/TCnRB6s6LleH7AIEwv4kPtJnSTCtJDPD6EQIvBvfV4DxH4=;7:0qRwQcjdE1eNjlnVGABT0ppvdTkpTEqtm1Kz3gkDmadhEzH74/z3wJdxKeebGdB4Azg8TQ6XV/J8svFnPfDW3iOowdRZvrXpamqeB+BDmHQoFUX+d+cWOYP4xGTUrtVQQGtziPes9nCNeN34/u0S9Kn+InZdFabw7N4upySW+S7IFivwwVW+ZM2pmgCi6aFBhm54ucDsCbD2o6xRIWobwb7n0avIoJRiwHV7iZ4uuhO4itQkacIEuG08UrvNbpbc
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bb4a9c8a-9c63-498f-3ebd-08d62ce51d05
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3866;
x-ms-traffictypediagnostic: DB3PR0402MB3866:
x-microsoft-antispam-prvs: <DB3PR0402MB38668637FD9B6A937DDBCD89F5E60@DB3PR0402MB3866.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:DB3PR0402MB3866;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3866;
x-forefront-prvs: 081904387B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(13464003)(51914003)(199004)(189003)(68736007)(53936002)(229853002)(478600001)(44832011)(33656002)(14454004)(6116002)(3846002)(66066001)(74316002)(25786009)(6436002)(2900100001)(4326008)(305945005)(5250100002)(9686003)(7736002)(55016002)(6246003)(316002)(8676002)(476003)(71200400001)(71190400001)(86362001)(81166006)(81156014)(106356001)(102836004)(8936002)(26005)(6916009)(97736004)(575784001)(7696005)(105586002)(53546011)(76176011)(11346002)(5660300001)(486006)(6506007)(186003)(446003)(256004)(99286004)(54906003)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3866;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: xORrVHkc5A68Q0mx2QmQkmS9BX+zSAU/hujwkeb2usUCLLb3Z8oY3MMmwvCudqFR00HnUx+M+he6IN8MjFDZ+RJpAv5Jyng4f/YdainJ2dto494LPtDaFO1UCUeENFKUqrIx83rZbxYmm9RKQy4MbdmNmHO30MiZBrNauoJAWSk8qrc+xnOlL0p5jozeKMZkrmQwI4b1B8PbPtnsq0oyEljbpDKWwhty94sFImY6tI0Wo/ery76bwg3g/C7qFdChJOkKGt9OQU/oUp4ldRLKIEBvOGzDZI4IF8WmJpDkVDEyKmtuAJKkGW0m7xEjhz5XfdTWcRGoK+mL7ZrkAsh2NOZPXEru6hp3LGTlto+lkoY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4a9c8a-9c63-498f-3ebd-08d62ce51d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 06:13:06.4599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Viresh

Anson Huang
Best Regards!


> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Monday, October 8, 2018 2:04 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: rjw@rjwysocki.net; linux-pm@vger.kernel.org;
> linux-kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH V3] cpufreq: imx6q: read OCOTP through nvmem for
> imx6ul/imx6ull
>=20
> On 08-10-18, 09:10, Anson Huang wrote:
> > On i.MX6UL/i.MX6ULL, accessing OCOTP directly is wrong because the
> > ocotp clock needs to be enabled first. Add support for reading OCOTP
> > through the nvmem API, and keep the old method there to support old
> > dtb.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > changes since V2:
> > 	Add put node when reading ocotp register done.
> >  drivers/cpufreq/imx6q-cpufreq.c | 53
> > ++++++++++++++++++++++++++++-------------
> >  1 file changed, 36 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c
> > b/drivers/cpufreq/imx6q-cpufreq.c index b2ff423..38b67f8 100644
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
> > @@ -290,20 +291,33 @@ static void
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
>=20
> You could have done of_node_put(np); right here and remove the below two
> calls to the same.
=20
Thanks for the suggestion, please help review V4.

Anson.

>=20
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
> > +		of_node_put(np);
> >  	}
>=20
> --
> viresh
