Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E501AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7CA2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548411680;
	bh=/shTs6szw5hB+rgE3gamOY2M0cAOyr3GMHd6NfI2WSM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Cj8Rf+I8FMXon0mDOgujejSGC9DB0nNCLoyu8CJLWPBzGMTqd9s6uVn+AHwDQUR4K
	 8QMlPbkuYZsBOakdT3VGiyOhYmiFPxJhGhTCWxG5P3xv/GV63ElD4qhPxM2uHDISD4
	 MPvnqaM5yb/qTNwSG8NYjGX0XTICTFiuVajJRkCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfAYKVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:21:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbfAYKVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:21:17 -0500
Received: from quaco.ghostprotocols.net (unknown [147.229.117.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EF382184B;
        Fri, 25 Jan 2019 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548411673;
        bh=/shTs6szw5hB+rgE3gamOY2M0cAOyr3GMHd6NfI2WSM=;
        h=Date:From:To:Cc:Subject:From;
        b=OCk19gQAIntS9YA3gCBcvP3lvdpgVJTNHsDKwZmNvY9hjUExTMqz6RHV2zdYe6sgc
         saaeruus87cwG5lhkjG79hfcpsLOt2GsfQi/IHSyVyGu6V7Lake1KPdAMcUAMSrXbd
         fvvNeKm+6Ys8LheuRwJTcaZj9bGtK/QCRaiqO9SA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2C61D4034F; Fri, 25 Jan 2019 11:20:57 +0100 (CET)
Date:   Fri, 25 Jan 2019 11:20:57 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin Lau <kafai@fb.com>
Cc:     Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>
Subject: [RFC] Loading BTF and pretty printing maps with bpftool
Message-ID: <20190125102057.GB12077@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Trying to get BTF to beautify some maps in augmented_raw_syscalls.o,
something is not working, these are the steps, maybe writing them down
will help me to find the problem :-)

	So in tools/perf/examples/bpf/augmented_raw_syscalls.c I have
the "syscalls" map, where I'll store details about what 'perf trace'
wants augmented_raw_syscalls.o hooked to raw_syscalls:sys_{enter,exit}:

It looks like:

----

struct syscall {
        bool    enabled;
};

bpf_map(syscalls, ARRAY, int, struct syscall, 512);

----

That 'struct syscall' will grow to have more per-syscall setup details,
like how many bytes to copy from the 'write' syscall 'buf' argument to
show in the strace-like output, etc.

For now its just to tell what syscalls are enabled.

That 'bpf_map' helper is in tools/perf/include/bpf/bpf.h, and its there
to make map definitions more compact, and to provide a point where we
can, transparently, add the annotations needed for the libbpf BTF
annotations, i.e. it expands to:

---------------------

#define bpf_map(name, _type, type_key, type_val, _max_entries)  \
struct bpf_map SEC("maps") name = {                             \
        .type        = BPF_MAP_TYPE_##_type,                    \
        .key_size    = sizeof(type_key),                        \
        .value_size  = sizeof(type_val),                        \
        .max_entries = _max_entries,                            \
};                                                              \
struct ____btf_map_##name {                                     \
        type_key key;                                           \
        type_val value;                                         \
};                                                              \
struct ____btf_map_##name __attribute__((section(".maps." #name), used)) \
        ____btf_map_##name = { }

---------------------

The __btf_map_ I got from tools/testing/selftests/bpf/bpf_helpers.h,
from the BPF_ANNOTATE_KV_PAIR macro that Martin introduced.

