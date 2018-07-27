Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E40C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C072064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBhx7tuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02C072064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbeG0Pfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730709AbeG0Pfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:35:50 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 558DC2064D;
        Fri, 27 Jul 2018 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532700822;
        bh=FtaLHzHf5V9tfrN9+ImxEWj5Al5821ns5bzHGlx9huc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBhx7tuUrXEiBKQIWZ9llFkCZ4R7Fn0JQuegwBuBL/xhsEya7UYvITOjJhALN7zar
         /puVzfii+3gU7gWxltJhC+h7kgtW4Klx1P1YLwr7aKYdJtyWLLt3//rmPU0zAys9Jv
         CuocxFT6MpbXo5oeSCapcctUjh+9w4B4orsFCANw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 275451403B8; Fri, 27 Jul 2018 11:13:40 -0300 (-03)
Date:   Fri, 27 Jul 2018 11:13:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     rodia@autistici.org, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] perf c2c report: Fix crash for empty browser
Message-ID: <20180727141340.GA4722@kernel.org>
References: <20180724062008.26126-1-jolsa@kernel.org>
 <20180726193046.GC20438@kernel.org>
 <c5cb64016f7da6c2abdef4a05ea74425@autistici.org>
 <20180727070623.GA24770@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180727070623.GA24770@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Joe to the CC list.

Em Fri, Jul 27, 2018 at 09:06:23AM +0200, Jiri Olsa escreveu:
> On Thu, Jul 26, 2018 at 11:31:34PM +0000, rodia@autistici.org wrote:
> > On 2018-07-26 19:30, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Jul 24, 2018 at 08:20:08AM +0200, Jiri Olsa escreveu:
> > > > Do not try to display entry details if there's
> > > > not any. Currently this ends up in crash:
> > > >   $ perf c2c report
> > > >   perf: Segmentation fault

> > > How to replicate this?

> > > I tried:

> > > $ perf record sleep 1
> > > $ perf c2c report

> > > But it didn't segfault

> > Similarly I have tried :
> > $ perf record sleep 1
> > $ perf c2c report
> > Then Press `d` to show the cache-line contents.

> yep, sry I forgot to mention you need to press the 'd' to show details
 
> > This replies the segfault on my machine (4.17.8-1).
> > The patch mentioned above should solve it, even tough I am not sure as I
> > haven't been able to recompile the kernel.
 
> no need to recompile kernel
 
> > The segfault by itself seems to be due to the report logic, as it did not
> > expect to report on an empty browser.
> > What has stepped me back is that application which I have been testing with
> > rely on multiple threads instantiated through pthread, which should be
> > counted in user-level threads right? But they still seem to return an empty
> > browser.
 
> right, c2c scans read/write accesses and tries to find false sharing
> cases maybe there was nothing to be found
 
> > When instead c2c is runned system-wide, with an application running on
> > multiple threads like firefox or julia, cache hits are measured and also
> > they are traced back in the source code.
 
> I got a cache line (attached) for 'perf bench sched messaging'
> NOT being traced system wide and just for user (you'll get plenty
> of detected cachelines in kernel space):

With that info in mind, we get:

[root@seventh ~]# perf record sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.001 MB perf.data (6 samples) ]
[root@seventh ~]# 
[root@seventh ~]# 
[root@seventh ~]# perf c2c report # and press 'd'
perf: Segmentation fault
-------- backtrace --------
perf[0x5b1d2a]
/lib64/libc.so.6(+0x346df)[0x7fcb566e36df]
perf[0x46fcae]
perf[0x4a9f1e]
perf[0x4aa220]
perf(main+0x301)[0x42c561]
/lib64/libc.so.6(__libc_start_main+0xe9)[0x7fcb566cff29]
perf(_start+0x29)[0x42c999]
[root@seventh ~]#

With your patches the segfault is gone, but I'd do a follow up patch to
show some message telling the user why 'd' showed nothing and
instructing him about what is missing, i.e. is this done on a perf.data
file that has no events of interest? Suggest using 'perf c2c record' or
'perf record -e events,of,interest,to,perf,c2c', was this done on some
workload where no false sharing was detected? Say so, etc.

I applied your patch with a more detailed commit log to state how this
can reproduced, etc, as usual:

https://git.kernel.org/acme/c/983eb6aa7098

- Arnaldo
