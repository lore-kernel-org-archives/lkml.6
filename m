Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbeCLN4f (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbeCLN4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:56:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13893204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 12 Mar 2018 10:56:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Brendan Gregg <bgregg@netflix.com>,
        Stanislav Kozina <skozina@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>, Will Cohen <wcohen@redhat.com>,
        Eugene Syromiatnikov <esyromia@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, Jiri Olsa <jolsa@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@fb.com>
Subject: Re: [RFC 00/13] perf bpf: Add support to run BEGIN/END code
Message-ID: <20180312135628.GB4882@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
 <20180312111705.GA23111@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312111705.GA23111@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 12, 2018 at 12:17:05PM +0100, Jiri Olsa escreveu:
> adding Alexei and Wang to the loop
> 
> On Mon, Mar 12, 2018 at 10:43:00AM +0100, Jiri Olsa wrote:
> > hi,
> > this is *RFC* and the following patchset is very rough
> > and ugly 'prove of concept'-kind-of-toy code. I'm mostly
> > interested in opinions about if this could be useful in
> > your current eBPF usage.
> > 
> > Currently we can load eBPF code within the record command
> > and attach it to event. We have 2 ways of communicating
> > the data back to user: bpf-output event that goes to
> > perf.data or 'trace_printk' output in tracefs buffer.
> > 
> > AFAICS we're not covering quite large usage base that runs
> > code before and once the probe is finished to setup, collect
> > and display the collected data.
> > 
> > This patchset is adding support to run BEGIN and END
> > code snipets before and after eBPF probe is loaded.

Right, with all the code that Wang contributed, and reusing that
begin/end code from systemtap, it was easy to do it, not that much code
added, so I don't see a reason for this not to be merged.

On top of this patchset, I think that the restricted C code that is used
to write the eBPF utilities should be simplified, I've toyed with this
from time to time, for instance:

[root@jouet bpf]# cat o_cloexec.c 
#include "bpf.h"
#include "stdio.h"

#define O_CLOEXEC       0x80000

int syscall_enter(openat)
{
	char filename[256];
	int flags = syscall_field_int(flags, 32);
	int len = syscall_field_str(filename, 24);

	if (!(flags & O_CLOEXEC))
		return 0;

	perf_stdout(filename, len);
	return 1;
}

[root@jouet bpf]# perf trace -e openat,o_cloexec.c
     0.573 (         ): __bpf_stdout__:/etc/ld.so.cache....)
     0.576 (         ): syscalls:sys_enter_openat:dfd: 0xffffffffffffff9c, filename: 0x7fc4de411563, flags: 0x00080000, mode: 0x00000000)
     0.579 ( 0.013 ms): sh/17728 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC           ) = 3
     0.620 (         ): __bpf_stdout__:/lib64/libtinfo.so.6........)
     0.622 (         ): syscalls:sys_enter_openat:dfd: 0xffffffffffffff9c, filename: 0x7fc4de619ce0, flags: 0x00080000, mode: 0x00000000)
     0.624 ( 0.013 ms): sh/17728 openat(dfd: CWD, filename: /lib64/libtinfo.so.6, flags: CLOEXEC       ) = 3
     0.705 (         ): __bpf_stdout__:/lib64/libdl.so.2...)
     0.708 (         ): syscalls:sys_enter_openat:dfd: 0xffffffffffffff9c, filename: 0x7fc4de5ef4c0, flags: 0x00080000, mode: 0x00000000)
     0.710 ( 0.058 ms): sh/17728 openat(dfd: CWD, filename: /lib64/libdl.so.2, flags: CLOEXEC          ) = 3
     0.852 (         ): __bpf_stdout__:/lib64/libc.so.6....)
     0.857 (         ): syscalls:sys_enter_openat:dfd: 0xffffffffffffff9c, filename: 0x7fc4de5ef9a0, flags: 0x00080000, mode: 0x00000000)
     0.860 ( 0.021 ms): sh/17728 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 3
^C
[root@jouet bpf]#

Hiding details such as:

[root@jouet bpf]# cat stdio.h 
struct bpf_map_def SEC("maps") __bpf_stdout__ = {
       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
       .key_size = sizeof(int),
       .value_size = sizeof(u32),
       .max_entries = __NR_CPUS__,
};

#define perf_stdout(from, len) \
	perf_event_output(ctx, &__bpf_stdout__, BPF_F_CURRENT_CPU, \
			  &from, len & (sizeof(from) - 1));
[root@jouet bpf]#

That 'perf trace' will setup "bpf_output" event, etc.

And the other macros:

#define SEC(NAME) __attribute__((section(NAME), used))

#define pid_map(name, value_type) \
struct bpf_map_def SEC("maps") name = { \
        .type        = BPF_MAP_TYPE_HASH, \
        .key_size    = sizeof(u64), \
        .value_size  = sizeof(value_type), \
        .max_entries = 500, \
}

#define syscall_enter(name) \
        SEC("syscalls:sys_enter_" #name) syscall_enter_ ## name(void *ctx)

#define syscall_exit(name) \
        SEC("syscalls:sys_exit_" #name) syscall_exit_ ## name(void *ctx)

#define syscall_field_str(field, offset) \
        ({ char *__ptr = *((char **)(ctx + offset)); \
           bpf_probe_read_str(field, sizeof(field), __ptr); })

#define syscall_field_int(field, offset) \
        ({ int *__ptr = (int *)(ctx + offset); \
           bpf_probe_read(&field, sizeof(field), __ptr); field; }

While this hides some of the details, it still hardcodes the offset, so
should be used that way, I was trying to read about clang internals to
do some preprocessing trick that would automagically make the tracepoint
fields accessible as local variables, reading the tracepoint format
files from the running system or from the description stored in the
perf.data header, when running these things on perf.data files.

- Arnaldo
