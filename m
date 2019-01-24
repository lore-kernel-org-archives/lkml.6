Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8F9C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2017921872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548325761;
	bh=w5Nf/AsXwzRipOdiswXGk7XkdYniG9kNR51Y39PmBw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TAiUMyleSKC98pDPnlqaAim3aritDFDcpQ75xTrqssaCDj1qZknLOk0fZcJleTGVN
	 U9KfXJlhjpifPOP2XWQjm/vGJmLSvADG8c7TZ5Uw9W6c7LaIgNubnpzWuUjqrhoHPO
	 yh+LZHO9nO2OoqdCopkYhmTGu7pQRKyfQuh11ayw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfAXK3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:29:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfAXK3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:29:19 -0500
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE81217D4;
        Thu, 24 Jan 2019 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548325758;
        bh=w5Nf/AsXwzRipOdiswXGk7XkdYniG9kNR51Y39PmBw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eoBeDTw6+nGMRQfGNtr1vo02zYpKsyLhfHYeUygbgajgMlSr9bQeBDItljdWw5UTt
         WRGyKrcz4sWSLGqbolyATW04hNqrnHvXHCZ0NvX9b63SLoXnaxTKME6E2JMHdUwFzA
         EhjhAjTtIC2ciqdka+VNVJM/MnfbNbuam5NNuIx8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B380D40355; Thu, 24 Jan 2019 11:29:15 +0100 (CET)
Date:   Thu, 24 Jan 2019 11:29:15 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH perf] perf tools: fix synthesized
 PERF_RECORD_KSYMBOL/BPF_EVENT
Message-ID: <20190124102915.GA30768@kernel.org>
References: <20190122210218.358664-1-songliubraving@fb.com>
 <20190124094946.GK14973@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124094946.GK14973@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 24, 2019 at 10:49:46AM +0100, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jan 22, 2019 at 01:02:18PM -0800, Song Liu escreveu:
> > Added missing machine->id_hdr_size to event->header.size. Also fixed size
> > of PERF_RECORD_KSYMBOL by removing extra bytes for name.
> 
> Ok, noticed this now, thanks,
> 
> - Arnaldo
>  
> > Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Suggested-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Song Liu <songliubraving@fb.com>
> > ---
> >  tools/perf/util/bpf-event.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> > index 01e1dc1bb7fb..f610872812ef 100644
> > --- a/tools/perf/util/bpf-event.c
> > +++ b/tools/perf/util/bpf-event.c
> > @@ -7,6 +7,7 @@
> >  #include "bpf-event.h"
> >  #include "debug.h"
> >  #include "symbol.h"
> > +#include "machine.h"
> >  
> >  #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
> >  
> > @@ -149,7 +150,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
> >  		*ksymbol_event = (struct ksymbol_event){
> >  			.header = {
> >  				.type = PERF_RECORD_KSYMBOL,
> > -				.size = sizeof(struct ksymbol_event),
> > +				.size = offsetof(struct ksymbol_event, name),
> >  			},
> >  			.addr = prog_addrs[i],
> >  			.len = prog_lens[i],
> > @@ -178,6 +179,9 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
> >  
> >  		ksymbol_event->header.size += PERF_ALIGN(name_len + 1,
> >  							 sizeof(u64));
> > +
> > +		memset(event + event->header.size, 0, machine->id_hdr_size);
> > +		event->header.size += machine->id_hdr_size;
> >  		err = perf_tool__process_synth_event(tool, event,
> >  						     machine, process);
> >  	}
> > @@ -194,6 +198,8 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
> >  			.id = info.id,
> >  		};
> >  		memcpy(bpf_event->tag, prog_tags[i], BPF_TAG_SIZE);
> > +		memset(event + event->header.size, 0, machine->id_hdr_size);
> > +		event->header.size += machine->id_hdr_size;

So, you need the patch below as well, the last bit isn't needed if your
ksymbol name is short, so one doesn't notice this when not applying that
last patch but it is needed:

