Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D23C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4F520854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4F520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeKESHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:07:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbeKESHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:07:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 449383086269;
        Mon,  5 Nov 2018 08:49:10 +0000 (UTC)
Received: from krava (unknown [10.40.205.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9DBAE5C1B5;
        Mon,  5 Nov 2018 08:49:07 +0000 (UTC)
Date:   Mon, 5 Nov 2018 09:49:06 +0100
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
Message-ID: <20181105084906.GA30951@krava>
References: <CADvbK_dNN34=5V3qtk3_vBzKNts55ACR4c-erPafgNuAQ-eRuw@mail.gmail.com>
 <20181102102616.GC5458@krava>
 <CADvbK_cr_vhtyaid=xbECdNs+xCr4Oi8pJJc83jZa+XJOWAjJw@mail.gmail.com>
 <20181104191754.GB18517@krava>
 <CADvbK_cgp7S-8Q-6GArwViCDBhCoB9LcZvJaGM6QFAg9qNOeHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_cgp7S-8Q-6GArwViCDBhCoB9LcZvJaGM6QFAg9qNOeHw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 05 Nov 2018 08:49:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 03:20:15PM +0900, Xin Long wrote:

SNIP

> > > > [root@ibm-x3650m4-02 perf]# ./perf probe 'consume_skb'
> > > > [root@ibm-x3650m4-02 perf]# ./perf record -g -e probe:consume_skb* -aR ^C
> > > >
> > > Thanks Jiri,
> > >
> > > My debugging script is using tracepoint with some filters which I
> > > don't think probe can support.
> > > Any one have fixes for this tracepoint issue?
> >
> > trying to bisect that.. looks like orc code issue,
> > it works for me when you switch to fp unwind:
> >   CONFIG_UNWINDER_FRAME_POINTER
> >
> 
> That's a good workaround, thanks.
> 
> Another problem is when I'm using perf built manually from upstream kernel tree,
> I couldn't see the function's names.
> # perf --version
> perf version 4.19.g26f1de
> 
> # perf report -T
> # To display the perf.data header info, please use
> --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 97  of event 'probe:consume_skb'
> # Event count (approx.): 97
> #
> # Children      Self  Trace output
> # ........  ........  ..................
> #
>    100.00%   100.00%  (ffffffff86f090f0)
>             |
>             |--93.81%--0xffffffff868000e6
>             |          0xffffffff8684ed7f
>             |          0xffffffff868e97ad
>             |          0xffffffff868e953a
>             |          0xffffffff87087623
>             |          0xffffffff8682a06f
>             |          0xffffffff870872ad
>             |          |
>             |          |--89.69%--0xffffffff8720098f
>             |          |          0xffffffff87201b69
>             |          |          0xffffffff868b9c2e
> 
> 
> The below is with rhel7's perf
> # perf --version
> perf version 3.10.0-957.el7.x86_64.debug
> # perf report -T
> # To display the perf.data header info, please use
> --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 97  of event 'probe:consume_skb'
> # Event count (approx.): 97
> #
> # Children      Self  Trace output
> # ........  ........  ..................
> #
>    100.00%   100.00%  (ffffffff86f090f0)
>             |
>             |--93.81%--0x2000e6
>             |          start_secondary
>             |          cpu_startup_entry
>             |          do_idle
>             |          default_idle_call
>             |          arch_cpu_idle
>             |          default_idle
>             |          |
>             |          |--89.69%--ret_from_intr
>             |          |          do_IRQ
>             |          |          irq_exit

I think that's already fixed on Arnaldo's perf/urgent branch,
  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

but perhaps this post as well:
  https://lore.kernel.org/lkml/20181031091043.23465-1-adrian.hunter@intel.com/

please give it a try.. it should be merged in soon

jirka
