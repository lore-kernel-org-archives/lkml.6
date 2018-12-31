Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CACC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E4421019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="forae9l8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeLaVMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:12:16 -0500
Received: from mail-eopbgr730056.outbound.protection.outlook.com ([40.107.73.56]:31247
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727801AbeLaVMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:12:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uw3JE8ZTw8W8NRjRqevGgal/sE2x/x6YosHCX6xhb6Y=;
 b=forae9l87UyDpr0ELFOlabxvc7ZKOetiKQXwhwSxFNV7UYRCTh2Un76RZZwASpCDACy0WfN2U9XgTDsQ7KsdZji9p8VGkp3oeYoOE5BsRWTjqxSxGdFAy1keSIYu45cxcEb4P+HyjmlNBUd7qNjolEjyzc00h6dkXBkwm45LSaM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4280.namprd05.prod.outlook.com (52.135.202.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.4; Mon, 31 Dec 2018 21:12:10 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a418:297e:ee09:5872]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a418:297e:ee09:5872%4]) with mapi id 15.20.1495.005; Mon, 31 Dec 2018
 21:12:10 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC v2 1/6] x86: introduce kernel restartable sequence
Thread-Topic: [RFC v2 1/6] x86: introduce kernel restartable sequence
Thread-Index: AQHUoNliFu2b5ov/lE6qLKBN9Ci3LqWZR22AgAAR24A=
Date:   Mon, 31 Dec 2018 21:12:10 +0000
Message-ID: <968F3551-9FF7-4486-B821-36C37DBCFE02@vmware.com>
References: <20181231072112.21051-1-namit@vmware.com>
 <20181231072112.21051-2-namit@vmware.com>
 <CALCETrXqdgqYgsKd0xR7RMvVvotu1u==+n3gYyDgTZvbvmJ5VQ@mail.gmail.com>
In-Reply-To: <CALCETrXqdgqYgsKd0xR7RMvVvotu1u==+n3gYyDgTZvbvmJ5VQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4280;20:41eoavpuY98pYVXZQb9g0lZAIzvBqhE9Sw/aBu8S6/M0TkjVOw9CzWafZZfFuU42E8Bbs3AJm6BUr2dWbknTqwn6glYOO8QNoX5rtvJsNrJgpeaanEuZBs3/dT+4UprvXyRVrxqYy3E2l9UWcGiTbzt1k8A4eHMKkCVcy+FmCjs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e8719138-77c6-4c9e-9cb7-08d66f64a09f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4280;
x-ms-traffictypediagnostic: BYAPR05MB4280:
x-microsoft-antispam-prvs: <BYAPR05MB42800BB4CF13A59CAE4B85DBD0B20@BYAPR05MB4280.namprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB4280;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4280;
x-forefront-prvs: 0903DD1D85
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(5660300001)(71190400001)(53546011)(102836004)(71200400001)(6506007)(8936002)(316002)(99286004)(4326008)(2906002)(3846002)(6116002)(26005)(86362001)(14454004)(256004)(7416002)(14444005)(53936002)(82746002)(6246003)(66066001)(229853002)(105586002)(6512007)(25786009)(486006)(83716004)(478600001)(6436002)(81156014)(54906003)(11346002)(36756003)(186003)(7736002)(76176011)(8676002)(6486002)(476003)(106356001)(2616005)(81166006)(6916009)(33656002)(97736004)(446003)(305945005)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4280;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uFKCOEdXJseKPBVjz8gEmAw5HS9SXdNA0z9ywuweo1Frl2GJ/9fVyXqAAjg+mp1eNXBc9tEQoGRnSiPImEJbNoizso/+dRKCm/SDxvDBPYkWdJ7wAGjNX1lhOJ1m6HWwkczfxmo2W4srcb3vz9qZfpfDeyIsC/nQQFj0nyPnSSJblCHzDTluI94IismAYwzZNZeJiS8pNE2R170CUB0SZBl8dBgN/J6cEAwY9QAIP7JalSlfeNKARt6sSlVtC/sHXvQRJ5BaDe3qx3JjlgBdO9NUkj3VVbV0FEqtTEYg56YwlXdeKmA0LDYqgRCJOH9S
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E6F0BDD20F7A4C4AA050147A91C9D00E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8719138-77c6-4c9e-9cb7-08d66f64a09f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2018 21:12:10.0168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 31, 2018, at 12:08 PM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Sun, Dec 30, 2018 at 11:20 PM Nadav Amit <namit@vmware.com> wrote:
>> It is sometimes beneficial to have a restartable sequence - very few
>> instructions which if they are preempted jump to a predefined point.
>>=20
>> To provide such functionality on x86-64, we use an empty REX-prefix
>> (opcode 0x40) as an indication for instruction in such a sequence. Befor=
e
>> calling the schedule IRQ routine, if the "magic" prefix is found, we
>> call a routine to adjust the instruction pointer.  It is expected that
>> this opcode is not in common use.
>>=20
>> The following patch will make use of this function. Since there are no
>> other users (yet?), the patch does not bother to create a general
>> infrastructure and API that others can use for such sequences. Yet, it
>> should not be hard to make such extension later.
>=20
> The following patch does not use it.  Can you update this?

I will. Sorry for not updating the commit-log. The GCC plugin, and various
requests (that I am not sure I fully agree with) really caused me to spit
some blood.

>> +asmlinkage __visible void restart_kernel_rseq(struct pt_regs *regs)
>> +{
>> +       if (user_mode(regs) || *(u8 *)regs->ip !=3D KERNEL_RESTARTABLE_P=
REFIX)
>> +               return;
>=20
> else?
>=20
> I suspect something is missing here.  Or I'm very confused.

Indeed, the code should call optpoline_restart_rseq() (or some other name,
once I fix the naming). I will fix it.

