Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CD8C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C386218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="T+A018z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeLSEcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:32:12 -0500
Received: from mail-eopbgr710134.outbound.protection.outlook.com ([40.107.71.134]:7344
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbeLSEcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 23:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seC7Z5zuPCSmMsv4I0ZdXdYw487kK/+in7lz74blSR8=;
 b=T+A018z3j6Teemldp+IztaMFY2ohtbSAQYC8ky1qtcrohyKSAh5BFDaXx/quhcezO7n9oA8IsWkLafB4Dfb5wMcuBzZ1EYgrLhd/Q6CPzB3tCqbh910L5TsQeyFhQhIkkJpUB05dMLyTs2hHzCzzyXqrs559GzfrcJlvm5fgf/0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1727.namprd22.prod.outlook.com (10.164.206.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Wed, 19 Dec 2018 04:32:06 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%9]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 04:32:06 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Andy Lutomirski <luto@kernel.org>, Hugh Dickins <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Rich Felker <dalias@libc.org>
Subject: Re: Fixing MIPS delay slot emulation weakness?
Thread-Topic: Fixing MIPS delay slot emulation weakness?
Thread-Index: AQHUlKsnfXRylMltrkarAU/KL34KxKWFfjSA
Date:   Wed, 19 Dec 2018 04:32:05 +0000
Message-ID: <20181219043155.nkaofln64lbp2gfz@pburton-laptop>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
In-Reply-To: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CWLP265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:53::26) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.104.180.111]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1727;6:40AXUzbi3yEAANHsEeHHu5AQvQ1gv8quw58TnbPOXkTd6uMsL/apz59VaVS28QdEqDx8R2Fa3YrOLwkCVjAKD8UCmz3M9knVRY3+ypOfUUkBUThqdtj8P6bYdG3afvCSRIKlp96HKCalcylfaUrvDZZ2r5ePWVCKbfdkKucIOw0n5ya1Nx16QMGKZ+UYtKJ6c74mSj+zPXZScKblOPKW5IZ/BYkvLsbPUyS3uG3W5tHl2EcZXrzRXqPqyEA0rz1eEFF0KguPwGyrqFyztGzV/xnYIzZLayWjyGOlIneKTB1OQM4dIcJr5eiIuFfX1Vs5ePfehNC/gVaU62Qmaq4Hej+jP85sjBxzueWCFaAfyEsdQntkJHgK4hFMt/qvbab21P8K6+Xmttjris4Ku+GGIeRRBTNKgtMAynFFeB4eOhCnYorfDVpPuFtoOi8yyw8ocTtrt82u2eYqozB3zglh6A==;5:Np6PTknme0XCqCB1F2n3jvxW2C/MR3ipNzvUigc/JJR7am96q7XHRAKjh/CYCYdTMXhtLn1WyS5BauqmQD/3Ymlv8JfAUAV1iV0osDVexuajzalEyM4PNxIJ5/xTgCSzDBdMFbnbOgNYUvC2YpQfOPVEl7O6IcTQ9OVo6pPghc4=;7:HjBJ/HCbwmVvumPQoGAG84Qol1MyWv2Bd7Us/a+9GNWkhsSMahWq6ysXkZoMpmU+gz+AN7bnF9Zkqe0YsR4+bqYVNENLjE9YrhBi5ZkbAuFKnUVLVF2knjO2/VWgS/YuH9pzBah9JQHHkxofgx0vGQ==
x-ms-office365-filtering-correlation-id: 3c566f7a-0152-43c2-8ca4-08d6656aedf5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1727;
x-ms-traffictypediagnostic: MWHPR2201MB1727:
x-microsoft-antispam-prvs: <MWHPR2201MB1727BF1619088A5ADD7D47D6C1BE0@MWHPR2201MB1727.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1727;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1727;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(376002)(136003)(346002)(39840400004)(189003)(199004)(52116002)(14444005)(256004)(97736004)(508600001)(186003)(33716001)(99286004)(33896004)(54906003)(76176011)(14454004)(5660300001)(11346002)(2906002)(2501003)(25786009)(42882007)(446003)(26005)(110136005)(58126008)(106356001)(4326008)(229853002)(386003)(6506007)(316002)(71200400001)(44832011)(71190400001)(81156014)(8936002)(6512007)(102836004)(68736007)(9686003)(105586002)(1076003)(81166006)(476003)(66066001)(8676002)(7736002)(53936002)(3846002)(486006)(6486002)(305945005)(6246003)(6116002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1727;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HM88n9VObcvplSZcKnhbAltlHzNunYZwcSsss9kWxuQw49nS7iNZToLa92neNk/1uGd5O+9N9rUMnwZzg6os8MUBXoyE1Td5TaldoTKoBaO+FYojyj/Z1OfXMc+z9/booyN/eSzJqiecvu2mHTBcn66zdx4gmiLKcT+Z6YHeFOFvlQiP2iG0u4J3tRhYobrhuZeaBrKnlbIFoHeSLw3CyAW0c8fQC4LeClZuSH1D1SqMb+8NOk1YJpfGUTnkYIVw+B5DQgCg1fnsS1qc5ZfNB5i4r/7XpXH9cOTyq7xVxzRnOWdK89ZeNYHe+vPvUAc4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2767F97AF549844DA09ACB11DBD84E0A@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c566f7a-0152-43c2-8ca4-08d6656aedf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 04:32:06.1782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1727
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Dec 15, 2018 at 11:19:37AM -0800, Andy Lutomirski wrote:
> The really simple but possibly suboptimal fix is to get rid of
> VM_WRITE and to use get_user_pages(..., FOLL_FORCE) to write to it.

I actually wound up trying this route because it seemed like it would
produce a nice small patch that would be simple to backport, and we
could clean up mainline afterwards.

Unfortunately though things fail because get_user_pages() returns
-EFAULT for the delay slot emulation page, due to the !is_cow_mapping()
check in check_vma_flags(). This was introduced by commit cda540ace6a1
("mm: get_user_pages(write,force) refuse to COW in shared areas"). I'm a
little confused as to its behaviour...

is_cow_mapping() returns true if the VM_MAYWRITE flag is set and
VM_SHARED is not set - this suggests a private & potentially-writable
area, right? That fits in nicely with an area we'd want to COW. Why then
does check_vma_flags() use the inverse of this to indicate a shared
area? This fails if we have a private mapping where VM_MAYWRITE is not
set, but where FOLL_FORCE would otherwise provide a means of writing to
the memory.

If I remove this check in check_vma_flags() then I have a nice simple
patch which seems to work well, leaving the user mapping of the delay
slot emulation page non-writeable. I'm not sure I'm following the mm
innards here though - is there something I should change about the delay
slot page instead? Should I be marking it shared, even though it isn't
really? Or perhaps I'm misunderstanding what VM_MAYWRITE does & I should
set that - would that allow a user to use mprotect() to make the region
writeable..?

The work-in-progress patch can be seen below if it's helpful (and yes, I
realise that the modified condition in check_vma_flags() became
impossible & that removing it would be equivalent).

