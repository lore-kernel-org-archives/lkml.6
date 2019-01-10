Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBCEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBA3214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="KLhXUETA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfAJJc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:32:29 -0500
Received: from mail-eopbgr770055.outbound.protection.outlook.com ([40.107.77.55]:18880
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727826AbfAJJc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7Mdr0sK+fz+xGotzIIeKi/7DkkgYtW3SC+5a6/cPIQ=;
 b=KLhXUETANXV8IHgcha3s3/EpTOw2fktSdAoW7XBBdbr6YsSmqoR2uIty15qme+sGw3IDPxrgKOYPpADfvSotZqAsg99k8qV1kDdDJ5WwVF6D8tGKiSvcJIdifIhatdC3jiwnLLsmZT6CFnc0VfraYyQ+32GF+doJDhphTKK5zlc=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB3957.namprd05.prod.outlook.com (52.135.195.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.9; Thu, 10 Jan 2019 09:32:23 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::35a9:ab4b:cc18:b732%2]) with mapi id 15.20.1516.010; Thu, 10 Jan 2019
 09:32:23 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
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
Thread-Index: AQHUqG8Wf4/RNokb7ki08kHGReVe6KWoPeeA
Date:   Thu, 10 Jan 2019 09:32:23 +0000
Message-ID: <8138A1EE-359D-4CD2-8E96-5BF00313AB3B@vmware.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
 <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
In-Reply-To: <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:9dd3:1f44:cc9c:6866]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB3957;20:qaNDOXOjF3QzNVdKRFXjEG7PK4Vc1mLZMrP8HohrQ8knjMLe8yy1Z94kuhlFb1Ede4NOVLli6WhNwtGJyXo/Tdt+8t1sI6fQKXoPtsFsl1KmpH0yL/29Se4j5u3/rBWJuwC7REnysveQW98NPczzRsjrPFEW80XHhsHfzc9+EQI=
x-ms-office365-filtering-correlation-id: 961acfe6-b8cd-4235-dbe7-08d676de86e3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB3957;
x-ms-traffictypediagnostic: BYAPR05MB3957:
x-microsoft-antispam-prvs: <BYAPR05MB39579591CC5BF833386F1EB3D0840@BYAPR05MB3957.namprd05.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(39860400002)(376002)(199004)(189003)(7416002)(14444005)(53546011)(68736007)(6436002)(102836004)(6506007)(86362001)(7736002)(106356001)(105586002)(6512007)(6116002)(82746002)(5660300001)(6916009)(186003)(486006)(256004)(305945005)(478600001)(76176011)(14454004)(83716004)(99286004)(71190400001)(53936002)(229853002)(81156014)(36756003)(81166006)(8676002)(25786009)(4326008)(54906003)(33656002)(8936002)(46003)(97736004)(316002)(6486002)(476003)(6246003)(11346002)(2906002)(2616005)(71200400001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB3957;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MdKIdFFlsZpy2V43FYCeXR024hX11sGyuxw8vTYSFhPBBu/dqsdCn6WLrFLU7SkopWafXZU1rpsJnQPD8nkgcZrYxc0dzDkCX9XsEcXNitxU9Rem3MPU/GPfkC+0OvLH/WOefs2v12FxwitkNGTyg57G7aHya9gNtB61FpS3uXE5w0zrJEJ5AjLVJg06X7vwFId0rn5MXZKijOlAKeAzK1g7/sT1DhRPtd4F9fRSKse0CP6I4qmeOmjXFCr7jwi5FP6p+okPYNaqbzh/PMqfpk6nj9EA1jnN9sDcEE0giO46UOUDrP0n1cU4atStnoYp
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5EBBFC6CD77BA049953E53732A87FF28@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961acfe6-b8cd-4235-dbe7-08d676de86e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 09:32:23.4119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB3957
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jan 9, 2019, at 2:59 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>=20
> Static call inline patching will need to use single 32-bit writes.
> Change text_poke() to do so where possible.
>=20
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> arch/x86/kernel/alternative.c | 31 ++++++++++++++++++++++++++++---
> 1 file changed, 28 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
> index ebeac487a20c..607f48a90097 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -692,7 +692,7 @@ void *__init_or_module text_poke_early(void *addr, co=
nst void *opcode,
> void *text_poke(void *addr, const void *opcode, size_t len)
> {
> 	unsigned long flags;
> -	char *vaddr;
> +	unsigned long vaddr;
> 	struct page *pages[2];
> 	int i;
>=20
> @@ -714,14 +714,39 @@ void *text_poke(void *addr, const void *opcode, siz=
e_t len)
> 	}
> 	BUG_ON(!pages[0]);
> 	local_irq_save(flags);
> +
> 	set_fixmap(FIX_TEXT_POKE0, page_to_phys(pages[0]));
> 	if (pages[1])
> 		set_fixmap(FIX_TEXT_POKE1, page_to_phys(pages[1]));
> -	vaddr =3D (char *)fix_to_virt(FIX_TEXT_POKE0);
> -	memcpy(&vaddr[(unsigned long)addr & ~PAGE_MASK], opcode, len);
> +
> +	vaddr =3D fix_to_virt(FIX_TEXT_POKE0) + ((unsigned long)addr & ~PAGE_MA=
SK);
> +
> +	/*
> +	 * Use a single access where possible.  Note that a single unaligned
> +	 * multi-byte write will not necessarily be atomic on x86-32, or if the
> +	 * address crosses a cache line boundary.
> +	 */
> +	switch (len) {
> +	case 1:
> +		WRITE_ONCE(*(u8 *)vaddr, *(u8 *)opcode);
> +		break;
> +	case 2:
> +		WRITE_ONCE(*(u16 *)vaddr, *(u16 *)opcode);
> +		break;
> +	case 4:
> +		WRITE_ONCE(*(u32 *)vaddr, *(u32 *)opcode);
> +		break;
> +	case 8:
> +		WRITE_ONCE(*(u64 *)vaddr, *(u64 *)opcode);
> +		break;
> +	default:
> +		memcpy((void *)vaddr, opcode, len);
> +	}
> +

Even if Intel and AMD CPUs are guaranteed to run instructions from L1
atomically, this may break instruction emulators, such as those that
hypervisors use. They might not read instructions atomically if on SMP VMs
when the VM's text_poke() races with the emulated instruction fetch.

While I can't find a reason for hypervisors to emulate this instruction,
smarter people might find ways to turn it into a security exploit.

