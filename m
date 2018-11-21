Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5FEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157B72146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="lrzN+d04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157B72146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cavium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbeKUXxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:53:32 -0500
Received: from mail-eopbgr800050.outbound.protection.outlook.com ([40.107.80.50]:36042
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727100AbeKUXxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kicw/Fknuy4Gw6/laOU3gZ4allUlfO0pr64b1jkaBU8=;
 b=lrzN+d04YXHO6V4H56vmJ4hYRrt6hPuuqacAlzIRmxilsEjYVu2LHl9L/nxe5fDej6RQzzBd+qUtoaPTHBfEX08kntkzmz/bViaqTnGK1fwlMRu2Zy0j8//OjiD5ouFfE2NxEbVd2ZfXGBGTareQ+EJPCeImlnqvPWVgxcBJB4E=
Received: from BYAPR07MB4599.namprd07.prod.outlook.com (52.135.204.25) by
 BYAPR07MB4407.namprd07.prod.outlook.com (52.135.224.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Wed, 21 Nov 2018 13:19:06 +0000
Received: from BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::1513:e267:a343:917]) by BYAPR07MB4599.namprd07.prod.outlook.com
 ([fe80::1513:e267:a343:917%5]) with mapi id 15.20.1294.048; Wed, 21 Nov 2018
 13:19:06 +0000
From:   Jan Glauber <Jan.Glauber@cavium.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dcache_readdir NULL inode oops
Thread-Topic: dcache_readdir NULL inode oops
Thread-Index: AQHUeDnKfcShvdBH+0+6hZ8Ik/l9/A==
Date:   Wed, 21 Nov 2018 13:19:06 +0000
Message-ID: <20181121131900.GA18931@hc>
References: <20181109143744.GA12128@hc> <20181109155856.GC2091@brain-police>
 <20181110111656.GA16667@hc> <20181120182854.GC28838@arm.com>
 <20181120190317.GA29161@arm.com>