Or perhaps this is only confusing because it's 4:25am & I'm massively
jetlagged... :)

> A possibly nicer way to accomplish more or less the same thing would
> be to allocate the area with _install_special_mapping() and arrange to
> keep a reference to the struct page around.

I looked at this, but it ends up being a much bigger patch. Perhaps it
could be something to look into as a follow-on cleanup, though it
complicates things a little because we need to actually allocate the
page, preferrably only on demand, which is handled for us with the
current mmap_region() code.

Thanks,
    Paul

---
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 48a9c6b90e07..9476efb54d18 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -126,8 +126,7 @@ int arch_setup_additional_pages(struct linux_binprm *bp=
rm, int uses_interp)
=20
 	/* Map delay slot emulation page */
 	base =3D mmap_region(NULL, STACK_TOP, PAGE_SIZE,
-			   VM_READ|VM_WRITE|VM_EXEC|
-			   VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+			   VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYEXEC,
 			   0, NULL);
 	if (IS_ERR_VALUE(base)) {
 		ret =3D base;
diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index 5450f4d1c920..3aa8e3b90efb 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -67,11 +67,6 @@ struct emuframe {
=20
 static const int emupage_frame_count =3D PAGE_SIZE / sizeof(struct emufram=
e);
=20
-static inline __user struct emuframe *dsemul_page(void)
-{
-	return (__user struct emuframe *)STACK_TOP;
-}
-
 static int alloc_emuframe(void)
 {
 	mm_context_t *mm_ctx =3D &current->mm->context;
@@ -139,7 +134,7 @@ static void free_emuframe(int idx, struct mm_struct *mm=
)
=20
 static bool within_emuframe(struct pt_regs *regs)
 {
-	unsigned long base =3D (unsigned long)dsemul_page();
+	unsigned long base =3D STACK_TOP;
=20
 	if (regs->cp0_epc < base)
 		return false;
@@ -172,8 +167,8 @@ bool dsemul_thread_cleanup(struct task_struct *tsk)
=20
 bool dsemul_thread_rollback(struct pt_regs *regs)
 {
-	struct emuframe __user *fr;
-	int fr_idx;
+	struct emuframe fr;
+	int fr_idx, ret;
=20
 	/* Do nothing if we're not executing from a frame */
 	if (!within_emuframe(regs))
@@ -183,7 +178,12 @@ bool dsemul_thread_rollback(struct pt_regs *regs)
 	fr_idx =3D atomic_read(&current->thread.bd_emu_frame);
 	if (fr_idx =3D=3D BD_EMUFRAME_NONE)
 		return false;
-	fr =3D &dsemul_page()[fr_idx];
+
+	ret =3D access_process_vm(current,
+				STACK_TOP + (fr_idx * sizeof(fr)),
+				&fr, sizeof(fr), FOLL_FORCE);
+	if (WARN_ON(ret !=3D sizeof(fr)))
+		return false;
=20
 	/*
 	 * If the PC is at the emul instruction, roll back to the branch. If
@@ -192,9 +192,9 @@ bool dsemul_thread_rollback(struct pt_regs *regs)
 	 * then something is amiss & the user has branched into some other area
 	 * of the emupage - we'll free the allocated frame anyway.
 	 */
-	if (msk_isa16_mode(regs->cp0_epc) =3D=3D (unsigned long)&fr->emul)
+	if (msk_isa16_mode(regs->cp0_epc) =3D=3D (unsigned long)&fr.emul)
 		regs->cp0_epc =3D current->thread.bd_emu_branch_pc;
-	else if (msk_isa16_mode(regs->cp0_epc) =3D=3D (unsigned long)&fr->badinst=
)
+	else if (msk_isa16_mode(regs->cp0_epc) =3D=3D (unsigned long)&fr.badinst)
 		regs->cp0_epc =3D current->thread.bd_emu_cont_pc;
=20
 	atomic_set(&current->thread.bd_emu_frame, BD_EMUFRAME_NONE);
@@ -214,8 +214,8 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction =
ir,
 {
 	int isa16 =3D get_isa16_mode(regs->cp0_epc);
 	mips_instruction break_math;
-	struct emuframe __user *fr;
-	int err, fr_idx;
+	struct emuframe fr;
+	int fr_idx, ret;
=20
 	/* NOP is easy */
 	if (ir =3D=3D 0)
@@ -250,27 +250,31 @@ int mips_dsemul(struct pt_regs *regs, mips_instructio=
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
+	ret =3D access_process_vm(current,
+				STACK_TOP + (fr_idx * sizeof(fr)),
+				&fr, sizeof(fr), FOLL_FORCE | FOLL_WRITE);
+	if (WARN_ON(ret !=3D sizeof(fr))) {
 		MIPS_FPU_EMU_INC_STATS(errors);
 		free_emuframe(fr_idx, current->mm);
 		return SIGBUS;
@@ -282,10 +286,7 @@ int mips_dsemul(struct pt_regs *regs, mips_instruction=
 ir,
 	atomic_set(&current->thread.bd_emu_frame, fr_idx);
=20
 	/* Change user register context to execute the frame */
-	regs->cp0_epc =3D (unsigned long)&fr->emul | isa16;
-
-	/* Ensure the icache observes our newly written frame */
-	flush_cache_sigtramp((unsigned long)&fr->emul);
+	regs->cp0_epc =3D (unsigned long)&fr.emul | isa16;
=20
 	return 0;
 }
diff --git a/mm/gup.c b/mm/gup.c
index f76e77a2d34b..9a1bc941dcb9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -587,7 +587,7 @@ static int check_vma_flags(struct vm_area_struct *vma, =
unsigned long gup_flags)
 			 * Anon pages in shared mappings are surprising: now
 			 * just reject it.
 			 */
-			if (!is_cow_mapping(vm_flags))
+			if ((vm_flags & VM_SHARED) && !is_cow_mapping(vm_flags))
 				return -EFAULT;
 		}
 	} else if (!(vm_flags & VM_READ)) {
