Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AD6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DBB2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dSQw2eI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbfARCkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:40:02 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:52672
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726398AbfARCkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2YGtn1tgFXz62iKUCEw1BFaRC+poWI8KpH28FPOT68=;
 b=dSQw2eI4+Wdal2dptOqL5fYmLORwY6KKx57sDyZn0nHYlcDoZfp6FXrmTzUMm4Bd/qS7oaJAfH4dzqtWQPehkNFmwUZ6mD8MR9G2mwtUd+ydGw9QR8YWqHh/cq+WfU2kXMPrA624Vgb4VOIzu1uRdQXl/taMifSRLKQVg5ur7LI=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2820.eurprd04.prod.outlook.com (10.175.41.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.18; Fri, 18 Jan 2019 02:39:58 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 02:39:58 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Topic: [PATCH v2 1/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Index: AQHUrkSK5gjXIA2AjUOFpVeBl/CheKWzoS2AgACr9oA=
Date:   Fri, 18 Jan 2019 02:39:57 +0000
Message-ID: <AM5PR0402MB28658F89C6853D65BB381DB4F19C0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190117091135.44209-1-ran.wang_1@nxp.com>
 <Pine.LNX.4.44L0.1901171107150.1207-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1901171107150.1207-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2820;6:W3JS4XyuxjnrBP+efMB5UWhdyUuzxA2w4duYfdiaYvwc+goHQPqy9z7IrWV50EGvwlX3l+oJlW6i1eBGDeTYK9C+bwuVicUqZdtfKqO0l0rZC9j/G0Ofx84luQZzAGhDTNz/AouWcAfifOpPHSGKf7ZEWFhz8PEVscLKpTTUXxXcAoOqc5BZIQAw+RZbnadexwzo2tMR/RbJYogJikiC/AqI86UZbA46GO616TuyazohwRfgUmlrwcYxEJ0rL8Aun7Mn9KZaI0IXi4v+X9rNXGpVxJ6TiXWSG2YK0Xim2yONLECdB/xVwpBaZcwwIFozi0yVZXotm2K/++UDkzr+TVSa5rzqKpRUXl7C6Di/+bwngrystFSpPmNGVJ2911nigwnnIDlpZTu8W7qgLFKCqDL6Z7WyZv3L2NBI8c1NBHlg0Nb0ozHn+m2WYEkQH/B49xgpHt31Y9uHWP+o2wCP0Q==;5:eKpYTybbJGDC0Z8qWuBgMv/iM0UFEkaXVR/1CiZtD0PcBIunwD/2Xg4uudj6HX+AOuSlHrj5jAEpxkjQcA+sAte2gyKLQQaxKFMgMAKCaPc4JTfLw715DYUnnVJceJeITGVa35TIn1LmvuXdMbuEj/PNQBCXtFhlKRXFK0gLhNhiX/ud5Z8Od58QCA19YIHV15EgO+31oCJZ1VZH9qfDpw==;7:7usDoS0VrSTScKTI7PTsrTw9jRtT6HBG8llCbWbyF+mBygKMtGwgxhcwiBDDo5JzpSz+JCFSIjUGGoLvCsoYBWJ1j8yZYBH2CqRg4QuRlqmwSavpQytTFdbAIWTv3CHvnzrOIdgcCnTCd3rMTXX+lA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: de1ad6b5-bf1d-417c-306d-08d67cee3c9a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2820;
x-ms-traffictypediagnostic: AM5PR0402MB2820:
x-microsoft-antispam-prvs: <AM5PR0402MB28204E21737DAB2279BBCF8DF19C0@AM5PR0402MB2820.eurprd04.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(199004)(189003)(6246003)(102836004)(2171002)(478600001)(68736007)(14454004)(4326008)(229853002)(53936002)(9686003)(106356001)(305945005)(7736002)(486006)(54906003)(6436002)(66066001)(256004)(86362001)(55016002)(105586002)(81166006)(8936002)(7696005)(97736004)(99286004)(76176011)(6916009)(186003)(33656002)(25786009)(14444005)(71200400001)(6506007)(8676002)(446003)(11346002)(476003)(2906002)(6116002)(3846002)(316002)(26005)(71190400001)(5660300001)(81156014)(15650500001)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2820;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Y4pmgjNGzmAN4A+UQehLCVkZ/rggwv27KyWvWVyR6CZfH/oiTr/TI5WDpOztHbpd82gv9P1RsipYU9i14NFjPBSCRX1wemX4FpF+t4E9RLxo1FK4WQ3e71Kpp5AQS0gQ0cP2yo0SdR2diCQK5SbJ8cHLsGbryRfBZizOeRxo53NoSXBeqqmZ57Q0qDxPs8zF3LoW152lfCZCYormVp+mJqXQmRaM+LLD/pVxqT0uuP8isnlJe4jj6GdZbtSVYaEUJNlOzLwg2BQGquI9gm7lgpk5tWhyJP+xPt+Qwe6h7vdYDcewzkSd34b1+2cBEfdNkSYkdP+e2pVGy5m5otHkyIYjIFMe+Rsl8XM/nrbnrcGKkaQDFG5aP274BZv/Wvhi/DsilFE4HVscxq71qDUS00xyKxl71Z3m+c2fonG8x8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1ad6b5-bf1d-417c-306d-08d67cee3c9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 02:39:57.9271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2820
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On January 18, 2019 00:08, Alan Stern wrote:
>=20
> On Thu, 17 Jan 2019, Ran Wang wrote:
>=20
> > arm/arm64's io.h doesn't define clrbits32() and clrsetbits_be32(),
> > which causing compile failure on some Layerscape Platforms (such as
> > LS1021A and LS2012A which also integrates FSL EHCI controller). So use
> > ioread32be()/iowrite32be() instead to make it workable on both powerpc
> > and arm.
>=20
> For patches 1/3 and 3/3:
>=20
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>=20
> Have you tested these on the Layerscape platforms to make sure they work
> correctly?

To be honest, the first goal of this patch set is to fix compile issue.=20
And I have verified it on LS1012AQDS, and encountered failure as below:

[    2.966755] ehci-fsl: Freescale EHCI Host controller driver
[    2.973113] fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
[    2.979851] fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus nu=
mber 3
[    2.987549] fsl-ehci fsl-ehci.0: irq 22, io mem 0x08600000
[    3.005769] fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 0.00
[    3.012122] hub 3-0:1.0: USB hub found
[    3.016088] hub 3-0:1.0: config failed, hub doesn't have any ports! (err=
 -19)

However, actually the only board which I can find so far has known HW issue=
 on
EHCI part, so I plan to find other platform to do complete verification whe=
n
possible. And will submit other fix if needed. Is that OK?

BTW, for powerpc platform, I've tested on a T1042AD4RDB and USB worked fine=
 with it.

Regards,
Ran

