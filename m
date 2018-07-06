Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D534EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B58722BEB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KTfryNin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B58722BEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934166AbeGFSF6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:05:58 -0400
Received: from mail-eopbgr730091.outbound.protection.outlook.com ([40.107.73.91]:38720
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933921AbeGFSF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ILTKSg7PDEvXjEVSXskbrXevPywlI3suut3Mb+WzHI=;
 b=KTfryNin/4h/pfpUUkjkusaU6yAMxvnOdL7Ln6RymsCn1SdyTG8vcPLWTVdgkHdYHJ1B3DHwIwDpPll8HQtxtvcMhoqOxFkh95t85HxccBSUpimNURirOk+qwm/BtK7NT7PhjL5E6K2JmUlUP+Q79O2rGamWaH8wK3QKRTn+Af8=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB0969.namprd21.prod.outlook.com (52.132.146.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Fri, 6 Jul 2018 18:05:54 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b%2]) with mapi id 15.20.0952.008; Fri, 6 Jul 2018
 18:05:54 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
Thread-Topic: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
Thread-Index: AQHUEyH9R1sw7hnGhUy3uKImudYi5KR/PNWAgAF9s6CAAAuaAIAAQyQAgAAt7wCAAAaDgIAAVr2QgABS24CAAB5fgIAAe6VQ
Date:   Fri, 6 Jul 2018 18:05:53 +0000
Message-ID: <MW2PR2101MB111348B748C29FF13C4807E8A0470@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180703230155.15160-1-kys@linuxonhyperv.com>
 <20180704161039.GA23658@gmail.com>
 <MW2PR2101MB111396005B0F5572C92B4CD7A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705153820.GA26768@gmail.com>
 <MW2PR2101MB1113ABC82EC62E2C8DBA2400A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705222302.GB5410@gmail.com>
 <alpine.DEB.2.21.1807060043290.1771@nanos.tec.linutronix.de>
 <MW2PR2101MB11131ACDDA6734BD588919F5A0470@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1807061052410.1664@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1807061240560.1664@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807061240560.1664@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:24f1:b44b:61e5:601d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0969;7:ipfCm37/smulSYr3HexH6ATWw9+3hSfP/7RnaOBQEeR5zGcdu/QliXJS2O35oIkDwOBwvzZ8P6Qvqys7c7Aj555tClv68AFvvabyzUPeveaCjgLBI5e3qDZ3QP8fnO89ANXhyJ9xVURHRoH4qoAZk29fs5S9aS0rm7mqWC7952nCG1jCxgprLS0ZqY8SvRAYSamifEjj5WpkxAkAWrfRNFfq+TxMImKhftrEFeNnTJtrw4HIWMQN3b8E1JZQLmRE
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5ab94185-c4d1-4d66-cbdc-08d5e36b1daf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:MW2PR2101MB0969;
x-ms-traffictypediagnostic: MW2PR2101MB0969:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB096901AC75944AF207DEFC47A0470@MW2PR2101MB0969.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231291)(2018427008)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB0969;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0969;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(346002)(366004)(13464003)(199004)(189003)(76176011)(4326008)(33656002)(97736004)(46003)(25786009)(93886005)(5660300001)(7416002)(486006)(446003)(6916009)(8990500004)(10090500001)(478600001)(10290500003)(476003)(11346002)(14454004)(256004)(2906002)(53936002)(8936002)(6116002)(68736007)(55016002)(105586002)(106356001)(8676002)(229853002)(81166006)(81156014)(6436002)(9686003)(54906003)(22452003)(316002)(186003)(99286004)(5250100002)(305945005)(102836004)(74316002)(2900100001)(6246003)(6506007)(7736002)(86362001)(86612001)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0969;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BoSOMIOpHalUa0jrfaoN260LyFFuct3b/CBlhATp9CEWVExeurL2Or8N5kM8fovymsUYb8UvJr7/XaHY1CfYqK1kEtAkL0MUmJkjj3sc5/gGBBKwapu2qnZo0LCiIt0V+hiwA8UGc5l5LeSQkpqWydx7qXRQcuhjYgj3dSxnpmKZyaQJ/zpvXMYFGW7U2X5lrv/ZOqG58CVusNdkIMUM4HP985ZLCaMi8RGrk9u29oZlv/f49ce+v8uQ9P0PPQsTDRls1BaqfIPYROgUO7gDANCoTGbYnm7HEvxwQkV9TJWvbM4qFtm03sxs4GU76BTChzYY/kFJOZYmkqfEsVZbsl1oAcmeFh62syzCQtfz0/o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab94185-c4d1-4d66-cbdc-08d5e36b1daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 18:05:53.9927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0969
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> On Fri, 6 Jul 2018, Thomas Gleixner wrote:
> > On Fri, 6 Jul 2018, KY Srinivasan wrote:
> > > >
> > > > The problem is that the wreckage is in Linus tree and needs to be f=
ixed
> > > > there, i.e. via x86/urgent.
> > > >
> > > > Now we have the new bits queued in x86/hyperv already which collide=
.
> So
> > > > we
> > > > need to merge x86/urgent into x86/hyperv after applying the fix and
> mop up
> > > > the merge wreckage in x86/hyperv.
> > > >
> > > > I'll have a look tomorrow morning unless you beat me to it.
> > >
> > > I can rebase this patch against the latest tip and resend (tomorrow).
> >
> > That doesn't help as we need to push the original fix to Linus ...
>=20
> Applied it to x86/urgent and fixed up the '-1' sloppy hack as pointed out
> by Vitaly and merged x86/urgent into x86/hyperv.
>=20
> Please check both branches for correctness.

Thanks Thomas. The merge looks good.

Regards,

K. Y