In-Reply-To: <20181120190317.GA29161@arm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:404:121::15) To BYAPR07MB4599.namprd07.prod.outlook.com
 (2603:10b6:a02:f2::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jan.Glauber@cavium.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [88.67.135.23]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB4407;6:ZYoq2+0sYnOYdDR8d1KQ+W3y8+bOVsmDdYZ67VtTN5ugLgPvmYH5ZGpp6ZSSNUkfs5kye1j4cJ7AjXIajNQFRpNKJx7IQecOAD0bEjPQnJtOVPD8ewz77qBcS8aRE9NAkAuSrB1Z1FF8d3ivEnZsyMVWU1dHZQiaWlRFWgdRzBFzMF+55AbUxsdcc0BYQED2JwCPlnvUOlZOr8pKLPSoEspVik12a99g3vVJydyT+AFXNS9QGNQO5CMli79kfRw/EI4tQ9DvIcGQ8BJ7Fgl45DMbFQXO3usTebXyI2YkfNmnsHHyKFn3wQ3KLGmO+LYx0EtvHF0/v0fDljEQM4JdiaUl3P/RXzmEUwaBG6SHnmcxL9NLPApeJCyvfWDTC4aoXz1xoQmt3slfKgy/GDZ1+mqWIgFeuZsehQutp/FNORdXyGG02IrzZcywZywx6l7WezE+eMyeFIy43nCzEudUAA==;5:MmFNjP94hsFcFISb18SqZjrcbO3kpePFHKSFuuydwSI97glow+jf+I2Y8nY+ttfKWqRxkCWd5uOnsepuS8l1kjOLEyb+Z0uJ0QeKQe3KjoL+tzhiIlw0ONch9mI1gv7ZBQLn2h8tl2JlcCcd6EGaUu5CuwyRkNSym/9R28UR/+A=;7:s6d7v8a8BLoiPz6cUKFvNA9bgJJGSck/8bNncNZ1IDug8LC5MdHIvatVo5q32iuBYTBYv99v9Wp6yGXBeaAG57obIoctep890JKz5ItTVOATL79PLtSQwxSbi+TWDS5ZSAxuFURTXpU4acX+0HDp+g==
x-ms-office365-filtering-correlation-id: c601f718-3556-444b-d5c4-08d64fb3e9a0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4407;
x-ms-traffictypediagnostic: BYAPR07MB4407:
x-microsoft-antispam-prvs: <BYAPR07MB44073F01BEFDDED2D474D35891DA0@BYAPR07MB4407.namprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231442)(944501410)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BYAPR07MB4407;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4407;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(366004)(39850400004)(376002)(396003)(136003)(189003)(199004)(55674003)(6246003)(53936002)(229853002)(4326008)(52116002)(76176011)(33896004)(6486002)(186003)(102836004)(478600001)(81156014)(8676002)(256004)(14444005)(2906002)(386003)(316002)(81166006)(68736007)(97736004)(8936002)(33656002)(7736002)(72206003)(25786009)(93886005)(71200400001)(305945005)(6506007)(71190400001)(54906003)(6916009)(486006)(6116002)(3846002)(476003)(33716001)(86362001)(2900100001)(446003)(66066001)(6436002)(14454004)(11346002)(44832011)(1076002)(26005)(99286004)(6512007)(9686003)(105586002)(5660300001)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4407;H:BYAPR07MB4599.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4s1orKfJxWPn8ZlmQODN4UdVxJLIIluNXU21cMZwmrTxH2Yc/gSrUxPAHLC8biPNQt+FeMJocnLFn4qzUfYpFdMC/yZdabdn8OzzW5h4KmOgWyi0zQr6aIW47yxcIxmSueYe2q2LvriwanHt0ugpw8sM/dBczyVGleyQkWO0kBKJvC9TfWa1NuQbb+B1SsbGN1ZYFcoKC5bu4h9sYHh1wP9YYDZfaRvuLZ6J9O27RvxQgtWLDo2X/i/qT8j4Ak11U5Q6gS9bGhB44lJZCV+vxp9qYMP7SUMIKT4sQhRqYMxXrwaOOmzfgfidIGtbhUn2YEqnsCETmCtwZsqrl5+1H6C/vjnTHm2U//gdXrU0h8U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <44C8F01F8BB08248B4B5DFB4703FFDC3@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c601f718-3556-444b-d5c4-08d64fb3e9a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 13:19:06.5081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4407
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 07:03:17PM +0000, Will Deacon wrote:
> On Tue, Nov 20, 2018 at 06:28:54PM +0000, Will Deacon wrote:
> > On Sat, Nov 10, 2018 at 11:17:03AM +0000, Jan Glauber wrote:
> > > On Fri, Nov 09, 2018 at 03:58:56PM +0000, Will Deacon wrote:
> > > > On Fri, Nov 09, 2018 at 02:37:51PM +0000, Jan Glauber wrote:
> > > > > I'm seeing the following oops reproducible with upstream kernel o=
n arm64
> > > > > (ThunderX2):
> > > >
> > > > [...]
> > > >
> > > > > It happens after 1-3 hours of running 'stress-ng --dev 128'. This=
 testcase
> > > > > does a scandir of /dev and then calls random stuff like ioctl, ls=
eek,
> > > > > open/close etc. on the entries. I assume no files are deleted und=
er /dev
> > > > > during the testcase.
> > > > >
> > > > > The NULL pointer is the inode pointer of next. The next dentry->d=
_flags is
> > > > > DCACHE_RCUACCESS when this happens.
> > > > >
> > > > > Any hints on how to further debug this?
> > > >
> > > > Can you reproduce the issue with vanilla -rc1 and do you have a "kn=
own good"
> > > > kernel?
> > >
> > > I can try out -rc1, but IIRC this wasn't bisectible as the bug was pr=
esent at
> > > least back to 4.14. I need to double check that as there were other i=
ssues
> > > that are resolved now so I may confuse things here. I've defintely se=
en
> > > the same bug with 4.18.
> > >
> > > Unfortunately I lost access to the machine as our data center seems t=
o be
> > > moving currently so it might take some days until I can try -rc1.
> >
> > Ok, I've just managed to reproduce this in a KVM guest running v4.20-rc=
3 on
> > both the host and the guest, so if anybody has any ideas of things to t=
ry then
> > I'm happy to give them a shot. In the meantime, I'll try again with a b=
unch of
> > debug checks enabled.

Hi Will,

good that you can reproduce the issue. I've verified that the issue is
indeed reproducible with 4.14.

>=20
> Weee, I eventually hit a use-after-free from KASAN. See below.

I ran KASAN (and all the other debug stuff) but didn't trigger anything
in the host.

--Jan
