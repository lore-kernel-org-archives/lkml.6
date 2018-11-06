Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989A5C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575292086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOVftvL4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575292086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbeKFVbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:31:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387612AbeKFVbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:31:41 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FFB62086C;
        Tue,  6 Nov 2018 12:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541506007;
        bh=KOPmIdvPPP9IyM3b2VbKi7m+FOKPr7LzwyRg/dmHyxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOVftvL4HukwzkqIb9WE+NLphI3YjSP/+ugGY3r1N1ut4+sYRLpaoWsdHnJI/MusO
         meOu3HkofU/v+8jLac9Ls3Ic2PSp50ZCzN1Iwc7R8vnfVM9LHVrtAexq8NoeT5us6v
         Zm82D2ykI9z51zDNIgq4V1Y28744AdciFxG1l8iM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Edward Cree <ecree@solarflare.com>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 05/18] perf augmented_syscalls: Start collecting pathnames in the BPF program
Date:   Tue,  6 Nov 2018 09:05:59 -0300
Message-Id: <20181106120612.8262-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is the start of having the raw_syscalls:sys_enter BPF handler
collecting pointer arguments, namely pathnames, and with two syscalls
that have that pointer in different arguments, "open" as it as its first
argument, "openat" as the second.

With this in place the existing beautifiers in 'perf trace' works, those
args are shown instead of just the pointer that comes with the syscalls
tracepoints.

This also serves to show and document pitfalls in the process of using
just that place in the kernel (raw_syscalls:sys_enter) plus tables
provided by userspace to collect syscall pointer arguments.

One is the need to use a barrier, as suggested by Edward, to avoid clang
optimizations that make the kernel BPF verifier to refuse loading our
pointer contents collector.

The end result should be a generic eBPF program that works in all
architectures, with the differences amongst archs resolved by the
userspace component, 'perf trace', that should get all its tables
created automatically from the kernel components where they are defined,
via string table constructors for things not expressed in BTF/DWARF
(enums, structs, etc), and otherwise using those observability files
(BTF).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Edward Cree <ecree@solarflare.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-37dz54pmotgpnwg9tb6zuk9j@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 72 ++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index cde91c34b101..90a19336310b 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -37,15 +37,87 @@ struct syscall_exit_args {
 	long		   ret;
 };
 
+struct augmented_filename {
+	unsigned int	size;
+	int		reserved;
+	char		value[256];
+};
+
+#define SYS_OPEN 2
+#define SYS_OPENAT 257
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
 	struct {
 		struct syscall_enter_args args;
+		struct augmented_filename filename;
 	} augmented_args;
 	unsigned int len = sizeof(augmented_args);
+	const void *filename_arg = NULL;
 
 	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
+	/*
+	 * Yonghong and Edward Cree sayz:
+	 *
+	 * https://www.spinics.net/lists/netdev/msg531645.html
+	 *
+	 * >>   R0=inv(id=0) R1=inv2 R6=ctx(id=0,off=0,imm=0) R7=inv64 R10=fp0,call_-1
+	 * >> 10: (bf) r1 = r6
+	 * >> 11: (07) r1 += 16
+	 * >> 12: (05) goto pc+2
+	 * >> 15: (79) r3 = *(u64 *)(r1 +0)
+	 * >> dereference of modified ctx ptr R1 off=16 disallowed
+	 * > Aha, we at least got a different error message this time.
+	 * > And indeed llvm has done that optimisation, rather than the more obvious
+	 * > 11: r3 = *(u64 *)(r1 +16)
+	 * > because it wants to have lots of reads share a single insn.  You may be able
+	 * > to defeat that optimisation by adding compiler barriers, idk.  Maybe someone
+	 * > with llvm knowledge can figure out how to stop it (ideally, llvm would know
+	 * > when it's generating for bpf backend and not do that).  -O0?  ¯\_(ツ)_/¯
+	 *
+	 * The optimization mostly likes below:
+	 *
+	 *	br1:
+	 * 	...
+	 *	r1 += 16
+	 *	goto merge
+	 *	br2:
+	 *	...
+	 *	r1 += 20
+	 *	goto merge
+	 *	merge:
+	 *	*(u64 *)(r1 + 0)
+	 *
+	 * The compiler tries to merge common loads. There is no easy way to
+	 * stop this compiler optimization without turning off a lot of other
+	 * optimizations. The easiest way is to add barriers:
+	 *
+	 * 	 __asm__ __volatile__("": : :"memory")
+	 *
+	 * 	 after the ctx memory access to prevent their down stream merging.
+	 */
+	switch (augmented_args.args.syscall_nr) {
+	case SYS_OPEN:	 filename_arg = (const void *)args->args[0];
+			__asm__ __volatile__("": : :"memory");
+			 break;
+	case SYS_OPENAT: filename_arg = (const void *)args->args[1];
+			 break;
+	}
+
+	if (filename_arg != NULL) {
+		augmented_args.filename.reserved = 0;
+		augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
+							      sizeof(augmented_args.filename.value),
+							      filename_arg);
+		if (augmented_args.filename.size < sizeof(augmented_args.filename.value)) {
+			len -= sizeof(augmented_args.filename.value) - augmented_args.filename.size;
+			len &= sizeof(augmented_args.filename.value) - 1;
+		}
+	} else {
+		len = sizeof(augmented_args.args);
+	}
+
 	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, &augmented_args, len);
 	return 0;
 }
-- 
2.14.4

