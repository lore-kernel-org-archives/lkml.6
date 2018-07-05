Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2B4C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FED22EC0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fAoS6c2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FED22EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753555AbeGEPmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:42:49 -0400
Received: from mail-db5eur01on0082.outbound.protection.outlook.com ([104.47.2.82]:32258
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753397AbeGEPmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyO6N/FDWdpV1gpTbvO39W0Fz7+5sXVEfSLtPlR4fSg=;
 b=fAoS6c2tVRuMvNUaOiskPbnFZc1Ov1N80HwXZmMrM4GfjavfjnSA3xQBI5moIKefPLV9rRegOyQvVWMNmtcp8Jmyb1svsL/zDTQebEPDoPB4IqulKvQ0+AbuvHJNEtKUc7zDWgphAyHfd4HyFfpOHR1kCyk0j3kvOmJdaD5m3Bc=
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com (10.169.245.8) by
 AM5PR0401MB2609.eurprd04.prod.outlook.com (10.169.245.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Thu, 5 Jul 2018 15:42:44 +0000
Received: from AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::9d6:45c2:b0d6:87f0]) by AM5PR0401MB2545.eurprd04.prod.outlook.com
 ([fe80::9d6:45c2:b0d6:87f0%3]) with mapi id 15.20.0906.027; Thu, 5 Jul 2018
 15:42:44 +0000
From:   Bharat Bhushan <bharat.bhushan@nxp.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "geoff@infradead.org" <geoff@infradead.org>,
        "tyreld@linux.vnet.ibm.com" <tyreld@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] powerpc/mpic: Cleanup irq vector accounting
Thread-Topic: [PATCH] powerpc/mpic: Cleanup irq vector accounting
Thread-Index: AQHUD5P3Jr0y9lVSqkimrQyPAQjzzKR/FkqAgAG3HxA=
Date:   Thu, 5 Jul 2018 15:42:44 +0000
Message-ID: <AM5PR0401MB2545E56D1B38A07D1FB9D2499A400@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1530267872-31244-1-git-send-email-Bharat.Bhushan@nxp.com>
 <87efgjku6k.fsf@concordia.ellerman.id.au>
In-Reply-To: <87efgjku6k.fsf@concordia.ellerman.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.142.187.166]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0401MB2609;7:H5pSiODNpFY9X51Bxf3q2VIMDpLeH2tR73s5gr/850mo7g2pbMSV5OIalTa7OSWe/WoQ3Ir6dknDgFfe6tmjgRbMnvpPV5aqMOdjDqg7N4ZPT40CLsCY1yLFDhBrtyhXKxu4PIcVWnKi7VZI+TYj7ywIq67pEXu558UGzXIs+RQQOuA4XFj7+vGg3hcrsc9SjVMEzP475MlIHGv/0NkQ/bh/pNk/sA/dBfB40458SizFkbb/nIqTJYx3uNVFcWBo
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f1b5bb5e-1f48-4229-3a41-08d5e28df3a8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2609;
x-ms-traffictypediagnostic: AM5PR0401MB2609:
x-microsoft-antispam-prvs: <AM5PR0401MB2609B3F4CC4504920B922BDE9A400@AM5PR0401MB2609.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(65623756079841)(185117386973197)(104084551191319);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM5PR0401MB2609;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0401MB2609;
x-forefront-prvs: 0724FCD4CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(13464003)(316002)(110136005)(55236004)(575784001)(86362001)(2201001)(53936002)(102836004)(76176011)(99286004)(7696005)(15650500001)(2906002)(53546011)(97736004)(6506007)(305945005)(2900100001)(7736002)(5660300001)(74316002)(478600001)(68736007)(81166006)(8676002)(8936002)(81156014)(476003)(55016002)(25786009)(229853002)(6436002)(256004)(6246003)(6116002)(3846002)(9686003)(66066001)(33656002)(105586002)(14454004)(106356001)(5250100002)(26005)(486006)(446003)(44832011)(11346002)(186003)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0401MB2609;H:AM5PR0401MB2545.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MEbkqTxfvO57HA5kc6dWbCXWxZZ4ayHZ0+9AJw7loC/dmRyys5IkakHDW7I1AcrjYaADOIFe0J2Yxlag1UnNJoCg7SZsULbJpQY45sAUrNkFQIAovJik/Cud3sDsqyZBPHfzKKNQqlZaErY9bY5iQ2doPeqOQHKfkRNtdC+/jjSuI2S2VqIMeiuOMHiklBrv4jL4FPFmS1bFgQOFGZ+Z2rU0Gkuxicrz6jiwDybiRC2Tu8BmTV7Fr8xKPhmqWDLAdv/0Kwm8C2FaFRX2X0RSdv5f656y7VGRgOOSmkQNAObVp8hfS2x3VtHQejShX3HDvmO8BsczGjhLb5g3GniGjlWvEnOOEBceCEzCrDtOegQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b5bb5e-1f48-4229-3a41-08d5e28df3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2018 15:42:44.8479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2609
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michael Ellerman [mailto:mpe@ellerman.id.au]
> Sent: Wednesday, July 4, 2018 6:57 PM
> To: Bharat Bhushan <bharat.bhushan@nxp.com>;
> benh@kernel.crashing.org; paulus@samba.org; robh@kernel.org;
> geoff@infradead.org; tyreld@linux.vnet.ibm.com; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
> Cc: Bharat Bhushan <bharat.bhushan@nxp.com>
> Subject: Re: [PATCH] powerpc/mpic: Cleanup irq vector accounting
>=20
> Bharat Bhushan <Bharat.Bhushan@nxp.com> writes:
>=20
> > Available vector space accounts ipis and timer interrupts while
> > spurious vector was not accounted.
>=20
> OK. What is the symptom of that? Nothing? Total system crash?
>=20
> Looks like this can be tagged:
>=20
> Fixes: 0a4081641d72 ("powerpc/mpic: FSL MPIC error interrupt support.")
>=20
> Which added the code that uses "12".
>=20
> > Also later
> > mpic_setup_error_int() escape one more vector, seemingly it assumes
> > one spurious vector.
>=20
> Ah right, I get it now.
>=20
> So there is no bug. It's just a disagreement about whether the "intvec"
> argument to mpic_setup_error_int() indicates the first number that's free=
 to
