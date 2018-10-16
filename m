Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16112C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC51E2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 19:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC51E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbeJQCyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 22:54:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55768 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJQCyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 22:54:23 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EE34212106D9E;
        Tue, 16 Oct 2018 12:02:32 -0700 (PDT)
Date:   Tue, 16 Oct 2018 12:02:30 -0700 (PDT)
Message-Id: <20181016.120230.1607256792594000833.davem@davemloft.net>
To:     acme@redhat.com
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        peterz@infradead.org, mingo@kernel.org, jolsa@redhat.com,
        namhyung@gmail.com, mhiramat@kernel.org
Subject: Re: perf's handling of unfindable user symbols...
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181016184506.GB3254@redhat.com>
References: <20181015222546.GA2159@redhat.com>
        <20181015.160246.58484704665215987.davem@davemloft.net>
        <20181016184506.GB3254@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 16 Oct 2018 12:02:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 16 Oct 2018 15:45:06 -0300

> Exec summary: yeah, drop that hack, I agree, patch at the end of the
> message.
> 
> So, I thought something had changed and in the past we would somehow
> find that address in the kallsyms, but I couldn't find anything to back
> that up, the patch introducing this is over a decade old, lots of things
> changed, so I was just thinking I was missing something.
> 
> I tried a gtod busy loop to generate vdso activity and added a 'perf
> probe' at that branch, on x86_64 to see if it ever gets hit:

Good, thanks for doing the detailed checking!

> In the process I noticed a bug, we're only have records for '[vdso]' for
> pre-existing commands, i.e. ones that are running when we start 'perf top',
> when we will generate the PERF_RECORD_MMAP by looking at /perf/PID/maps.

Hmmm.  vdso mappings are installed by __install_special_mapping()
which should be emitting proper mmap events by calling
perf_event_mmap(vma).

Maybe the event is emitted too early?  It doesn't look like it.  These
are emitted after load_elf_binary() iterates over the PHDRs and
mmap()'s those areas of the binary, and we definitely see those events
properly.

> The kernel doesn't seem to be generating a PERF_RECORD_MMAP for vDSOs...  And
> we can't do this in 'perf record' because we don't process event by event, just
> dump things from the ring buffer to a file...

It should be, see above.

> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 0988eb3b844b..bc646185f8d9 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -1561,26 +1561,9 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  
>  		return NULL;
>  	}
> -try_again:
> +
>  	al->map = map_groups__find(mg, al->addr);
> -	if (al->map == NULL) {
> -		/*
> -		 * If this is outside of all known maps, and is a negative
> -		 * address, try to look it up in the kernel dso, as it might be
> -		 * a vsyscall or vdso (which executes in user-mode).
> -		 *
> -		 * XXX This is nasty, we should have a symbol list in the
> -		 * "[vdso]" dso, but for now lets use the old trick of looking
> -		 * in the whole kernel symbol list.
> -		 */
> -		if (cpumode == PERF_RECORD_MISC_USER && machine &&
> -		    mg != &machine->kmaps &&
> -		    machine__kernel_ip(machine, al->addr)) {
> -			mg = &machine->kmaps;
> -			load_map = true;
> -			goto try_again;
> -		}
> -	} else {
> +	if (al->map != NULL) {
>  		/*
>  		 * Kernel maps might be changed when loading symbols so loading
>  		 * must be done prior to using kernel maps.
> 
> 

Acked-by: David S. Miller <davem@davemloft.net>

:-)
