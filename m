Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbeFDOXp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753389AbeFDOXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:23:43 -0400
Date: Mon, 4 Jun 2018 11:23:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3]: perf record: enable arbitrary event names thru name=
 modifier
Message-ID: <20180604142340.GJ3397@kernel.org>
References: <c194b060-761d-0d50-3b21-bb4ed680002d@linux.intel.com>
 <20180604075600.GA10484@krava>
 <20180604135849.GE3397@kernel.org>
 <3269ec8e-88b0-8254-6419-da1896c083df@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3269ec8e-88b0-8254-6419-da1896c083df@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 04, 2018 at 05:19:11PM +0300, Alexey Budankov escreveu:
> Hi,
> 
> On 04.06.2018 16:58, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jun 04, 2018 at 09:56:02AM +0200, Jiri Olsa escreveu:
> >> On Mon, Jun 04, 2018 at 09:50:56AM +0300, Alexey Budankov wrote:
> >>> Enable complex event names containing [.:=,] symbols to be encoded into Perf 
> >>> trace using name= modifier e.g. like this:
> > 
> >>> perf record -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',\
> >>> 		period=0x3567e0,event=0x3c,cmask=0x1/Duk ./futex
> > 
> >>> Below is how it looks like in the report output. Please note explicit escaped 
> >>> quoting at cmdline string in the header so that thestring can be directly reused
> >>> for another collection in shell:
> > 
> > Applied, but there are other places where we show event names, such as:
> > 
> > [root@jouet ~]# perf record -e cpu/name=\'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM\',period=0x3567e0,event=0x3c,cmask=0x1/Duk
> > ^C[ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 1.599 MB perf.data (704 samples) ]
> > 
> > [root@jouet ~]# perf evlist
> > OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM
> > [root@jouet ~]# perf evlist -v
> > OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM: type: 4, size: 112, config: 0x100003c, { sample_period, sample_freq }: 3500000, sample_type: IP|TID|TIME|CPU, disabled: 1, inherit: 1, pinned: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1
> > [root@jouet ~]# 
> > 
> > That I used to check if the period, etc were correctly set, etc. Perhaps
> > we should add that \'\' there as well?
> 
> Like this?
> 
> name: 'OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.SNOOP_HITM', type: 4, size: 112, config: 0x100003c, { sample_period, sample_freq }: 3500000, sample_type: IP|TID|TIME|CPU, disabled: 1, inherit: 1, pinned: 1, exclude_hv: 1, mmap: 1, comm: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1

Nope, I mean with the same intent you had when showing escaped single
quotes in the 'perf report' header, that users would copy'n'paste and
get something that works on the command line?

- Arnaldo
 
> Thanks,
> Alexey
> 
> > 
> > Also please consider adding an entry to tools/perf/tests/attr/ to make
> > sure this is checked everytime we run 'perf test attr' or plain 'perf
> > test'.
> > 
> > Those can be followup patches, so I'm applying this one, thanks.
> > 
> > - Arnaldo
> > 