So, now when I build a BPF .o file using the above, I get:

  # head -3 ~/.perfconfig 
  [llvm]
	dump-obj = true
	clang-opt = -g
  #
  # perf record -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c sleep 0.1
  LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.023 MB perf.data ]
  [root@quaco ~]# clang --version
  clang version 7.0.1 (Fedora 7.0.1-1.fc29)
  Target: x86_64-unknown-linux-gnu
  Thread model: posix
  InstalledDir: /usr/bin
  # 
  # file /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o: ELF 64-bit LSB relocatable, eBPF, version 1 (SYSV), with debug_info, not stripped
  # 
 # readelf -SW /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  There are 32 section headers, starting at offset 0x2758:

  Section Headers:
    [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
    [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
    [ 1] .strtab           STRTAB          0000000000000000 002582 0001d1 00      0   0  1
    [ 2] .text             PROGBITS        0000000000000000 000040 000000 00  AX  0   0  4
    [ 3] raw_syscalls:sys_enter PROGBITS        0000000000000000 000040 0001d0 00  AX  0   0  8
    [ 4] .relraw_syscalls:sys_enter REL             0000000000000000 001c38 000030 10     31   3  8
    [ 5] raw_syscalls:sys_exit PROGBITS        0000000000000000 000210 0000c0 00  AX  0   0  8
    [ 6] .relraw_syscalls:sys_exit REL             0000000000000000 001c68 000020 10     31   5  8
    [ 7] maps              PROGBITS        0000000000000000 0002d0 000054 00  WA  0   0  4
    [ 8] .maps.__augmented_syscalls__ PROGBITS        0000000000000000 000324 000008 00  WA  0   0  4
    [ 9] .maps.syscalls    PROGBITS        0000000000000000 00032c 000008 00  WA  0   0  4
    [10] .maps.pids_filtered PROGBITS        0000000000000000 000334 000008 00  WA  0   0  4
    [11] license           PROGBITS        0000000000000000 00033c 000004 00  WA  0   0  1
    [12] version           PROGBITS        0000000000000000 000340 000004 00  WA  0   0  4
    [13] .debug_str        PROGBITS        0000000000000000 000344 000320 01  MS  0   0  1
    [14] .debug_loc        PROGBITS        0000000000000000 000664 0001a0 00      0   0  1
    [15] .rel.debug_loc    REL             0000000000000000 001c88 0001e0 10     31  14  8
    [16] .debug_abbrev     PROGBITS        0000000000000000 000804 000167 00      0   0  1
    [17] .debug_info       PROGBITS        0000000000000000 00096b 0004c4 00      0   0  1
    [18] .rel.debug_info   REL             0000000000000000 001e68 000650 10     31  17  8
    [19] .debug_ranges     PROGBITS        0000000000000000 000e2f 000030 00      0   0  1
    [20] .rel.debug_ranges REL             0000000000000000 0024b8 000040 10     31  19  8
    [21] .debug_macinfo    PROGBITS        0000000000000000 000e5f 000001 00      0   0  1
    [22] .debug_pubnames   PROGBITS        0000000000000000 000e60 00016b 00      0   0  1
    [23] .rel.debug_pubnames REL             0000000000000000 0024f8 000010 10     31  22  8
    [24] .debug_pubtypes   PROGBITS        0000000000000000 000fcb 00016e 00      0   0  1
    [25] .rel.debug_pubtypes REL             0000000000000000 002508 000010 10     31  24  8
    [26] .debug_frame      PROGBITS        0000000000000000 001140 000040 00      0   0  8
    [27] .rel.debug_frame  REL             0000000000000000 002518 000040 10     31  26  8
    [28] .debug_line       PROGBITS        0000000000000000 001180 0002a5 00      0   0  1
    [29] .rel.debug_line   REL             0000000000000000 002558 000020 10     31  28  8
    [30] .llvm_addrsig     LOOS+0xfff4c03  0000000000000000 002578 00000a 00   E 31   0  1
    [31] .symtab           SYMTAB          0000000000000000 001428 000810 18      1  76  8
  Key to Flags:
    W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
    L (link order), O (extra OS processing required), G (group), T (TLS),
    C (compressed), x (unknown), o (OS specific), E (exclude),
    p (processor specific)
  # 

  # readelf -sW /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o

  Symbol table '.symtab' contains 86 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
     1: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   13
     2: 000000000000002a     0 NOTYPE  LOCAL  DEFAULT   13
     3: 000000000000006f     0 NOTYPE  LOCAL  DEFAULT   13
     4: 0000000000000075     0 NOTYPE  LOCAL  DEFAULT   13
     5: 000000000000008c     0 NOTYPE  LOCAL  DEFAULT   13
     6: 0000000000000091     0 NOTYPE  LOCAL  DEFAULT   13
     7: 000000000000009e     0 NOTYPE  LOCAL  DEFAULT   13
     8: 00000000000000a7     0 NOTYPE  LOCAL  DEFAULT   13
     9: 00000000000000b2     0 NOTYPE  LOCAL  DEFAULT   13
    10: 00000000000000be     0 NOTYPE  LOCAL  DEFAULT   13
    11: 00000000000000c8     0 NOTYPE  LOCAL  DEFAULT   13
    12: 00000000000000d6     0 NOTYPE  LOCAL  DEFAULT   13
    13: 00000000000000e0     0 NOTYPE  LOCAL  DEFAULT   13
    14: 00000000000000e8     0 NOTYPE  LOCAL  DEFAULT   13
    15: 000000000000010b     0 NOTYPE  LOCAL  DEFAULT   13
    16: 000000000000010f     0 NOTYPE  LOCAL  DEFAULT   13
    17: 0000000000000113     0 NOTYPE  LOCAL  DEFAULT   13
    18: 0000000000000119     0 NOTYPE  LOCAL  DEFAULT   13
    19: 000000000000011f     0 NOTYPE  LOCAL  DEFAULT   13
    20: 0000000000000123     0 NOTYPE  LOCAL  DEFAULT   13
    21: 000000000000012c     0 NOTYPE  LOCAL  DEFAULT   13
    22: 0000000000000141     0 NOTYPE  LOCAL  DEFAULT   13
    23: 0000000000000149     0 NOTYPE  LOCAL  DEFAULT   13
    24: 000000000000014f     0 NOTYPE  LOCAL  DEFAULT   13
    25: 0000000000000154     0 NOTYPE  LOCAL  DEFAULT   13
    26: 000000000000015c     0 NOTYPE  LOCAL  DEFAULT   13
    27: 000000000000016a     0 NOTYPE  LOCAL  DEFAULT   13
    28: 0000000000000184     0 NOTYPE  LOCAL  DEFAULT   13
    29: 0000000000000193     0 NOTYPE  LOCAL  DEFAULT   13
    30: 0000000000000199     0 NOTYPE  LOCAL  DEFAULT   13
    31: 00000000000001a2     0 NOTYPE  LOCAL  DEFAULT   13
    32: 00000000000001a7     0 NOTYPE  LOCAL  DEFAULT   13
    33: 00000000000001bb     0 NOTYPE  LOCAL  DEFAULT   13
    34: 00000000000001c4     0 NOTYPE  LOCAL  DEFAULT   13
    35: 00000000000001dd     0 NOTYPE  LOCAL  DEFAULT   13
    36: 00000000000001e8     0 NOTYPE  LOCAL  DEFAULT   13
    37: 00000000000001fc     0 NOTYPE  LOCAL  DEFAULT   13
    38: 000000000000020b     0 NOTYPE  LOCAL  DEFAULT   13
    39: 000000000000021d     0 NOTYPE  LOCAL  DEFAULT   13
    40: 000000000000022f     0 NOTYPE  LOCAL  DEFAULT   13
    41: 0000000000000236     0 NOTYPE  LOCAL  DEFAULT   13
    42: 0000000000000246     0 NOTYPE  LOCAL  DEFAULT   13
    43: 000000000000024b     0 NOTYPE  LOCAL  DEFAULT   13
    44: 000000000000024f     0 NOTYPE  LOCAL  DEFAULT   13
    45: 0000000000000259     0 NOTYPE  LOCAL  DEFAULT   13
    46: 0000000000000262     0 NOTYPE  LOCAL  DEFAULT   13
    47: 0000000000000267     0 NOTYPE  LOCAL  DEFAULT   13
    48: 0000000000000278     0 NOTYPE  LOCAL  DEFAULT   13
    49: 000000000000028f     0 NOTYPE  LOCAL  DEFAULT   13
    50: 000000000000029a     0 NOTYPE  LOCAL  DEFAULT   13
    51: 00000000000002a3     0 NOTYPE  LOCAL  DEFAULT   13
    52: 00000000000002b6     0 NOTYPE  LOCAL  DEFAULT   13
    53: 00000000000002ba     0 NOTYPE  LOCAL  DEFAULT   13
    54: 00000000000002c7     0 NOTYPE  LOCAL  DEFAULT   13
    55: 00000000000002d6     0 NOTYPE  LOCAL  DEFAULT   13
    56: 00000000000002df     0 NOTYPE  LOCAL  DEFAULT   13
    57: 00000000000002e4     0 NOTYPE  LOCAL  DEFAULT   13
    58: 00000000000002ed     0 NOTYPE  LOCAL  DEFAULT   13
    59: 0000000000000300     0 NOTYPE  LOCAL  DEFAULT   13
    60: 0000000000000304     0 NOTYPE  LOCAL  DEFAULT   13
    61: 0000000000000316     0 NOTYPE  LOCAL  DEFAULT   13
    62: 0000000000000178     0 NOTYPE  LOCAL  DEFAULT    3 LBB0_11
    63: 00000000000001c0     0 NOTYPE  LOCAL  DEFAULT    3 LBB0_12
    64: 00000000000000e0     0 NOTYPE  LOCAL  DEFAULT    3 LBB0_6
    65: 00000000000000f0     0 NOTYPE  LOCAL  DEFAULT    3 LBB0_7
    66: 00000000000000f8     0 NOTYPE  LOCAL  DEFAULT    3 LBB0_8
    67: 00000000000000b0     0 NOTYPE  LOCAL  DEFAULT    5 LBB1_3
    68: 0000000000000000     0 SECTION LOCAL  DEFAULT    3
    69: 0000000000000000     0 SECTION LOCAL  DEFAULT    5
    70: 0000000000000000     0 SECTION LOCAL  DEFAULT   14
    71: 0000000000000000     0 SECTION LOCAL  DEFAULT   16
    72: 0000000000000000     0 SECTION LOCAL  DEFAULT   17
    73: 0000000000000000     0 SECTION LOCAL  DEFAULT   19
    74: 0000000000000000     0 SECTION LOCAL  DEFAULT   26
    75: 0000000000000000     0 SECTION LOCAL  DEFAULT   28
    76: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    8 ____btf_map___augmented_syscalls__
    77: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT   10 ____btf_map_pids_filtered
    78: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    9 ____btf_map_syscalls
    79: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    7 __augmented_syscalls__
    80: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT   11 _license
    81: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT   12 _version
    82: 0000000000000038     0 NOTYPE  GLOBAL DEFAULT    7 pids_filtered
    83: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    3 sys_enter
    84: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT    5 sys_exit
    85: 000000000000001c     0 NOTYPE  GLOBAL DEFAULT    7 syscalls
  #

So so far it seems the __btf annotation is there, etc, we need now to
have the BTF there, so I'm using pahole for that:

  # readelf -SW /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o | grep -i btf
  # pahole -J /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  # readelf -SW /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o | grep -i btf
readelf: /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o: Warning: possibly corrupt ELF header - it has a non-zero program header offset, but no program headers
    [32] .BTF              PROGBITS        0000000000000000 002835 000664 00      0   0  1
  #

And if I use pahole to load that .BTF info:

  # pahole -F btf /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o 
  struct bpf_map {
  	unsigned int               type;                 /*     0     4 */
  	unsigned int               key_size;             /*     4     4 */
  	unsigned int               value_size;           /*     8     4 */
  	unsigned int               max_entries;          /*    12     4 */
  	unsigned int               map_flags;            /*    16     4 */
  	unsigned int               inner_map_idx;        /*    20     4 */
  	unsigned int               numa_node;            /*    24     4 */
  
  	/* size: 28, cachelines: 1, members: 7 */
  	/* last cacheline: 28 bytes */
  };
  struct ____btf_map___augmented_syscalls__ {
  	int                        key;                  /*     0     4 */
  	u32                        value;                /*     4     4 */
  
  	/* size: 8, cachelines: 1, members: 2 */
  	/* last cacheline: 8 bytes */
  };
  struct ____btf_map_syscalls {
  	int                        key;                  /*     0     4 */
  	struct syscall             value;                /*     4     1 */
  
  	/* size: 8, cachelines: 1, members: 2 */
  	/* padding: 3 */
  	/* last cacheline: 8 bytes */
  };
  struct syscall {
  	bool                       enabled;              /*     0     1 */
  
  	/* size: 1, cachelines: 1, members: 1 */
  	/* last cacheline: 1 bytes */
  };
  struct ____btf_map_pids_filtered {
  	pid_t                      key;                  /*     0     4 */
  	bool                       value;                /*     4     1 */
  
  	/* size: 8, cachelines: 1, members: 2 */
  	/* padding: 3 */
  	/* last cacheline: 8 bytes */
  };
  struct syscall_enter_args {
  	long long unsigned int     common_tp_fields;     /*     0     8 */
  	long int                   syscall_nr;           /*     8     8 */
  	long unsigned int          args[6];              /*    16    48 */
  
  	/* size: 64, cachelines: 1, members: 3 */
  };
  struct augmented_filename {
  	unsigned int               size;                 /*     0     4 */
  	int                        reserved;             /*     4     4 */
  	char                       value[256];           /*     8   256 */
  
  	/* size: 264, cachelines: 5, members: 3 */
  	/* last cacheline: 8 bytes */
  };
  struct syscall_exit_args {
  	long long unsigned int     common_tp_fields;     /*     0     8 */
  	long int                   syscall_nr;           /*     8     8 */
  	long int                   ret;                  /*    16     8 */
  
  	/* size: 24, cachelines: 1, members: 3 */
  	/* last cacheline: 24 bytes */
  };
  #

So, yes, the BTF there seems ok.

Now lets try to use this with 'perf trace':

[root@quaco ~]# perf trace -e *sleep sleep 1s 
nanosleep(0x7ffdacc934c0, NULL)         = 0
[root@quaco ~]# 

So it is working, setting up that augmented_raw_syscalls.o into the
raw_syscalls:sys_enter, with the "syscalls" map with just the array
slots for "clock_nanosleep" and "nanosleep" to be with ".enabled =
true".

If I do it again with a 100h sleep, so that it stays there and we can
observe the maps using bpftool, we get:

  # bpftool version
  bpftool v5.0.0-rc3
  #

  # bpftool prog | tail -6
  309: tracepoint  name sys_enter  tag 819967866022f1e1  gpl
	loaded_at 2019-01-25T11:05:41+0100  uid 0
	xlated 528B  jited 381B  memlock 4096B  map_ids 200,199,198
  310: tracepoint  name sys_exit  tag c1bd85c092d6e4aa  gpl
	loaded_at 2019-01-25T11:05:41+0100  uid 0
	xlated 256B  jited 191B  memlock 4096B  map_ids 200,199
  #

And the maps:

  # bpftool map | tail -6
  198: perf_event_array  name __augmented_sys  flags 0x0
	key 4B  value 4B  max_entries 8  memlock 4096B
  199: array  name syscalls  flags 0x0
	key 4B  value 1B  max_entries 512  memlock 8192B
  200: hash  name pids_filtered  flags 0x0
	key 4B  value 1B  max_entries 64  memlock 8192B
  #

So, dumping the entries for those entries:

[root@quaco ~]# egrep sleep /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c
	[35] = "nanosleep",
	[230] = "clock_nanosleep",
[root@quaco ~]#

Looking at just the open and nanosleep:

  # bpftool map dump id 199 | grep "value: 01"
  key: 23 00 00 00  value: 01
  key: e6 00 00 00  value: 01
  #

  # bpftool map lookup id 199 key 35
  Error: key expected 4 bytes got 1
  #

  # bpftool map lookup id 199 key 35 00 00 00
  key: 23 00 00 00  value: 01
  # bpftool map lookup id 199 key 230 00 00 00
  key: e6 00 00 00  value: 01
  # 

I thought it was that --pretty option, so I tried:

  # bpftool map --pretty lookup id 199 key 230 00 00 00
  {
    "key": ["0xe6","0x00","0x00","0x00"
    ],
    "value": ["0x01"
    ]
  }
  # 

Not yet...

  # perf ftrace perf trace -e *sleep sleep 1 > /tmp/perf.trace.ftrace.output
  nanosleep(0x7ffec0262650, NULL)         = 0
  # 

  # grep btf /tmp/perf.trace.ftrace.output
   7)   1.818 us    |              } /* __btf_verifier_log */
   7)               |              __btf_verifier_log() {
   7)   3.753 us    |            } /* btf_verifier_log_member */
   7)   0.125 us    |            btf_name_valid_identifier.isra.12();
   7)               |            btf_verifier_log_member() {
   7)               |              __btf_verifier_log() {
   7)               |              __btf_verifier_log() {
   7)   0.136 us    |            btf_name_valid_identifier.isra.12();
   7)               |            btf_verifier_log_member() {
   7)               |              __btf_verifier_log() {
   7)               |              __btf_verifier_log() {
   7)   0.139 us    |            btf_name_valid_identifier.isra.12();
   7)               |            btf_verifier_log_member() {
   7)               |              __btf_verifier_log() {
   7)               |              __btf_verifier_log() {
   7) + 34.984 us   |          } /* btf_struct_check_meta */
  #

