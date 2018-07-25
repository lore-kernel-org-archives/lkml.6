Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C91C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96A42064D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A96A42064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbeGYGqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 02:46:12 -0400
Received: from www62.your-server.de ([213.133.104.62]:42851 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeGYGqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 02:46:12 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiCSy-00071h-T6; Wed, 25 Jul 2018 07:36:04 +0200
Received: from [2601:647:4601:b6c5::9c2f] (helo=localhost.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fiCSy-000Thz-9f; Wed, 25 Jul 2018 07:36:04 +0200
Subject: Re: [PATCH] perf build: Build error in libbpf with
 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
To:     Thomas Richter <tmricht@linux.ibm.com>, ast@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     heiko.carstens@de.ibm.com, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, wangnan0@huawei.com
References: <20180724151011.36495-1-tmricht@linux.ibm.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <94ad1c4c-cf22-dfed-4e16-455443f205aa@iogearbox.net>
Date:   Wed, 25 Jul 2018 07:35:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180724151011.36495-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24780/Wed Jul 25 02:42:30 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/2018 05:10 PM, Thomas Richter wrote:
> commit a5b8bd47dcc57 ("bpf tools: Collect eBPF programs from their own sections")
> 
> cause a compiler error when building the perf tool in the linux-next tree.
> I compile it using a FEDORA 28 installation, my gcc compiler version:
> gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
> 
> The file that causes the error is tools/lib/bpf/libbpf.c
> 
> Here is the error message:
> 
> [root@p23lp27] # make V=1 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
> [...]
> make -f /home6/tmricht/linux-next/tools/build/Makefile.build
> 	dir=./util/scripting-engines obj=libperf
> libbpf.c: In function ‘bpf_object__elf_collect’:
> libbpf.c:811:15: error: ignoring return value of ‘strerror_r’,
> 		declared with attribute warn_unused_result [-Werror=unused-result]
>      strerror_r(-err, errmsg, sizeof(errmsg));
>                ^
> cc1: all warnings being treated as errors
> mv: cannot stat './.libbpf.o.tmp': No such file or directory
> /home6/tmricht/linux-next/tools/build/Makefile.build:96: recipe for target 'libbpf.o' failed
> 
> Fix this by using strerror_r return value in pr_warning statement.
> Also fixes a possible initialization issue.
> 
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/lib/bpf/libbpf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 955f8eafbf41..c70785ea903c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -808,9 +808,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
>  			if (err) {
>  				char errmsg[STRERR_BUFSIZE];
>  
> -				strerror_r(-err, errmsg, sizeof(errmsg));
>  				pr_warning("failed to alloc program %s (%s): %s",
> -					   name, obj->path, errmsg);
> +					   name, obj->path,
> +					   strerror_r(-err, errmsg, sizeof(errmsg)));

This doesn't build for me. Doing this here won't work since it uses
strerror_r() variant that returns an int (which is posix variant and
not gnu specific one that would return char *):

# make
  BUILD:   Doing 'make -j4' parallel build
  HOSTCC   fixdep.o
  HOSTLD   fixdep-in.o
  LINK     fixdep
Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at 'arch/powerpc/include/uapi/asm/unistd.h'
Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ OFF ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                      libslang: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]

Makefile.config:443: No sys/sdt.h found, no SDT events are defined, please install systemtap-sdt-devel or systemtap-sdt-dev
Makefile.config:610: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
Makefile.config:637: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
Makefile.config:669: No 'python-config' tool was found: disables Python support - please install python-devel/python-dev
Makefile.config:812: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
Makefile.config:849: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
  GEN      common-cmds.h
  CC       fd/array.o
  CC       event-parse.o
  PERF_VERSION = 4.18.rc5.g56801c
  CC       fs/fs.o
  LD       fd/libapi-in.o
  CC       fs/tracing_path.o
  CC       event-plugin.o
  LD       fs/libapi-in.o
  CC       cpu.o
  CC       debug.o
  CC       trace-seq.o
  CC       str_error_r.o
  LD       libapi-in.o
  CC       exec-cmd.o
  AR       libapi.a
  CC       parse-filter.o
  CC       parse-utils.o
  CC       help.o
  CC       pager.o
Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'
  CC       kbuffer-parse.o
  CC       libbpf.o
  LD       libtraceevent-in.o
  LINK     libtraceevent.a
libbpf.c: In function ‘bpf_object__elf_collect’:
libbpf.c:81:10: error: format ‘%s’ expects argument of type ‘char *’, but argument 4 has type ‘int’ [-Werror=format=]
   (func)("libbpf: " fmt, ##__VA_ARGS__); \
          ^
libbpf.c:84:30: note: in expansion of macro ‘__pr’
 #define pr_warning(fmt, ...) __pr(__pr_warning, fmt, ##__VA_ARGS__)
                              ^~~~
libbpf.c:858:5: note: in expansion of macro ‘pr_warning’
     pr_warning("failed to alloc program %s (%s): %s",
     ^~~~~~~~~~
  CC       parse-options.o
  HOSTCC   pmu-events/json.o
  CC       run-command.o
  HOSTCC   pmu-events/jsmn.o
cc1: all warnings being treated as errors


>  			}
>  		} else if (sh.sh_type == SHT_REL) {
>  			void *reloc = obj->efile.reloc;
> @@ -2334,7 +2334,7 @@ bpf_perf_event_read_simple(void *mem, unsigned long size,
>  	__u64 data_tail = header->data_tail;
>  	__u64 data_head = header->data_head;
>  	void *base, *begin, *end;
> -	int ret;
> +	int ret = 0;
>  
>  	asm volatile("" ::: "memory"); /* in real code it should be smp_rmb() */
>  	if (data_head == data_tail)
> 

