Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AF3C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EF721EA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofRCXSSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EF721EA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbeHIR0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIR0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:26:34 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6240214FF;
        Thu,  9 Aug 2018 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826877;
        bh=IqGUt+YILxxWm++raEu0Gac3SEiAwK1E8U9giHbfs7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofRCXSSvASP4qna9J+GqCu2CcxZSvCI5TIoHg1ZKrI0qjZtDwCo6INelH50i2aRDu
         kRxKKFHTdvvlRhEe+d+trQb31NO6Q8HHa4Q2RmHZZq3za3wkR/kSm4b9yexkD2HO3j
         o/VHBk1a/4EcD/uCTQ8EqE0hd41MO4bA09CUM7Bk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 33/44] perf bpf: Add struct bpf_map struct
Date:   Thu,  9 Aug 2018 11:58:11 -0300
Message-Id: <20180809145822.21391-34-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

A helper structure used by eBPF C program to describe map attributes to
elf_bpf loader, to be used initially by the special __bpf_stdout__ map
used to print strings into the perf ring buffer in BPF scripts, e.g.:

Using the upcoming stdio.h and puts() macros to use the __bpf_stdout__
map to add strings to the ring buffer:

  # cat tools/perf/examples/bpf/hello.c
  #include <stdio.h>

  int syscall_enter(openat)(void *args)
  {
	  puts("Hello, world\n");
	  return 0;
  }

  license(GPL);
  #
  # cat ~/.perfconfig
  [llvm]
	dump-obj = true
  # perf trace -e openat,tools/perf/examples/bpf/hello.c/call-graph=dwarf/ cat /etc/passwd > /dev/null
  LLVM: dumping tools/perf/examples/bpf/hello.o
     0.016 (         ): __bpf_stdout__:Hello, world
     0.018 ( 0.010 ms): cat/9079 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC           ) = 3
     0.057 (         ): __bpf_stdout__:Hello, world
     0.059 ( 0.011 ms): cat/9079 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 3
     0.417 (         ): __bpf_stdout__:Hello, world
     0.419 ( 0.009 ms): cat/9079 openat(dfd: CWD, filename: /etc/passwd                                ) = 3
  #
  # file tools/perf/examples/bpf/hello.o
  tools/perf/examples/bpf/hello.o: ELF 64-bit LSB relocatable, *unknown arch 0xf7* version 1 (SYSV), not stripped
   # readelf -SW tools/perf/examples/bpf/hello.o
  There are 10 section headers, starting at offset 0x208:

  Section Headers:
    [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
    [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
    [ 1] .strtab           STRTAB          0000000000000000 000188 00007f 00      0   0  1
    [ 2] .text             PROGBITS        0000000000000000 000040 000000 00  AX  0   0  4
    [ 3] syscalls:sys_enter_openat PROGBITS        0000000000000000 000040 000088 00  AX  0   0  8
    [ 4] .relsyscalls:sys_enter_openat REL             0000000000000000 000178 000010 10      9   3  8
    [ 5] maps              PROGBITS        0000000000000000 0000c8 00001c 00  WA  0   0  4
    [ 6] .rodata.str1.1    PROGBITS        0000000000000000 0000e4 00000e 01 AMS  0   0  1
    [ 7] license           PROGBITS        0000000000000000 0000f2 000004 00  WA  0   0  1
    [ 8] version           PROGBITS        0000000000000000 0000f8 000004 00  WA  0   0  4
    [ 9] .symtab           SYMTAB          0000000000000000 000100 000078 18      1   1  8
  Key to Flags:
    W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
    L (link order), O (extra OS processing required), G (group), T (TLS),
    C (compressed), x (unknown), o (OS specific), E (exclude),
    p (processor specific)
    # readelf -s tools/perf/examples/bpf/hello.o

  Symbol table '.symtab' contains 5 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
     1: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    5 __bpf_stdout__
     2: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    7 _license
     3: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    8 _version
     4: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    3 syscall_enter_openat
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-81fg60om2ifnatsybzwmiga3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 2873cdde293f..1f632b56bb34 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -4,6 +4,20 @@
 
 #include <uapi/linux/bpf.h>
 
+/*
+ * A helper structure used by eBPF C program to describe map attributes to
+ * elf_bpf loader, taken from tools/testing/selftests/bpf/bpf_helpers.h:
+ */
+struct bpf_map {
+        unsigned int type;
+        unsigned int key_size;
+        unsigned int value_size;
+        unsigned int max_entries;
+        unsigned int map_flags;
+        unsigned int inner_map_idx;
+        unsigned int numa_node;
+};
+
 #define SEC(NAME) __attribute__((section(NAME),  used))
 
 #define probe(function, vars) \
-- 
2.14.4

