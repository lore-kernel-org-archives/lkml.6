Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8F0C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBEC22B66
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 22:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBEC22B66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754259AbeGFWAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 18:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753631AbeGFWAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 18:00:20 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 354C722ACC;
        Fri,  6 Jul 2018 22:00:19 +0000 (UTC)
Date:   Fri, 6 Jul 2018 18:00:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Claudio <claudio.fontana@gliwa.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ftrace performance (sched events): cyclictest shows 25% more
 latency
Message-ID: <20180706180017.1f52ba5f@gandalf.local.home>
In-Reply-To: <20180706173922.734616de@gandalf.local.home>
References: <73e2f61e-7e7b-d8be-6c94-896cf94e7567@gliwa.com>
        <20180706172428.30aeef91@gandalf.local.home>
        <20180706173922.734616de@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018 17:39:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 6 Jul 2018 17:24:28 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > I'll investigate further.  
> 
> Note, I enabled function tracing to trace the scheduler function:
> 
>  # trace-cmd start -p function -l schedule
> 
> And then ran cyclictest. That does not cause any noticeable increase
> in latency (try it). So there is some kind of side effect with the
> trace event itself, and not the recording of the event.

It does add some noise but not nearly as much as a trace event. But,
then I did function graph tracing:

First I did:

  trace-cmd record -p function_graph -l schedule /work/git-local/rt-tests.git/cyclictest --smp -p95 -m -s -N -l 100000 -q

