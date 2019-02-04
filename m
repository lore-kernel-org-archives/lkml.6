Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D692C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DAC217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfBDKgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:36:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbfBDKgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:36:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8D9BF81F0D;
        Mon,  4 Feb 2019 10:36:46 +0000 (UTC)
Received: from krava (unknown [10.43.17.135])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1EA0191F14;
        Mon,  4 Feb 2019 10:36:43 +0000 (UTC)
Date:   Mon, 4 Feb 2019 11:36:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in
 directory
Message-ID: <20190204103643.GA18141@krava>
References: <20190203153018.9650-1-jolsa@kernel.org>
 <8d8b3f0d-cea8-2daf-249f-29f485c49a46@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d8b3f0d-cea8-2daf-249f-29f485c49a46@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 04 Feb 2019 10:36:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 01:12:11PM +0300, Alexey Budankov wrote:
> 
> Hi,
> 
> On 03.02.2019 18:30, Jiri Olsa wrote:
> > hi,
> > this patchset adds the --dir option to record command (and all
> > the other record command that overload cmd_record) that allows
> > the data to be stored in directory with multiple data files.
> > 
> > It's next step for multiple threads implementation in record.
> > It's now possible to make directory data via --dir option, like:
> > 
> >   $ perf record --dir perf bench sched messaging
> 
> Is it possible to name data directory differently from perf.data 
> e.g. using --output option, like this?
> 
>   $ perf record --output result_1 --dir perf bench sched messaging


yep, it's taken into account:

[jolsa@krava perf]$ ./perf record --output result_1 --dir ./perf bench sched messaging
Couldn't synthesize bpf events.
# Running 'sched/messaging' benchmark:
# 20 sender and receiver processes per group
# 10 groups == 400 processes run

     Total time: 0.177 [sec]
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.316 MB result_1 (7225 samples) ]

[jolsa@krava perf]$ ll result_1/
total 348
-rw-------. 1 jolsa jolsa 27624 Feb  4 11:35 data.0
-rw-------. 1 jolsa jolsa 56672 Feb  4 11:35 data.1
-rw-------. 1 jolsa jolsa 30824 Feb  4 11:35 data.2
-rw-------. 1 jolsa jolsa 49136 Feb  4 11:35 data.3
-rw-------. 1 jolsa jolsa 22712 Feb  4 11:35 data.4
-rw-------. 1 jolsa jolsa 53392 Feb  4 11:35 data.5
-rw-------. 1 jolsa jolsa 43352 Feb  4 11:35 data.6
-rw-------. 1 jolsa jolsa 46688 Feb  4 11:35 data.7
-rw-------. 1 jolsa jolsa  9068 Feb  4 11:35 header

jirka
