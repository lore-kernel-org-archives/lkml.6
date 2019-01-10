Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEFCC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF94820685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 03:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gqyfyFuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfAJDlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 22:41:12 -0500
Received: from mail-eopbgr10075.outbound.protection.outlook.com ([40.107.1.75]:60782
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbfAJDlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 22:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G56xszGymZ8uWeZjhtx/pmxti62LO0bVvt5XNktxuFA=;
 b=gqyfyFufcE+3IE9nrdBLILN14hUjdwndalQ5gcoIavX8BpJLXLibGMxEl9P5InVPEeaZc3pCmk/QrR/kVxb3z+H+ghBz5gq1dEvDtHEaP5ygysK2jsaNFSApAdpL0pS+yZz2yH+1v0sqyfUkc2E3GCkW4V1JyOopUVBmUe2gH4s=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2771.eurprd04.prod.outlook.com (10.175.41.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 03:41:07 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 03:41:07 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Topic: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Index: AQHUpxgC6yBGLPIm9UWYEo0ogu0Vc6WljdKAgAC5jzCAAMZlAIAAz2UA
Date:   Thu, 10 Jan 2019 03:41:07 +0000
Message-ID: <AM5PR0402MB286596CEFCD502488F579FADF1840@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <AM5PR0402MB28654E2A6EB5914CB3C35174F18B0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <Pine.LNX.4.44L0.1901091010570.1453-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1901091010570.1453-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2771;6:FohG7KGA3ssw3TEwX7e6JZHPOGEI5gfHkZpetf6C5BSWTbFVV+I79RipZQIYzyPA14oA/UPNNvDDhwj6SWbQ7VFsf3IszuVcYe8RboOvUeJbm1JHl+HyefUf33vrMN2zB2kURLInDdaqhcfXksGA/QFa8yjiBoVY4sHRBFG8HBxUAQrfnPupy/IFByUo8K3OzXtJ1ptk/ZYjV+lhvzAgzbMV5ESm4U9qTugPJsthd1L7s86HiJyNRb0WDJOtdvup398vq+sn2W7YNl3mKSxNDjMQGn4KlIzG24Ea74YmCXblA3/kGGt8xqh8vbJohGx8g8wAbX2BZ5mCFbloyXpY1ds90PQ8AwFXgllDoctIX/5l4NQv4JtNNo3rObHKsIhpiy67j595Z7+ldlsxeZeHtxGPYbu72nP/azWdwX50Cv6389qs81mAHCq4MqK0beJCZdhv619+/Sqdw5WIRTOKGw==;5:yQg2pUF9diHws/+z3kMLSVCcKe1GH4uUPc2WyM/aB2mNNK1Y3zNiG9oc8gogRPJhkHIH7HhXHPvHNLjPCINjHI9DvQHPuJZoxk9M6Q7qs9XZmqs+VepMqx1ZXdeErZ+am/GPOO6qVR70vcJkKmEZS++y1+RNMWcJ6x428+1A8Bs79SW6+onR6s6TuwNapFyuTxnaXS2+4xtje8IywyXCjw==;7:b3Vgz/K4emw2slNbTa2zo4TUOUeLnhJOjP4fzPkkFBhZ5WnTbkPPvZDie6eVcQEvI59feVp52DmYrWw9MfFarXQ005HMYrP4uAbN5HZXmQw6a+ywZeYnZBXAnNJm47FAEKXeLveUITRvKtOgj0SBUg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: efc8bb0d-05e7-49e4-390a-08d676ad748f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2771;
x-ms-traffictypediagnostic: AM5PR0402MB2771:
x-microsoft-antispam-prvs: <AM5PR0402MB2771CFC43FE7D9A5044B7EABF1840@AM5PR0402MB2771.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM5PR0402MB2771;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2771;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(366004)(346002)(13464003)(189003)(199004)(86362001)(55016002)(6246003)(2171002)(6436002)(68736007)(15650500001)(9686003)(5660300001)(74316002)(6916009)(53936002)(6116002)(3846002)(446003)(486006)(11346002)(256004)(476003)(14444005)(99286004)(76176011)(7696005)(14454004)(186003)(26005)(54906003)(53546011)(102836004)(229853002)(6506007)(8676002)(25786009)(105586002)(2906002)(81166006)(81156014)(71200400001)(106356001)(305945005)(7736002)(4326008)(316002)(71190400001)(97736004)(66066001)(478600001)(8936002)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2771;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rejGsQ2QXhnkOE4jrDU1HEJjlUgEdcH/NLHmXNKy3+XawF1c5qjNichg1gDc5PHdIRb6rMLiShFqbzkYVBXCiL6o67jlX2q1G8QFOgNrFbL9eAYs28w12SACSRCwoRAK820YfENj/MelgNk/5wQkty+otfeRPes4rGlDHdL9tEb4qy9g9jtNprC0ZsOLEm4pum8QnEtLZyvpARQ8BYvI7BB96itn1ws2Ejipbuz8Ufov4VXtvLjQgihChwsY8hqXRjmjt/v7jrq5CH7B4TJ5axI/eM8JzGoL3kVvzpkYdf0uOFSCK9OTbW6OwtICgTcX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc8bb0d-05e7-49e4-390a-08d676ad748f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 03:41:07.5726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> -----Original Message-----
> From: Alan Stern <stern@rowland.harvard.edu>
> Sent: Wednesday, January 09, 2019 23:14
> To: Ran Wang <ran.wang_1@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
> arm/arm64 platforms
>=20
> On Wed, 9 Jan 2019, Ran Wang wrote:
>=20
> > > Why do you change this writel() into iowrite32be() but leave other
> > > instances of writel() unchanged?  Was this a mistake?
> >
> > Yes, I didn't notice there are other writel() used in this file.
> > However, as I know, on both powerpc and arm SoC, EHCI FSL IP's memory
> > mapped register block is always Big-endian, so I'd like to replace all
> > writel() with iowrite32be() in this file. Is it necessary?
> >
> > Or I just replace them with ehci_writel() and select
> CONFIG_USB_EHCI_BIG_ENDIAN_MMIO?
>=20
> That should work okay.  ehci_fsl_setup() sets ehci->big_endian_desc and
> ehci->big_endian_mmio according to the platform data, so you just have
> to make sure the platform data is initialized correctly.
>
OK, so I should not change writel() into iowrite32be() at that
place you mentioned, and still using iowrite32be()/ioread32be() to replace
clrsetbits_be32(), am I right?

Regards,
Ran

> Alan Stern

