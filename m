Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0337C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AED920894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pgIi6LHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AED920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733006AbeHAGUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:20:24 -0400
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:25338
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730668AbeHAGUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8L+zNIbt5ZhdJDIRIUZSfq6HklPJGGo7SvvuAViVfMI=;
 b=pgIi6LHEf4t59vxD4jZN78Am620WazsoXza2+xZ/3/muuq8+HJ2l4NDOWU0kiMPvZPJOPxOD2GkVNfMQWP+is92iivR/w/Z/KAzMOdjxx+AKuZpZWy8+Zx5doUvEn8nEQRgRTD5u2xX4LH2SE3KImnlMFEppjrQLMr9GYwAnFtI=
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com (10.169.224.151) by
 DB6PR0401MB2344.eurprd04.prod.outlook.com (10.168.55.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.14; Wed, 1 Aug 2018 04:36:41 +0000
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::4c47:d558:823:271b]) by DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::4c47:d558:823:271b%6]) with mapi id 15.20.1017.010; Wed, 1 Aug 2018
 04:36:40 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Richard Cochran <richardcochran@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
Thread-Topic: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
 initialization
Thread-Index: AQHUJ+4m7ji74zU7lkWu9l5BQ4RFQqSn0+6AgAJ4fIA=
Date:   Wed, 1 Aug 2018 04:36:40 +0000
Message-ID: <DB6PR0401MB253643010802739AD55820F3F82D0@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180730100154.27906-1-yangbo.lu@nxp.com>
 <20180730100154.27906-3-yangbo.lu@nxp.com>
 <20180730143043.qu66ttzwyjbw6si7@localhost>
In-Reply-To: <20180730143043.qu66ttzwyjbw6si7@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2344;6:o7Q2PI2gQDIBc17WCPD/jOdiv9FZAX9MCWlwMxypzbKaUDyw2Yn4MIFYtF8VGkHZfsFiHLIIRogaXGvnmSbx3CKmjx9CVyz1cVZPL+lQVKCTSGrJqH2PCVVDtCLuKOwTyxxIVW1m6OVnfCndpd2D1t1hBNqgmEuvUWGYEN3UayaI94SO76fF7zzvIX2SJ+3geJFPcf9LSrLpoEuO2EStU8wZZNNyX+OjqoFPRMbMHYJYaP4qE+Suk1SeHwoT9GDq1kbe3XrKWcI1pi4+4n32Vw+bIYiEwNuOeYvp8H5IgVI4/GDxW1mn8n2i00o+SmJwqwhsXHdQHFVVSYTtuQVsGlV5Z1JnkeFwMto3ylr8PhBgilY9VS3A+TiVC5O0z1DXIOOzIcIWed6nEAEyxpitUDi4cKEgCsdbcVsszzUYOwJsRr8kijC15JOFmjpEFrEHGXxoZoOY5Qo3YyclUvruTg==;5:qFySzFJpUwsYnKInCYE8NpsXe43Ub/sjQK+NX003uR/nbOzxU9wYuYvo3Fne1bkBekuHnYis+1gQ1ZC82MkB81+eFPncsnDgHKfEq9U3X05PAg0hBXTu1k/g7yfTQHULDn1KOb6AS0cpbHOS7lUqf14REeDZRsuyWrBnZf9fIr0=;7:jd4kkm9KbhAUMUpO2nGdSVJ7cx0v2zdhP0tQi/TtBj7CaEh5iFoXJscSNhnjFEnpM8kbDn6IduK3Cq1erkX8jDWpAVrT8K9rRyxwqRT0zvTNnKGlGj0i5TMOqKGD1W42eouSRHQy1bkb/0krTj1nSPO6cu0LwPyhlZSEqI9ltfNtJR2cFbv8TUiwK/vLeTy+n5BoMvbzvgoBu8mSxHgNI4Lw6/HYnbV7SKtydNJTrqYMqY/A867HzbH/JFF95+u2
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 712acb92-b279-460b-7b00-08d5f768606a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2344;
x-ms-traffictypediagnostic: DB6PR0401MB2344:
x-microsoft-antispam-prvs: <DB6PR0401MB2344F681FD62F876CBC4FE20F82D0@DB6PR0401MB2344.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(65623756079841)(185117386973197)(85827821059158)(788757137089)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0401MB2344;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2344;
x-forefront-prvs: 0751474A44
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(13464003)(6436002)(5250100002)(2900100001)(316002)(14444005)(66066001)(86362001)(3846002)(486006)(229853002)(5660300001)(6116002)(476003)(55016002)(99286004)(97736004)(6916009)(1411001)(106356001)(105586002)(478600001)(53936002)(2906002)(68736007)(8676002)(4326008)(74316002)(33656002)(8936002)(9686003)(7736002)(305945005)(6506007)(102836004)(53546011)(26005)(14454004)(76176011)(256004)(186003)(39060400002)(81166006)(6246003)(25786009)(81156014)(54906003)(7696005)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2344;H:DB6PR0401MB2536.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hZ0KRRpqgBJAnargvhOnLLDVZEMcohBbmBtXURZ1cA1xaRcuU8Xw84rHauojj/DWENw/Ab7c6HhEMV3vSX/NGGHw667lvYGhtR/ZUyQ17a8/4aWKRHB5LTVSamUf7N4Af0wTTCWwAGGscx/+lkCh4equlowQLagi9/XX/ov1WOemEVtkttWpLjvUBmLX3ft4lNuEkxK1DudRkujcQWdmBAR5C36C7UM2xBIvDFRrcEbmTJv3lnJL3P/BWrck3iwfZOLE+Ga+SaMXWvhvcE2gQ1J1LqRN42nSPcS60zw5XI5fFeJSwLHw1dBx3Dhjv8hJeaVZHZ4yC/aUoniFBL9bOoExioxEp/Hmws+zNJYY+p8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712acb92-b279-460b-7b00-08d5f768606a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2018 04:36:40.8273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran@gmail.com]
> Sent: Monday, July 30, 2018 10:31 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev@vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Rob Herring <robh+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; David S . Miller <davem@davemloft.net>;
> devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 3/3] ptp_qoriq: convert to use module parameters for
> initialization
>=20
> On Mon, Jul 30, 2018 at 06:01:54PM +0800, Yangbo Lu wrote:
> > The ptp_qoriq driver initialized the 1588 timer with the
> > configurations provided by the properties of device tree node. For
> > example,
> >
> >   fsl,tclk-period =3D <5>;
> >   fsl,tmr-prsc    =3D <2>;
> >   fsl,tmr-add     =3D <0xaaaaaaab>;
> >   fsl,tmr-fiper1  =3D <999999995>;
> >   fsl,tmr-fiper2  =3D <99990>;
> >   fsl,max-adj     =3D <499999999>;
> >
> > These things actually were runtime configurations which were not
> > proper to be put into dts.
>=20
> That is debatable.  While I agree that the dts isn't ideal for these, sti=
ll it is the
> lesser of two or more evils.

