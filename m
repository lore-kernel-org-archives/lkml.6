Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1B0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D6E20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FAx3DJ1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfAQIGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:06:15 -0500
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:40911
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726196AbfAQIGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYRcCn3v+lk0ZzXx9tzWrKiKUVs34nR8V5qb2b29LTw=;
 b=FAx3DJ1z8P5mXSfG6LoclVr9b2jVc+aZuKhshGbCkeEwpE3bX8PAVr8tc2hXCrZqNWpdVZp6kKEjZpyOG3GtBQJEOVnCajjpw3L5ZPT8sTzXu09+s7iJjxYgcQWi4zz5IQ/OJQUbfR54WEEnZDXdu2C3eD6iQdFiSVvZ2RIqX1w=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2833.eurprd04.prod.outlook.com (10.175.41.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Thu, 17 Jan 2019 08:06:11 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 08:06:11 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Topic: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Index: AQHUpxgC6yBGLPIm9UWYEo0ogu0Vc6WlhCWAgA2jZwA=
Date:   Thu, 17 Jan 2019 08:06:10 +0000
Message-ID: <AM5PR0402MB28657886AFEA567C4426DF73F1830@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190108060426.11581-1-ran.wang_1@nxp.com>
 <20190108060426.11581-2-ran.wang_1@nxp.com>
 <20190108154523.GB20989@kroah.com>
In-Reply-To: <20190108154523.GB20989@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2833;6:/81EfGqLGP4tYDKWydtT7e4HPZwgaJsfv7X3sIXxvtcaq915EacH4SbKd/5ix61EFWlynf6R8JHtRJE9KwZd9jgfb1o22OjgoecJjGVGsYOHnQgyNixUaWI7A67Obh9UiUinHexC06ksag/2634t7LYOnPBbEW+efudG0DNuzPFkBt6njTkDyFjq/PfVIVleUsU4HlCPsdy7Krv6XgV+PbJ0wrlj6ODOTpc3EKSzruA3WNcfXKGCuF7U18PJkCp4GSdlr/DXyP434gd5XBMMYhUi9WipxGiGe2bw3IompWlYLWiSRiwxIZDHrUL7n0k3KqR91556oFMN8qzXRSRwY6xhn2ENdwTq8BQ6afkQC2W1x2S2ELDhtUHpKskXaHBl7m9KTV15JQAoo79Mt89f5EjLvAjklLQtuNkkNoY2IgLMqNA6PgyKtqCeu4ohmsyFqjnMQxIej8unxy5JAd84Bg==;5:6n1GbQSmVAeMynsORSS7DqhAm6nGHw6XBATCpbt59blMPMhvl0Vu0WyxumeyOBaGkkEtOz9u6CUB/dNl0YJvOe/mtRn8QAVUjfHAC5BQO5ACFAUd8VFXXKnBTzo3SDEp5lpRmEtChPcTgJp9HB80u4ktSXunOwctI41qSGoc1x86S4tXOAI8+xAVIZ6ibusWTHLgOQ53auU29Lgw8Z5BxQ==;7:UwNA7IqDyjx9Jy+Onfma9wfgFesnf0Ma/cUIbBzWHmsTe20lVhWl0mCQruf8UzfqJdcptFZTjMiumq730vir3YYZxCeodIuxNcU20QWvoGR7PM6FfeXuCSrTmZlHGvEllT2FggAq4tdp8B3yw0BbIQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2de1a343-7fff-4a86-fcd8-08d67c52a4a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2833;
x-ms-traffictypediagnostic: AM5PR0402MB2833:
x-microsoft-antispam-prvs: <AM5PR0402MB283346E6977447D80B69D894F1830@AM5PR0402MB2833.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(199004)(189003)(316002)(4744005)(54906003)(486006)(33656002)(99286004)(26005)(6506007)(6436002)(7696005)(476003)(6916009)(53936002)(446003)(11346002)(8676002)(9686003)(4326008)(102836004)(68736007)(25786009)(229853002)(305945005)(55016002)(2906002)(71200400001)(81156014)(186003)(81166006)(8936002)(76176011)(7736002)(97736004)(6246003)(71190400001)(105586002)(14454004)(478600001)(66066001)(106356001)(86362001)(14444005)(6116002)(3846002)(5660300001)(74316002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2833;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LolAH0e1YP1M4YOnv2H75jyyTRv2p6iR5sdZNnlcKgIimeGbVDKNJKZEwW3ktyXQsg1mwJeChnhdeVuUgVGATmkkIpSYhLjnFbXDyb/wi+F/rG4BRjbExenXj7hu4nFUzAvH1g4K7p24wHGa09pcX4eDIJHx8DiZbZ6Z7VMD2MOI/gD3AEeSkUxDA+K6mDlMwNAxwxA99a4t8Ry4QKwuP58Vv7dQXdqQLuowy6sX4QPQhx7iu14kPi1PuFB5JuwnYlGlnmTlQeNpQqXrI0SwbUwqojh6izTdjXMhf0U4hnbt121IWFI512B77+J8nLPl9IiYP2WIsGaiG97fjtRBt9mfm3w1gMxGP8FJHXGb/54TEuSSHo9hakMhZL0epWUUmjIWREtElgJLUZHFIZF+WQcBd2//L8UL6fMSK+Y62do=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de1a343-7fff-4a86-fcd8-08d67c52a4a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 08:06:10.9690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 08, 2019 23:45, Greg Kroah-Hartman wrote:
>=20
> On Tue, Jan 08, 2019 at 06:04:26AM +0000, Ran Wang wrote:
> > arm/arm64's io.h doesn't define clrbits32() and clrsetbits_be32(),
> > which causing compile failure on some Layerscape Platforms (such as
> > LS1021A and LS2012A which also integrates FSL EHCI controller). So use
> > ioread32be()/iowrite32be() instead to make it workable on both powerpc
> > and arm.
>=20
> Shouldn't you have this patch before the Kconfig change, so that you do n=
ot
> break the build on ARM systems on that one and then fix it up on this one=
?

Yes, you are right, will adjust it in next version, thanks for pointing out=
.

Regards,
Ran
