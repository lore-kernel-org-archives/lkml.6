Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18682C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F0C20857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 17:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F0C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeG2ShE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 14:37:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbeG2ShE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 14:37:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 262FD87A70;
        Sun, 29 Jul 2018 17:05:59 +0000 (UTC)
Received: from krava (ovpn-204-74.brq.redhat.com [10.40.204.74])
        by smtp.corp.redhat.com (Postfix) with SMTP id BF6222156701;
        Sun, 29 Jul 2018 17:05:56 +0000 (UTC)
Date:   Sun, 29 Jul 2018 19:05:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     rodia@autistici.org, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] perf c2c report: Fix crash for empty browser
Message-ID: <20180729170556.GB17776@krava>
References: <20180724062008.26126-1-jolsa@kernel.org>
 <20180726193046.GC20438@kernel.org>
 <c5cb64016f7da6c2abdef4a05ea74425@autistici.org>
 <20180727070623.GA24770@krava>
 <20180727141340.GA4722@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727141340.GA4722@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sun, 29 Jul 2018 17:05:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sun, 29 Jul 2018 17:05:59 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 11:13:40AM -0300, Arnaldo Carvalho de Melo wrote:
> Adding Joe to the CC list.
> 
> Em Fri, Jul 27, 2018 at 09:06:23AM +0200, Jiri Olsa escreveu:
> > On Thu, Jul 26, 2018 at 11:31:34PM +0000, rodia@autistici.org wrote:
> > > On 2018-07-26 19:30, Arnaldo Carvalho de Melo wrote:
> > > > Em Tue, Jul 24, 2018 at 08:20:08AM +0200, Jiri Olsa escreveu:
> > > > > Do not try to display entry details if there's
> > > > > not any. Currently this ends up in crash:
> > > > >   $ perf c2c report
> > > > >   perf: Segmentation fault
> 
> > > > How to replicate this?
> 
> > > > I tried:
> 
> > > > $ perf record sleep 1
> > > > $ perf c2c report
> 
> > > > But it didn't segfault
> 
> > > Similarly I have tried :
> > > $ perf record sleep 1
> > > $ perf c2c report
> > > Then Press `d` to show the cache-line contents.
> 
> > yep, sry I forgot to mention you need to press the 'd' to show details
>  
> > > This replies the segfault on my machine (4.17.8-1).
> > > The patch mentioned above should solve it, even tough I am not sure as I
> > > haven't been able to recompile the kernel.
>  
> > no need to recompile kernel
>  
> > > The segfault by itself seems to be due to the report logic, as it did not
> > > expect to report on an empty browser.
> > > What has stepped me back is that application which I have been testing with
> > > rely on multiple threads instantiated through pthread, which should be
> > > counted in user-level threads right? But they still seem to return an empty
> > > browser.
>  
> > right, c2c scans read/write accesses and tries to find false sharing
> > cases maybe there was nothing to be found
>  
> > > When instead c2c is runned system-wide, with an application running on
> > > multiple threads like firefox or julia, cache hits are measured and also
> > > they are traced back in the source code.
>  
> > I got a cache line (attached) for 'perf bench sched messaging'
> > NOT being traced system wide and just for user (you'll get plenty
> > of detected cachelines in kernel space):
> 
> With that info in mind, we get:
> 
> [root@seventh ~]# perf record sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.001 MB perf.data (6 samples) ]
> [root@seventh ~]# 
> [root@seventh ~]# 
> [root@seventh ~]# perf c2c report # and press 'd'
> perf: Segmentation fault
> -------- backtrace --------
> perf[0x5b1d2a]
> /lib64/libc.so.6(+0x346df)[0x7fcb566e36df]
> perf[0x46fcae]
> perf[0x4a9f1e]
> perf[0x4aa220]
> perf(main+0x301)[0x42c561]
> /lib64/libc.so.6(__libc_start_main+0xe9)[0x7fcb566cff29]
> perf(_start+0x29)[0x42c999]
> [root@seventh ~]#
> 
> With your patches the segfault is gone, but I'd do a follow up patch to
> show some message telling the user why 'd' showed nothing and
> instructing him about what is missing, i.e. is this done on a perf.data
> file that has no events of interest? Suggest using 'perf c2c record' or
> 'perf record -e events,of,interest,to,perf,c2c', was this done on some
> workload where no false sharing was detected? Say so, etc.

ok, will try to come up with something

> 
> I applied your patch with a more detailed commit log to state how this
> can reproduced, etc, as usual:
> 
> https://git.kernel.org/acme/c/983eb6aa7098

I checked, looks good, thanks

jirka