> use or the last number that has been allocated.
>=20
> Right?

Yes, it is not any bug fix. This is minor cleanup where passing rather than=
 passing "last intvec used" to "intvec to be used" in mpic_setup_error_int(=
).

Thanks
-Bharat

>=20
> cheers
>=20
> > Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> > ---
> >  arch/powerpc/sysdev/fsl_mpic_err.c | 2 +-
> >  arch/powerpc/sysdev/mpic.c         | 6 +++---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c
> > b/arch/powerpc/sysdev/fsl_mpic_err.c
> > index 488ec45..2a98837 100644
> > --- a/arch/powerpc/sysdev/fsl_mpic_err.c
> > +++ b/arch/powerpc/sysdev/fsl_mpic_err.c
> > @@ -76,7 +76,7 @@ int mpic_setup_error_int(struct mpic *mpic, int
> intvec)
> >  	mpic->flags |=3D MPIC_FSL_HAS_EIMR;
> >  	/* allocate interrupt vectors for error interrupts */
> >  	for (i =3D MPIC_MAX_ERR - 1; i >=3D 0; i--)
> > -		mpic->err_int_vecs[i] =3D --intvec;
> > +		mpic->err_int_vecs[i] =3D intvec--;
> >
> >  	return 0;
> >  }
> > diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> > index 1d4e0ef6..e098d1e 100644
> > --- a/arch/powerpc/sysdev/mpic.c
> > +++ b/arch/powerpc/sysdev/mpic.c
> > @@ -1380,12 +1380,12 @@ struct mpic * __init mpic_alloc(struct
> device_node *node,
> >  		 * global vector number space, as in case of ipis
> >  		 * and timer interrupts.
> >  		 *
> > -		 * Available vector space =3D intvec_top - 12, where 12
> > +		 * Available vector space =3D intvec_top - 13, where 13
> >  		 * is the number of vectors which have been consumed by
> > -		 * ipis and timer interrupts.
> > +		 * ipis, timer interrupts and spurious.
> >  		 */
> >  		if (fsl_version >=3D 0x401) {
> > -			ret =3D mpic_setup_error_int(mpic, intvec_top - 12);
> > +			ret =3D mpic_setup_error_int(mpic, intvec_top - 13);
> >  			if (ret)
> >  				return NULL;
> >  		}
> > --
> > 1.9.3
