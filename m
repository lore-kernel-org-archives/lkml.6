Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A35FC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5434620685
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="BXrqa24N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfAJRrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:47:47 -0500
Received: from mail-eopbgr810112.outbound.protection.outlook.com ([40.107.81.112]:58784
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729827AbfAJRrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7cBH1Ni7zVd4/qc1qHR9+k4YMDMgq9lck8etJOPXEw=;
 b=BXrqa24N1avEQV9jD8NtH8wKmRmF3X+I+HJbrJ29KK4/N7lELCix1/ocio2WxdSUAS6v8IipZ3CdRPJ/phsMvRXB8hk6Z4mVpqSfBlTFdlm0a7fnexrsNT4jhPJA2Pe08Y16YUcI4Eu3HoBpEmAt0bhK6yUSxXSA91YEmuL4pig=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1486.namprd22.prod.outlook.com (10.174.170.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Thu, 10 Jan 2019 17:47:42 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 17:47:42 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        David Daney <david.daney@cavium.com>
Subject: [4.9 PATCH] MIPS: math-emu: Write-protect delay slot emulation pages
Thread-Topic: [4.9 PATCH] MIPS: math-emu: Write-protect delay slot emulation
 pages
Thread-Index: AQHUqQyVbRbwT2bLTUqKA8xpxehvCg==
Date:   Thu, 10 Jan 2019 17:47:42 +0000
Message-ID: <20190110174724.24713-1-paul.burton@mips.com>
References: <154685090718637@kroah.com>
In-Reply-To: <154685090718637@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0009.prod.exchangelabs.com (2603:10b6:a02:80::22)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1486;6:Bi4yOSVF3BhypQmoW8oEpQSU+AV3ot0nHVBlzfyXCNN6SGz4rLdSghgEyNrpYCoQcF9KHX50VNKbS4Vu7xNAf3NZkm30QlzPPsr4NW7L6PI8RbwJn2jzUXpRLRuLdGcdv9Jc9rTJGuZzRcZgEX7ScnBtmQ+fos2C4C+ZjV8AMSR2QiVioQZ+V+83zFXcH8PW/GhY+m8skvTW/tspYj2uaihgMtBEJNBKOZNSmYFiDrfKakvN2ewAkRXTaiHf0+vp17IU5Ac9LF94y8XOeA5LnxjHf+5aZyY20YXFdd0BIDVnOFuZJKtGo0wz/dVs6r7MrLVh955uABG2GikPfUcq/lVfIayjE+HXXnV5wyA+zQDNkkkzyvcBTCZnMkCrjhSM5mMeu7ILeYmoXi1vhEyXtTSiS2N9qTbK+9rBXBVKb0IjLLl9am5y98pr1dEUTB7kDZO51IlTn/8TXhfSDBvmuw==;5:rczbvAAD0tXIoFURVmchOeGC89MlGsLy2y+OWxhIpriev8Sjaz5zp613jhVVXj6yUx6TT1BY4vd8a98sWqhjbdvLGNfaCxqbql4TTe3ABjNeLoF3rBi2KNREzavtbItULT4wAI3DtY+VhiPA34P6WtSBpQvgWxClSs5DmH6WfDoF1QAA4aS1sJfQ+i4LDMkpyBME6efmLNaZXnv9Umlzvw==;7:JL8aAR4OgOPcK4rdbJiptnluXLvuRj4ZQdrnye6Tlhw5GoDyPKLOTRiFKYoCQ9d1VUYsBCJ8Ub017z8VBol2hq5EZyP7v1K6d6yExHvdfIa1luT6wESK7NQZ6jUQ0eQYvUC00uOfEVs0EZgsuuOsUA==
x-ms-office365-filtering-correlation-id: 93162ff8-b7a6-4608-cbba-08d67723b835
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1486;
x-ms-traffictypediagnostic: MWHPR2201MB1486:
x-microsoft-antispam-prvs: <MWHPR2201MB1486A886C16C42AB7712A909C1840@MWHPR2201MB1486.namprd22.prod.outlook.com>
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(366004)(376002)(346002)(396003)(136003)(199004)(189003)(54906003)(478600001)(316002)(14454004)(8936002)(81156014)(3846002)(1730700003)(6116002)(81166006)(2906002)(8676002)(36756003)(53936002)(6512007)(105586002)(106356001)(2351001)(4326008)(575784001)(97736004)(66066001)(5660300001)(6486002)(6436002)(25786009)(5640700003)(567974002)(68736007)(7736002)(44832011)(71200400001)(71190400001)(305945005)(256004)(14444005)(99286004)(11346002)(486006)(6506007)(446003)(42882007)(6916009)(476003)(2616005)(386003)(76176011)(1076003)(52116002)(186003)(102836004)(2501003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1486;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0Wnkf898C3ZW/3lRfv439H3nHj6LlbnyCnD8jvZfcOxIYzotxRI7h9dDv5SCsmSLrCa5gMD059A23UtNawypNTvlYhX93IM/P7GVxULGYEsCdNqjYiLD8DRUYYGlocuhXrX+tCvOq5vK4kp942Kn4Koz2d2UJP5xfzY9J688D0mMasu+qGY8Yzde2UJhLLqBKUCz611FKWXOJBEETG+G8fGteMNvVIREAmlmDc2GulR7hU2iDkRSmgJ2L4hxfLF9aVRkQ8C7p+p1x+vxZQrV6FTF4R5Q9N8KtWLSoJkrvB37R1VctTfV9stzBMoWArjN0Synn6Qg+MC/32ORJoux/w3G4IOS24h6EglWsTOoR+mwozl3tDYLnqPrFE4DyuAULi2njmyC7gXoOX9CZBKSxtaM+eG0V+zqC2lxICiYCkAwSV2QAMfqWE4fEuGwEP62HnTF+ljJ+zufICPyLKL/jQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93162ff8-b7a6-4608-cbba-08d67723b835
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 17:47:42.0370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit adcc81f148d733b7e8e641300c5590a2cdc13bf3 upstream.

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
Cc: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>
Cc: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/vdso.c     |  4 ++--
 arch/mips/math-emu/dsemul.c | 38 +++++++++++++++++++------------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index e88344e3d508..c6297a03d945 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -111,8 +111,8 @@ int arch_setup_additional_pages(struct linux_binprm *bp=
rm, int uses_interp)
=20
 	/* Map delay slot emulation page */
 	base =3D mmap_region(NULL, STACK_TOP, PAGE_SIZE,
-			   VM_READ|VM_WRITE|VM_EXEC|
-			   VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+			   VM_READ | VM_EXEC |
+			   VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
 			   0);
 	if (IS_ERR_VALUE(base)) {
 		ret =3D base;
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index 4a094f7acb3d..7b4329861056 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -211,8 +211,9 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction =
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
@@ -247,27 +248,31 @@ int mips_dsemul(struct pt_regs *regs, mips_instructio=
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
@@ -279,10 +284,7 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction=
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
2.20.1

