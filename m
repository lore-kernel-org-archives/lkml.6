Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753175AbeDPWFZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 18:05:25 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:43133 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeDPWFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 18:05:06 -0400
X-Google-Smtp-Source: AIpwx488Pgi03wKCJ6ztaLw8QK7OlxDRzzsVlpcRdI8NTk4eREc2Z05RDElTab+DpMTPGvVidbYhLWCs3aRHtcZWZvY=
MIME-Version: 1.0
From: Stephane Eranian <eranian@google.com>
Date: Mon, 16 Apr 2018 22:04:53 +0000
Message-ID: <CABPqkBS6MuO6Twtq=_+TDV=RNy0_2vRWf=LVCk6wk0tPwNSTog@mail.gmail.com>
Subject: [RFC] perf/core: what is exclude_idle supposed to do
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, mingo@elte.hu,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to understand what the exclude_idle event attribute is supposed
to accomplish.
As per the definition in the header file:

    exclude_idle   :  1, /* don't count when idle */

Naively, I thought it would simply stop the event when running in the
context of the idle task (swapper, pid 0) on any CPU. That would seem to
match the succinct description.

However, running a simple:

$ perf record -a -e cycles:I sleep 5
perf_event_attr:
    sample_type                      IP|TID|TIME|CPU|PERIOD
   read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID
   exclude_idle                     1

on an idle machine, showed me that this is not what is actually happening:
$ perf  script
          swapper     0 [000] 1132634.287442:          1 cycles:I:
  ffffffff8100b1fb __intel_pmu_enable_all.isra.17 ([kernel.kallsyms])
          swapper     0 [001] 1132634.287498:          1 cycles:I:
  ffffffff8100b1fb __intel_pmu_enable_all.isra.17 ([kernel.kallsyms])


After looking at the code, it all made sense, it seems to current
implementation is only relevant for sw events. I don't understand why.

I am left wondering what is the goal of exclude_idle?