Program received signal SIGSEGV, Segmentation fault.
__memset_avx2_unaligned_erms () at ../sysdeps/x86_64/multiarch/memset-vec-unaligned-erms.S:170
170		VMOVU	%VEC(0), -VEC_SIZE(%rdi,%rdx)
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-28.fc29.x86_64 elfutils-libelf-0.174-5.fc29.x86_64 elfutils-libs-0.174-5.fc29.x86_64 glib2-2.58.2-1.fc29.x86_64 libbabeltrace-1.5.6-1.fc29.x86_64 libunwind-1.2.1-6.fc29.x86_64 libuuid-2.32.1-1.fc29.x86_64 libxcrypt-4.4.2-3.fc29.x86_64 numactl-libs-2.0.12-1.fc29.x86_64 openssl-libs-1.1.1a-1.fc29.x86_64 pcre-8.42-6.fc29.x86_64 perl-libs-5.28.1-427.fc29.x86_64 popt-1.16-15.fc29.x86_64 python2-libs-2.7.15-11.fc29.x86_64 slang-2.3.2-4.fc29.x86_64 xz-libs-5.2.4-3.fc29.x86_64
(gdb) bt
#0  __memset_avx2_unaligned_erms () at ../sysdeps/x86_64/multiarch/memset-vec-unaligned-erms.S:170
#1  0x00000000005e0054 in perf_event__synthesize_one_bpf_prog (tool=0x9202a0 <record>, process=0x4451dc <process_synthesized_event>,
    machine=0xab67a0, fd=77, event=0xb4dd90, opts=0x9203b0 <record+272>) at util/bpf-event.c:183
#2  0x00000000005e03a3 in perf_event__synthesize_bpf_events (tool=0x9202a0 <record>, process=0x4451dc <process_synthesized_event>,
    machine=0xab67a0, opts=0x9203b0 <record+272>) at util/bpf-event.c:250
#3  0x0000000000446eac in record__synthesize (rec=0x9202a0 <record>, tail=false) at builtin-record.c:1086
#4  0x000000000044740f in __cmd_record (rec=0x9202a0 <record>, argc=2, argv=0xab4720) at builtin-record.c:1209
#5  0x0000000000448d64 in cmd_record (argc=2, argv=0xab4720) at builtin-record.c:2153
#6  0x00000000004406dd in __cmd_record (argc=3, argv=0x7fffffffdb30) at builtin-sched.c:3339
#7  0x00000000004411ff in cmd_sched (argc=3, argv=0x7fffffffdb30) at builtin-sched.c:3486
#8  0x00000000004d46e3 in run_builtin (p=0x932c50 <commands+432>, argc=4, argv=0x7fffffffdb30) at perf.c:302
#9  0x00000000004d4950 in handle_internal_command (argc=4, argv=0x7fffffffdb30) at perf.c:354
#10 0x00000000004d4a9f in run_argv (argcp=0x7fffffffd98c, argv=0x7fffffffd980) at perf.c:398
#11 0x00000000004d4e0b in main (argc=4, argv=0x7fffffffdb30) at perf.c:520
(gdb) fr 1
#1  0x00000000005e0054 in perf_event__synthesize_one_bpf_prog (tool=0x9202a0 <record>, process=0x4451dc <process_synthesized_event>,
    machine=0xab67a0, fd=77, event=0xb4dd90, opts=0x9203b0 <record+272>) at util/bpf-event.c:183
183			memset(event + event->header.size, 0, machine->id_hdr_size);
(gdb) p machine->id_hdr_size
$1 = 32
(gdb) p event
$2 = (union perf_event *) 0xb4dd90
(gdb) p event->header.size
$3 = 56

I'm folding the fixes below into your fix, thanks.

- Arnaldo

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index f610872812ef..b62c976e7c4c 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -180,7 +180,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 		ksymbol_event->header.size += PERF_ALIGN(name_len + 1,
 							 sizeof(u64));
 
-		memset(event + event->header.size, 0, machine->id_hdr_size);
+		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
 		event->header.size += machine->id_hdr_size;
 		err = perf_tool__process_synth_event(tool, event,
 						     machine, process);
@@ -198,7 +198,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 			.id = info.id,
 		};
 		memcpy(bpf_event->tag, prog_tags[i], BPF_TAG_SIZE);
-		memset(event + event->header.size, 0, machine->id_hdr_size);
+		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
 		event->header.size += machine->id_hdr_size;
 		err = perf_tool__process_synth_event(tool, event,
 						     machine, process);
@@ -223,7 +223,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 	int err;
 	int fd;
 
-	event = malloc(sizeof(event->bpf_event) + KSYM_NAME_LEN);
+	event = malloc(sizeof(event->bpf_event) + KSYM_NAME_LEN + machine->id_idr_size);
 	if (!event)
 		return -1;
 	while (true) {
