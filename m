Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03554C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93022098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93022098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJQDaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 23:30:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbeJQDaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 23:30:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D43FC88E4F;
        Tue, 16 Oct 2018 19:38:04 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2945B608EE;
        Tue, 16 Oct 2018 19:38:04 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id E80A2295E; Tue, 16 Oct 2018 16:37:50 -0300 (BRT)
Date:   Tue, 16 Oct 2018 16:37:50 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        peterz@infradead.org, mingo@kernel.org, jolsa@redhat.com,
        namhyung@gmail.com, mhiramat@kernel.org, williams@redhat.com
Subject: Re: perf's handling of unfindable user symbols...
Message-ID: <20181016193750.GC3254@redhat.com>
References: <20181015222546.GA2159@redhat.com>
 <20181015.160246.58484704665215987.davem@davemloft.net>
 <20181016184506.GB3254@redhat.com>
 <20181016.120230.1607256792594000833.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016.120230.1607256792594000833.davem@davemloft.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 16 Oct 2018 19:38:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 16, 2018 at 12:02:30PM -0700, David Miller escreveu:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Tue, 16 Oct 2018 15:45:06 -0300
> 
> > Exec summary: yeah, drop that hack, I agree, patch at the end of the
> > message.

> > So, I thought something had changed and in the past we would somehow
> > find that address in the kallsyms, but I couldn't find anything to back
> > that up, the patch introducing this is over a decade old, lots of things
> > changed, so I was just thinking I was missing something.

> > I tried a gtod busy loop to generate vdso activity and added a 'perf
> > probe' at that branch, on x86_64 to see if it ever gets hit:
 
> Good, thanks for doing the detailed checking!
 
> > In the process I noticed a bug, we're only have records for '[vdso]' for
> > pre-existing commands, i.e. ones that are running when we start 'perf top',
> > when we will generate the PERF_RECORD_MMAP by looking at /perf/PID/maps.
> 
> Hmmm.  vdso mappings are installed by __install_special_mapping()

Yeah, the kernel is ok, tooling seems b0rken, will check.

[root@jouet ~]# perf record ~acme/c/gtod
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.076 MB perf.data (1499 samples) ]

[root@jouet ~]# perf report -D | grep PERF_RECORD_MMAP2
71293612401913 0x11b48 [0x70]: PERF_RECORD_MMAP2 25484/25484: [0x400000(0x1000) @ 0 fd:02 1137 541179306]: r-xp /home/acme/c/gtod
71293612419012 0x11be0 [0x70]: PERF_RECORD_MMAP2 25484/25484: [0x7fa4a2783000(0x227000) @ 0 fd:00 3146370 854107250]: r-xp /usr/lib64/ld-2.26.so
71293612432110 0x11c50 [0x60]: PERF_RECORD_MMAP2 25484/25484: [0x7ffcdb53a000(0x2000) @ 0 00:00 0 0]: r-xp [vdso]
71293612509944 0x11cb0 [0x70]: PERF_RECORD_MMAP2 25484/25484: [0x7fa4a23cd000(0x3b6000) @ 0 fd:00 3149723 262067164]: r-xp /usr/lib64/libc-2.26.so
[root@jouet ~]#

And using tools/perf/python/twatch.py enabling mmap = 1:

<SNIP>
cpu: 1, pid: 25743, tid: 25743 { type: comm, pid: 25743, tid: 25743, comm: gtod }
cpu: 2, pid: 25742, tid: 25742 { type: mmap, pid: 25742, tid: 25742, start: 0x55d0a916e000, length: 0x219000, offset: 0, filename: /usr/bin/procmail }
cpu: 1, pid: 25743, tid: 25743 { type: mmap, pid: 25743, tid: 25743, start: 0x400000, length: 0x1000, offset: 0, filename: /home/acme/c/gtod
}
cpu: 2, pid: 25742, tid: 25742 { type: mmap, pid: 25742, tid: 25742, start: 0x7fa6d666e000, length: 0x227000, offset: 0, filename: /usr/lib64/ld-2.26.so }
cpu: 1, pid: 25743, tid: 25743 { type: mmap, pid: 25743, tid: 25743, start: 0x7f7774286000, length: 0x227000, offset: 0, filename: /usr/lib64/ld-2.26.so }
cpu: 2, pid: 25742, tid: 25742 { type: mmap, pid: 25742, tid: 25742, start: 0x7ffd673d6000, length: 0x2000, offset: 0, filename: [vdso] }
cpu: 1, pid: 25743, tid: 25743 { type: mmap, pid: 25743, tid: 25743, start: 0x7fff8f7ad000, length: 0x2000, offset: 0, filename: [vdso] }
<SNIP>

> which should be emitting proper mmap events by calling
> perf_event_mmap(vma).
> Maybe the event is emitted too early?  It doesn't look like it.  These
> are emitted after load_elf_binary() iterates over the PHDRs and
> mmap()'s those areas of the binary, and we definitely see those events
> properly.
> 
> > The kernel doesn't seem to be generating a PERF_RECORD_MMAP for vDSOs...  And
> > we can't do this in 'perf record' because we don't process event by event, just
> > dump things from the ring buffer to a file...
 
> It should be, see above.

Yeah, I'll check why is that the tooling side doesn't seem to be
catching those...

> > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> > index 0988eb3b844b..bc646185f8d9 100644
> > --- a/tools/perf/util/event.c
> > +++ b/tools/perf/util/event.c
> > @@ -1561,26 +1561,9 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
> >  
> >  		return NULL;
> >  	}
> > -try_again:
> > +
> >  	al->map = map_groups__find(mg, al->addr);
> > -	if (al->map == NULL) {
> > -		/*
> > -		 * If this is outside of all known maps, and is a negative
> > -		 * address, try to look it up in the kernel dso, as it might be
> > -		 * a vsyscall or vdso (which executes in user-mode).
> > -		 *
> > -		 * XXX This is nasty, we should have a symbol list in the
> > -		 * "[vdso]" dso, but for now lets use the old trick of looking
> > -		 * in the whole kernel symbol list.
> > -		 */
> > -		if (cpumode == PERF_RECORD_MISC_USER && machine &&
> > -		    mg != &machine->kmaps &&
> > -		    machine__kernel_ip(machine, al->addr)) {
> > -			mg = &machine->kmaps;
> > -			load_map = true;
> > -			goto try_again;
> > -		}
> > -	} else {
> > +	if (al->map != NULL) {
> >  		/*
> >  		 * Kernel maps might be changed when loading symbols so loading
> >  		 * must be done prior to using kernel maps.
> > 
> > 
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Reported-by:
Suggested-by:

:-)

OK, will get this with a nice cover letter and stash into my perf/urgent
branch.

- Arnaldo