And got this:

          <idle>-0     [000]  3034.534021: sched_switch:         swapper/0:0 [120] S ==> trace-cmd:1693 [120]
       trace-cmd-1693  [000]  3034.534029: funcgraph_entry:                   |  schedule() {
       trace-cmd-1693  [000]  3034.534043: sched_switch:         trace-cmd:1693 [120] D ==> swapper/0:0 [120]
          <idle>-0     [000]  3034.535084: sched_switch:         swapper/0:0 [120] S ==> trace-cmd:1693 [120]
       trace-cmd-1693  [000]  3034.535086: funcgraph_exit:       # 1056.055 us |  }
       trace-cmd-1693  [000]  3034.535090: funcgraph_entry:                   |  schedule() {
       trace-cmd-1693  [000]  3034.535093: sched_switch:         trace-cmd:1693 [120] D ==> swapper/0:0 [120]
          <idle>-0     [000]  3034.536146: sched_switch:         swapper/0:0 [120] S ==> trace-cmd:1693 [120]
       trace-cmd-1693  [000]  3034.536147: funcgraph_exit:       # 1056.563 us |  }
       trace-cmd-1693  [000]  3034.536150: funcgraph_entry:                   |  schedule() {
       trace-cmd-1693  [000]  3034.536153: sched_switch:         trace-cmd:1693 [120] D ==> swapper/0:0 [120]
          <idle>-0     [000]  3034.537206: sched_switch:         swapper/0:0 [120] S ==> trace-cmd:1693 [120]
       trace-cmd-1693  [000]  3034.537207: funcgraph_exit:       # 1056.107 us |  }
       trace-cmd-1693  [000]  3034.537210: funcgraph_entry:                   |  schedule() {
       trace-cmd-1693  [000]  3034.537213: sched_switch:         trace-cmd:1693 [120] D ==> swapper/0:0 [120]
          <idle>-0     [000]  3034.538262: sched_switch:         swapper/0:0 [120] S ==> trace-cmd:1693 [120]
       trace-cmd-1693  [000]  3034.538263: funcgraph_exit:       # 1053.077 us |  }
       trace-cmd-1693  [000]  3034.538265: funcgraph_entry:                   |  schedule() {
       trace-cmd-1693  [000]  3034.538266: sched_switch:         trace-cmd:1693 [120] D ==> swapper/0:0 [120]
          <idle>-0     [000]  3034.538554: sched_switch:         swapper/0:0 [120] S ==> cyclictest:1698 [120]
      cyclictest-1698  [000]  3034.538565: funcgraph_entry:                   |  schedule() {
      cyclictest-1698  [000]  3034.538566: sched_switch:         cyclictest:1698 [4] D ==> swapper/0:0 [120]
          <idle>-0     [000]  3034.539318: sched_switch:         swapper/0:0 [120] S ==> trace-cmd:1693 [120]
       trace-cmd-1693  [000]  3034.539319: funcgraph_exit:       # 1053.723 us |  }
       trace-cmd-1693  [000]  3034.539322: funcgraph_entry:                   |  schedule() {
       trace-cmd-1693  [000]  3034.539324: sched_switch:         trace-cmd:1693 [120] D ==> swapper/0:0 [120]
          <idle>-0     [000]  3034.539567: sched_switch:         swapper/0:0 [120] S ==> cyclictest:1698 [4]
      cyclictest-1698  [000]  3034.539567: funcgraph_exit:       # 1002.624 us |  }

And that continued on as normal.

Then I ran it like this:

  trace-cmd record -p function_graph -l schedule /work/git-local/rt-tests.git/cyclictest --smp -p95 -m -s -N -l 100000 -q


And this was my result:

       trace-cmd-1749  [000]  3321.110772: funcgraph_entry:                   |  schedule() {
       trace-cmd-1749  [000]  3321.111826: funcgraph_exit:       # 1053.004 us |  }
       trace-cmd-1749  [000]  3321.111830: funcgraph_entry:                   |  schedule() {
       trace-cmd-1749  [000]  3321.112885: funcgraph_exit:       # 1054.734 us |  }
       trace-cmd-1749  [000]  3321.112888: funcgraph_entry:                   |  schedule() {
      cyclictest-1756  [000]  3321.113930: funcgraph_entry:                   |  schedule() {
       trace-cmd-1749  [000]  3321.113942: funcgraph_exit:       # 1054.240 us |  }
       trace-cmd-1749  [000]  3321.113947: funcgraph_entry:                   |  schedule() {
      cyclictest-1756  [000]  3321.114933: funcgraph_exit:       # 1002.600 us |  }
      cyclictest-1756  [000]  3321.114935: funcgraph_entry:                   |  schedule() {
       trace-cmd-1749  [000]  3321.115000: funcgraph_exit:       # 1053.451 us |  }
       trace-cmd-1749  [000]  3321.115004: funcgraph_entry:                   |  schedule() {
      cyclictest-1756  [000]  3321.115939: funcgraph_exit:       # 1003.116 us |  }
      cyclictest-1756  [000]  3321.115941: funcgraph_entry:                   |  schedule() {
       trace-cmd-1749  [000]  3321.116058: funcgraph_exit:       # 1054.142 us |  }
       trace-cmd-1749  [000]  3321.116061: funcgraph_entry:                   |  schedule() {
      cyclictest-1756  [000]  3321.116945: funcgraph_exit:       # 1003.559 us |  }
      cyclictest-1756  [000]  3321.116947: funcgraph_entry:                   |  schedule() {
       trace-cmd-1749  [000]  3321.117115: funcgraph_exit:       # 1053.649 us |  }
       trace-cmd-1749  [000]  3321.117119: funcgraph_entry:                   |  schedule() {
      cyclictest-1756  [000]  3321.117951: funcgraph_exit:       # 1003.586 us |  }
      cyclictest-1756  [000]  3321.117953: funcgraph_entry:                   |  schedule() {
       trace-cmd-1749  [000]  3321.118172: funcgraph_exit:       # 1053.264 us |  }
       trace-cmd-1749  [000]  3321.118176: funcgraph_entry:                   |  schedule() {
      cyclictest-1756  [000]  3321.118957: funcgraph_exit:       # 1003.656 us |  }
      cyclictest-1756  [000]  3321.118960: funcgraph_entry:                   |  schedule() {
       trace-cmd-1749  [000]  3321.119230: funcgraph_exit:       # 1053.770 us |  }
       trace-cmd-1749  [000]  3321.119234: funcgraph_entry:                   |  schedule() {
      cyclictest-1756  [000]  3321.119965: funcgraph_exit:       # 1004.830 us |  }
      cyclictest-1756  [000]  3321.119967: funcgraph_entry:                   |  schedule() {
       trace-cmd-1749  [000]  3321.120286: funcgraph_exit:       # 1052.469 us |  }

No noticeable difference in the time the scheduler took (going to and
from idle).

-- Steve
