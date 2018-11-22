Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294D0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CA920821
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0AVt6aX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CA920821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404409AbeKVOOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404394AbeKVOOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:36 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201882075B;
        Thu, 22 Nov 2018 03:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857830;
        bh=c4GJawUFt/dtACkuU4P7tomGmkIauA00FmqezInkm80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0AVt6aXBXN69Co/9Qj57zHNcfGeY8R3JfK+wjkY08h0o8mdwsoqs1a7Z9uUHJ9H6
         v7rMTNNxs0yW6fH1JW6JYEIud0PCvH8OdSLZjb+chaGz5KwzO8x1qfQqawAbabp51H
         8sJ/kT+HySPfmon2scVs1dvsKI38BWfpxCzUupw8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Milian Wolff <milian.wolff@kdab.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/28] perf script: Share code and output format for uregs and iregs output
Date:   Thu, 22 Nov 2018 00:35:59 -0300
Message-Id: <20181122033611.15890-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

The iregs output was missing the newline at end as well as the leading
ABI output. This made it hard to compare the iregs and uregs values.
Instead, use a single function to output the register values and use it
for both, iregs and uregs, to ensure the output is consistent.

Before:

  perf  7049 [-01]  1343.354347:          1 cycles:ppp:
        ffffffffa7bc21ce perf_event_exec+0x18e (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7ead3 setup_new_exec+0xf3 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7cd7be5 load_elf_binary+0x395 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7e540 search_binary_handler+0x80 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7f1aa __do_execve_file.isra.13+0x58a (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7f561 do_execve+0x21 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7f596 __x64_sys_execve+0x26 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7a041cb do_syscall_64+0x5b (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa840008c entry_SYSCALL_64+0x7c (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
    AX:0x80000000    BX:0x0    CX:0x0    DX:0x7    SI:0xf    DI:0x286    BP:0xffff95bc8213a460    SP:0xffffacbf0ba97d18    IP:0xffffffffa7bc21cd FLAGS:0x28e    CS:0x10    SS:0x18    R8:0x2    R9:0x21440   R10:0x33816fb3b8c   R11:0x1   R12:0xffff95bc8213a460   R13:0xffff95bc8213a400   R14:0xffff95bc8213a400   R15:0x1  ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7f84ad85798b    DX:0x560209699d50    SI:0x7ffe2c7a6820    DI:0x7ffe2c7a8c9b    BP:0x7ffe2c7a20d0    SP:0x7ffe2c7a2058    IP:0x7f84ad85798b FLAGS:0x206    CS:0x33    SS:0x2b    R8:0x7ffe2c7a2030    R9:0x7f84ae55f010   R10:0x8   R11:0x206   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff

  perf  7049 [-01]  1343.354363:          1 cycles:ppp:
        ...

After:

  perf  7049 [-01]  1343.354347:          1 cycles:ppp:
        ffffffffa7bc21ce perf_event_exec+0x18e (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7ead3 setup_new_exec+0xf3 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7cd7be5 load_elf_binary+0x395 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7e540 search_binary_handler+0x80 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7f1aa __do_execve_file.isra.13+0x58a (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7f561 do_execve+0x21 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7c7f596 __x64_sys_execve+0x26 (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa7a041cb do_syscall_64+0x5b (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
        ffffffffa840008c entry_SYSCALL_64+0x7c (/lib/modules/4.20.0-rc1perf-devel-05115-gc0bc98f76e39-dirty/build/vmlinux)
    ABI:2    AX:0x80000000    BX:0x0    CX:0x0    DX:0x7    SI:0xf    DI:0x286    BP:0xffff95bc8213a460    SP:0xffffacbf0ba97d18    IP:0xffffffffa7bc21cd FLAGS:0x28e    CS:0x10    SS:0x18    R8:0x2    R9:0x21440   R10:0x33816fb3b8c   R11:0x1   R12:0xffff95bc8213a460   R13:0xffff95bc8213a400   R14:0xffff95bc8213a400   R15:0x1
    ABI:2    AX:0xffffffffffffffda    BX:0xffffffffffffffff    CX:0x7f84ad85798b    DX:0x560209699d50    SI:0x7ffe2c7a6820    DI:0x7ffe2c7a8c9b    BP:0x7ffe2c7a20d0    SP:0x7ffe2c7a2058    IP:0x7f84ad85798b FLAGS:0x206    CS:0x33    SS:0x2b    R8:0x7ffe2c7a2030    R9:0x7f84ae55f010   R10:0x8   R11:0x206   R12:0xffffffffffffffff   R13:0xffffffffffffffff   R14:0xffffffffffffffff   R15:0xffffffffffffffff

  perf  7049 [-01]  1343.354363:          1 cycles:ppp:
        ...

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181107223437.9071-1-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index daf73832743e..04913136bac9 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -566,30 +566,10 @@ static int perf_session__check_output_opt(struct perf_session *session)
 	return 0;
 }
 
-static int perf_sample__fprintf_iregs(struct perf_sample *sample,
-				      struct perf_event_attr *attr, FILE *fp)
-{
-	struct regs_dump *regs = &sample->intr_regs;
-	uint64_t mask = attr->sample_regs_intr;
-	unsigned i = 0, r;
-	int printed = 0;
-
-	if (!regs)
-		return 0;
-
-	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
-		u64 val = regs->regs[i++];
-		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
-	}
-
-	return printed;
-}
-
-static int perf_sample__fprintf_uregs(struct perf_sample *sample,
-				      struct perf_event_attr *attr, FILE *fp)
+static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
+				     FILE *fp
+)
 {
-	struct regs_dump *regs = &sample->user_regs;
-	uint64_t mask = attr->sample_regs_user;
 	unsigned i = 0, r;
 	int printed = 0;
 
@@ -608,6 +588,20 @@ static int perf_sample__fprintf_uregs(struct perf_sample *sample,
 	return printed;
 }
 
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
-- 
2.14.5

