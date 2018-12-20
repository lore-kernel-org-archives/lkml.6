Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66500C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2266A218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="b5TEUy65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbeLTRpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:45:47 -0500
Received: from mail-eopbgr820120.outbound.protection.outlook.com ([40.107.82.120]:7833
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388116AbeLTRpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1bl+aydacSecRLoDTObn4T0do0wF6NzXjd5KGUer9c=;
 b=b5TEUy65+rL5VVBAdGAt/LvWBhOEq5Q3sEFvEF/KKLPRMCQjfNGBMgVKCUw5lxWrlAr6waUd+wBGqUHyoffffTIXJJoj44/8DCUluxNS6RpUKZy1B+IPOta2mKK3ypW5HCsXm7P5t4Fr1DtPc5YEyuZU2L4e6rakNvxD9KmYctc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1230.namprd22.prod.outlook.com (10.174.161.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 17:45:43 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 17:45:43 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        David Daney <david.daney@cavium.com>,
        Paul Burton <pburton@wavecomp.com>,
        Andy Lutomirski <luto@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] MIPS: math-emu: Write-protect delay slot emulation pages
Thread-Topic: [PATCH] MIPS: math-emu: Write-protect delay slot emulation pages
Thread-Index: AQHUmIvU0UY0CfycF02ZZK4s2JaOTQ==
Date:   Thu, 20 Dec 2018 17:45:43 +0000
Message-ID: <20181220174514.24953-1-paul.burton@mips.com>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
In-Reply-To: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0060.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:12::24) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.197.89.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1230;6:2vg8ZB/ap7ANBSmKWxM6c06WjMZD/pntqjTeqGwLQWydlZx/oSKRyV5UnNRXJr+eYfPkCAXMZUoV0XeZHLDAcQT3X/ygdmpn5xGftLotdBSYPFuI1Ckal33Ommi4C/ZtytKrPbwED0htcccTpCIViJEOFrd18ExXatun9Yz3eMjRRDOcMNLzTNhONjyu808m/lJV4vWNsr4g7lTlV2+fsqYKbi1s0PzaGOQzBY5PT01JyOetqrbejO+8VifqChVYLX3qf9ife/P6c0E6tCxNODv9p2ZWoR9QtsbkAA0TY0XHwJ3oyWrtu2fg11tv9xIbXBGn/1524s5cdedVEgc4V8XHHmFdjH03r+3kpOdMg3c292Kqr1jGw8xMxSZ0UON98DHWC7xdwdyDphr+uzIIOmVl5C+gUDTExhBtyO70k3yJUd5wLm13/DXOvt5Iw+WF4Hn05YMXyVQWj5U4knlj+w==;5:CC8MvA2ol7I+6QjDkBORv8klySWAnWZ5PLFIT0Z4YmTMHu9u9UcpNQASpepfo8FOvBFSYM82MqNZCg1ofIfwHygl1086e8RPpAeIO68qMM6RNKN2NaCbmftYEXpfdwe9YV5MKOe39DZwQhzZ+7vLrTEl498nX8MzyzA/iKbahFY=;7:NOXojE8wiqnLlRrNh+B9NPueaM4OOeScNDNe0RHWjnGKkpQqUAtRdY72noT5jkuk0eFBBKD6U9bTCHb9TySJ8fLoTN9g4iKzhFmp4V/4IPzKTVBZhCdGYwp6nC+IMjA+Wy22WM4q9VPtc1is/44nnA==
x-ms-office365-filtering-correlation-id: 74ed1a91-7d0d-4b08-0401-08d666a2f691
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1230;
x-ms-traffictypediagnostic: MWHPR2201MB1230:
x-microsoft-antispam-prvs: <MWHPR2201MB1230F1CE88B04AB8212247E5C1BF0@MWHPR2201MB1230.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(10201501046)(93006095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1230;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1230;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39840400004)(136003)(396003)(376002)(199004)(189003)(305945005)(6486002)(5640700003)(4326008)(6116002)(81166006)(81156014)(6436002)(8676002)(8936002)(3846002)(14454004)(508600001)(7736002)(316002)(5660300001)(54906003)(575784001)(68736007)(53936002)(25786009)(102836004)(186003)(476003)(97736004)(446003)(42882007)(71190400001)(386003)(6506007)(6512007)(71200400001)(11346002)(2351001)(44832011)(105586002)(486006)(2616005)(106356001)(66066001)(76176011)(1076003)(99286004)(36756003)(256004)(6916009)(2501003)(52116002)(2906002)(26005)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1230;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: j+ds6qxXD81LUlccMAFwu5KFbj+CgAZqHeyJAVq5YnkeIneqptVL1icSZyXhVbyo/WUR09EfGw1jvoU/F9yTjxv3JC4l/9Yy2jv9TX5ooZdXDoGQg4f46wiTSZAPTN60CRErK5vKkb0uSpQ0IFCUIUMGuFWiY8ubbTRhQflM3viczQHi0TpE5k8TpwI7dnF9wUl9MJmHPTxwjsGNyNXOb4mQaXPfvAwnCFprPRtA0KXx2RHwEq2Z2izz/RjG/FRo18L5DtpzhCqq7b9Y0J85zOvtm9w6dGe1swcVp685bpqK/3EmpY44s9OCEvUID03m
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ed1a91-7d0d-4b08-0401-08d666a2f691
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 17:45:43.2942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mapping the delay slot emulation page as both writeable & executable
presents a security risk, in that if an exploit can write to & jump into
the page then it can be used as an easy way to execute arbitrary code.

