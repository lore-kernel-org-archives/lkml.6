Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9443FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AB0208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="khB+hH3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AB0208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbeGaPBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:01:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732110AbeGaPBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:01:04 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1378820894;
        Tue, 31 Jul 2018 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533043245;
        bh=ZUTLJ1AMns46orV7eMpll9+c8SVEORWg7voiZxvPjWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khB+hH3j9imbL+jtEOgYuRsozwWaKz1wx3sclj0UAzwAB8yYPUD3ye+0vcfhXoxqA
         RXnT5I4rw6gOT0YUidM1rvuOaFWISf4n9tWDsHcJz+YqA+IAQqeHIDC3MUwHHkeGFc
         BJh6J+PSXUhu1MHB6WZhAhVTwZ6/jABgY6d+QF7U=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 754F81403B8; Tue, 31 Jul 2018 10:20:42 -0300 (-03)
Date:   Tue, 31 Jul 2018 10:20:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v2] perf build: Fix installation directory for bpf
Message-ID: <20180731132042.GA4909@kernel.org>
References: <20180731073254.91090-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731073254.91090-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 31, 2018 at 09:32:54AM +0200, Thomas Richter escreveu:
> Output after using command ./perf test -Fv 40:
> echo '...[bpf-program-source]...' | /usr/bin/clang ... \
> 		 -I/root/lib/perf/include/bpf ...
>                              ^^^^^^^^^^^^
> ...
> [root@p23lp27 perf]# ./perf test -F 40
> 40: BPF filter                                            :
> 40.1: Basic BPF filtering                                 : Ok
> 40.2: BPF pinning                                         : Ok
> 40.3: BPF prologue generation                             : Ok
> 40.4: BPF relocation checker                              : Ok
> [root@p23lp27 perf]#

So, testing it:

[root@jouet perf]# cat tools/perf/examples/bpf/5sec.c
// SPDX-License-Identifier: GPL-2.0
/*
    Description:

    . Disable strace like syscall tracing (--no-syscalls), or try tracing
      just some (-e *sleep).

    . Attach a filter function to a kernel function, returning when it should
      be considered, i.e. appear on the output.

    . Run it system wide, so that any sleep of >= 5 seconds and < than 6
      seconds gets caught.

    . Ask for callgraphs using DWARF info, so that userspace can be unwound

    . While this is running, run something like "sleep 5s".

    . If we decide to add tv_nsec as well, then it becomes:

      int probe(hrtimer_nanosleep, rqtp->tv_sec rqtp->tv_nsec)(void *ctx, int err, long sec, long nsec)

      I.e. add where it comes from (rqtp->tv_nsec) and where it will be
      accessible in the function body (nsec)

    # perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c/call-graph=dwarf/
         0.000 perf_bpf_probe:func:(ffffffff9811b5f0) tv_sec=5
                                           hrtimer_nanosleep ([kernel.kallsyms])
                                           __x64_sys_nanosleep ([kernel.kallsyms])
                                           do_syscall_64 ([kernel.kallsyms])
                                           entry_SYSCALL_64 ([kernel.kallsyms])
                                           __GI___nanosleep (/usr/lib64/libc-2.26.so)
                                           rpl_nanosleep (/usr/bin/sleep)
                                           xnanosleep (/usr/bin/sleep)
                                           main (/usr/bin/sleep)
                                           __libc_start_main (/usr/lib64/libc-2.26.so)
                                           _start (/usr/bin/sleep)
    ^C#

   Copyright (C) 2018 Red Hat, Inc., Arnaldo Carvalho de Melo <acme@redhat.com>
*/

#include <bpf.h>

int probe(hrtimer_nanosleep, rqtp->tv_sec)(void *ctx, int err, long sec)
{
	return sec == 5;
}

license(GPL);
[root@jouet perf]# perf trace --no-syscalls -e tools/perf/examples/bpf/5sec.c
     0.000 perf_bpf_probe:hrtimer_nanosleep:(ffffffff9911efe0) tv_sec=5
  3145.238 perf_bpf_probe:hrtimer_nanosleep:(ffffffff9911efe0) tv_sec=5
^C[root@jouet perf]#

After it works just the same, thanks, applying.

I need to get the above testing process hooked up in 'perf test', so
that besides adding that -I/root/lib/perf/include/bpf we actually _try_
to include something from there from the /root/lib/perf/examples/bpf/
bpf example scripts.

- Arnaldo
