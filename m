Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4956C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7B22184A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 22:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfBQWEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 17:04:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfBQWEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 17:04:20 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63247C04BD4E;
        Sun, 17 Feb 2019 22:04:20 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A39D519741;
        Sun, 17 Feb 2019 22:04:17 +0000 (UTC)
Date:   Sun, 17 Feb 2019 23:04:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v3 perf,bpf 00/11] perf annotation of BPF programs
Message-ID: <20190217220415.GA26460@krava>
References: <20190215215354.3114006-1-songliubraving@fb.com>
 <20190217215744.GA797@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190217215744.GA797@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 17 Feb 2019 22:04:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 10:57:44PM +0100, Jiri Olsa wrote:
> On Fri, Feb 15, 2019 at 01:53:43PM -0800, Song Liu wrote:
> > Changes v2 to v3:
> > 1. Remove unnecessary include in header files;
> > 2. Improved error handling;
> > 3. Better naming of functions, variables, etc.;
> > 4. Enable bpf events by default for perf-top.
> > 
> > Changes v1 to v2:
> > 1. Fix compilation error with different feature-disassembler-four-args;
> > 2. Fix a segfault in perf-record;
> > 3. Split patches 5/9 and 6/9 so that perf_env changes and perf.data changes
> >    are in separate patches.
> > 
> > This series enables annotation of BPF programs in perf.
> > 
> > perf tool gathers information via sys_bpf and (optionally) stores them in
> > perf.data as headers.
> > 
> > Patch 1/11 fixes a minor issue in kernel;
> > Patch 2/11 to 4/11 introduce new helper functions and use them in perf and
> >      bpftool;
> > Patch 5/11 to 8/11 saves information of bpf program in perf_env;
> > Patch 9/11 adds --bpf-event options to perf-top;
> > Patch 10/11 enables annotation of bpf programs based on information
> >      gathered in 5/11 to 8/11;
> > Patch 11/11 handles information of short living BPF program that are loaded
> >      during perf-record or perf-top.
> > 
> > Commands tested during developments are perf-top, perf-record, perf-report,
> > and perf-annotate.
> > 
> > ===================== Note on patch dependency  ========================
> > This set has dependency in both bpf-next tree and tip/perf/core. Current
> > version is developed on bpf-next tree with the following commits
> > cherry-picked from tip/perf/core:
> > 
> > (from 1/10 to 10/10)
> > commit 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
> > commit d764ac646491 ("tools headers uapi: Sync tools/include/uapi/linux/perf_event.h")
> > commit 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
> > commit df063c83aa2c ("tools headers uapi: Sync tools/include/uapi/linux/perf_event.h")
> > commit 9aa0bfa370b2 ("perf tools: Handle PERF_RECORD_KSYMBOL")
> > commit 45178a928a4b ("perf tools: Handle PERF_RECORD_BPF_EVENT")
> > commit 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
> > commit a40b95bcd30c ("perf top: Synthesize BPF events for pre-existing loaded BPF programs")
> > commit 6934058d9fb6 ("bpf: Add module name [bpf] to ksymbols for bpf programs")
> > commit 811184fb6977 ("perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT")
> > ========================================================================
> > 
> > This set is also available at:
> > 
> > https://github.com/liu-song-6/linux/tree/bpf-annotation
> 
> I'm getting same compilation error as last time,
> maybe it wasnt updated?

I also applied manualy (with some conflicts) your patches
from emails on bpf/next/master with merged tip/perf/core

and got following compilation error:

  CC       util/find_bit.o
util/annotate.c: In function ‘symbol__disassemble_bpf’:
util/annotate.c:1771:29: error: incompatible type for argument 1 of ‘disassembler’
  disassemble = disassembler(bfdf);
                             ^~~~
In file included from util/annotate.c:36:
/usr/include/dis-asm.h:276:63: note: expected ‘enum bfd_architecture’ but argument is of type ‘bfd *’ {aka ‘struct bfd *’}
 extern disassembler_ftype disassembler (enum bfd_architecture arc,
                                         ~~~~~~~~~~~~~~~~~~~~~~^~~
util/annotate.c:1771:16: error: too few arguments to function ‘disassembler’
  disassemble = disassembler(bfdf);
                ^~~~~~~~~~~~
In file included from util/annotate.c:36:
/usr/include/dis-asm.h:276:27: note: declared here
 extern disassembler_ftype disassembler (enum bfd_architecture arc,
                           ^~~~~~~~~~~~

thanks,
jirka
