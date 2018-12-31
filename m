Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D1EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBEC2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="EF+9TspV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbeLaVHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:07:37 -0500
Received: from mail-eopbgr690042.outbound.protection.outlook.com ([40.107.69.42]:58808
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727405AbeLaVHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ipYLaFknlF+ldj3pMLW4leDgbKsR6Xozj+i8PCWYqo=;
 b=EF+9TspV3+S0AZOfAGEqpQTi5+KcOlj2f4txxJE8nJwPw+UXqoZuoZG/askHjAbmiXeDs3f7SfcQYFBqhkhn7k6/cFia9QzOvO4uXqWzzWbYdxOuexTgjXdvNxewCgS09v90QeIvOGx8nA3L4MVy62sKZj8mlkoYUqp0V4wh0zo=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5304.namprd05.prod.outlook.com (20.177.127.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.4; Mon, 31 Dec 2018 21:07:28 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a418:297e:ee09:5872]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::a418:297e:ee09:5872%4]) with mapi id 15.20.1495.005; Mon, 31 Dec 2018
 21:07:28 +0000
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
Subject: Re: [RFC v2 5/6] x86: learning and patching indirect branch targets
Thread-Topic: [RFC v2 5/6] x86: learning and patching indirect branch targets
Thread-Index: AQHUoNlimzAVgn6OHkOyVb20xZHwB6WZRraAgAARQYA=
Date:   Mon, 31 Dec 2018 21:07:27 +0000
Message-ID: <296B2961-9250-4E60-A8BF-535CD669A4B8@vmware.com>
References: <20181231072112.21051-1-namit@vmware.com>
 <20181231072112.21051-6-namit@vmware.com>
 <CALCETrVyJ9gBaJG6poOiWLro3z2jrSXtL087EOEssQ=gOhOBpA@mail.gmail.com>
In-Reply-To: <CALCETrVyJ9gBaJG6poOiWLro3z2jrSXtL087EOEssQ=gOhOBpA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB5304;20:4WH1KRBOraF7Vppgy7r82kQAME3rQUr62nGI1xIBWSlAxT8HFbmg81KKt0wG44Ms30tKsQK2Oob6IenCZkKpqOAJHxGpGxzkPf+CKRJWyGJ+k3IENJGSMF/YjCzYMzliB+xhy01MzuEFtvwwkzLAZv2I1IgGJYfzlsaho/Q7Hx0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e82fcb57-171f-4320-be12-08d66f63f887
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB5304;
x-ms-traffictypediagnostic: BYAPR05MB5304:
x-microsoft-antispam-prvs: <BYAPR05MB5304625B2CCCA815BB247F4AD0B20@BYAPR05MB5304.namprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR05MB5304;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB5304;
x-forefront-prvs: 0903DD1D85
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(189003)(6346003)(102836004)(8676002)(8936002)(81166006)(2616005)(81156014)(76176011)(186003)(25786009)(7736002)(305945005)(99286004)(26005)(53546011)(6506007)(54906003)(7416002)(478600001)(316002)(11346002)(446003)(86362001)(66066001)(476003)(486006)(6116002)(3846002)(68736007)(36756003)(106356001)(4326008)(105586002)(53936002)(5660300001)(14454004)(6512007)(6916009)(97736004)(82746002)(6436002)(2906002)(71190400001)(33656002)(71200400001)(14444005)(256004)(83716004)(229853002)(6246003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5304;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1PFO3NmktFkWlA+lVrWQqGwM9aJ7AY8920UeYjsJsrTGG1DfT9xLeTBO7gnGutjiWULxZHmS45k7TSduSn7LBvrY/DZHyEbGKlr94Fxzuvk6WuWm+B6fPqPMhSCn+jDQjzOw5oi+uu3zPCyAYyS5hA+jgyB/i1sFRL5Dz1Xtiuw/uvQUh6nwGQ17FhBUaTkzEfFv12+kfNXGe7FLx+oPIekmVvuYJS0Gmm+eiOEzIh2cGLCnCXegbZbn+972wp0jKIQUCnED8wV2T6SFQ2StyTOWbc/bJFyZbfT+PXidLTsV9Bi1PAqxvKWsvUCW2oW0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98B4A989C15B0347B88AA16FAFE57DBD@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e82fcb57-171f-4320-be12-08d66f63f887
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2018 21:07:27.9876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5304
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Dec 31, 2018, at 12:05 PM, Andy Lutomirski <luto@kernel.org> wrote:
>=20
> On Sun, Dec 30, 2018 at 11:20 PM Nadav Amit <namit@vmware.com> wrote:
>> During runtime, we collect the targets of indirect branch targets and
>> patch them in. Patching is done asynchronously, by modifying each of the
>> relpoline code-paths separately while diverting code execution to the
>> other path during patching. Preemption is disabled while the code runs,
>> and we wait for preemption to occur on each core to ensure no core is
>> executing the patched code.
>>=20
>> To make use of relpolines, a worker goes over the experienced indirect
>> calls targets and sorts them according to frequency. The target that
>> was encountered most times is patched in.
>>=20
>> Periodically, the indirect branches are set back into learning mode to
>> see whether the targets have changed. The current policy might be too
>> aggressive.
>=20
> Can you put, in a comment somewhere, a clear description of the actual
> optpoline assembly sequence?  I'm finding this code very hard to
> follow as is.  Something like:
>=20
> /*
> * An optpoline is:
> *
> * cmp something, something else
> * je somewhere
> * [repeats of the above]
> * RETPOLINE (i.e. call some thunk)
> */
>=20

Sure. I will add it. The GCC plugin code [3/6] holds commented assembly
code, but I will add it to the commit log as well.

> And please make it correct.
>=20
> Your comment says that preemption is disabled, but it's not obvious to
> me where this happens.
>=20
> Also, you define REX_B and don't use it.  Are there other cases of that?

Yes, I was sloppy. The preemption is not disabled, and instead I used your
proposed approach of restartable sequences.

REX_B is used as KERNEL_RESTARTABLE_PREFIX in [3/6], [5/6] and [6/6]. I wil=
l
rename it.

