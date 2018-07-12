Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A62C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9C320652
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="eqpJoIgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9C320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbeGLGgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:36:41 -0400
Received: from mail-by2nam01on0046.outbound.protection.outlook.com ([104.47.34.46]:22487
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbeGLGgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:36:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN4DwG4vJ/9jhHoCrT5ZGKrcSp5gD2lnsk5zU1stVY4=;
 b=eqpJoIgAppiKlYDrXe40ZqJGlz/7YoJ9wXswYPLz3oKaSKH4zq0xn5nc1kJdOmqZ2y/2IoXL5ROglQdV20WIXagRzgFevv/sqCI8O5vkK4F8Hn8Ev1g+3f7crxZVV6ikDGMDMOF1U/AOwy3Wa0LNftenQHCmmH2DE4nPa2GNxHs=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5447.namprd07.prod.outlook.com (52.135.241.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Thu, 12 Jul 2018 06:28:33 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::39ca:4bef:3be8:fdf5]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::39ca:4bef:3be8:fdf5%3]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 06:28:33 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: RE: [PATCH 02/31] usb: usbssp: Added some decoding functions.
Thread-Topic: [PATCH 02/31] usb: usbssp: Added some decoding functions.
Thread-Index: AQHUGaPhZIddO8iCH0aR0BV4Q6TTjKSLGsoAgAAA+mA=
Date:   Thu, 12 Jul 2018 06:28:33 +0000
Message-ID: <BYAPR07MB4709D8EB760716D0F9B0F4FBDD590@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
 <1531374448-26532-3-git-send-email-pawell@cadence.com>
 <20180712061030.GB20905@kroah.com>
In-Reply-To: <20180712061030.GB20905@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZDQyMzZjMjktODU5Yy0xMWU4LTg3MTAtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGQ0MjM2YzJhLTg1OWMtMTFlOC04NzEwLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNzQ1IiB0PSIxMzE3NTg1MDUyNjU3NTI1NDciIGg9IkUxbWNZSkFyVXowQWlKcFhVSEVYNUJ1Q0N0Zz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pawell@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5447;7:hdA7SsOZxOMXNPi46M70PhvVWJa7m55Mo/rD0kIVGD95+B4P5WA/evlL+0bB6tTQD6n5wOCnUFImZ6AWmAesSy01jo5Ww37CbZzLT+2kD1Xxd3Stv7vYC2yhVQawNUfzEF9drMUNZTBGjnQuBddY6AFdAjJGuohSqm9q53N+3GH73tFtPhc1Bz0rKUY4LcMrCYLyc8NJ3e4MBw7KIphrjaCZa3hnvlqOnQ0H2VCjLWp8qag9abWgP8BSq+s+lI+2;20:cLuLxiQkM2JToU7FVOpM9Sz9nZMLT7Ohf94Pad0eEsc55SdI2xLSXGsSM9snqOznZzB99IrSSgK6oj/d51c/EkE96A4Pmdj9P78Hw5J/Xd+M3tLeOOr9GjB0TnEN+aCOGZ8tLrojoMFiuFnPdZtTeBEUyxUccp7875bUxv6VgAvdJyl1HJOsaCV2s1VnhLht5VqitXB3f2jYxo1cfIrqT1NLGaU5QOuqg/4hyNolBN+7v6vHKXGETWmDArSh6bi/
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(396003)(39860400002)(36092001)(199004)(189003)(14454004)(4326008)(256004)(25786009)(81156014)(107886003)(6246003)(316002)(8676002)(53936002)(99286004)(33656002)(7736002)(2900100001)(81166006)(7696005)(54906003)(11346002)(102836004)(55016002)(5660300001)(186003)(446003)(6916009)(476003)(3846002)(8936002)(478600001)(68736007)(86362001)(66066001)(6116002)(9686003)(6436002)(2906002)(105586002)(5250100002)(74316002)(486006)(305945005)(106356001)(76176011)(26005)(6506007)(97736004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5447;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 2f02ff8d-c9b7-4fbc-6f61-08d5e7c0b119
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5447;
x-ms-traffictypediagnostic: BYAPR07MB5447:
x-microsoft-antispam-prvs: <BYAPR07MB5447A7B372B6E8F7BB82FDC9DD590@BYAPR07MB5447.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB5447;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5447;
x-forefront-prvs: 0731AA2DE6
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RQgs+knib0eOQSWRBZhRELljNTJNIEtIoH5fnvlJRSSZIDsLXem5+v5l+SKPPqytBLUbz1JDS3KSQuGwV/9HIblqhiy+YV4swmM8KXgmeZgk/PDt9AMYc/ago11QlJsUjplS+cUC/Ta/KOTzje961nVPeD9YYKCZhCrFySLTswkyUAToJ7bzeClN8DgUGXxPf5WCYa7vcKPu6feM+aUTsD6mOhtnbURFLkIkWP/6sQkgxL7yuOp3nyE1h9A/xfoF8m0roxCUEoaDFHgDh68lJ3RuiSmTT69GgstmACAFzpcfVIYXrU2ATaJCH5x9Pp95/jjAdoMc3iroA8TIc9m6506zfCFsP71eHSURV8XJfog=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f02ff8d-c9b7-4fbc-6f61-08d5e7c0b119
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 06:28:33.2653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5447
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This patch add additional functions that converts some fields to string=
.
> >
> > For example function usbssp_trb_comp_code_string take completion c ode
> > value and return string describing completion code.
>=20
> Odd line-wrapping :(
Do you mean additional space character between "c" and "ode"

> And why do you want a string for these things?  Who cares about them?
It will be used in next version of driver. I have plan to add gadget-debugf=
s.c file.
At this moment this functions can be useful during debugging driver if some=
one want to display
some debug information.=20

Should I remove this function ?
=20
> thanks,
>=20
> greg k-h
