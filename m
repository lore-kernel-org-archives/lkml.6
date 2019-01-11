Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C9BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB96D20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="DcU6Adyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbfAKRyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:54:52 -0500
Received: from mail-eopbgr700043.outbound.protection.outlook.com ([40.107.70.43]:45737
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728616AbfAKRyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90d7pAizvTB9OgI7oTf4PFXp+Tc2gc3Anjr4nq3hWMY=;
 b=DcU6Adyd8QgIch9b65m25EnGhoxFlD3afI4bFNgAaOFUI69yAcBedQmJ9mC7qtquPQP5g8Z5s1f70aS3mPqMgoa35WCHNxC4HQNPDH5IVULOa6EfTzRjZu/AXPkGTRaxHsfZAKh8qz3t+wpigqW+nXUvd1Y+kaKojvMb4CUFXFU=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4600.namprd05.prod.outlook.com (52.135.233.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.9; Fri, 11 Jan 2019 17:54:43 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1537.013; Fri, 11 Jan 2019
 17:54:43 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Jason Baron <jbaron@akamai.com>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 5/6] x86/alternative: Use a single access in
 text_poke() where possible
Thread-Topic: [PATCH v3 5/6] x86/alternative: Use a single access in
 text_poke() where possible
Thread-Index: AQHUqG8Wf4/RNokb7ki08kHGReVe6KWoPeeAgACCrgCAAAOIgIAAAtyAgAAEMYCAAAHSAIABL4oAgAA3H4CAABXrAIAAAyYAgAAMFgCAAAPLAA==
Date:   Fri, 11 Jan 2019 17:54:43 +0000
Message-ID: <73A1EC50-AF51-4035-A3B3-D989AC89B929@vmware.com>
References: <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
 <8138A1EE-359D-4CD2-8E96-5BF00313AB3B@vmware.com>
 <20190110172004.wuh45xoafynfm2df@treble>
 <20190110123243.3b9e0856@gandalf.local.home>
 <20190110174257.GE16556@linux.intel.com>
 <20190110125757.1c8d2870@gandalf.local.home>
 <20190110180428.GG16556@linux.intel.com>
 <e5ea3781-336d-7b03-a22e-5012e915affd@oracle.com>
 <20190111152809.ejutcmqrx4ud3fli@treble>
 <ad6fae93-4122-7854-aa4c-2facd67ca839@oracle.com>
 <20190111165752.z6e2dfktj2caqi4n@treble>
 <d9b1c9b7-ae7b-80df-7b2f-19721f3460cf@akamai.com>
In-Reply-To: <d9b1c9b7-ae7b-80df-7b2f-19721f3460cf@akamai.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4600;20:qlZkwu0YnDx8B9XzXLx3ktiiwWj1rLfrUhQu7WzAk7kpPMpLdCUmVo24P1/XkUOEhJfYt8C3bQUlsavb07+E1LXWR+DicUrGmzKqYXW6gaEr6czLOQieHo6UrUpvrIbzCH6L41zuD9HewuTi95LVV5TTFfZiwijDLn0NOW/jSJc=
x-ms-office365-filtering-correlation-id: 094260b5-9e90-43f8-a520-08d677edde2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4600;
x-ms-traffictypediagnostic: BYAPR05MB4600:
x-microsoft-antispam-prvs: <BYAPR05MB4600E12CF83EE544A2271544D0850@BYAPR05MB4600.namprd05.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(396003)(136003)(346002)(199004)(189003)(8936002)(102836004)(8676002)(71200400001)(71190400001)(25786009)(93886005)(256004)(14444005)(53546011)(5660300001)(3846002)(6116002)(186003)(7416002)(33656002)(6506007)(105586002)(106356001)(446003)(2906002)(97736004)(229853002)(6306002)(478600001)(6512007)(6486002)(4326008)(68736007)(53936002)(26005)(81156014)(82746002)(966005)(6436002)(86362001)(11346002)(54906003)(7736002)(305945005)(476003)(6246003)(486006)(6916009)(99286004)(36756003)(316002)(83716004)(14454004)(76176011)(66066001)(2616005)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4600;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tNbbjkFsiIwUgGoyswqNkUAaGSCBOaHC4aoAf8Paq2NDT+IVXxw8bv8roSz4TeZyIHeCQcm57MbdKRSy4hr1DhjDMFt4ZrjqJxm9LBlbE4g0hhwONF+Cv4kkTor44HnX/U55MLB1wQEmx4VLFTkCBIq316IWJ74irOXEmyRP9CvMMRoJJBEuI7T2Vr4Uvc7JdYjkrJ2fmnJSCZKiYhGwQGJMYsZXxK8kS36cnd7jRLikNRs8JlMn4YY20L0pfHYRyHqyMijxpzlUqGfGKl4KmhokeyK3R128dPcCPz/ftBprjoDNV2ugzKWC6VaWqwpfy/hktiio63VpGnKQLPjdsv+tevOUxBEYkSGXd6UH/QDuiLhY6bLXHgKSRWYLlmEgRFNHjG2IqEdqOdASDumQVdF1vZQAlV+ZHFiDZXRN5II=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D367677AD9950C44AD5FD61480FFF74B@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094260b5-9e90-43f8-a520-08d677edde2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 17:54:43.6049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 11, 2019, at 9:41 AM, Jason Baron <jbaron@akamai.com> wrote:
>=20
> On 1/11/19 11:57 AM, Josh Poimboeuf wrote:
>> On Fri, Jan 11, 2019 at 05:46:36PM +0100, Alexandre Chartre wrote:
>>> On 01/11/2019 04:28 PM, Josh Poimboeuf wrote:
>>>> On Fri, Jan 11, 2019 at 01:10:52PM +0100, Alexandre Chartre wrote:
>>>>> To avoid any issue with live patching the call instruction, what abou=
t
>>>>> toggling between two call instructions: one would be the currently ac=
tive
>>>>> call, while the other would currently be inactive but to be used afte=
r a
>>>>> change is made. You can safely patch the inactive call and then toggl=
e
>>>>> the call flow (using a jump label) between the active and inactive ca=
lls.
>>>>>=20
>>>>> So instead of having a single call instruction:
>>>>>=20
>>>>> 	call function
>>>>>=20
>>>>> You would have:
>>>>>=20
>>>>> 	STATIC_JUMP_IF_TRUE label, key
>>>>> 	call function1
>>>>> 	jmp done
>>>>> label:
>>>>> 	call function2
>>>>> done:
>>>>>=20
>>>>> If the key is set so that function1 is currently called then you can
>>>>> safely update the call instruction for function2. Once this is done,
>>>>> just flip the key to make the function2 call active. On a next update=
,
>>>>> you would, of course, have to switch and update the call for function=
1.
>>>>=20
>>>> What about the following race?
>>>>=20
>>>> CPU1						CPU2
>>>> static key is false, doesn't jump
>>>> task gets preempted before calling function1
>>>> 						change static key to true
>>>> 						start patching "call function1"
>>>> task resumes, sees inconsistent call instruction
>>>=20
>>> If the function1 call is active then it won't be changed, you will chan=
ge
>>> function2. However, I presume you can still have a race but if the func=
tion
>>> is changed twice before calling function1:
>>>=20
>>> CPU1						CPU2
>>> static key is false, doesn't jump
>>> task gets preempted before calling function1
>>>                                                -- first function change=
 --
>>>                                                patch "call function2"
>>>                                                change static key to tru=
e
>>>                                                -- second function chang=
e --
>>>                                                start patching "call fun=
ction1"
>>> task resumes, sees inconsistent call instruction
>>>=20
>>> So right, that's a problem.
>>=20
>> Right, that's what I meant to say :-)
>=20
> could you use something like synchronize_rcu_tasks() between successive
> updates to guarantee nobody's stuck in the middle of the call
> instruction update? Yes its really slow but the update path is slow anywa=
ys.

You would need to disable preemption or IRQs before the call, which is not
something you want to do (when would you enable it?)

Having said that, I suggested something somewhat similar things here:
https://lore.kernel.org/lkml/F6735FF5-4D62-4C4E-A145-751E6469CE9E@vmware.co=
m/
https://lore.kernel.org/lkml/CCF7D3C7-9D12-489B-B778-C2156D2DBF47@vmware.co=
m/

