Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54405C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46C8208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="jFouhPQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46C8208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbeGKCBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:01:46 -0400
Received: from mail-by2nam03on0048.outbound.protection.outlook.com ([104.47.42.48]:30774
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732348AbeGKCBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WQpDbG/KurEh59jjPbeAbXWYGzrtk0e5hJRk/xBgYo=;
 b=jFouhPQoqm6o/MBmhwFBwuU70FeNtscsefBgvabhhq04E57FRTGF433Hk8HXBsFsik2nU6h3QzZWt3/q69M+aAHRK/sv6esqJPGOD0fHyN2BQjSNCuD3IunzaWBgW1QBvdY/iwk5ZAnkyBRliAmdx8ssl4EUdZdFl4yN4z1d8/A=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4792.namprd05.prod.outlook.com (52.135.235.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.10; Wed, 11 Jul 2018 01:59:49 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c5f:4dd5:fff8:3333]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c5f:4dd5:fff8:3333%6]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 01:59:49 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 0/9] x86: macrofying inline asm for better compilation
Thread-Topic: [PATCH v6 0/9] x86: macrofying inline asm for better compilation
Thread-Index: AQHUCk2jftyJo3QGcUSfbD4Su8VULqSJYRCA
Date:   Wed, 11 Jul 2018 01:59:49 +0000
Message-ID: <BA4C0931-A51D-41AE-B918-C37EFFF35840@vmware.com>
References: <20180622172212.199633-1-namit@vmware.com>
In-Reply-To: <20180622172212.199633-1-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [38.97.127.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4792;7:0CtK8sya5pWYXR5qb4fwd7JMEXS3Kj8GE0yE6mteXnYasbJXisENDIvknaML1PO+Yk6vgw90MW2RhYdaWI+61N6g51br8XJmbkTMaVYSsn0FhsYUiwMh30ug3KdcJR7P0RTnSAKHjVhK7GJvJJrT2niiASvIl0eXpPt3DzM3e55luCf5PjgQ9j8wVx7U/XqKOclNtcSbuTbFwutNdRNW6uDZDaPY9hHCl5sdZNIgy9YDseuw4lZuYUbXYAeZv3yS;20:vk+REiYW+EIxYopQhK8ue709Q1MQjlaiiQiqoWQ31USv9fB0U63N7Ue8YW+n0vH4z75r6baq9MofbXMqGDAMnPSrQAHqfJahLH7GrcE0IUZsF8e22UU+WHc5D0gMW/fxNl3c677iDSZLaVYon40iN/yYQFsndBON9tRvyofBWqM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9699c1e6-3e4b-4698-d8a5-08d5e6d1fbf4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4792;
x-ms-traffictypediagnostic: BYAPR05MB4792:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB47924EB3A4256910666F69C9D05A0@BYAPR05MB4792.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BYAPR05MB4792;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4792;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(396003)(346002)(39860400002)(189003)(199004)(966005)(2906002)(102836004)(83716003)(81166006)(5250100002)(81156014)(6506007)(8676002)(486006)(316002)(97736004)(6436002)(6486002)(36756003)(5660300001)(476003)(11346002)(2616005)(110136005)(54906003)(6116002)(478600001)(26005)(14454004)(8936002)(2900100001)(76176011)(3846002)(256004)(14444005)(86362001)(53936002)(4326008)(186003)(105586002)(82746002)(305945005)(6306002)(7736002)(33656002)(6246003)(106356001)(6512007)(68736007)(66066001)(7416002)(25786009)(229853002)(99286004)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4792;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dvFUSmhMxrXoVPtQZvslGzDutmn4zFKYzHJmw62xcAggsHjDOH/2i+MjeUdnC58Qsak1I7QUPCW5M+Gvg/P574Wa8WVh6mI2uzrK4VTk8vPCfJmRnUwuJsG2c5+phB/niwxOWpLi2eE+eK9eJ8mxOC7c0qfrGEng7Qlpc1Xm2kn8jbAqbuGP9Yi4iDbD6e64urbNh41hxPaY+JslKLMo2gBsK2nPBQUhnc5+QiPEhKiWTFWaEM54EN5yn5/DXHwPReXjXGUtGM2pLulMei++yKTefaNWQKMA+KOzEODvoAkpEtRBkGdlnbyASnwhCYDVr499UjETbyuVUfgHT1y2B0n4THHicKQNX0Joq7GmMhc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8CFB5CE65CBFE64CB34D20BD84B183DC@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9699c1e6-3e4b-4698-d8a5-08d5e6d1fbf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 01:59:49.0832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4792
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 1:22 PM, Nadav Amit <namit@vmware.com> wrote:

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
>=20
>=20
> Nadav Amit (9):
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
> include/asm-generic/bug.h              |  8 +--
> include/linux/compiler.h               | 56 +++++++++++----
> scripts/Kbuild.include                 |  4 +-
> scripts/mod/Makefile                   |  2 +
> 16 files changed, 331 insertions(+), 256 deletions(-)
> create mode 100644 arch/x86/kernel/macros.S
>=20
> --=20
> 2.17.1

Ping?


