Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5B5C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F083B20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nvQ+LXow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F083B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbeLCAvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 19:51:47 -0500
Received: from mail-eopbgr1300107.outbound.protection.outlook.com ([40.107.130.107]:20682
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbeLCAvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 19:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shI7OLHGEHRb1sbIPBNpv0bcDAK5u8rEb+dcYgD+L00=;
 b=nvQ+LXowPHX3c3XMegRQAe7qc/cP8bXwHvdOYmOidwpEhuBkq275lqBPZ8AwNCN8qn9xuYIdMmKwaCdGSu9U7FN5kdXU4Q1Thj8/q0hx6XHaoyKVbW6sHyeFLBkHthIgTOTTjGg+jAo7sF0xJxgoDqSyuPCrn8hLCikDhOqbzzY=
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM (10.170.189.13) by
 PU1P153MB0155.APCP153.PROD.OUTLOOK.COM (10.170.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.2; Mon, 3 Dec 2018 00:50:52 +0000
Received: from PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b]) by PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
 ([fe80::3d50:29f2:1244:8b4b%8]) with mapi id 15.20.1425.000; Mon, 3 Dec 2018
 00:50:52 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of
 channels to two workqueues
Thread-Topic: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of
 channels to two workqueues
Thread-Index: AdSHnLf8sFQRqiTYT1imO/A1WbZ3vgAGqdqAAACQe+AARPSgcAACV9+QAE6h+oAAAjt60AAOhFUAABM+GiA=
Date:   Mon, 3 Dec 2018 00:50:52 +0000
Message-ID: <PU1P153MB0169BD8B02249DE8D72B303FBFAE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <PU1P153MB016946D99D63F9713E32B99ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181129074435.GA12347@kroah.com>
 <PU1P153MB01695E455F77117812AA0D1ABFD20@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <SN4PR2101MB0815A8C285162E3B48CD209AA0D30@SN4PR2101MB0815.namprd21.prod.outlook.com>
 <PU1P153MB016907FDC34F47CFE71B82EABFD30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181202073345.GC31761@kroah.com>
 <PU1P153MB0169244CF3902294F42D114DBFAD0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181202153320.GA24440@kroah.com>
