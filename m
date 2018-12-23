Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4EDC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59FC222A2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 16:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ZYgV/z9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbeLWQVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 11:21:20 -0500
Received: from mail-eopbgr690111.outbound.protection.outlook.com ([40.107.69.111]:49380
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728109AbeLWQVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 11:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XtQ+M50ougNclk/kvu4AQe6f/cdM2CPKgOxMJem4/s=;
 b=ZYgV/z9m61nqR65S7fJs5lOMiuYxKk5mtr6ZLmZu7Zv9yKosqx7Bu3MD2zwO0cT2GkUMS8SNOzpnwUJtiNOp7+F5xDRczzFdXq2qkTYVWLg4ceEQsUFCRZKiFavR+ImalZosoUw4VITdVI+d4jJ+H8WuIpwhmRf2ObFhlsW+SS4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1181.namprd22.prod.outlook.com (10.174.169.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.21; Sun, 23 Dec 2018 16:21:14 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 16:21:14 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Firoz Khan <firoz.khan@linaro.org>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v5 0/7] mips: system call table generation support
Thread-Topic: [PATCH v5 0/7] mips: system call table generation support
Thread-Index: AQHUksNkwRxr1H0Clkm+GMhsJsm4RaWMkAAAgAABfgA=
Date:   Sun, 23 Dec 2018 16:21:14 +0000
Message-ID: <20181223162108.c6tzowjcgii5f3ev@pburton-laptop>
References: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
 <MWHPR2201MB1277088F42DB7C2850037098C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
In-Reply-To: <MWHPR2201MB1277088F42DB7C2850037098C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::19) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1181;6:f1B5UKaJ8uACs8eMXaf2AQzdtPcMnSXOfyZynxBqDiowAcsZWunlENe95YopvqTllYO9aNLFgVtsOe3oE+xbRFt9zFAsk4rWeh7ahScXbZr9/s1v9S+R19pMTtOeLsjfMeMXqWiLBBIs65/9LRY6EcSMsZqiF7HLHIM/EPFmzSHGsELRxQei4kSa8E+yZNjxPjn5SD/oz+2bHQaPigFTtbmORkMFG0vjIDS62W1yZO/HKXRr5klQ8CeAencwI3UXo83nTE/EhB/OSDXMg6cgbk4FvswpjXym3A0RW0i3DG1g1yNhlSQXNMi9rWknIj9AMBUkxtcRjchdLB2tBINN0QOk1OnNrZ1eG49UKDAfo+jEn+xVZY1aKto/B2ECgS6x4iMdpL7Ir4OpZMsdBfu4SlKZ2sYztIZC/XOjVrVpe7pF3DB7ngUp5rDYXfpkYJHdbybZOEEpINxEmiN48QYfYQ==;5:vv+6OoqmGNAYSqp1h0/UXriUHscUxkQqHoXsvcP6KXmUZ7sxCgn0uFQbN4x0XscJx6BpUwct1T3IxVZsmsknvswD0HfGIpV04gh/I1mM8KuwvTYLs9dDsHjt9i6o4AwDUMVJb6PskNqf1FFx0v5jZngFw9BQ7nEEbzKRpXuF+KY=;7:zB2DjBwe+C5j5oKW0EF4X1R6foZbkk8rwQ3QltAABm4uxX7YRh5/Jm8H26q4C2glumBzHJGhZ5pNDojLUYPyem8zoijItpAeTKM9FYZLDuz/nBHsdBDSv0n+UBdsKF6/wPwAQuAz4kNFHN+ravZaQw==
x-ms-office365-filtering-correlation-id: e96e5b75-f186-42ec-3b50-08d668f2a8aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1181;
x-ms-traffictypediagnostic: MWHPR2201MB1181:
x-microsoft-antispam-prvs: <MWHPR2201MB11810FC72EF13867B81F6090C1BA0@MWHPR2201MB1181.namprd22.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3002001)(93006095)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1181;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1181;
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(396003)(39840400004)(366004)(376002)(346002)(189003)(199004)(69234005)(44832011)(256004)(8676002)(229853002)(14444005)(97736004)(7416002)(105586002)(106356001)(81156014)(81166006)(7736002)(486006)(386003)(508600001)(6506007)(68736007)(305945005)(14454004)(4326008)(2906002)(33716001)(76176011)(33896004)(52116002)(9686003)(6512007)(186003)(1076003)(6246003)(39060400002)(99286004)(54906003)(58126008)(102836004)(42882007)(53936002)(26005)(6116002)(316002)(5660300001)(6486002)(8936002)(11346002)(71190400001)(446003)(71200400001)(3846002)(476003)(6436002)(66066001)(6916009)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1181;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RtUr5ci3Abe+6tcp5jfDizojWbXyEd/vk0gtI2OrM7/y7cenQf/0zCgIwH2KVZRDbdKtmf70pnLmkCczF098gc4aZck6/zBj6bWCoSzhzfUWykRSLYvZSrZQbBuHV6k0+Se1xaEb48OrZNYW9cX1TdcCbPNkOSPx5VLHZ9vtOO6kKtez++LN+b3vEBypuPdpAUthCxtfH590wyCJ+60gAKFHQ99U0aRAFEUp9aYNvWmGSOSpBaEg4rJKcg/F4PXWp3Z1OJwM0SrLGigUjTPrP4sCkDEYH/J4KOIBfV4K3nyLxP+gWKnLAGYOSzgRBv2J
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80E09EDBADDB7148B4CE25727F5ADD02@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96e5b75-f186-42ec-3b50-08d668f2a8aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 16:21:14.2978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Sun, Dec 23, 2018 at 08:15:48AM -0800, Paul Burton wrote:
> Hello,
>=20
> Firoz Khan wrote:
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
>%
> Series applied to mips-fixes.
>=20
> Thanks,
>     Paul
>=20
> [ This message was auto-generated; if you believe anything is incorrect
>   then please email paul.burton@mips.com to report it. ]

FYI this was actually applied to mips-next on the 14th & is part of the
pull request I'm about to send for 4.21, but running my ack-email script
is still a manual step & clearly still could be improved :)

Thanks,
    Paul
