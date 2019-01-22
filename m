Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E5AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E47B21721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548168501;
	bh=D6u7spcp7GsS4GUzimQhFGMXnLLBNI2Jp0dGFTI5vZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KrVtCVQj9eRKablznuuimqfHDHqrZmNSLuIT+q3Cc5o5kexAOy6ojJYRIFM5DToaM
	 /3D/14DUgj+SZrytUVZtJpNtwNc8E69vItVuncpJ24nlSrhc5ZHGic3ewB2Luo2OCM
	 B5U5yUdn83LZcPxGhx1t7zgof06UDm3/hsHdO6wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfAVOsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:48:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbfAVOsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:48:19 -0500
Received: from quaco.ghostprotocols.net (unknown [189.16.122.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A3921019;
        Tue, 22 Jan 2019 14:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548168498;
        bh=D6u7spcp7GsS4GUzimQhFGMXnLLBNI2Jp0dGFTI5vZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKaYrt7ew0zMjw6Klv9ilzx2Q24ypaDiVqMISg3EP9gRG2/5p99nXXjPeWOKDXsaK
         fUFLwaH8JJ7Ti567JBsYZjnHxBV4zXxbqnRFu6rFVY5EDfvA1bMqF3mML2SURCsB8e
         i0nm8wdG+U4FJeX0ASh4JRC9ffB0R9xwOUSs51bg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 91D2C40355; Tue, 22 Jan 2019 12:48:15 -0200 (-02)
Date:   Tue, 22 Jan 2019 12:48:15 -0200
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v11 perf, bpf-next 7/9] perf tools: synthesize
 PERF_RECORD_* for loaded BPF programs
Message-ID: <20190122144815.GH14973@kernel.org>
References: <20190117161521.1341602-1-songliubraving@fb.com>
 <20190117161521.1341602-8-songliubraving@fb.com>
 <20190118144655.GM5823@kernel.org>
 <20190122141320.GF14973@kernel.org>
 <20190122143117.GG14973@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122143117.GG14973@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 22, 2019 at 12:31:17PM -0200, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jan 22, 2019 at 12:13:20PM -0200, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Jan 18, 2019 at 11:46:55AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Jan 17, 2019 at 08:15:19AM -0800, Song Liu escreveu:
> > > > This patch synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for
> > > > BPF programs loaded before perf-record. This is achieved by gathering
> > > > information about all BPF programs via sys_bpf.
> > > 
> > > Ditto
> > 
> > This is breaking 'perf sched', see below, the fix seems trivial:
> > 
> > [root@quaco ~]# perf sched record -a sleep 2
> > [ perf record: Woken up 1 times to write data ]
> > 0x5b60 [0x138]: failed to process type: 17
> > [ perf record: Captured and wrote 1.539 MB perf.data ]
> > [root@quaco ~]# perf sched lat
> > 0x5b60 [0x138]: failed to process type: 17
> > Failed to process events, error -22
> > [root@quaco ~]#
> 
> So:
> 
>    perf_session__process_event (event->header.type = 17 (PERF_RECORD_KSYMBOL)
>      if (tool->ordered_events)
>        ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
>        if (ret && ret != -1)
>             return ret;
> 
> So it returns here with -EFAULT, i.e. this is failing:
> 
> int perf_evlist__parse_sample_timestamp(struct perf_evlist *evlist,
>                                         union perf_event *event,
>                                         u64 *timestamp)
> {
>         struct perf_evsel *evsel = perf_evlist__event2evsel(evlist, event);
> 
>         if (!evsel)
>                 return -EFAULT;
>         return perf_evsel__parse_sample_timestamp(evsel, event, timestamp);
> }
> 
> It isn't mapping the event ID it finds back to an evsel.. Jiri, ideas?
> 
> This is happening so far only for 'perf sched', perf record with two
> events works.

So it fails for tracepoints with plain 'perf record':

[root@quaco tmp]# perf record -e sched:sched* sleep 1
[ perf record: Woken up 29 times to write data ]
0x6658 [0x138]: failed to process type: 17
[ perf record: Captured and wrote 0.029 MB perf.data ]
[root@quaco tmp]# perf script
0x6658 [0x138]: failed to process type: 17
[root@quaco tmp]#

[ perf record: Woken up 1 times to write data ]

Breakpoint 1, reader__process_events (rd=0x7ffffffe4160, session=0xab66a0, prog=0x7ffffffe4180) at util/session.c:1911
1911			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-28.fc29.x86_64 elfutils-libelf-0.174-5.fc29.x86_64 elfutils-libs-0.174-5.fc29.x86_64 glib2-2.58.2-1.fc29.x86_64 libbabeltrace-1.5.6-1.fc29.x86_64 libunwind-1.2.1-6.fc29.x86_64 libuuid-2.32.1-1.fc29.x86_64 libxcrypt-4.4.2-3.fc29.x86_64 numactl-libs-2.0.12-1.fc29.x86_64 openssl-libs-1.1.1a-1.fc29.x86_64 pcre-8.42-6.fc29.x86_64 perl-libs-5.28.1-427.fc29.x86_64 popt-1.16-15.fc29.x86_64 python2-libs-2.7.15-11.fc29.x86_64 slang-2.3.2-4.fc29.x86_64 xz-libs-5.2.4-3.fc29.x86_64
(gdb) bt
#0  reader__process_events (rd=0x7ffffffe4160, session=0xab66a0, prog=0x7ffffffe4180) at util/session.c:1911
#1  0x0000000000540deb in __perf_session__process_events (session=0xab66a0) at util/session.c:1955
#2  0x0000000000540f1c in perf_session__process_events (session=0xab66a0) at util/session.c:1988
#3  0x0000000000445feb in process_buildids (rec=0x9202a0 <record>) at builtin-record.c:689
#4  0x0000000000446597 in record__finish_output (rec=0x9202a0 <record>) at builtin-record.c:846
#5  0x0000000000447b8c in __cmd_record (rec=0x9202a0 <record>, argc=2, argv=0xab4720) at builtin-record.c:1429
#6  0x0000000000448d64 in cmd_record (argc=2, argv=0xab4720) at builtin-record.c:2153
#7  0x00000000004406dd in __cmd_record (argc=3, argv=0x7fffffffdb30) at builtin-sched.c:3339
#8  0x00000000004411ff in cmd_sched (argc=3, argv=0x7fffffffdb30) at builtin-sched.c:3486
#9  0x00000000004d46e3 in run_builtin (p=0x932c50 <commands+432>, argc=4, argv=0x7fffffffdb30) at perf.c:302
#10 0x00000000004d4950 in handle_internal_command (argc=4, argv=0x7fffffffdb30) at perf.c:354
#11 0x00000000004d4a9f in run_argv (argcp=0x7fffffffd98c, argv=0x7fffffffd980) at perf.c:398
#12 0x00000000004d4e0b in main (argc=4, argv=0x7fffffffdb30) at perf.c:520
(gdb)

[root@quaco tmp]# perf c2c record
^C[ perf record: Woken up 1 times to write data ]
0x5698 [0x138]: failed to process type: 17
[ perf record: Captured and wrote 7.110 MB perf.data ]

[root@quaco tmp]# perf kmem record
^C[ perf record: Woken up 1 times to write data ]
0x5998 [0x138]: failed to process type: 17
[ perf record: Captured and wrote 1.470 MB perf.data ]

[root@quaco tmp]#