In-Reply-To: <20181202153320.GA24440@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-12-03T00:50:48.4873461Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2601:600:a27f:df20:5896:cf8a:cefe:fd7]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PU1P153MB0155;6:n3bkNQWoxb2Alf9TNdx1MB9bYvanVpUrEeubnFx3JP8y9lqEtWSmyIUZmqgjL15cOYP8ErjOkwOQvV8r6Rb5JgxVI6+5KGQIr5qz6memjUPaY4vWLsg3QUVX9ShCI1OGckTAQ92Yr5OJkCKPc0bnE50njuOw7Rd8kea/BjprjrUmwU62dRsBggifh6yVNr2Jh8kbejRNtOvHflFR1dIAEeW6EixwycQrY+CGprcTzoPxV12tvGJp3wVkmh9gvZXTcxdBkM4/H19laHsD0chdYgCxwsD58YzmrfbmF36pcr+tJWeLFITs1eLrG3XN5gvKg6RuETdas0KyghgJK3srUSVqH7meoj09LQE5q0ddwSJ4lFNw8ZPNJoqht8lTe75nTh89k4prhezA22MDxLFesEX3XjynlQJKwQw5Tw+049Zvhp6MY81tFpcBs2v5rUEmy5kvZGDJeltwIfeFwskzDA==;5:To539hEvHkOvfRCp6Jh77L9tXjlKiAkNxQkk/7NZXgfy8UkFcRXOrdWLqNlSh5UBSZrBH8Z6xEqIpZhczWgV/qjUvXoC3J5R5vMwHkwyF3s6HWZeISDIEPWXXULhk97FeyOz+I4rUfdH7o2y8FS7Nu9zBoKGX44qyEaAR9vt6XQ=;7:JMb8aXXz7zn3V77iW5liGwkxKDs12pnsVlJs+gFmBKofQ3x9DEoUo3LJVImSTNJZ79GpR1omQ4E7J5OzLTew2tmXIciaR4ohnkRyva75lBfF2gIKZMQl3qtB5qjesOw+SAtU+bLgJYCM2v1DHK10hA==
x-ms-office365-filtering-correlation-id: b28ccb4e-b391-4078-8a96-08d658b9602a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:PU1P153MB0155;
x-ms-traffictypediagnostic: PU1P153MB0155:
x-ms-exchange-purlcount: -3
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PU1P153MB015555B5B09C3CC930AD084ABFAE0@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(8220035)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(944501493)(2280197)(2018427008)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:PU1P153MB0155;BCL:0;PCL:0;RULEID:;SRVR:PU1P153MB0155;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(11346002)(97736004)(107886003)(10290500003)(81166006)(229853002)(476003)(71200400001)(486006)(71190400001)(46003)(6246003)(54906003)(25786009)(2351001)(86362001)(8936002)(446003)(102836004)(2906002)(14454004)(6916009)(53546011)(68736007)(8676002)(86612001)(81156014)(1730700003)(478600001)(6116002)(105586002)(74316002)(7696005)(6436002)(93886005)(33656002)(5640700003)(10090500001)(186003)(106356001)(76176011)(8990500004)(256004)(5024004)(4326008)(99286004)(55016002)(53936002)(5660300001)(9686003)(22452003)(305945005)(316002)(2501003)(7736002)(6506007)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:PU1P153MB0155;H:PU1P153MB0169.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: YoJTTc/sO/jAcPfDAdkAaf4hxv/4Zanw0qPpBgNLXCQD72XmFc/6Ww7DUQAWD5HHM3f1AfreDi+KMSnU7HHbpZnnO/5chrzb2AdFUyC83j8CjJ8NOfMtMbbeDdDHvWs6bvXm07qrg3o/aQQ+K1V+aid0p8e/3rIAh0qrvq453jsRzr6G6tCocMNNCCgszTLRliJZezhpCKjy4tt1szHgECIHgpJlk0KEWcuihM5ymCWGCbBKbh5cDNGmJLFmnXACiONmJGT3HQrM9+OF1ox5qM/VYwW30cAIy8g5bHOFcqRU0NVmNsACI8ETHOkruH5p4+L9tCt13e+YlYpOUQp6AiXSSNZxllpBLY9z0isoptxrYPtLDKiXuMFYGBj7ZBWfHjq2aBzM6nObvcJCRPoIHLv9Rv6ShpV4Rnvjj0dSmYOWQn2iTfAHLCZ+g/GbBFxbbVjA0SXDMdHI52smNuzzzEFD+N97Jk5Eik5mBzIH7ALCVMlGHOIJAD87R1EgJKMPpZD3P/bMA4bNcdNyMjMBZg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28ccb4e-b391-4078-8a96-08d658b9602a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 00:50:52.0365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1P153MB0155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Sunday, December 2, 2018 7:33 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; apw@canonical.com; vkuznets
> <vkuznets@redhat.com>; olaf@aepfle.de; jasowang@redhat.com; Michael
> Kelley <mikelley@microsoft.com>
> Subject: Re: [PATCH] [repost] Drivers: hv: vmbus: Offload the handling of
> channels to two workqueues
>=20
> On Sun, Dec 02, 2018 at 08:47:03AM +0000, Dexuan Cui wrote:
> > Hi Greg,
> > Please use the attached patch: I rebased the patch to today's char-misc=
's
> > char-misc-linus branch. It can also cleanly apply to Linus's master bra=
nch
> > today.
>=20
> I can't use an attached patch, you know better.  Please fix up and
> resend properly.
>=20
> greg k-h

Ok, let me re-send it right now.

BTW, Linus's tree was updated to v4.20-rc5 98 minutes ago. This patch can
still cleanly apply there, and on your char-misc-linus branch.

Thanks,
-- Dexuan
