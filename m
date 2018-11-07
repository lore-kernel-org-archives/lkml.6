Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FD0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62772089F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="si/v+yPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62772089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeKHIHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:07:12 -0500
Received: from mail.kdab.com ([176.9.126.58]:60632 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbeKHIHL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:07:11 -0500
Authentication-Results: mail.kdab.com (amavisd-new); dkim=pass (1024-bit key)
 reason="pass (just generated,
 assumed good)" header.d=kdab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-transfer-encoding:mime-version:message-id:date:date
 :subject:subject:from:from; s=dkim; t=1541630080; x=1542494081;
 bh=+St47CVkLCy3scR3OzbCKXkW7eVgZD8rF5Dw+IFH6xM=; b=si/v+yPnTqb/
 CdetbkLo3UcvWNRqxOlI8hw07GD3w53S4MnuJlCuwpXHwBa0vQPeLUyxyzI2cXY9
 w6ZIVphcvU5/4kB+MFJFmW3K34OkLxNuZmbsPDUynxOZaagfrRnIwdQljYI5a0we
 xumhZA1e+8ZAVXr7rd//ltIhVCMZho0=
X-Virus-Scanned: amavisd-new at kdab.com
From:   Milian Wolff <milian.wolff@kdab.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH] perf script: share code and output format for uregs and iregs
 output
Date:   Wed,  7 Nov 2018 23:34:37 +0100
Message-Id: <20181107223437.9071-1-milian.wolff@kdab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iregs output was missing the newline at end as well as the leading
ABI output. This made it hard to compare the iregs and uregs values.
Instead, use a single function to output the register values and use
it for both, iregs and uregs, to ensure the output is consistent.

Before:

```
perf  7049 [-01]  1343.354347:          1 cycles:ppp:
        ffffffffa7bc21ce perf_event_exec+0x18e (/lib/modules/4.20.0-rc1pe=
rf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7ead3 setup_new_exec+0xf3 (/lib/modules/4.20.0-rc1perf=
-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7cd7be5 load_elf_binary+0x395 (/lib/modules/4.20.0-rc1pe=
rf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7e540 search_binary_handler+0x80 (/lib/modules/4.20.0-=
rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7f1aa __do_execve_file.isra.13+0x58a (/lib/modules/4.2=
0.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7f561 do_execve+0x21 (/lib/modules/4.20.0-rc1perf-deve=
l-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7f596 __x64_sys_execve+0x26 (/lib/modules/4.20.0-rc1pe=
rf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7a041cb do_syscall_64+0x5b (/lib/modules/4.20.0-rc1perf-=
devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa840008c entry_SYSCALL_64+0x7c (/lib/modules/4.20.0-rc1pe=
rf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
   AX:0x80000000    BX:0x0    CX:0x0    DX:0x7    SI:0xf    DI:0x286    B=
P:0xffff95bc8213a460    SP:0xffffacbf0ba97d18    IP:0xffffffffa7bc21cd FL=
AGS:0x28e    CS:0x10    SS:0x18    R8:0x2    R9:0x21440   R10:0x33816fb3b=
8c   R11:0x1   R12:0xffff95bc8213a460   R13:0xffff95bc8213a400   R14:0xff=
ff95bc8213a400   R15:0x1  ABI:2    AX:0xffffffffffffffda    BX:0xffffffff=
ffffffff    CX:0x7f84ad85798b    DX:0x560209699d50    SI:0x7ffe2c7a6820  =
  DI:0x7ffe2c7a8c9b    BP:0x7ffe2c7a20d0    SP:0x7ffe2c7a2058    IP:0x7f8=
4ad85798b FLAGS:0x206    CS:0x33    SS:0x2b    R8:0x7ffe2c7a2030    R9:0x=
7f84ae55f010   R10:0x8   R11:0x206   R12:0xffffffffffffffff   R13:0xfffff=
fffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff

perf  7049 [-01]  1343.354363:          1 cycles:ppp:
        ...
```

After:

