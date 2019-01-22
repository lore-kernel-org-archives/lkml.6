Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F9C282C0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E962920870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JyJF46C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfAVCih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:38:37 -0500
Received: from mail-eopbgr50058.outbound.protection.outlook.com ([40.107.5.58]:18336
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbfAVCih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3jz6o/NvneTgkiJf+F7LrbtU7FLesNn1rP47m1X8qY=;
 b=JyJF46C06KWa+6fKMxkYjo5/21a96FrLJeKsm73RkWcd4RWQoL1SzqE81JEW1NQ2K0r8YLgn+YF3Vq1J86pJ64W8jAm/aVNMdAfJ43VmZLdlOkQJQltHCfLRrhAYG7hmbSFpQg2Sf4YTCGKPgv0OlfTpzbYVK/+M/O9uWcWk1CM=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2786.eurprd04.prod.outlook.com (10.175.41.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 02:38:32 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 02:38:32 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci reset
Thread-Topic: [PATCH 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci reset
Thread-Index: AQHUrWdviEVntsRQzEWnqfJhKWO2IKW6ga0AgAASwBA=
Date:   Tue, 22 Jan 2019 02:38:31 +0000
Message-ID: <AM5PR0402MB286524243DB67DA15AE4EA42F1980@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190116064820.20007-1-ran.wang_1@nxp.com>
 <20190116064820.20007-2-ran.wang_1@nxp.com> <20190122010310.GA5165@bogus>
In-Reply-To: <20190122010310.GA5165@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2786;6:frst9He2LRP2TMqMggPF7kac9GLEbrc5G8gnyolw0ih0+GD1o5kX3jc38lZzopX8/r5jZo0wwN50pPM5lvBB5yFDXAt/YFSmCoJCL/tCnXGHXuP/lSo+I6U9E7bw/llMviMCHLMU7BR+Z9quI08G5tMieX5HnYwHz/WjAI4U2kMwvOZF8gUzHfP7sGrnzmER9OmjlFYSrSJWb0WlJmvTKuHGiJoZscpq5VnZhbkib61v8nkdk3ULqJv0pEJ+d2DJUDertxaD+BwRK599nIj/TjZIkigOv+QrVmcuQrBl3sDCUElEdYMxa1LYEPxKNBEOcaj4uL6HSJVISuRe6z5z8Ms9B3o//XBHLMy3Y2aD3WVmy28skZFwj5QYACwCdakaIFUCy0byqDCLphVWuMyGck1vHPM3G3gKA5R5EHYh2JRTc66lzDIDPTPYenUWOLrxTEaqi9J7QJHONmzprUcSzA==;5:UbqpHz/NWqqbRnTZ4DcYMX4LZMDBdsO3RTukTyK2B5cXWZTiLhefpUInAcdVMXNDCRPR4iupZfoSpTVYJXfY1TkSIgTJChw+Y2UFcxYNGXaxmEVNrU/t6eofcYHrCdTMEy/5UKEsChsT7KF7+6BgQzploJ4hln7iE+D7H+hvzN93n8szSjG6et0uTQCs2kxudzPXN38eK5RSq3T5Mxrlfg==;7:nDN8DDNJnVzylS707+PNg30NEcvMlIiksvRam7HFxlf/nLxhD1wrN6yfq7+qCPA8tbox/5wSj4MrmQzHxr2nTv+vX5CyNO80IGXEXod57QxmUa5tP9bi+XfPAPFsdQQaw/YVYfaYzEgdsGqqVppYjw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 81aad6d1-4144-4bd8-9c47-08d68012b302
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2786;
x-ms-traffictypediagnostic: AM5PR0402MB2786:
x-microsoft-antispam-prvs: <AM5PR0402MB2786D9EA88029E4423DC5795F1980@AM5PR0402MB2786.eurprd04.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(366004)(376002)(346002)(396003)(136003)(85664002)(189003)(199004)(476003)(305945005)(186003)(6306002)(2906002)(7736002)(68736007)(3846002)(6116002)(9686003)(6916009)(53936002)(55016002)(6246003)(486006)(8936002)(106356001)(105586002)(229853002)(102836004)(86362001)(26005)(6506007)(81166006)(81156014)(8676002)(11346002)(478600001)(66066001)(4326008)(446003)(14454004)(71200400001)(71190400001)(76176011)(7696005)(33656002)(25786009)(74316002)(256004)(316002)(6436002)(97736004)(54906003)(99286004)(966005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2786;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g+FepUXpTkqUGExFfieDeeMcCq2S+d+gbPRR+044prlP1mitv8Z9hW4TT1eA8MLpxI7LNcPCdEFdnkJDdJpKGWPenMwDXKVInY+x2ULt6DTr9c3MNt96c6TDYBXMqXZ0jgPBEXtByzrllCpYRq1rg5YXkbMX1UmSVwA3URfJYWfeNbNOzmvpWPgZaELksWt4+yOPb6QcmJpLGVh0rdjHQ0OcpocMUBExBbLegom958bsyk/viS6/MNCFpZaB0fKWAjjaAJ7L28fQaR3Y+VRZFvE3sOm2BnxRDKpiyRpsJfXJNAkDcfgjr3DcjMo7M1fLpLShiCGcFUPstgBrFwSm/uzImcf3fOrqhsk5zb9fRoMQlBSyuxZJbZHkbdKd1G3Jw0J4lF5jzxCJGd7gTaVXzYZvTt6arruEjwEbQDog+W8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81aad6d1-4144-4bd8-9c47-08d68012b302
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 02:38:31.9762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On January 22, 2019 09:03, Rob Herring wrote:
>=20
> On Wed, Jan 16, 2019 at 06:48:06AM +0000, Ran Wang wrote:
> > When DWC3 is set to host mode by programming register DWC3_GCTL,
> VUBS
>=20
> s/VUBS/VBUS/

Yes, will fix it in next version.
=20
> > (or its control signal) will on immediately on related Root Hub ports.
>=20
> /will on/will turn on/

Got it. Thanks.

> > Then the VUBS will be de-asserted for a little while during xhci reset
> > (conducted by xhci driver) for a little while and back to normal.
> >
> > This VBUS glitch might cause some USB devices emuration fail if kernel
> > boot with them connected. One SW workaround which can fix this is to
> > program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> > host mode in DWC3 driver(per signal measurement result, it will be too
> > late to do it in xhci-plat.c or xhci.c).
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/usb/dwc3.txt |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt
> > b/Documentation/devicetree/bindings/usb/dwc3.txt
> > index 8e5265e..dadb530 100644
> > --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> > +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> > @@ -106,6 +106,9 @@ Optional properties:
> >  			When just one value, which means INCRX burst
> mode enabled. When
> >  			more than one value, which means undefined length
> INCR burst type
> >  			enabled. The values can be 1, 4, 8, 16, 32, 64, 128
> and 256.
> > + - snps,avoid-vbus-glitch-when-set-host: Power off all Root Hub ports
> immediately
> > +			after setting host mode to avoid vbus (negative)
> glitch happen in later
> > +			xhci reset. And the vbus will back to 5V automatically
> when reset done.
>=20
> Can't you imply this from the compatible string. You should have an SoC
> specific compatible.

Sorry, not quite get your point here? Actually I have discussed with Soc de=
sign guys
and Felipe, it seems to be DWC3 native behavior rather than SoC specific is=
sue.
https://lkml.org/lkml/2018/11/23/387
https://lkml.org/lkml/2018/12/12/140

I think there could be 2 reasons why we got no report for a long time till =
now:
1. Most USB devices are not so sensitive to this VBUS glitch, they would wo=
rks fine.
2. A proper VBUS pump circuit design can successfully filter this glitch ou=
t. I have
confirmed this with scope, which means some platforms might resolve issue i=
n
this way already (some might not, of cause).

> Does this even need to be conditional? What would be the harm in doing
> this unconditionally for all DWC3 hosts?

From the logic level, I don't see a harm to DWC3 hosts if unconditionally a=
pply this.
However, since this is not a only solution (can fix it in HW way), I prefer=
 to let it
controlled by property in DTS node for those questionable board already exi=
sting
in market.=20

Regards,
Ran

