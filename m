Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EFEECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 19:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA572081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 19:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA572081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbeKEEeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 23:34:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbeKEEeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 23:34:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FF8630001E0;
        Sun,  4 Nov 2018 19:17:59 +0000 (UTC)
Received: from krava (ovpn-204-66.brq.redhat.com [10.40.204.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 26E3219749;
        Sun,  4 Nov 2018 19:17:55 +0000 (UTC)
Date:   Sun, 4 Nov 2018 20:17:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf script doesn't dump a normal call trace
Message-ID: <20181104191754.GB18517@krava>
References: <CADvbK_dNN34=5V3qtk3_vBzKNts55ACR4c-erPafgNuAQ-eRuw@mail.gmail.com>
 <20181102102616.GC5458@krava>
 <CADvbK_cr_vhtyaid=xbECdNs+xCr4Oi8pJJc83jZa+XJOWAjJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_cr_vhtyaid=xbECdNs+xCr4Oi8pJJc83jZa+XJOWAjJw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 04 Nov 2018 19:17:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2018 at 06:36:21PM +0900, Xin Long wrote:
> On Fri, Nov 2, 2018 at 7:26 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Nov 02, 2018 at 03:36:13PM +0900, Xin Long wrote:
> > > On upstream kernel(4.19) or RHEL-8 kernel(4.18.0):
> > >
> > > # perf record -e 'skb:consume_skb' -ag
> > > ^C[ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.612 MB perf.data (634 samples) ]
> > >
> > > # perf script
> > > swapper     0 [009] 274370.117711: skb:consume_skb: skbaddr=0xffff962c591d5b00
> > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > >
> > > kworker/9:1-eve   926 [009] 274370.117729: skb:consume_skb:
> > > skbaddr=0xffff962c591d5b00
> > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > >
> > > kworker/9:1-eve   926 [009] 274370.117732: skb:consume_skb:
> > > skbaddr=0xffff962c591d4900
> > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > >
> > > swapper     0 [009] 274370.145528: skb:consume_skb: skbaddr=0xffff962c591d4900
> > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > >
> > > kworker/9:1-eve   926 [009] 274370.145545: skb:consume_skb:
> > > skbaddr=0xffff962c591d4900
> > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > >
> > > kworker/9:1-eve   926 [009] 274370.145547: skb:consume_skb:
> > > skbaddr=0xffff962c591d5b00
> > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> > >
> > > swapper     0 [009] 274370.173443: skb:consume_skb: skbaddr=0xffff962c591d5b00
> > >         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> >
> > I can see that on upstream as well, probably something within
> > tracepoint entry code, because I have it working nicely when
> > from kprobe, like:
> >
> > [root@ibm-x3650m4-02 perf]# ./perf probe 'consume_skb'
> > [root@ibm-x3650m4-02 perf]# ./perf record -g -e probe:consume_skb* -aR ^C
> >
> Thanks Jiri,
> 
> My debugging script is using tracepoint with some filters which I
> don't think probe can support.
> Any one have fixes for this tracepoint issue?

trying to bisect that.. looks like orc code issue,
it works for me when you switch to fp unwind:
  CONFIG_UNWINDER_FRAME_POINTER

jirka
