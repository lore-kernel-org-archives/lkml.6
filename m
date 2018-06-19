Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60DDC5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54D0820836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="lxtRa2B0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D0820836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=concurrent-rt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030725AbeFST42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:56:28 -0400
Received: from mail-eopbgr710110.outbound.protection.outlook.com ([40.107.71.110]:2427
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030472AbeFST40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector1-concurrentrt-com02e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQEZ50UzOVGGoHqRNP6p+/7zM3XQQG+li1B0AwUDb0w=;
 b=lxtRa2B0CWJYdrgK64nSw+MW9FNEaXOlxb3NcTn32K1ePEtymMb9TmRDOvTIzYPyg+ku5bcmaKkvuscWG/9K1s2hsUV9ug7qoM1lNLSwKtEz3jVP7JUlJ4hHcaXYxfNaU6N1KrLBc3HTytvz/WCxZt0aMxs3ijvARwVQs1QZl1w=
Received: from DM5PR11MB2011.namprd11.prod.outlook.com (10.168.105.151) by
 DM5PR11MB0043.namprd11.prod.outlook.com (10.164.155.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Tue, 19 Jun 2018 19:56:24 +0000
Received: from DM5PR11MB2011.namprd11.prod.outlook.com
 ([fe80::d9fc:b142:3a66:2c34]) by DM5PR11MB2011.namprd11.prod.outlook.com
 ([fe80::d9fc:b142:3a66:2c34%7]) with mapi id 15.20.0863.016; Tue, 19 Jun 2018
 19:56:24 +0000
From:   Siarhei Liakh <Siarhei.Liakh@concurrent-rt.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bpetkov@suse.de>
Subject: Re: [PATCH] x86: Call fixup_exception() before notify_die() in
 math_error()
Thread-Topic: [PATCH] x86: Call fixup_exception() before notify_die() in
 math_error()
Thread-Index: AQHUBBaUW86w1+9ez0usdUxJuRkw36Rmk56AgACQVQCAAKJ8YIAANDWAgAAFfUk=
Date:   Tue, 19 Jun 2018 19:56:24 +0000
Message-ID: <DM5PR11MB201136DAFFB7005FA4E4DCB0B1700@DM5PR11MB2011.namprd11.prod.outlook.com>
References: <DM5PR11MB201156F1CAB2592B07C79A03B17D0@DM5PR11MB2011.namprd11.prod.outlook.com>
 <CALCETrXUdLZTnf0EF2LVM4ru2G6nkFX--gQ=6JpBRNZ7Gm+MsQ@mail.gmail.com>
 <alpine.DEB.2.21.1806190820210.1692@nanos.tec.linutronix.de>
 <DM5PR11MB2011397361BB5C0FB3D4FDFFB1700@DM5PR11MB2011.namprd11.prod.outlook.com>,<B739D98B-BA3F-40F6-82DF-6444546B6B4C@amacapital.net>
In-Reply-To: <B739D98B-BA3F-40F6-82DF-6444546B6B4C@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
x-originating-ip: [65.190.80.89]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR11MB0043;7:jYvmXN5SL0niDi1bcPeEWMrFRJwikM312nF/9i4iVbbX9mjxvYCHFfapxHI1OVEnPSdBXhdCR4TQsbPplVUkLxkUUJN/uXkFXc6enlO9lECKl/0pJgIlGpJ084pm2d55lSZWYB3nXFB+uLPH1/mKwEXqYHKy5abA8Zy6WD4dd2kAdOeWRVZdTpTs0Ir9gZRSKafBWwJtKtC+wNKWQPvyXszClibvDrP/0bD+aKSTRNK7qCnZlsMVVTZja+BgfPwj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d9c53f29-5d85-47bf-de78-08d5d61ebcd5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM5PR11MB0043;
x-ms-traffictypediagnostic: DM5PR11MB0043:
x-microsoft-antispam-prvs: <DM5PR11MB004366FFCDB543BDB3E56176B1700@DM5PR11MB0043.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR11MB0043;BCL:0;PCL:0;RULEID:;SRVR:DM5PR11MB0043;
x-forefront-prvs: 07083FF734
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(39840400004)(376002)(189003)(199004)(7696005)(81156014)(33656002)(105586002)(102836004)(6506007)(5660300001)(74316002)(14454004)(9686003)(59450400001)(8936002)(54906003)(7736002)(93886005)(2906002)(53546011)(3660700001)(229853002)(81166006)(8676002)(478600001)(3280700002)(66066001)(76176011)(72206003)(106356001)(5250100002)(305945005)(6916009)(316002)(97736004)(486006)(55016002)(6436002)(476003)(3846002)(25786009)(6246003)(4326008)(2900100001)(446003)(11346002)(186003)(6116002)(26005)(99286004)(68736007)(53936002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR11MB0043;H:DM5PR11MB2011.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: skpSOek8GhUkFHrkNl/ucK7k+6BcQVUTsOUPJeCHmZOGZ+rgKWVfkmMCblQRG3fxoiOmpbHxu1UX2rq6bG0I2C+Hs/Zxi2G+UFpiN99UsoxoApguZ0XNzo5J/M9Sm/OTEYOQoXyxqsV+2h14A8CumVdRRs3g+OULyRcy+gGfQvrEYybSQgfTRtaRUoSCdYBvfanUuppgwhPaLSnb/ZG81K1bskfqpsI//6ZQYm1/saWDTG6aylBmHlIG9PnUcNwL4EXpfdLFkGo8wzYOyCHk50Zm7v24DDv9gtjxuUKQYiI6K3uQoXxAFpdPlkmhXj1SLhj6TIv3k8f0RLg82fQEQA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c53f29-5d85-47bf-de78-08d5d61ebcd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2018 19:56:24.7097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018, Andy Lutomirski wrote:=A0 =20

> On Jun 19, 2018, at 9:15 AM, Siarhei Liakh <Siarhei.Liakh@concurrent-rt.c=
om> wrote:
>=20
> > On Mon, 18 Jun 2018, Andy Lutomirski wrote:
> >=20
> > > > On Thu, Jun 14, 2018 at 10:10 PM Siarhei Liakh
> > > > <Siarhei.Liakh@concurrent-rt.com> wrote:
> > > > >
> > > > > fpu__drop() has an explicit fwait which under some conditions can=
 trigger
> > > > > a fixable FPU exception while in kernel. Thus, we should attempt =
to fixup
> > > > > the exception first, and only call notify_die() if the fixup fail=
ed just
> > > > > like in do_general_protection(). The original call sequence incor=
rectly
> > > > > triggers KDB entry on debug kernels under particular FPU-intensiv=
e
> > > > > workloads. This issue had been privately observed, fixed, and tes=
ted
> > > > > on 4.9.98, while this patch brings the fix to the upstream.
> > > >=20
> > > > Reviewed-by: Andy Lutomirski <luto@kernel.org>
> > > >=20
> > > > With the caveat that you are perpetuating what is arguably a bug in
> > > > some of the other entries: math_error() can now be called with IRQs
> > > > off and return with IRQs on.=A0 If we actually start asserting good
> > > > behavior in the entry code, we'll need to fix this.
> > >=20
> > > Confused. math_error() is still invoked with interrupts off. What's
> > > different now is that notify_die() is called with interrupts conditio=
nally
> > > enabled while upstream it's always called with interrupts disabled.
> >=20
> > I see that notify_die() is being called either way in upstream (ex:
> > do_general_protection() and do_iret_error() vs do_bounds() and etc.).
> > Is there some some sort of general policy/guide documentation available
> > which outlines the expectations of notify_die(), as well as its notifie=
rs?
>=20
> I doubt it.
>=20
> The right fix is to delete notify_die(), not to document it. kernel debug=
gers should
> hook die() directly, and other users (if any) should be moved into the er=
ror handlers.

Got it. Unfortunately, this looks like a whole separate code refactoring pr=
oject
which I cannot undertake at this time. In the mean time, this patch offers =
a fix for
an immediate issue (KDB tripped when it shouldn't) even if it does nothing =
to
address the deficiencies in the framework itself.=20

Thank you.=
