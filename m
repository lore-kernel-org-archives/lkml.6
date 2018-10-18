Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB248ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CE721476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wKzmTsDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CE721476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeJRRnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:37362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbeJRRnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:43:02 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C673C208E4;
        Thu, 18 Oct 2018 09:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539855771;
        bh=TjI+igHuP2XLnbYyYLZfiMS+0GTUUaekiLe0jBwnkAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wKzmTsDqqQzMnxx8gy+3/+8uAv/qjMeBJ+/r6YlC1MDSL+MpBuHVEN5WsKWSyXuAg
         LaojaFRfMoU0rW92JhKoVKt0i6hS9mwCT2xjdfXOR1I2I2MuL+uwP//FyNB9iXsGEO
         DwdDy7hK1Cm8oR0F+R1Am1nPLnD+6tNBEWNQWpVk=
Date:   Thu, 18 Oct 2018 18:42:48 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Miller <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@gmail.com>
Subject: Re: perf's handling of unfindable user symbols...
Message-Id: <20181018184248.81fa704692a65c0fb471641f@kernel.org>
In-Reply-To: <20181017122855.GB31465@kernel.org>
References: <20181014.004238.292485794143606801.davem@davemloft.net>
        <20181015222546.GA2159@redhat.com>
        <20181015.160246.58484704665215987.davem@davemloft.net>
        <20181016184506.GB3254@redhat.com>
        <20181017172226.7274498db2bbe3431c3f4057@kernel.org>
        <20181017122855.GB31465@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 09:28:55 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Wed, Oct 17, 2018 at 05:22:26PM +0900, Masami Hiramatsu escreveu:
> > On Tue, 16 Oct 2018 15:45:06 -0300
> > Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
> > > So, I thought something had changed and in the past we would somehow
> > > find that address in the kallsyms, but I couldn't find anything to back
> > > that up, the patch introducing this is over a decade old, lots of things
> > > changed, so I was just thinking I was missing something.
> 
> > > I tried a gtod busy loop to generate vdso activity and added a 'perf
> > > probe' at that branch, on x86_64 to see if it ever gets hit:
> 
> > > Made thread__find_map() noinline, as 'perf probe' in lines of inline
> > > functions seems to not be working, only at function start. (Masami?)
>  
> > Thank you for reporting it. Hmm, what happened when you did it?
> > I checked some points, but seems no problem.
> > (Would you see no line number? or defined event didn't work?)
> 
> So, the problem is with a function in the perf tool that ends up inlined
> in five places, then when I ask for a line inside of this function to be
> probed, it creates 4 probes, one in each of the function it inlines,
> see:
> 
> [root@jouet ~]# perf probe -x ~/bin/perf -L thread__find_map:43
> <thread__find_map@/home/acme/git/perf/tools/perf/util/event.c:43>
>      43                 return NULL;
>                 }
>          
>      46         al->map = map_groups__find(mg, al->addr);
>      47         if (al->map != NULL) {
>                         /*
>                          * Kernel maps might be changed when loading symbols so loading
>                          * must be done prior to using kernel maps.
>                          */
>                         if (load_map)
>      53                         map__load(al->map);
>      54                 al->addr = al->map->map_ip(al->map, al->addr);
>                 }
>          
>      57         return al->map;
>      58  }
>          
>          struct symbol *thread__find_symbol(struct thread *thread, u8 cpumode,
>                                            u64 addr, struct addr_location *al)
> 
> [root@jouet ~]# 
> 
> So I know that everytime we look for a mmap in a thread and we find that map,
> we get to line 54, lets try to add it:
> 
> [root@jouet ~]# perf probe -x ~/bin/perf thread__find_map:54
> Added new events:
>   probe_perf:thread__find_map (on thread__find_map:54 in /home/acme/bin/perf)
>   probe_perf:thread__find_map_1 (on thread__find_map:54 in /home/acme/bin/perf)
>   probe_perf:thread__find_map_2 (on thread__find_map:54 in /home/acme/bin/perf)
>   probe_perf:thread__find_map_3 (on thread__find_map:54 in /home/acme/bin/perf)
>   probe_perf:thread__find_map_4 (on thread__find_map:54 in /home/acme/bin/perf)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe_perf:thread__find_map_4 -aR sleep 1
> 
> [root@jouet ~]#

Hmm, it seems that the line is optimized and spread into 5 places (instructions).
"perf probe -x ~/bin/perf -D thread__find_map:54" will show you the actual address
where the probes are. Or, you can just dump the /sys/kernel/debug/tracing/uprobe_events.

> Now I run 'perf top' and then, on another terminal, run this to get system wide
> events to get a few of those probes:
> 
> [root@jouet ~]# perf trace -a -e *perf:*/max-stack=7/ sleep 0.02
>      0.000 probe_perf:thread__find_map_3:(4be2e3)
>                                        machine__resolve (/home/acme/bin/perf)
>                                        perf_top__mmap_read_idx (/home/acme/bin/perf)
>                                        perf_top__mmap_read (/home/acme/bin/perf)
>                                        cmd_top (/home/acme/bin/perf)
>                                        run_builtin (/home/acme/bin/perf)
>                                        handle_internal_command (/home/acme/bin/perf)
>                                        main (/home/acme/bin/perf)
>      0.023 probe_perf:thread__find_map_3:(4be2e3)
>                                        machine__resolve (/home/acme/bin/perf)
>                                        perf_top__mmap_read_idx (/home/acme/bin/perf)
>                                        perf_top__mmap_read (/home/acme/bin/perf)
>                                        cmd_top (/home/acme/bin/perf)
>                                        run_builtin (/home/acme/bin/perf)
>                                        handle_internal_command (/home/acme/bin/perf)
>                                        main (/home/acme/bin/perf)
>      0.048 probe_perf:thread__find_map_3:(4be2e3)
>                                        machine__resolve (/home/acme/bin/perf)
>                                        perf_top__mmap_read_idx (/home/acme/bin/perf)
>                                        perf_top__mmap_read (/home/acme/bin/perf)
>                                        cmd_top (/home/acme/bin/perf)
>                                        run_builtin (/home/acme/bin/perf)
>                                        handle_internal_command (/home/acme/bin/perf)
>                                        main (/home/acme/bin/perf)
> <SNIP>
> [root@jouet ~]# 
> 
> So it now I'm not being able to reproduce... Erm, nevermind then, I'll report
> back if I notice this again... :-)

OK, I will wait for your report.

> 
> Thanks for checking, sorry for the noise.

Issue reports are always welcome :)

Thank you,

> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
