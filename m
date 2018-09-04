Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F4BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B392054F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="mYtq51sb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B392054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeIDVl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 17:41:26 -0400
Received: from mail-co1nam03on0075.outbound.protection.outlook.com ([104.47.40.75]:19232
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbeIDVlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 17:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZC75i6G19FS7IUUzdVw9qmFNfd2GbsrN+kh6nm04M24=;
 b=mYtq51sbwYi8L8FmORrR6IJ2WuvozCzU06LiPdttuE5NQVRF6GWEOGNZ14EuTBz62xh1xKrAh2L5TnH07dr3nRg/pB2YWMEk9vbkYfV8QlnVmrv2rQJzByPJNaTXqo9PTZtOTk2Yfj748ER+Fz1W+shvzZH657VnipJfLF1BuFY=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4984.namprd05.prod.outlook.com (20.177.230.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.15; Tue, 4 Sep 2018 17:14:27 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3%3]) with mapi id 15.20.1101.016; Tue, 4 Sep 2018
 17:14:27 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>
Subject: Re: [PATCH v7 00/10] x86: macrofying inline asm for better
 compilation
Thread-Topic: [PATCH v7 00/10] x86: macrofying inline asm for better
 compilation
Thread-Index: AQHUMB4G8Q2B7h5OjUe7mTMkYteFXKTghQ0A
Date:   Tue, 4 Sep 2018 17:14:27 +0000
Message-ID: <4EDCB9E5-22C4-4168-A80A-4EC81ECE43EF@vmware.com>
References: <20180809201554.168804-1-namit@vmware.com>
In-Reply-To: <20180809201554.168804-1-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2603:3024:1516:f700:78cb:80c2:2c96:2fa0]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4984;20:DrzbZ/YTy1t1aosdI+Us/lmtFnFObgk2gnyWtO5FJlnyWQwCMxgwQw9O5SdQU9FyQPny6S4ThMS/o8OptLgLpugJHkd6Xxi42i2rZXRzkE6C1pxwztN8cizJe/K2x4gzSIpUYXRkMxyth0eet/tjZ99S5+WMnVEBe2C5G7962P0=
x-ms-office365-filtering-correlation-id: 0f6f2184-6261-4cd4-29b3-08d61289deed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4984;
x-ms-traffictypediagnostic: BYAPR05MB4984:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4984CBC156E45B6786EC2352D0030@BYAPR05MB4984.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR05MB4984;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4984;
x-forefront-prvs: 0785459C39
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(346002)(396003)(366004)(199004)(189003)(305945005)(229853002)(7736002)(7416002)(6486002)(68736007)(76176011)(33656002)(6436002)(99286004)(6306002)(6512007)(8676002)(2616005)(476003)(102836004)(2906002)(6506007)(186003)(14444005)(256004)(8936002)(86362001)(6246003)(966005)(36756003)(39060400002)(25786009)(4326008)(105586002)(46003)(81156014)(5660300001)(82746002)(6916009)(81166006)(106356001)(446003)(14454004)(11346002)(486006)(97736004)(5250100002)(316002)(83716003)(2900100001)(478600001)(53936002)(54906003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4984;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: i3b85V2hgddLjgMXtJ/Ea1Cy/bvRWH6S4buo8ZXz9Bhzuw786zlCbgyAXxhVIU8dTBqdgj/zSV1Am7BAnQU+dRjY4J6MC0rkmtGXDtUvkTEVj4zzhyOiy4iWe2cJgizb/w2DyFRmiD+fwv6+zH/EcAf3Vkp4Ql589YdTfnRgsuR7e1r9toP1Lo6aeL0QQ7vbx9FOJ8DG1b0PHde/f4QqTprMcC2XbUUERG74i1ajqzypEMced4IqfYptYIQc+6XiAqZHuD1hhvjM77vmWkaOjkDiBFReOUjuZPXvZZ8SnrU3GxfUchzbCrErKUFvw49CJsq9z/F0W0YGb3R7IRvPa9cKvMqhtnRaofcL9cHUQgg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8130DB4A4A108D4C82A4C993C7853BF8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6f2184-6261-4cd4-29b3-08d61289deed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2018 17:14:27.5814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

at 1:15 PM, Nadav Amit <namit@vmware.com> wrote:

> This patch-set deals with an interesting yet stupid problem: kernel code
> that does not get inlined despite its simplicity. There are several
> causes for this behavior: "cold" attribute on __init, different function
> optimization levels; conditional constant computations based on
> __builtin_constant_p(); and finally large inline assembly blocks.
>=20
> This patch-set deals with the inline assembly problem. I separated these
> patches from the others (that were sent in the RFC) for easier
> inclusion. I also separated the removal of unnecessary new-lines which
> would be sent separately.
>=20
> The problem with inline assembly is that inline assembly is often used
> by the kernel for things that are other than code - for example,
> assembly directives and data. GCC however is oblivious to the content of
> the blocks and assumes their cost in space and time is proportional to
> the number of the perceived assembly "instruction", according to the
> number of newlines and semicolons. Alternatives, paravirt and other
> mechanisms are affected, causing code not to be inlined, and degrading
> compilation quality in general.
>=20
> The solution that this patch-set carries for this problem is to create
> an assembly macro, and then call it from the inline assembly block.  As
> a result, the compiler sees a single "instruction" and assigns the more
> appropriate cost to the code.
>=20
> To avoid uglification of the code, as many noted, the macros are first
> precompiled into an assembly file, which is later assembled together
> with the C files. This also enables to avoid duplicate implementation
> that was set before for the asm and C code. This can be seen in the
> exception table changes.
>=20
> Overall this patch-set slightly increases the kernel size (my build was
> done using my Ubuntu 18.04 config + localyesconfig for the record):
>=20
>   text	   data	    bss	    dec	    hex	filename
> 18140829 10224724 2957312 31322865 1ddf2f1 ./vmlinux before
> 18163608 10227348 2957312 31348268 1de562c ./vmlinux after (+0.1%)
>=20
> The number of static functions in the image is reduced by 379, but
> actually inlining is even better, which does not always shows in these
> numbers: a function may be inlined causing the calling function not to
> be inlined.
>=20
> I ran some limited number of benchmarks, and in general the performance
> impact is not very notable. You can still see >10 cycles shaved off some
> syscalls that manipulate page-tables (e.g., mprotect()), in which
> paravirt caused many functions not to be inlined. In addition this
> patch-set can prevent issues such as [1], and improves code readability
> and maintainability.
>=20
> [1] https://patchwork.kernel.org/patch/10450037/
>=20
> v6->v7: * Fix context switch tracking (Ingo)
> 	* Fix xtensa build error (Ingo)
> 	* Rebase on 4.18-rc8
>=20
> v5->v6:	* Removing more code from jump-labels (PeterZ)
> 	* Fix build issue on i386 (0-day, PeterZ)
>=20
> v4->v5:	* Makefile fixes (Masahiro, Sam)
>=20
> v3->v4: * Changed naming of macros in 2 patches (PeterZ)
> 	* Minor cleanup of the paravirt patch
>=20
> v2->v3: * Several build issues resolved (0-day)
> 	* Wrong comments fix (Josh)
> 	* Change asm vs C order in refcount (Kees)
>=20
> v1->v2:	* Compiling the macros into a separate .s file, improving
> 	  readability (Linus)
> 	* Improving assembly formatting, applying most of the comments
> 	  according to my judgment (Jan)
> 	* Adding exception-table, cpufeature and jump-labels
> 	* Removing new-line cleanup; to be submitted separately
>=20
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Alok Kataria <akataria@vmware.com>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jan Beulich <JBeulich@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-sparse@vger.kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: virtualization@lists.linux-foundation.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: x86@kernel.org
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
>=20
> Nadav Amit (10):
>  xtensa: defining LINKER_SCRIPT for the linker script
>  Makefile: Prepare for using macros for inline asm
>  x86: objtool: use asm macro for better compiler decisions
>  x86: refcount: prevent gcc distortions
>  x86: alternatives: macrofy locks for better inlining
>  x86: bug: prevent gcc distortions
>  x86: prevent inline distortion by paravirt ops
>  x86: extable: use macros instead of inline assembly
>  x86: cpufeature: use macros instead of inline assembly
>  x86: jump-labels: use macros instead of inline assembly
>=20
> Makefile                               |  9 ++-
> arch/x86/Makefile                      | 11 ++-
> arch/x86/entry/calling.h               |  2 +-
> arch/x86/include/asm/alternative-asm.h | 20 ++++--
> arch/x86/include/asm/alternative.h     | 11 +--
> arch/x86/include/asm/asm.h             | 61 +++++++---------
> arch/x86/include/asm/bug.h             | 98 +++++++++++++++-----------
> arch/x86/include/asm/cpufeature.h      | 82 ++++++++++++---------
> arch/x86/include/asm/jump_label.h      | 77 ++++++++------------
> arch/x86/include/asm/paravirt_types.h  | 56 +++++++--------
> arch/x86/include/asm/refcount.h        | 74 +++++++++++--------
> arch/x86/kernel/macros.S               | 16 +++++
> arch/xtensa/kernel/Makefile            |  4 +-
> include/asm-generic/bug.h              |  8 +--
> include/linux/compiler.h               | 56 +++++++++++----
> scripts/Kbuild.include                 |  4 +-
> scripts/mod/Makefile                   |  2 +
> 17 files changed, 333 insertions(+), 258 deletions(-)
> create mode 100644 arch/x86/kernel/macros.S
>=20
> --=20
> 2.17.1


