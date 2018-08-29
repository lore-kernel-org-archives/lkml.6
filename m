Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72303C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124522064A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="JF4WNjXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 124522064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbeH2UwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:52:04 -0400
Received: from mail-eopbgr720052.outbound.protection.outlook.com ([40.107.72.52]:9248
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727245AbeH2UwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DShstZYyK6IcNOYw8LMA0LAuyuPvkyYSO7bv0kEUjMk=;
 b=JF4WNjXXBrPhOyxuKYmNuZYYd5mZT1Knr1aDj3YDyj6JR0FUOJRoMYFUCY3JKxaeS8aO+K4jajXl5LsSf7Vo9me84leTLFnJ7peJGZac+oHu7ETXZZG2A+UPJXP7B50oPrnUxOLxS6KaEOHFenBI+X/u/HDZA40Oi4X26DOaaCI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4597.namprd05.prod.outlook.com (52.135.233.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Wed, 29 Aug 2018 16:54:13 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3%3]) with mapi id 15.20.1101.007; Wed, 29 Aug 2018
 16:54:13 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/6] x86/mm: temporary mm struct
Thread-Topic: [RFC PATCH 2/6] x86/mm: temporary mm struct
Thread-Index: AQHUP3AvtPpOeUrzJkKcPlbuZwJlIKTWfEOAgABiOwCAABRygA==
Date:   Wed, 29 Aug 2018 16:54:13 +0000
Message-ID: <A7F037E7-6FA1-418D-A8D9-E8752663EF86@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-3-namit@vmware.com>
 <20180829184925.64caee4dadf705080373f84f@kernel.org>
 <CALCETrWF5XQndPikmBgo9t1UWKS7T0K2kFGOpzX-tavFVis5_Q@mail.gmail.com>
In-Reply-To: <CALCETrWF5XQndPikmBgo9t1UWKS7T0K2kFGOpzX-tavFVis5_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4597;20:83eowXEzknIRxPqQ8j9vpkvzPWeTjmtO8Wf4N7KuJZUo3nnTc23WQpRQT1KBWokcPNsCHnSQmeIeGCH+cZ0YxzPw/TYSc8e4DgG+QyasCMJeiLm0SY+/zPAZG8IYUj6cp6SW9eLFwBa9txXFx0L0GIimc9HK0tSpoa6R15vrNZ0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 046db511-c129-4dc5-aea6-08d60dd00cc3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4597;
x-ms-traffictypediagnostic: BYAPR05MB4597:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4597432C5B381C7A7744AF4FD0090@BYAPR05MB4597.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:BYAPR05MB4597;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4597;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(486006)(256004)(93886005)(14444005)(83716003)(217873002)(76176011)(186003)(26005)(53546011)(99286004)(6506007)(110136005)(54906003)(102836004)(316002)(305945005)(2906002)(5660300001)(7736002)(11346002)(66066001)(2900100001)(36756003)(5250100002)(446003)(476003)(2616005)(53936002)(6246003)(97736004)(8676002)(81166006)(229853002)(81156014)(575784001)(86362001)(7416002)(68736007)(6486002)(82746002)(6436002)(105586002)(106356001)(33656002)(6116002)(6512007)(3846002)(8936002)(4326008)(14454004)(25786009)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4597;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: v0HGmRloGZTEWHglpVO4lmJKZf3mIxnMBF44D4fuvctYDGA3zKq2zefCjTw65RK6ZbE/y47Tlat/yCtX0PLhVnPWHBO+cStKSG0BFjO3jUJz6YjFRbQddYU5DLMjwCZhLkJrNH+jODGbgm2vabBUmE36soXkzx6EhKl32aWFzn343SFvoeK3uubrp0UmlkyeJVxC0/HK2WmI1sr/ueJyltTYQvUDjxaI05pYowDFfCDMAWE4K2x3cgyqRtEBsY2CTHwPoOEcHVhl9fCXNhhJvp2coq8PVHUPftpADiXDtJJs6GpuT/jiealAMF23kmcanAwWlbrEGnLDb1qrQBlC+qVJ/v3Jb2TFAPrrUrgr3lM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <64481C5D4380F94F95B21EF5D2D69D6C@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 046db511-c129-4dc5-aea6-08d60dd00cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 16:54:13.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4597
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 8:41 AM, Andy Lutomirski <luto@kernel.org> wrote:

> On Wed, Aug 29, 2018 at 2:49 AM, Masami Hiramatsu <mhiramat@kernel.org> w=
rote:
>> On Wed, 29 Aug 2018 01:11:43 -0700
>> Nadav Amit <namit@vmware.com> wrote:
>>=20
>>> From: Andy Lutomirski <luto@kernel.org>
>>>=20
>>> Sometimes we want to set a temporary page-table entries (PTEs) in one o=
f
>>> the cores, without allowing other cores to use - even speculatively -
>>> these mappings. There are two benefits for doing so:
>>>=20
>>> (1) Security: if sensitive PTEs are set, temporary mm prevents their us=
e
>>> in other cores. This hardens the security as it prevents exploding a
>>> dangling pointer to overwrite sensitive data using the sensitive PTE.
>>>=20
>>> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
>>> remote page-tables.
>>>=20
>>> To do so a temporary mm_struct can be used. Mappings which are private
>>> for this mm can be set in the userspace part of the address-space.
>>> During the whole time in which the temporary mm is loaded, interrupts
>>> must be disabled.
>>>=20
>>> The first use-case for temporary PTEs, which will follow, is for poking
>>> the kernel text.
>>>=20
>>> [ Commit message was written by Nadav ]
>>>=20
>>> Cc: Andy Lutomirski <luto@kernel.org>
>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Nadav Amit <namit@vmware.com>
>>> ---
>>> arch/x86/include/asm/mmu_context.h | 20 ++++++++++++++++++++
>>> 1 file changed, 20 insertions(+)
>>>=20
>>> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/=
mmu_context.h
>>> index eeeb9289c764..96afc8c0cf15 100644
>>> --- a/arch/x86/include/asm/mmu_context.h
>>> +++ b/arch/x86/include/asm/mmu_context.h
>>> @@ -338,4 +338,24 @@ static inline unsigned long __get_current_cr3_fast=
(void)
>>>      return cr3;
>>> }
>>>=20
>>> +typedef struct {
>>> +     struct mm_struct *prev;
>>> +} temporary_mm_state_t;
>>> +
>>> +static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *=
mm)
>>> +{
>>> +     temporary_mm_state_t state;
>>> +
>>> +     lockdep_assert_irqs_disabled();
>>> +     state.prev =3D this_cpu_read(cpu_tlbstate.loaded_mm);
>>> +     switch_mm_irqs_off(NULL, mm, current);
>>> +     return state;
>>> +}
>>=20
>> Hmm, why don't we return mm_struct *prev directly?
>=20
> I did it this way to make it easier to add future debugging stuff
> later.  Also, when I first wrote this, I stashed the old CR3 instead
> of the old mm_struct, and it seemed like callers should be insulated
> from details like this.

Andy, please let me know if you want me to change it somehow, and please
provide your signed-off-by.

