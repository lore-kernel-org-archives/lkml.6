Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CBDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF67924066
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 03:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PvoxrUuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF67924066
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932348AbeGFD73 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 23:59:29 -0400
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:55968
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932171AbeGFD72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 23:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfowsBHNA4w0XAtR9BnMry7xRGJXvWIfS1b6CyNNVRg=;
 b=PvoxrUuuqCJ4otpUBH+Ojm1cb5qTtAqk/tDGuV99tdnpg5PmbP36jchUCmwzf2V4GzQ99uUASyDDRh7H3Ha5JJbERTJL2aeeYCAYJ+EV4IiWEhkS0Yb7D5A6V7RtfMn3s3/ZzzqbeQKTJbKG57pr9dJwDr6T3G6IxqUD6EzvVUA=
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com (52.132.149.30) by
 MW2PR2101MB0892.namprd21.prod.outlook.com (52.132.152.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Fri, 6 Jul 2018 03:59:24 +0000
Received: from MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b]) by MW2PR2101MB1113.namprd21.prod.outlook.com
 ([fe80::948d:3fab:e048:bb9b%2]) with mapi id 15.20.0952.008; Fri, 6 Jul 2018
 03:59:24 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
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
Thread-Index: AQHUEyH9R1sw7hnGhUy3uKImudYi5KR/PNWAgAF9s6CAAAuaAIAAQyQAgAAt7wCAAAaDgIAAVr2Q
Date:   Fri, 6 Jul 2018 03:59:23 +0000
Message-ID: <MW2PR2101MB11131ACDDA6734BD588919F5A0470@MW2PR2101MB1113.namprd21.prod.outlook.com>
References: <20180703230155.15160-1-kys@linuxonhyperv.com>
 <20180704161039.GA23658@gmail.com>
 <MW2PR2101MB111396005B0F5572C92B4CD7A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705153820.GA26768@gmail.com>
 <MW2PR2101MB1113ABC82EC62E2C8DBA2400A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705222302.GB5410@gmail.com>
 <alpine.DEB.2.21.1807060043290.1771@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807060043290.1771@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:600:a280:b50:24f1:b44b:61e5:601d]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0892;7:8KxNraotDtWa8HAvxlpfOsOw/HycfRRqbzk9jMlTLIH5HA2HVv/Pr535hrtmcoP7vXIPaJJhyr015kpe7nHZjJ6R8RSDxGMkziOav50dkWDsBCuKBWZJIeUEnQ9HBtfk9/N0j9ftNRo28hGscg0sNU0tiCICcUUa9K/u74OgS8bvSbdwQ3EK8NhjfSxZ1Wa9c0CmLhye/5jzkDCLgrezipcjBbV4saKMNCTUkAHN+O02kf/Tf3BJ8toimkUTIU4g
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 4de12bff-2367-4fd1-eb7b-08d5e2f4dc7b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7193020);SRVR:MW2PR2101MB0892;
x-ms-traffictypediagnostic: MW2PR2101MB0892:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB0892F7E13E3C3655E04E55E5A0470@MW2PR2101MB0892.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231290)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB0892;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0892;
x-forefront-prvs: 0725D9E8D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(136003)(376002)(366004)(199004)(189003)(13464003)(10290500003)(478600001)(106356001)(186003)(97736004)(105586002)(110136005)(54906003)(46003)(14454004)(53546011)(6506007)(25786009)(316002)(5250100002)(99286004)(8676002)(256004)(22452003)(11346002)(446003)(476003)(486006)(81166006)(81156014)(93886005)(8936002)(6246003)(9686003)(74316002)(10090500001)(53936002)(6116002)(86362001)(33656002)(7736002)(2906002)(4326008)(68736007)(305945005)(6436002)(5660300001)(55016002)(102836004)(7696005)(2900100001)(76176011)(8990500004)(7416002)(86612001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0892;H:MW2PR2101MB1113.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: H4f2YWKDVbtk9KMN4LppSV47fwiIcnvndL7ZhpPXYrwbRVkhTZdHCPLOUQ2fr1nP9uuOjIhwofayppYRkh0Q4JV7EQZqXN/DNn8hniTNUGUP8a9tCnZsJHGybYxsN5KWKZFJc4tm+0bAkQsvrMzAlXVCxCxZgdH/NTEl3imk/hXy9xf43Dyf31LL4qZC7WYMkM/0DZV1WxHm2BuDhkU5RyeCZRFeEY+p8kBZGPYtk0LYR4IAmH5YnTH7lhh/xkM6bXHYnnDqS7cuv4c5v9zRQXWMjjECIIjJHPgl4aYO9d7mAtD6fTU6AtUjYkOYDMxRa+5LUVFtbtEzVMeJsgQ6BY1sv4EM4LET5+IqFxgHV2A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de12bff-2367-4fd1-eb7b-08d5e2f4dc7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2018 03:59:23.9217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0892
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, July 5, 2018 3:46 PM
> To: Ingo Molnar <mingo@kernel.org>
> Cc: KY Srinivasan <kys@microsoft.com>; x86@kernel.org;
> gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com;
> jasowang@redhat.com; hpa@zytor.com; Stephen Hemminger
> <sthemmin@microsoft.com>; Michael Kelley (EOSG)
> <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> Subject: Re: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
> enlightenment.
>=20
> On Fri, 6 Jul 2018, Ingo Molnar wrote:
> > * KY Srinivasan <kys@microsoft.com> wrote:
> > > I am confused. The label ipi_mask_done was introduced in this patch
> > > (the patch under question fixes a circular dependency in this patch):
> > >
> > > commit 68bb7bfb7985df2bd15c2dc975cb68b7a901488a
> > > Author: K. Y. Srinivasan <kys@microsoft.com>
> > > Date:   Wed May 16 14:53:31 2018 -0700
> > >
> > >     X86/Hyper-V: Enable IPI enlightenments
> > >
> > >     Hyper-V supports hypercalls to implement IPI; use them.
> > >
> > >     Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > >     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > >     Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> > >
> > > This patch was committed by Thomas some weeks ago and is in linux-
> next.
> > > This patch is also in 4.18-rc3.
> >
> > And then that name was changed to a different label in:
> >
> >   4bd06060762b: x86/hyper-v: Use cheaper HVCALL_SEND_IPI hypercall
> when possible
> >
> > So maybe you were testing on an older kernel. Could you try the latest =
-
> tip?


>=20
> The problem is that the wreckage is in Linus tree and needs to be fixed
> there, i.e. via x86/urgent.
>=20
> Now we have the new bits queued in x86/hyperv already which collide. So
> we
> need to merge x86/urgent into x86/hyperv after applying the fix and mop u=
p
> the merge wreckage in x86/hyperv.
>=20
> I'll have a look tomorrow morning unless you beat me to it.

I can rebase this patch against the latest tip and resend (tomorrow).

K. Y=20
>=20
> Thanks,
>=20
> 	tglx