[Y.b. Lu] Ok. You're right indeed :)

>=20
> > This patch is to convert
> > to use module parameters for 1588 timer initialization, and to support
> > initial register values calculation.
>=20
> It is hard for me to understand how using module parameters improves the
> situation.

[Y.b. Lu] Actually I'm not sure whether module_param will be accepted to re=
place dts.
I thought the most possibility would be rejection before sending them out.
Just want suggestion and confirmation whether there is better idea than dts=
 from your comments.

Since we should keep the dts, I will drop the module_param.
Could I add a function to calculate a set of default register values to ini=
tialize ptp timer when dts method failed to get required properties in driv=
er?
I think this will be useful. The ptp timer on new platforms (you may see tw=
o dts patches in this patchset. Many platforms will be affected.) will work=
 without these dts properties. If user want specific setting, they can set =
dts properties.


>=20
> > If the parameters are not provided, the driver will calculate register
> > values with a set of default parameters. With this patch, those dts
> > properties are no longer needed for new platform to support 1588
> > timer, and many QorIQ DPAA platforms (some P series and T series
> > platforms of PowerPC, and some LS series platforms of ARM64) could use
> > this driver for their fman ptp timer with default module parameters.
> > However, this patch didn't remove the dts method. Because there were
> > still many old platforms using the dts method. We need to clean up
> > their dts files, verify module parameters on them, and convert them to
> > the new method gradually in case of breaking any function.
>=20
> In addition, like it or not, because the dts is an ABI, you must continue=
 support
> of the dts values as a legacy option.

[Y.b. Lu] I get your point now. The dts should be kept :)

>=20
> Thanks,
> Richard
