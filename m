Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF25C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A879420827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A879420827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388567AbeKGElR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:41:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48067 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388107AbeKGElR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:41:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JCNiX910638
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:12:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JCN7s910634;
        Tue, 6 Nov 2018 11:12:23 -0800
Date:   Tue, 6 Nov 2018 11:12:23 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-37dz54pmotgpnwg9tb6zuk9j@git.kernel.org>
Cc:     hpa@zytor.com, wangnan0@huawei.com, ast@kernel.org,
        namhyung@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        adrian.hunter@intel.com, ecree@solarflare.com, kafai@fb.com,
        tglx@linutronix.de, dsahern@gmail.com, acme@redhat.com,
        mingo@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org
Reply-To: kafai@fb.com, ecree@solarflare.com, acme@redhat.com,
          dsahern@gmail.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org,
          wangnan0@huawei.com, hpa@zytor.com, ast@kernel.org, yhs@fb.com,
          daniel@iogearbox.net, namhyung@kernel.org,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf augmented_syscalls: Start collecting
 pathnames in the BPF program
Git-Commit-ID: 79ef68c7e1f665578e005b454480b6eca60edabe
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  79ef68c7e1f665578e005b454480b6eca60edabe
Gitweb:     https://git.kernel.org/tip/79ef68c7e1f665578e005b454480b6eca60edabe
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 5 Nov 2018 12:23:40 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Nov 2018 12:41:10 -0300

perf augmented_syscalls: Start collecting pathnames in the BPF program

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
