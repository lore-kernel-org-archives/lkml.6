Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7D0C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9352077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8wLftMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9352077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbeIFCk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbeIFCk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:40:26 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F79B20869;
        Wed,  5 Sep 2018 22:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185294;
        bh=STTFwPcnAJfFk15/V6CtiUsecpoNdOsYYKdxDwEv9Wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8wLftMgGzAntQ8aTCW08xmuIjg4TsFjHGdrT5rd3zVE9YhL1UGAvHGmqb5L7SKMy
         /dd47T3Ob+5zdOi5dk5yNlNGENLG/JF/u6zg222/XrsTy7a3u2AIjy1V0L4PPklzoY
         aDffwsU+vxzbb8szV9MbQkqb/R6IauKcvc4qkquk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Gianluca Borello <g.borello@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 72/77] perf augmented_syscalls: Avoid optimization to pass older BPF validators
Date:   Wed,  5 Sep 2018 19:04:35 -0300
Message-Id: <20180905220440.20256-73-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

See https://www.spinics.net/lists/netdev/msg480099.html for the whole
discussio, but to make the augmented_syscalls.c BPF program to get built
and loaded successfully in a greater range of kernels, add an extra
check.

Related patch:

  a60dd35d2e39 ("bpf: change bpf_perf_event_output arg5 type to ARG_CONST_SIZE_OR_ZERO")

That is in the kernel since v4.15, I couldn't figure why this is hitting
me with 4.17.17, but adding the workaround discussed there makes this
work with this fedora kernel and with 4.18.recent.

Before:

  # uname -a
  Linux seventh 4.17.17-100.fc27.x86_64 #1 SMP Mon Aug 20 15:53:11 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c cat /etc/passwd > /dev/null
  libbpf: load bpf program failed: Permission denied
  libbpf: -- BEGIN DUMP LOG ---
  libbpf:
  0: (bf) r6 = r1
  1: (b7) r1 = 0
  2: (7b) *(u64 *)(r10 -8) = r1
  3: (7b) *(u64 *)(r10 -16) = r1
  4: (7b) *(u64 *)(r10 -24) = r1
  5: (7b) *(u64 *)(r10 -32) = r1
  6: (7b) *(u64 *)(r10 -40) = r1
  7: (7b) *(u64 *)(r10 -48) = r1
  8: (7b) *(u64 *)(r10 -56) = r1
  9: (7b) *(u64 *)(r10 -64) = r1
  10: (7b) *(u64 *)(r10 -72) = r1
  11: (7b) *(u64 *)(r10 -80) = r1
  12: (7b) *(u64 *)(r10 -88) = r1
  13: (7b) *(u64 *)(r10 -96) = r1
  14: (7b) *(u64 *)(r10 -104) = r1
  15: (7b) *(u64 *)(r10 -112) = r1
  16: (7b) *(u64 *)(r10 -120) = r1
  17: (7b) *(u64 *)(r10 -128) = r1
  18: (7b) *(u64 *)(r10 -136) = r1
  19: (7b) *(u64 *)(r10 -144) = r1
  20: (7b) *(u64 *)(r10 -152) = r1
  21: (7b) *(u64 *)(r10 -160) = r1
  22: (7b) *(u64 *)(r10 -168) = r1
  23: (7b) *(u64 *)(r10 -176) = r1
  24: (7b) *(u64 *)(r10 -184) = r1
  25: (7b) *(u64 *)(r10 -192) = r1
  26: (7b) *(u64 *)(r10 -200) = r1
  27: (7b) *(u64 *)(r10 -208) = r1
  28: (7b) *(u64 *)(r10 -216) = r1
  29: (7b) *(u64 *)(r10 -224) = r1
  30: (7b) *(u64 *)(r10 -232) = r1
  31: (7b) *(u64 *)(r10 -240) = r1
  32: (7b) *(u64 *)(r10 -248) = r1
  33: (7b) *(u64 *)(r10 -256) = r1
  34: (7b) *(u64 *)(r10 -264) = r1
  35: (7b) *(u64 *)(r10 -272) = r1
  36: (7b) *(u64 *)(r10 -280) = r1
  37: (7b) *(u64 *)(r10 -288) = r1
  38: (7b) *(u64 *)(r10 -296) = r1
  39: (7b) *(u64 *)(r10 -304) = r1
  40: (7b) *(u64 *)(r10 -312) = r1
  41: (bf) r7 = r10
  42: (07) r7 += -312
  43: (bf) r1 = r7
  44: (b7) r2 = 48
  45: (bf) r3 = r6
  46: (85) call bpf_probe_read#4
  47: (79) r3 = *(u64 *)(r6 +24)
  48: (bf) r1 = r10
  49: (07) r1 += -256
  50: (b7) r8 = 256
  51: (b7) r2 = 256
  52: (85) call bpf_probe_read_str#45
  53: (bf) r1 = r0
  54: (67) r1 <<= 32
  55: (77) r1 >>= 32
  56: (bf) r5 = r0
  57: (07) r5 += 56
  58: (2d) if r8 > r1 goto pc+1
   R0=inv(id=0) R1=inv(id=0,umin_value=256,umax_value=4294967295,var_off=(0x0; 0xffffffff)) R5=inv(id=0) R6=ctx(id=0,off=0,imm=0) R7=fp-312,call_-1 R8=inv256 R10=fp0,call_-1 fp-264=0
  59: (b7) r5 = 312
  60: (63) *(u32 *)(r10 -264) = r0
  61: (67) r5 <<= 32
  62: (77) r5 >>= 32
  63: (bf) r1 = r6
  64: (18) r2 = 0xffff8b9120cc8500
  66: (18) r3 = 0xffffffff
  68: (bf) r4 = r7
  69: (85) call bpf_perf_event_output#25
  70: (b7) r0 = 0
  71: (95) exit

  from 58 to 60: R0=inv(id=0) R1=inv(id=0,umax_value=255,var_off=(0x0; 0xff)) R5=inv(id=0) R6=ctx(id=0,off=0,imm=0) R7=fp-312,call_-1 R8=inv256 R10=fp0,call_-1 fp-264=0
  60: (63) *(u32 *)(r10 -264) = r0
  61: (67) r5 <<= 32
  62: (77) r5 >>= 32
  63: (bf) r1 = r6
  64: (18) r2 = 0xffff8b9120cc8500
  66: (18) r3 = 0xffffffff
  68: (bf) r4 = r7
  69: (85) call bpf_perf_event_output#25
  R5 unbounded memory access, use 'var &= const' or 'if (var < const)'

  libbpf: -- END LOG --
  libbpf: failed to load program 'syscalls:sys_enter_openat'
  libbpf: failed to load object 'tools/perf/examples/bpf/augmented_syscalls.c'
  bpf: load objects failed: err=-4007: (Kernel verifier blocks program loading)
  event syntax error: 'tools/perf/examples/bpf/augmented_syscalls.c'
                       \___ Kernel verifier blocks program loading

After:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c cat /etc/passwd > /dev/null
     0.000 cat/29249 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
     0.008 cat/29249 syscalls:sys_exit_openat:0x3
     0.021 cat/29249 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC)
     0.025 cat/29249 syscalls:sys_exit_openat:0x3
     0.180 cat/29249 open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC)
     0.185 cat/29249 syscalls:sys_exit_open:0x3
     0.242 cat/29249 openat(dfd: CWD, filename: /etc/passwd)
     0.245 cat/29249 syscalls:sys_exit_openat:0x3
  #

It also works with a more recent kernel:

  # uname -a
  Linux jouet 4.18.0-00014-g4e67b2a5df5d #6 SMP Thu Aug 30 17:34:17 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c cat /etc/passwd > /dev/null
     0.000 cat/26451 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
     0.020 cat/26451 syscalls:sys_exit_openat:0x3
     0.039 cat/26451 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC)
     0.044 cat/26451 syscalls:sys_exit_openat:0x3
     0.231 cat/26451 open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC)
     0.238 cat/26451 syscalls:sys_exit_open:0x3
     0.278 cat/26451 openat(dfd: CWD, filename: /etc/passwd)
     0.282 cat/26451 syscalls:sys_exit_openat:0x3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Gianluca Borello <g.borello@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-wkpsivs1a9afwldbul46btbv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 0decbcfa8b90..2ae44813ef2d 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -51,8 +51,10 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value, 		\
 						      sizeof(augmented_args.filename.value), 	\
 						      args->filename_ptr); 			\
-	if (augmented_args.filename.size < sizeof(augmented_args.filename.value))		\
+	if (augmented_args.filename.size < sizeof(augmented_args.filename.value)) {		\
 		len -= sizeof(augmented_args.filename.value) - augmented_args.filename.size;	\
+		len &= sizeof(augmented_args.filename.value) - 1;				\
+	}											\
 	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, 			\
 			  &augmented_args, len);						\
 	return 0;										\
-- 
2.14.4