```
perf  7049 [-01]  1343.354347:          1 cycles:ppp:
        ffffffffa7bc21ce perf_event_exec+0x18e (/lib/modules/4.20.0-rc1pe=
rf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7ead3 setup_new_exec+0xf3 (/lib/modules/4.20.0-rc1perf=
-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7cd7be5 load_elf_binary+0x395 (/lib/modules/4.20.0-rc1pe=
rf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7e540 search_binary_handler+0x80 (/lib/modules/4.20.0-=
rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7f1aa __do_execve_file.isra.13+0x58a (/lib/modules/4.2=
0.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7f561 do_execve+0x21 (/lib/modules/4.20.0-rc1perf-deve=
l-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7f596 __x64_sys_execve+0x26 (/lib/modules/4.20.0-rc1pe=
rf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7a041cb do_syscall_64+0x5b (/lib/modules/4.20.0-rc1perf-=
devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa840008c entry_SYSCALL_64+0x7c (/lib/modules/4.20.0-rc1pe=
rf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
 ABI:2    AX:0x80000000    BX:0x0    CX:0x0    DX:0x7    SI:0xf    DI:0x2=
86    BP:0xffff95bc8213a460    SP:0xffffacbf0ba97d18    IP:0xffffffffa7bc=
21cd FLAGS:0x28e    CS:0x10    SS:0x18    R8:0x2    R9:0x21440   R10:0x33=
816fb3b8c   R11:0x1   R12:0xffff95bc8213a460   R13:0xffff95bc8213a400   R=
14:0xffff95bc8213a400   R15:0x1
 ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7f84ad85=
798b    DX:0x560209699d50    SI:0x7ffe2c7a6820    DI:0x7ffe2c7a8c9b    BP=
:0x7ffe2c7a20d0    SP:0x7ffe2c7a2058    IP:0x7f84ad85798b FLAGS:0x206    =
CS:0x33    SS:0x2b    R8:0x7ffe2c7a2030    R9:0x7f84ae55f010   R10:0x8   =
R11:0x206   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xfffff=
fffffffffff   R15:0xffffffffffffffff

perf  7049 [-01]  1343.354363:          1 cycles:ppp:
        ...
```

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/builtin-script.c | 40 ++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index daf73832743e..04913136bac9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -566,30 +566,10 @@ static int perf_session__check_output_opt(struct pe=
rf_session *session)
 	return 0;
 }
=20
-static int perf_sample__fprintf_iregs(struct perf_sample *sample,
-				      struct perf_event_attr *attr, FILE *fp)
-{
-	struct regs_dump *regs =3D &sample->intr_regs;
-	uint64_t mask =3D attr->sample_regs_intr;
-	unsigned i =3D 0, r;
-	int printed =3D 0;
-
-	if (!regs)
-		return 0;
-
-	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
-		u64 val =3D regs->regs[i++];
-		printed +=3D fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
-	}
-
-	return printed;
-}
-
-static int perf_sample__fprintf_uregs(struct perf_sample *sample,
-				      struct perf_event_attr *attr, FILE *fp)
+static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t ma=
sk,
+				     FILE *fp
+)
 {
-	struct regs_dump *regs =3D &sample->user_regs;
-	uint64_t mask =3D attr->sample_regs_user;
 	unsigned i =3D 0, r;
 	int printed =3D 0;
=20
@@ -608,6 +588,20 @@ static int perf_sample__fprintf_uregs(struct perf_sa=
mple *sample,
 	return printed;
 }
=20
+static int perf_sample__fprintf_iregs(struct perf_sample *sample,
+				      struct perf_event_attr *attr, FILE *fp)
+{
+	return perf_sample__fprintf_regs(&sample->intr_regs,
+					 attr->sample_regs_intr, fp);
+}
+
+static int perf_sample__fprintf_uregs(struct perf_sample *sample,
+				      struct perf_event_attr *attr, FILE *fp)
+{
+	return perf_sample__fprintf_regs(&sample->user_regs,
+					 attr->sample_regs_user, fp);
+}
+
 static int perf_sample__fprintf_start(struct perf_sample *sample,
 				      struct thread *thread,
 				      struct perf_evsel *evsel,
--=20
2.19.1