Prevent this by mapping the page read-only for userland, and using
access_process_vm() with the FOLL_FORCE flag to write to it from
mips_dsemul().

This will likely be less efficient due to copy_to_user_page() performing
cache maintenance on a whole page, rather than a single line as in the
previous use of flush_cache_sigtramp(). However this delay slot
emulation code ought not to be running in any performance critical paths
anyway so this isn't really a problem, and we can probably do better in
copy_to_user_page() anyway in future.

A major advantage of this approach is that the fix is small & simple to
backport to stable kernels.

Reported-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: 432c6bacbd0c ("MIPS: Use per-mm page to execute branch delay slot in=
structions")
Cc: stable@vger.kernel.org # v4.8+
---
 arch/mips/kernel/vdso.c     |  4 ++--
 arch/mips/math-emu/dsemul.c | 38 +++++++++++++++++++------------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 48a9c6b90e07..9df3ebdc7b0f 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -126,8 +126,8 @@ int arch_setup_additional_pages(struct linux_binprm *bp=
rm, int uses_interp)
=20
 	/* Map delay slot emulation page */
 	base =3D mmap_region(NULL, STACK_TOP, PAGE_SIZE,
-			   VM_READ|VM_WRITE|VM_EXEC|
-			   VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+			   VM_READ | VM_EXEC |
+			   VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
 			   0, NULL);
 	if (IS_ERR_VALUE(base)) {
 		ret =3D base;
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index 5450f4d1c920..e2d46cb93ca9 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -214,8 +214,9 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction =
ir,
 {
 	int isa16 =3D get_isa16_mode(regs->cp0_epc);
 	mips_instruction break_math;
-	struct emuframe __user *fr;
-	int err, fr_idx;
+	unsigned long fr_uaddr;
+	struct emuframe fr;
+	int fr_idx, ret;
=20
 	/* NOP is easy */
 	if (ir =3D=3D 0)
@@ -250,27 +251,31 @@ int mips_dsemul(struct pt_regs *regs, mips_instructio=
n ir,
 		fr_idx =3D alloc_emuframe();
 	if (fr_idx =3D=3D BD_EMUFRAME_NONE)
 		return SIGBUS;
-	fr =3D &dsemul_page()[fr_idx];
=20
 	/* Retrieve the appropriately encoded break instruction */
 	break_math =3D BREAK_MATH(isa16);
=20
 	/* Write the instructions to the frame */
 	if (isa16) {
-		err =3D __put_user(ir >> 16,
-				 (u16 __user *)(&fr->emul));
-		err |=3D __put_user(ir & 0xffff,
-				  (u16 __user *)((long)(&fr->emul) + 2));
-		err |=3D __put_user(break_math >> 16,
-				  (u16 __user *)(&fr->badinst));
-		err |=3D __put_user(break_math & 0xffff,
-				  (u16 __user *)((long)(&fr->badinst) + 2));
+		union mips_instruction _emul =3D {
+			.halfword =3D { ir >> 16, ir }
+		};
+		union mips_instruction _badinst =3D {
+			.halfword =3D { break_math >> 16, break_math }
+		};
+
+		fr.emul =3D _emul.word;
+		fr.badinst =3D _badinst.word;
 	} else {
-		err =3D __put_user(ir, &fr->emul);
-		err |=3D __put_user(break_math, &fr->badinst);
+		fr.emul =3D ir;
+		fr.badinst =3D break_math;
 	}
=20
-	if (unlikely(err)) {
+	/* Write the frame to user memory */
+	fr_uaddr =3D (unsigned long)&dsemul_page()[fr_idx];
+	ret =3D access_process_vm(current, fr_uaddr, &fr, sizeof(fr),
+				FOLL_FORCE | FOLL_WRITE);
+	if (unlikely(ret !=3D sizeof(fr))) {
 		MIPS_FPU_EMU_INC_STATS(errors);
 		free_emuframe(fr_idx, current->mm);
 		return SIGBUS;
@@ -282,10 +287,7 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction=
 ir,
 	atomic_set(&current->thread.bd_emu_frame, fr_idx);
=20
 	/* Change user register context to execute the frame */
-	regs->cp0_epc =3D (unsigned long)&fr->emul | isa16;
-
-	/* Ensure the icache observes our newly written frame */
-	flush_cache_sigtramp((unsigned long)&fr->emul);
+	regs->cp0_epc =3D fr_uaddr | isa16;
=20
 	return 0;
 }
--=20
2.20.0

