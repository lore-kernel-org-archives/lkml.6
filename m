Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B71C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF02F21878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF02F21878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeHROoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:44:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50251 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHROoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:44:00 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBaT4d1287172
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:36:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBaRlT1287167;
        Sat, 18 Aug 2018 04:36:27 -0700
Date:   Sat, 18 Aug 2018 04:36:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-81fg60om2ifnatsybzwmiga3@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        dsahern@gmail.com
Reply-To: dsahern@gmail.com, wangnan0@huawei.com, adrian.hunter@intel.com,
          mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, namhyung@kernel.org, jolsa@kernel.org,
          acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bpf: Add struct bpf_map struct
Git-Commit-ID: 7402e543a74a08ae630234012356ff5cf947bd61
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

Commit-ID:  7402e543a74a08ae630234012356ff5cf947bd61
Gitweb:     https://git.kernel.org/tip/7402e543a74a08ae630234012356ff5cf947bd61
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 6 Aug 2018 09:02:26 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:54 -0300

perf bpf: Add struct bpf_map struct

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
