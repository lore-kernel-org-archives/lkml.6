Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520CFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E022082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tFcoHl58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbfAPHFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:05:53 -0500
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:52992
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388324AbfAPHFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfqQVWJJ2hbvhg9nUb/Ny/iGfQzLXnpVOzts0VZ3i94=;
 b=tFcoHl581fsu2yJRKGXQ8UUtfB8apv68aOGXn3HZydiP6XzV883s8Wg9rOYQkrH8l213XzQ+H17Se0tK9Ektf9AgsFVEVael0VgfVwjr1lYQLbp/bp0v6UMnC6rBCxdeEckL2jHp3ftX8DvDuFKmGl18jwMFXOdB0oymCHYf4sg=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2690.eurprd04.prod.outlook.com (10.175.40.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Wed, 16 Jan 2019 07:05:47 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 07:05:47 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci reset
Thread-Topic: [PATCH 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci reset
Thread-Index: AQHUrWdviEVntsRQzEWnqfJhKWO2IKWxd5rw
Date:   Wed, 16 Jan 2019 07:05:46 +0000
Message-ID: <AM5PR0402MB2865FC8FE157D5CE59126168F1820@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190116064820.20007-1-ran.wang_1@nxp.com>
 <20190116064820.20007-2-ran.wang_1@nxp.com>
In-Reply-To: <20190116064820.20007-2-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2690;6:OO9CRsekaLrKTii6LVyiJIpdRs4RE86Kr6s4tW5g6xlcm/kJrwnO8TGJiWd4ybkzVkYBu7K0hEtLhQ2uCe6o8sX2SKRAPpTzJpVrQO4kaEu6HWHTzAMYACzlxnC+NCVSZh7qbHmaxGtnCDvASq5Z5uRrrOd/Fi2gDzznIM1ig5JlnClDmf0kpS8+rBjm6ACD6lpKDSrZlNrYl2Fd+S+STWLUV4xcni+J2K3tpGhKG0eI++lYm1s1iUjs2KeE12vjQOJsKiLaDsfYCc5P6QU31RqbWn2WO4CjmPdCGFc5AzxqzqxOSHUIWl1wDFj4ciGFm161ghVDtA9y5HVKZXSND7bQ9Mu1xLG9QjntbrwRpU25i+SSh5w7NRBn+Cagdfml+3ulVPsqTnfhwk6X4ypsjWzuSpzCzNWmqjlOPDzmOci5gPcPO57vv+RxzsapDyVJXYE1mddf/uss8uwVMIu18w==;5:3ifUVSUupCDFnA2+UZd8HFzBlomX96iqMnNsoHr7K+HzKymbTmRkjimazFv1yzAzzYdS7cqEDM6DKHja4mwDSEq6sdET2cQHA7GFSJ4kB37AZt9eK4ApwWRMVHCV41SiufvaKm0Lz/YD7YS4bQ5BGWbI+3RWXa261TzVK8AW1tSyW+Tnmu4aCJIBY3DZl4JNNYT50omtuU+loSfYnyhSOA==;7:FtMq3Ko2bTM32rWEiYfGo0I/SqH6yj9E7UF4VVDKoHgvWMHNAeUUzoAaB7xaw3i/C9AwghB5xyO4aNXUW3mu/w54fosjPYk6WBOvMK7Bwh5+RC7tc6ks9+tYRgZD0mbRWF/MFPzthBvlbrxPJ8qwGw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e8045fd0-af95-455d-6743-08d67b810a21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2690;
x-ms-traffictypediagnostic: AM5PR0402MB2690:
x-microsoft-antispam-prvs: <AM5PR0402MB2690DDFE0316A4B51F35F1EDF1820@AM5PR0402MB2690.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(376002)(136003)(39860400002)(199004)(189003)(51874003)(5660300001)(110136005)(33656002)(478600001)(6246003)(14454004)(305945005)(66066001)(68736007)(966005)(7736002)(4326008)(25786009)(6506007)(486006)(86362001)(54906003)(53936002)(6116002)(3846002)(9686003)(6306002)(102836004)(99286004)(316002)(26005)(7696005)(76176011)(476003)(11346002)(446003)(74316002)(2906002)(186003)(8676002)(106356001)(71200400001)(105586002)(81166006)(81156014)(97736004)(71190400001)(8936002)(229853002)(55016002)(6436002)(256004)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2690;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8eHHTb29IqzCZ2DZjBFfGaS5pWtWMxirHTbZgBEWtmyCgpVjLfnU3pWkDOWue8RbR+dtDeiPEnPYQevY30EN6cHnCG/F9GmB7hQNcWI97Y26Ue2c6pxxPD0GAnh8/S6wrw3ZEnscOqim1t97rXsOIYed8HvCBF9DKCG7SUs7Rz04+Z93U2ZJjXKbYNJKtOaFp9SiFc78DYxU6eJyo9Sb0yA1cyWxQNiCsPjeCkphDdkP2v0hNmrwGaIYpbYgt/cFcf9gwrGABDBU58MEysk/KbEiRglxMiY8TowpPGR5KYAYip5UfLb0oiaZbzayGM2EhGoTt9nGT/3oWsTFapY/ec7266Y54cR0fZRzbjuS7I13+ft2f8dx3m3Zjk1AhYUfxBIF2KWEffVuFw85PY+hc7aDY/BS2ZPEivkn3osCmtw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8045fd0-af95-455d-6743-08d67b810a21
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 07:05:46.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16, 2019 14:48 Ran Wang wrote:
>

It seems the preface patch (0/2) failed to be accepted by patchwork (could
anyone tell me how to generate it properly with some sommand?),=20
I paste its content here for your reference :

This to fix USB enumeration compatibility issue found on DWC3 (host mode)
IP only.

Some pre-discussion mails can be referred from:
https://lkml.org/lkml/2018/11/23/387
https://lkml.org/lkml/2018/11/22/683

As to the workaround, I know programming xhci register in DWC3 dirver
(probe function) is not good from perspective of SW stack, but it seems
to be the only place to fix this real existing problem (test result show
that doing this in xhci-plat.c or xhci.c would not hlep on this kind of
failure). If who have better idea, please let me know, thanks in advanced.

Ran Wang (2):
 dt-bindings: Add workaround for host mode VBUS glitch when boot
 dwc3 core driver: Add avoiding vbus glitch happen during xhci reset

 Documentation/devicetree/bindings/usb/dwc3.txt |    3 +++
 drivers/usb/dwc3/core.c |   47 +++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/usb/dwc3/core.h |   10 +++++++++-
 3 files changed, 60 insertions(+), 0 deletions(-)
=20
> When DWC3 is set to host mode by programming register DWC3_GCTL, VUBS
> (or its control signal) will on immediately on related Root Hub ports.
> Then the VUBS will be de-asserted for a little while during xhci reset
> (conducted by xhci driver) for a little while and back to normal.
>=20
> This VBUS glitch might cause some USB devices emuration fail if kernel bo=
ot
> with them connected. One SW workaround which can fix this is to program
> all PORTSC[PP] to 0 to turn off VBUS immediately after setting host mode =
in
> DWC3 driver(per signal measurement result, it will be too late to do it i=
n
> xhci-plat.c or xhci.c).
>=20
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt
> b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 8e5265e..dadb530 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -106,6 +106,9 @@ Optional properties:
>  			When just one value, which means INCRX burst
> mode enabled. When
>  			more than one value, which means undefined length
> INCR burst type
>  			enabled. The values can be 1, 4, 8, 16, 32, 64, 128
> and 256.
> + - snps,avoid-vbus-glitch-when-set-host: Power off all Root Hub ports
> immediately
> +			after setting host mode to avoid vbus (negative)
> glitch happen in later
> +			xhci reset. And the vbus will back to 5V automatically
> when reset done.
>=20
>   - in addition all properties from usb-xhci.txt from the current directo=
ry are
>     supported as well
> --
> 1.7.1

Regards,
Ran