so there was some btf processing, I got a lot of:

CPU:7 [LOST 1130 EVENTS]

So probably a lot more happened, filtering a bit more:

[root@quaco ~]# perf ftrace -G '*btf*' perf trace -e *sleep sleep 1 > /tmp/perf.trace.ftrace.output
nanosleep(0x7ffc7f8927f0, NULL)         = 0
[root@quaco ~]#

[root@quaco ~]# grep btf /tmp/perf.trace.ftrace.output  | wc -l
260
[root@quaco ~]#

The full contents, filtering out ftrace output for interrupts:

 7)               |  bpf_btf_load() {
 7)               |    capable() {
 7)               |      ns_capable_common() {
 7)               |        security_capable() {
 7)   0.105 us    |          cap_capable();
 7)               |          selinux_capable() {
 7)   0.138 us    |            cred_has_capability();
 7)   0.355 us    |          }
 7)   0.969 us    |        }
 7)   1.260 us    |      }
 7)   1.527 us    |    }
 7)               |    btf_new_fd() {
 7)               |      kmem_cache_alloc_trace() {
 7)               |        _cond_resched() {
 7)   0.098 us    |          rcu_all_qs();
 7)   0.294 us    |        }
 7)   0.102 us    |        should_failslab();
 7)   0.172 us    |        memcg_kmem_put_cache();
 7)   1.351 us    |      }
 7)               |      kmem_cache_alloc_trace() {
 7)               |        _cond_resched() {
 7)   0.099 us    |          rcu_all_qs();
 7)   0.300 us    |        }
 7)   0.100 us    |        should_failslab();
 7)   0.313 us    |        memcg_kmem_put_cache();
 7)   1.178 us    |      }
 7)               |      kvmalloc_node() {
 7)               |        __kmalloc_node() {
 7)   0.104 us    |          kmalloc_slab();
 7)               |          _cond_resched() {
 7)   0.102 us    |            rcu_all_qs();
 7)   0.315 us    |          }
 7)   0.100 us    |          should_failslab();
 7)   0.099 us    |          memcg_kmem_put_cache();
 7)   1.150 us    |        }
 7)   1.340 us    |      }
 7)               |      __check_object_size() {
 7)   0.103 us    |        check_stack_object();
 7)   0.128 us    |        __virt_addr_valid();
 7)   0.108 us    |        __check_heap_object();
 7)   0.896 us    |      }
 7)   0.101 us    |      btf_sec_info_cmp();
 7)               |      btf_struct_check_meta() {
 7)   0.135 us    |        btf_name_valid_identifier.isra.12();
 7)   0.109 us    |        __btf_verifier_log_type();
 7)   0.107 us    |        btf_name_valid_identifier.isra.12();
 7)   0.108 us    |        btf_verifier_log_member();
 7)   0.150 us    |        btf_name_valid_identifier.isra.12();
 7)   0.118 us    |        btf_verifier_log_member();
 7)   0.143 us    |        btf_name_valid_identifier.isra.12();
 7)   0.102 us    |        btf_verifier_log_member();
 7)   0.133 us    |        btf_name_valid_identifier.isra.12();
 7)   0.099 us    |        btf_verifier_log_member();
 7)   0.112 us    |        btf_name_valid_identifier.isra.12();
 7)   0.101 us    |        btf_verifier_log_member();
 7)   0.135 us    |        btf_name_valid_identifier.isra.12();
 7)   0.096 us    |        btf_verifier_log_member();
 7)   0.118 us    |        btf_name_valid_identifier.isra.12();
 7)   0.098 us    |        btf_verifier_log_member();
 7)   3.642 us    |      }
 7)               |      kvmalloc_node() {
 7)               |        __kmalloc_node() {
 7)   0.112 us    |          kmalloc_slab();
 7)               |          _cond_resched() {
 7)   0.100 us    |            rcu_all_qs();
 7)   0.296 us    |          }
 7)   0.099 us    |          should_failslab();
 7)   0.102 us    |          memcg_kmem_put_cache();
 7)   1.145 us    |        }
 7)   1.553 us    |      }
 7)               |      kvfree() {
 7)   0.108 us    |        kfree();
 7)   0.304 us    |      }
 7)               |      btf_int_check_meta() {
 7)   0.100 us    |        __btf_verifier_log_type();
 7)   0.315 us    |      }
 7)               |      btf_struct_check_meta() {
 7)   0.244 us    |        btf_name_valid_identifier.isra.12();
 7)   0.102 us    |        __btf_verifier_log_type();
 7)   0.110 us    |        btf_name_valid_identifier.isra.12();
 7)   0.103 us    |        btf_verifier_log_member();
 7)   0.129 us    |        btf_name_valid_identifier.isra.12();
 7)   0.099 us    |        btf_verifier_log_member();
 7)   1.498 us    |      }
 7)               |      btf_int_check_meta() {
 7)   0.101 us    |        __btf_verifier_log_type();
 7)   0.296 us    |      }
 7)               |      btf_ref_type_check_meta() {
 7)   0.107 us    |        btf_name_valid_identifier.isra.12();
 7)   0.099 us    |        __btf_verifier_log_type();
 7)   0.512 us    |      }
 7)               |      btf_ref_type_check_meta() {
 7)   0.112 us    |        btf_name_valid_identifier.isra.12();
 7)   0.101 us    |        __btf_verifier_log_type();
 7)   0.526 us    |      }
 7)               |      btf_struct_check_meta() {
 7)   0.136 us    |        btf_name_valid_identifier.isra.12();
 7)   0.097 us    |        __btf_verifier_log_type();
 7)   0.108 us    |        btf_name_valid_identifier.isra.12();
 7)   0.101 us    |        btf_verifier_log_member();
 7)   0.104 us    |        btf_name_valid_identifier.isra.12();
 7)   0.102 us    |        btf_verifier_log_member();
 7)   1.355 us    |      }
 7)               |      btf_struct_check_meta() {
 7)   0.135 us    |        btf_name_valid_identifier.isra.12();
 7)   0.101 us    |        __btf_verifier_log_type();
 7)   0.115 us    |        btf_name_valid_identifier.isra.12();
 7)   0.104 us    |        btf_verifier_log_member();
 7)   0.960 us    |      }
 7)               |      btf_ref_type_check_meta() {
 7)   0.107 us    |        btf_name_valid_identifier.isra.12();
 7)   0.101 us    |        __btf_verifier_log_type();
 7)   0.516 us    |      }
 7)               |      btf_int_check_meta() {
 7)   0.102 us    |        __btf_verifier_log_type();
 7)   0.311 us    |      }
 7)               |      btf_struct_check_meta() {
 7)   0.153 us    |        btf_name_valid_identifier.isra.12();
 7)   0.103 us    |        __btf_verifier_log_type();
 7)   0.107 us    |        btf_name_valid_identifier.isra.12();
 7)   0.110 us    |        btf_verifier_log_member();
 7)   0.108 us    |        btf_name_valid_identifier.isra.12();
 7)   0.102 us    |        btf_verifier_log_member();
 7)   1.380 us    |      }
 7)               |      btf_ref_type_check_meta() {
 7)   0.118 us    |        btf_name_valid_identifier.isra.12();
 7)   0.101 us    |        __btf_verifier_log_type();
 7)   0.514 us    |      }
 7)               |      btf_ref_type_check_meta() {
 7)   0.156 us    |        btf_name_valid_identifier.isra.12();
 7)   0.103 us    |        __btf_verifier_log_type();
 7)   0.552 us    |      }
 7)               |      btf_array_check_meta() {
 7)   0.102 us    |        __btf_verifier_log_type();
 7)   0.296 us    |      }
 7)               |      btf_int_check_meta() {
 7)   0.098 us    |        __btf_verifier_log_type();
 7)   0.299 us    |      }
 7)               |      btf_int_check_meta() {
 7)   0.098 us    |        __btf_verifier_log_type();
 7)   0.305 us    |      }
 7)               |      kvmalloc_node() {
 7)               |        __kmalloc_node() {
 7)   0.118 us    |          kmalloc_slab();
 7)               |          _cond_resched() {
 7)   0.104 us    |            rcu_all_qs();
 7)   0.302 us    |          }
 7)   0.101 us    |          should_failslab();
 7)   0.219 us    |          memcg_kmem_put_cache();
 7)   1.421 us    |        }
 7)   1.617 us    |      }
 7)               |      kvfree() {
 7)   0.125 us    |        kfree();
 7)   0.313 us    |      }
 7)               |      btf_ref_type_check_meta() {
 7)   0.104 us    |        __btf_verifier_log_type();
 7)   0.311 us    |      }
 7)   0.109 us    |      btf_verifier_log();
 7)               |      kvfree() {
 7)   0.107 us    |        kfree();
 7)   0.296 us    |      }
 7)   0.212 us    |      kfree();
 7)               |      btf_free() {
 7)               |        kvfree() {
 7)   0.182 us    |          kfree();
 7)   0.366 us    |        } /* kvfree */
 7)               |        kvfree() {
 7)   0.104 us    |          kfree();
 7)   0.291 us    |        }
 7)               |        kvfree() {
 7)   0.100 us    |          kfree();
 7)   0.287 us    |        }
 7)               |        kvfree() {
 7)   0.109 us    |          kfree();
 7)   0.298 us    |        }
 7)   0.106 us    |        kfree();
 7)   1.923 us    |      }
 7) + 29.419 us   |    }
 7) + 49.743 us   |  }
 7)               |  bpf_btf_load() {
 7)               |    capable() {
 7)               |      ns_capable_common() {
 7)               |        security_capable() {
 7)   0.100 us    |          cap_capable();
 7)               |          selinux_capable() {
 7)   0.109 us    |            cred_has_capability();
 7)   0.317 us    |          }
 7)   0.750 us    |        }
 7)   0.955 us    |      }
 7)   1.150 us    |    }
 7)               |    btf_new_fd() {
 7)               |      kmem_cache_alloc_trace() {
 7)               |        _cond_resched() {
 7)   0.098 us    |          rcu_all_qs();
 7)   0.290 us    |        }
 7)   0.097 us    |        should_failslab();
 7)   0.108 us    |        memcg_kmem_put_cache();
 7)   0.934 us    |      }
 7)               |      kmem_cache_alloc_trace() {
 7)               |        _cond_resched() {
 7)   0.101 us    |          rcu_all_qs();
 7)   0.294 us    |        }
 7)   0.099 us    |        should_failslab();
 7)   0.099 us    |        memcg_kmem_put_cache();
 7)   0.914 us    |      }
 7)               |      kvmalloc_node() {
 7)               |        __kmalloc_node() {
 7)   0.110 us    |          kmalloc_slab();
 7)               |          _cond_resched() {
 7)   0.110 us    |            rcu_all_qs();
 7)   0.313 us    |          }
 7)   0.104 us    |          should_failslab();
 7)   0.102 us    |          memcg_kmem_put_cache();
 7)   1.158 us    |        }
 7)   6.526 us    |      }
 7)               |      __check_object_size() {
 7)   0.114 us    |        check_stack_object();
 7)   0.109 us    |        __virt_addr_valid();
 7)   0.108 us    |        __check_heap_object();
 7)   0.736 us    |      }
 7)               |      __btf_verifier_log() {
 7)               |        bpf_verifier_vlog() {
 7)               |          __check_object_size() {
 7)   0.104 us    |            check_stack_object();
 7)   0.193 us    |            __virt_addr_valid();
 7)   0.109 us    |            __check_heap_object();
 7)   0.836 us    |          }
 7)   1.569 us    |        }
 7)   1.877 us    |      }
 7)               |      __btf_verifier_log() {
 7)               |        bpf_verifier_vlog() {
 7)               |          __check_object_size() {
 7)   0.212 us    |            check_stack_object();
 7)   0.176 us    |            __virt_addr_valid();
 7)   0.112 us    |            __check_heap_object();
 7)   1.031 us    |          }
 7)   1.380 us    |        }
 7)   1.584 us    |      }
 7)               |      __btf_verifier_log() {
 7)               |        bpf_verifier_vlog() {
 7)               |          __check_object_size() {
 7)   0.101 us    |            check_stack_object();
 7)   0.108 us    |            __virt_addr_valid();
 7)   0.198 us    |            __check_heap_object();
 7)   1.012 us    |          }
 7)   1.347 us    |        }
 7)   1.549 us    |      }
 7)               |      __btf_verifier_log() {
 7)               |        bpf_verifier_vlog() {
 7)               |          __check_object_size() {
 7)   0.104 us    |            check_stack_object();
 7)   0.104 us    |            __virt_addr_valid();
 7)   0.108 us    |            __check_heap_object();
 7)   0.719 us    |          }
 7)   1.082 us    |        }
 7)   1.283 us    |      }
 7)               |      __btf_verifier_log() {
 7)               |        bpf_verifier_vlog() {
 7)               |          __check_object_size() {
 7)   0.105 us    |            check_stack_object();
 7)   0.107 us    |            __virt_addr_valid();
 7)   0.109 us    |            __check_heap_object();
 7)   0.728 us    |          }
 7)   1.056 us    |        }
 7)   1.258 us    |      }
 7)               |      __btf_verifier_log() {
 7)               |        bpf_verifier_vlog() {
 7)               |          __check_object_size() {
 7)   0.103 us    |            check_stack_object();
 7)   0.243 us    |            __virt_addr_valid();
 7)   0.109 us    |            __check_heap_object();
 7)   0.916 us    |          }
 7)   1.276 us    |        }
 7)   1.495 us    |      }
 7)               |      __btf_verifier_log() {
 7)               |        bpf_verifier_vlog() {
 7)               |          __check_object_size() {
 7)   0.103 us    |            check_stack_object();
 7)   0.104 us    |            __virt_addr_valid();
 7)   0.109 us    |            __check_heap_object();
 7)   0.715 us    |          }
 7)   1.268 us    |        }
 7)   1.529 us    |      }
 7)               |      __btf_verifier_log() {
 7)               |        bpf_verifier_vlog() {
 7)               |          __check_object_size() {
 7)   0.104 us    |            check_stack_object();
 7)   0.106 us    |            __virt_addr_valid();
 7)   0.109 us    |            __check_heap_object();
 7)   0.723 us    |          }
 7)   1.038 us    |        }
 7)   1.236 us    |      }
 7)               |      __btf_verifier_log() {
 7)               |        bpf_verifier_vlog() {
 7)               |          __check_object_size() {
 7)   0.210 us    |            check_stack_object();
 7)   0.103 us    |            __virt_addr_valid();
 7)   0.110 us    |            __check_heap_object();
 7)   0.940 us    |          }
 7)   1.342 us    |        }
 7)   1.638 us    |      }
 7)   0.114 us    |      btf_sec_info_cmp();
 7)               |      btf_struct_check_meta() {
 7)   0.139 us    |        btf_name_valid_identifier.isra.12();
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.103 us    |                check_stack_object();
 7)   0.103 us    |                __virt_addr_valid();
 7)   0.112 us    |                __check_heap_object();
 7)   0.765 us    |              }
 7)   1.704 us    |            }
 7)   1.905 us    |          }
 7)               |          btf_struct_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.106 us    |                  check_stack_object();
 7)   0.105 us    |                  __virt_addr_valid();
 7)   0.109 us    |                  __check_heap_object();
 7)   0.728 us    |                }
 7)   1.249 us    |              }
 7)   1.461 us    |            } /* btf_verifier_log */
 7)   1.652 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.108 us    |                check_stack_object();
 7)   0.105 us    |                __virt_addr_valid();
 7)   0.110 us    |                __check_heap_object();
 7)   0.909 us    |              }
 7)   1.279 us    |            }
 7)   1.477 us    |          }
 7)   5.584 us    |        }
 7)   0.124 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.105 us    |                check_stack_object();
 7)   0.121 us    |                __virt_addr_valid();
 7)   0.110 us    |                __check_heap_object();
 7)   0.741 us    |              }
 7)   1.350 us    |            }
 7)   1.547 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.103 us    |                check_stack_object();
 7)   0.195 us    |                __virt_addr_valid();
 7)   0.110 us    |                __check_heap_object();
 7)   0.893 us    |              }
 7)   1.336 us    |            }
 7)   1.537 us    |          }
 7)   3.393 us    |        }
 7)   0.126 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.270 us    |                check_stack_object();
 7)   0.103 us    |                __virt_addr_valid();
 7)   0.109 us    |                __check_heap_object();
 7)   1.021 us    |              }
 7)   1.528 us    |            }
 7)   1.718 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.102 us    |                check_stack_object();
 7)   0.102 us    |                __virt_addr_valid();
 7)   0.128 us    |                __check_heap_object();
 7)   0.726 us    |              }
 7)   1.131 us    |            }
 7)   1.420 us    |          }
 7)   3.471 us    |        }
 7)   0.135 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.105 us    |                check_stack_object();
 7)   0.123 us    |                __virt_addr_valid();
 7)   0.123 us    |                __check_heap_object();
 7)   0.864 us    |              }
 7)   1.393 us    |            }
 7)   1.681 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.104 us    |                check_stack_object();
 7)   0.102 us    |                __virt_addr_valid();
 7)   0.107 us    |                __check_heap_object();
 7)   0.720 us    |              }
 7)   0.975 us    |            }
 7)   1.192 us    |          }
 7)   3.354 us    |        }
 7)   0.153 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.106 us    |                check_stack_object();
 7)   0.106 us    |                __virt_addr_valid();
 7)   0.109 us    |                __check_heap_object();
 7)   0.780 us    |              }
 7)   1.302 us    |            } /* bpf_verifier_vlog */
 7)   1.608 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.253 us    |                check_stack_object();
 7)   0.201 us    |                __virt_addr_valid();
 7)   0.137 us    |                __check_heap_object();
 7)   1.191 us    |              }
 7)   1.444 us    |            }
 7)   1.662 us    |          }
 7)   3.567 us    |        }
 7)   0.124 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.106 us    |                check_stack_object();
 7)   0.122 us    |                __virt_addr_valid();
 7)   0.143 us    |                __check_heap_object();
 7)   0.781 us    |              }
 7)   1.307 us    |            }
 7)   1.533 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.104 us    |                check_stack_object();
 7)   0.105 us    |                __virt_addr_valid();
 7)   0.110 us    |                __check_heap_object();
 7)   0.729 us    |              }
 7)   1.062 us    |            }
 7)   1.417 us    |          }
 7)   3.249 us    |        }
 7)   0.272 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.105 us    |                check_stack_object();
 7)   0.107 us    |                __virt_addr_valid();
 7)   0.128 us    |                __check_heap_object();
 7)   0.747 us    |              }
 7)   1.362 us    |            }
 7)   1.779 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.200 us    |                check_stack_object();
 7)   0.112 us    |                __virt_addr_valid();
 7)   0.110 us    |                __check_heap_object();
 7)   0.823 us    |              }
 7)   1.170 us    |            }
 7)   1.504 us    |          }
 7)   3.771 us    |        }
 7)   0.140 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.102 us    |                check_stack_object();
 7)   0.099 us    |                __virt_addr_valid();
 7)   0.130 us    |                __check_heap_object();
 7)   0.768 us    |              }
 7)   1.354 us    |            }
 7)   1.691 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.100 us    |                check_stack_object();
 7)   0.102 us    |                __virt_addr_valid();
 7)   0.108 us    |                __check_heap_object();
 7)   0.733 us    |              }
 7)   1.154 us    |            }
 7)   1.353 us    |          }
 7)   3.399 us    |        }
 7) + 33.519 us   |      }
 7)               |      kvmalloc_node() {
 7)               |        __kmalloc_node() {
 7)   0.109 us    |          kmalloc_slab();
 7)               |          _cond_resched() {
 7)   0.129 us    |            rcu_all_qs();
 7)   0.427 us    |          }
 7)   0.216 us    |          should_failslab();
 7)   0.100 us    |          memcg_kmem_put_cache();
 7)   1.461 us    |        }
 7)   1.694 us    |      }
 7)               |      kvfree() {
 7)   0.104 us    |        kfree();
 7)   0.295 us    |      }
 7)               |      btf_int_check_meta() {
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.103 us    |                check_stack_object();
 7)   0.103 us    |                __virt_addr_valid();
 7)   0.112 us    |                __check_heap_object();
 7)   0.814 us    |              }
 7)   1.530 us    |            }
 7)   1.723 us    |          }
 7)               |          btf_int_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.104 us    |                  check_stack_object();
 7)   0.103 us    |                  __virt_addr_valid();
 7)   0.108 us    |                  __check_heap_object();
 7)   0.783 us    |                }
 7)   1.719 us    |              }
 7)   1.991 us    |            }
 7)   2.343 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.101 us    |                check_stack_object();
 7)   0.102 us    |                __virt_addr_valid();
 7)   0.231 us    |                __check_heap_object();
 7)   0.970 us    |              }
 7)   1.409 us    |            }
 7)   1.630 us    |          }
 7)   6.140 us    |        }
 7)   6.476 us    |      }
 7)               |      btf_struct_check_meta() {
 7)   0.189 us    |        btf_name_valid_identifier.isra.12();
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.101 us    |                check_stack_object();
 7)   0.295 us    |                __virt_addr_valid();
 7)   0.110 us    |                __check_heap_object();
 7)   1.144 us    |              }
 7)   1.673 us    |            }
 7)   2.189 us    |          }
 7)               |          btf_struct_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.105 us    |                  check_stack_object();
 7)   0.130 us    |                  __virt_addr_valid();
 7)   0.229 us    |                  __check_heap_object();
 7)   1.106 us    |                }
 7)   1.684 us    |              }
 7)   1.891 us    |            }
 7)   2.084 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.102 us    |                check_stack_object();
 7)   0.159 us    |                __virt_addr_valid();
 7)   0.111 us    |                __check_heap_object();
 7)   1.046 us    |              }
 7)   1.342 us    |            }
 7)   1.542 us    |          }
 7)   6.222 us    |        }
 7)   0.119 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.101 us    |                check_stack_object();
 7)   0.106 us    |                __virt_addr_valid();
 7)   0.137 us    |                __check_heap_object();
 7)   0.944 us    |              }
 7)   1.407 us    |            }
 7)   1.604 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.100 us    |                check_stack_object();
 7)   0.130 us    |                __virt_addr_valid();
 7)   0.315 us    |                __check_heap_object();
 7)   1.106 us    |              } /* __check_object_size */
 7)   1.354 us    |            }
 7)   1.765 us    |          }
 7)   3.673 us    |        }
 7)   0.122 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.250 us    |                check_stack_object();
 7)   0.102 us    |                __virt_addr_valid();
 7)   0.108 us    |                __check_heap_object();
 7)   0.988 us    |              }
 7)   1.441 us    |            }
 7)   1.641 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.135 us    |                check_stack_object();
 7)   0.225 us    |                __virt_addr_valid();
 7)   0.136 us    |                __check_heap_object();
 7)   1.149 us    |              }
 7)   1.402 us    |            }
 7)   1.622 us    |          }
 7)   3.579 us    |        }
 7) + 14.613 us   |      }
 7)               |      btf_int_check_meta() {
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.104 us    |                check_stack_object();
 7)   0.132 us    |                __virt_addr_valid();
 7)   0.288 us    |                __check_heap_object();
 7)   1.112 us    |              }
 7)   1.580 us    |            }
 7)   1.781 us    |          }
 7)               |          btf_int_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.102 us    |                  check_stack_object();
 7)   0.138 us    |                  __virt_addr_valid();
 7)   0.110 us    |                  __check_heap_object();
 7)   1.131 us    |                }
 7)   1.712 us    |              }
 7)   1.983 us    |            }
 7)   2.350 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.105 us    |                check_stack_object();
 7)   0.105 us    |                __virt_addr_valid();
 7)   0.109 us    |                __check_heap_object();
 7)   0.911 us    |              }
 7)   1.170 us    |            }
 7)   1.368 us    |          }
 7)   6.101 us    |        }
 7)   6.406 us    |      }
 7)               |      btf_ref_type_check_meta() {
 7)   0.206 us    |        btf_name_valid_identifier.isra.12();
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.105 us    |                check_stack_object();
 7)   0.106 us    |                __virt_addr_valid();
 7)   0.163 us    |                __check_heap_object();
 7)   0.869 us    |              }
 7)   1.361 us    |            }
 7)   1.655 us    |          }
 7)               |          btf_ref_type_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.101 us    |                  check_stack_object();
 7)   0.103 us    |                  __virt_addr_valid();
 7)   0.108 us    |                  __check_heap_object();
 7)   0.744 us    |                }
 7)   1.180 us    |              }
 7)   1.501 us    |            }
 7)   1.691 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.148 us    |                check_stack_object();
 7)   0.337 us    |                __virt_addr_valid();
 7)   0.109 us    |                __check_heap_object();
 7)   1.138 us    |              }
 7)   1.389 us    |            }
 7)   1.605 us    |          }
 7)   5.530 us    |        }
 7)   6.215 us    |      }
 7)               |      btf_ref_type_check_meta() {
 7)   0.104 us    |        btf_name_valid_identifier.isra.12();
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.102 us    |                check_stack_object();
 7)   0.106 us    |                __virt_addr_valid();
 7)   0.110 us    |                __check_heap_object();
 7)   0.861 us    |              }
 7)   1.413 us    |            }
 7)   1.611 us    |          }
 7)               |          btf_ref_type_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.128 us    |                  check_stack_object();
 7)   0.102 us    |                  __virt_addr_valid();
 7)   0.108 us    |                  __check_heap_object();
 7)   0.846 us    |                }
 7)   1.172 us    |              }
 7)   1.409 us    |            }
 7)   1.676 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.103 us    |                check_stack_object();
 7)   0.158 us    |                __virt_addr_valid();
 7)   0.108 us    |                __check_heap_object();
 7)   1.040 us    |              }
 7)   1.292 us    |            }
 7)   1.510 us    |          }
 7)   5.320 us    |        }
 7)   5.788 us    |      }
 7)               |      btf_struct_check_meta() {
 7)   0.253 us    |        btf_name_valid_identifier.isra.12();
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.103 us    |                check_stack_object();
 7)   0.107 us    |                __virt_addr_valid();
 7)   0.427 us    |                __check_heap_object();
 7)   1.042 us    |              }
 7)   1.597 us    |            }
 7)   1.986 us    |          }
 7)               |          btf_struct_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.102 us    |                  check_stack_object();
 7)   0.104 us    |                  __virt_addr_valid();
 7)   0.111 us    |                  __check_heap_object();
 7)   0.761 us    |                }
 7)   1.306 us    |              }
 7)   1.503 us    |            }
 7)   1.721 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.102 us    |                check_stack_object();
 7)   0.102 us    |                __virt_addr_valid();
 7)   0.108 us    |                __check_heap_object();
 7)   0.932 us    |              }
 7)   1.177 us    |            }
 7)   1.417 us    |          }
 7)   5.809 us    |        }
 7)   0.109 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.104 us    |                check_stack_object();
 7)   0.103 us    |                __virt_addr_valid();
 7)   0.172 us    |                __check_heap_object();
 7)   0.948 us    |              }
 7)   1.411 us    |            }
 7)   1.609 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.189 us    |                check_stack_object();
 7)   0.104 us    |                __virt_addr_valid();
 7)   0.108 us    |                __check_heap_object();
 7)   0.919 us    |              }
 7)   1.170 us    |            }
 7)   1.401 us    |          }
 7)   3.498 us    |        }
 7)   0.125 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.105 us    |                check_stack_object();
 7)   0.107 us    |                __virt_addr_valid();
 7)   0.109 us    |                __check_heap_object();
 7)   0.766 us    |              }
 7)   1.341 us    |            }
 7)   1.600 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.147 us    |                check_stack_object();
 7)   0.105 us    |                __virt_addr_valid();
 7)   0.108 us    |                __check_heap_object();
 7)   0.864 us    |              }
 7)   1.261 us    |            }
 7)   1.478 us    |          }
 7)   3.695 us    |        }
 7) + 14.434 us   |      }
 7)               |      btf_struct_check_meta() {
 7)   0.129 us    |        btf_name_valid_identifier.isra.12();
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.105 us    |                check_stack_object();
 7)   0.104 us    |                __virt_addr_valid();
 7)   0.239 us    |                __check_heap_object();
 7)   0.958 us    |              }
 7)   1.426 us    |            }
 7)   1.689 us    |          }
 7)               |          btf_struct_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.101 us    |                  check_stack_object();
 7)   0.121 us    |                  __virt_addr_valid();
 7)   0.110 us    |                  __check_heap_object();
 7)   1.070 us    |                }
 7)   1.473 us    |              }
 7)   1.879 us    |            }
 7)   2.103 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.104 us    |                check_stack_object();
 7)   0.103 us    |                __virt_addr_valid();
 7)   0.107 us    |                __check_heap_object();
 7)   0.908 us    |              }
 7)   1.159 us    |            }
 7)   1.385 us    |          }
 7)   5.993 us    |        }
 7)   0.138 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.107 us    |                check_stack_object();
 7)   0.106 us    |                __virt_addr_valid();
 7)   0.109 us    |                __check_heap_object();
 7)   0.770 us    |              }
 7)   1.337 us    |            }
 7)   1.668 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.131 us    |                check_stack_object();
 7)   0.103 us    |                __virt_addr_valid();
 7)   0.111 us    |                __check_heap_object();
 7)   0.839 us    |              }
 7)   1.179 us    |            }
 7)   1.444 us    |          }
 7)   3.474 us    |        }
 7) + 10.523 us   |      }
 7)               |      btf_ref_type_check_meta() {
 7)   0.113 us    |        btf_name_valid_identifier.isra.12();
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.106 us    |                check_stack_object();
 7)   0.125 us    |                __virt_addr_valid();
 7)   0.132 us    |                __check_heap_object();
 7)   0.818 us    |              }
 7)   1.293 us    |            }
 7)   1.621 us    |          }
 7)               |          btf_ref_type_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.104 us    |                  check_stack_object();
 7)   0.106 us    |                  __virt_addr_valid();
 7)   0.154 us    |                  __check_heap_object();
 7)   0.938 us    |                }
 7)   1.256 us    |              }
 7)   1.459 us    |            }
 7)   1.745 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.102 us    |                check_stack_object();
 7)   0.103 us    |                __virt_addr_valid();
 7)   0.109 us    |                __check_heap_object();
 7)   0.806 us    |              }
 7)   1.193 us    |            }
 7)   1.391 us    |          }
 7)   5.251 us    |        }
 7)   5.892 us    |      }
 7)               |      btf_int_check_meta() {
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.107 us    |                check_stack_object();
 7)   0.106 us    |                __virt_addr_valid();
 7)   0.111 us    |                __check_heap_object();
 7)   0.913 us    |              }
 7)   1.579 us    |            }
 7)   1.896 us    |          }
 7)               |          btf_int_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.247 us    |                  check_stack_object();
 7)   0.115 us    |                  __virt_addr_valid();
 7)   0.373 us    |                  __check_heap_object();
 7)   1.185 us    |                }
 7)   1.847 us    |              }
 7)   2.228 us    |            }
 7)   2.577 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.102 us    |                check_stack_object();
 7)   0.123 us    |                __virt_addr_valid();
 7)   0.112 us    |                __check_heap_object();
 7)   0.797 us    |              }
 7)   1.098 us    |            }
 7)   1.297 us    |          }
 7)   6.422 us    |        }
 7)   6.683 us    |      }
 7)               |      btf_struct_check_meta() {
 7)   0.144 us    |        btf_name_valid_identifier.isra.12();
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.105 us    |                check_stack_object();
 7)   0.182 us    |                __virt_addr_valid();
 7)   0.122 us    |                __check_heap_object();
 7)   0.910 us    |              }
 7)   1.417 us    |            }
 7)   1.619 us    |          }
 7)               |          btf_struct_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.134 us    |                  check_stack_object();
 7)   0.262 us    |                  __virt_addr_valid();
 7)   0.110 us    |                  __check_heap_object();
 7)   1.061 us    |                }
 7)   1.414 us    |              }
 7)   1.615 us    |            }
 7)   1.921 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.234 us    |                check_stack_object();
 7)   0.104 us    |                __virt_addr_valid();
 7)   0.221 us    |                __check_heap_object();
 7)   1.134 us    |              }
 7)   1.389 us    |            }
 7)   1.607 us    |          }
 7)   5.555 us    |        }
 7)   0.108 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.105 us    |                check_stack_object();
 7)   0.104 us    |                __virt_addr_valid();
 7)   0.107 us    |                __check_heap_object();
 7)   0.920 us    |              }
 7)   1.487 us    |            }
 7)   1.686 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.103 us    |                check_stack_object();
 7)   0.276 us    |                __virt_addr_valid();
 7)   0.110 us    |                __check_heap_object();
 7)   0.943 us    |              }
 7)   1.196 us    |            }
 7)   1.398 us    |          }
 7)   3.526 us    |        }
 7)   0.113 us    |        btf_name_valid_identifier.isra.12();
 7)               |        btf_verifier_log_member() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.105 us    |                check_stack_object();
 7)   0.103 us    |                __virt_addr_valid();
 7)   0.109 us    |                __check_heap_object();
 7)   0.723 us    |              }
 7)   1.174 us    |            }
 7)   1.453 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.102 us    |                check_stack_object();
 7)   0.103 us    |                __virt_addr_valid();
 7)   0.332 us    |                __check_heap_object();
 7)   1.019 us    |              }
 7)   1.479 us    |            }
 7)   1.750 us    |          }
 7)   3.808 us    |        }
 7) + 13.995 us   |      }
 7)               |      btf_ref_type_check_meta() {
 7)   0.125 us    |        btf_name_valid_identifier.isra.12();
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.136 us    |                check_stack_object();
 7)   0.102 us    |                __virt_addr_valid();
 7)   0.107 us    |                __check_heap_object();
 7)   0.861 us    |              }
 7)   1.449 us    |            }
 7)   1.673 us    |          }
 7)               |          btf_ref_type_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.102 us    |                  check_stack_object();
 7)   0.101 us    |                  __virt_addr_valid();
 7)   0.110 us    |                  __check_heap_object();
 7)   0.728 us    |                }
 7)   1.084 us    |              }
 7)   1.436 us    |            }
 7)   1.623 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.100 us    |                check_stack_object();
 7)   0.101 us    |                __virt_addr_valid();
 7)   0.135 us    |                __check_heap_object();
 7)   0.870 us    |              }
 7)   1.118 us    |            }
 7)   1.397 us    |          }
 7)   5.199 us    |        }
 7)   5.621 us    |      }
 7)               |      btf_ref_type_check_meta() {
 7)   0.366 us    |        btf_name_valid_identifier.isra.12();
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.106 us    |                check_stack_object();
 7)   0.263 us    |                __virt_addr_valid();
 7)   0.112 us    |                __check_heap_object();
 7)   1.007 us    |              }
 7)   1.518 us    |            }
 7)   1.719 us    |          }
 7)               |          btf_ref_type_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.105 us    |                  check_stack_object();
 7)   0.294 us    |                  __virt_addr_valid();
 7)   0.110 us    |                  __check_heap_object();
 7)   0.959 us    |                }
 7)   1.268 us    |              }
 7)   1.470 us    |            }
 7)   1.755 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.104 us    |                check_stack_object();
 7)   0.106 us    |                __virt_addr_valid();
 7)   0.112 us    |                __check_heap_object();
 7)   0.882 us    |              }
 7)   1.157 us    |            }
 7)   1.360 us    |          }
 7)   5.297 us    |        }
 7)   5.996 us    |      }
 7)               |      btf_array_check_meta() {
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.103 us    |                check_stack_object();
 7)   0.234 us    |                __virt_addr_valid();
 7)   0.109 us    |                __check_heap_object();
 7)   0.850 us    |              }
 7)   1.322 us    |            }
 7)   1.517 us    |          }
 7)               |          btf_array_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.105 us    |                  check_stack_object();
 7)   0.103 us    |                  __virt_addr_valid();
 7)   0.108 us    |                  __check_heap_object();
 7)   0.938 us    |                }
 7)   1.438 us    |              }
 7)   1.636 us    |            }
 7)   1.901 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.202 us    |                check_stack_object();
 7)   0.106 us    |                __virt_addr_valid();
 7)   0.137 us    |                __check_heap_object();
 7)   1.067 us    |              }
 7)   1.323 us    |            }
 7)   1.543 us    |          }
 7)   5.507 us    |        }
 7)   5.894 us    |      }
 7)               |      btf_int_check_meta() {
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.105 us    |                check_stack_object();
 7)   0.150 us    |                __virt_addr_valid();
 7)   0.111 us    |                __check_heap_object();
 7)   1.007 us    |              }
 7)   1.675 us    |            }
 7)   1.905 us    |          }
 7)               |          btf_int_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.104 us    |                  check_stack_object();
 7)   0.104 us    |                  __virt_addr_valid();
 7)   0.322 us    |                  __check_heap_object();
 7)   0.981 us    |                }
 7)   1.503 us    |              }
 7)   1.705 us    |            }
 7)   1.907 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.103 us    |                check_stack_object();
 7)   0.104 us    |                __virt_addr_valid();
 7)   0.108 us    |                __check_heap_object();
 7)   0.722 us    |              }
 7)   1.257 us    |            }
 7)   1.638 us    |          }
 7)   5.861 us    |        }
 7)   6.055 us    |      }
 7)               |      btf_int_check_meta() {
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.105 us    |                check_stack_object();
 7)   0.106 us    |                __virt_addr_valid();
 7)   0.145 us    |                __check_heap_object();
 7)   0.866 us    |              }
 7)   1.356 us    |            }
 7)   1.623 us    |          }
 7)               |          btf_int_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.102 us    |                  check_stack_object();
 7)   0.101 us    |                  __virt_addr_valid();
 7)   0.244 us    |                  __check_heap_object();
 7)   0.909 us    |                }
 7)   1.438 us    |              }
 7)   1.675 us    |            }
 7)   1.937 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.240 us    |                check_stack_object();
 7)   0.129 us    |                __virt_addr_valid();
 7)   0.108 us    |                __check_heap_object();
 7)   1.029 us    |              }
 7)   1.326 us    |            }
 7)   1.671 us    |          }
 7)   5.772 us    |        }
 7)   5.981 us    |      }
 7)               |      kvmalloc_node() {
 7)               |        __kmalloc_node() {
 7)   0.103 us    |          kmalloc_slab();
 7)               |          _cond_resched() {
 7)   0.265 us    |            rcu_all_qs();
 7)   0.460 us    |          }
 7)   0.099 us    |          should_failslab();
 7)   0.102 us    |          memcg_kmem_put_cache();
 7)   1.276 us    |        }
 7)   1.490 us    |      }
 7)               |      kvfree() {
 7)   0.119 us    |        kfree();
 7)   0.304 us    |      }
 7)               |      btf_ref_type_check_meta() {
 7)               |        __btf_verifier_log_type() {
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.103 us    |                check_stack_object();
 7)   0.100 us    |                __virt_addr_valid();
 7)   0.109 us    |                __check_heap_object();
 7)   0.746 us    |              }
 7)   1.210 us    |            }
 7)   1.407 us    |          }
 7)               |          btf_ref_type_log() {
 7)               |            btf_verifier_log() {
 7)               |              bpf_verifier_vlog() {
 7)               |                __check_object_size() {
 7)   0.097 us    |                  check_stack_object();
 7)   0.101 us    |                  __virt_addr_valid();
 7)   0.107 us    |                  __check_heap_object();
 7)   0.707 us    |                }
 7)   1.013 us    |              }
 7)   1.210 us    |            }
 7)   1.402 us    |          }
 7)               |          __btf_verifier_log() {
 7)               |            bpf_verifier_vlog() {
 7)               |              __check_object_size() {
 7)   0.101 us    |                check_stack_object();
 7)   0.115 us    |                __virt_addr_valid();
 7)   0.108 us    |                __check_heap_object();
 7)   0.737 us    |              }
 7)   0.990 us    |            }
 7)   1.188 us    |          }
 7)   4.405 us    |        }
 7)   4.608 us    |      }
 7)               |      btf_verifier_log() {
 7)               |        bpf_verifier_vlog() {
 7)               |          __check_object_size() {
 7)   0.107 us    |            check_stack_object();
 7)   0.106 us    |            __virt_addr_valid();
 7)   0.112 us    |            __check_heap_object();
 7)   0.744 us    |          }
 7)   1.545 us    |        }
 7)   1.745 us    |      }
 7)               |      kvfree() {
 7)   0.106 us    |        kfree();
 7)   0.296 us    |      }
 7)   0.120 us    |      kfree();
 7)               |      btf_free() {
 7)               |        kvfree() {
 7)   0.115 us    |          kfree();
 7)   0.298 us    |        }
 7)               |        kvfree() {
 7)   0.103 us    |          kfree();
 7)   0.291 us    |        }
 7)               |        kvfree() {
 7)   0.097 us    |          kfree();
 7)   0.281 us    |        }
 7)               |        kvfree() {
 7)   0.113 us    |          kfree();
 7)   0.300 us    |        }
 7)   0.103 us    |        kfree();
 7)   1.870 us    |      }
 7) ! 194.466 us  |    }
 7) ! 195.945 us  |  }

 Looking at 'perf trace -vv' the only messages that seem to have come
 from libbpf are:

INFO: nothing to config for map syscalls
INFO: nothing to config for map pids_filtered

   So, what am I missing?

- Arnaldo
