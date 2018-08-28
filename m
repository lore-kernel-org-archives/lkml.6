Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C8FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DE42089F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DE42089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeH1Mtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:49:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbeH1Mtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:49:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A18A40006EC;
        Tue, 28 Aug 2018 08:59:06 +0000 (UTC)
Received: from krava (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 147B92166B41;
        Tue, 28 Aug 2018 08:59:04 +0000 (UTC)
Date:   Tue, 28 Aug 2018 10:59:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20180828085904.GH23727@krava>
References: <bdd669cd-a6dc-d592-4655-33b7bfc46cbb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdd669cd-a6dc-d592-4655-33b7bfc46cbb@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 28 Aug 2018 08:59:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 28 Aug 2018 08:59:06 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:03:21PM +0300, Alexey Budankov wrote:
> 
> Currently in record mode the tool implements trace writing serially. 
> The algorithm loops over mapped per-cpu data buffers and stores ready 
> data chunks into a trace file using write() system call.
> 
> At some circumstances the kernel may lack free space in a buffer 
> because the other buffer's half is not yet written to disk due to 
> some other buffer's data writing by the tool at the moment.
> 
> Thus serial trace writing implementation may cause the kernel 
> to loose profiling data and that is what observed when profiling 
> highly parallel CPU bound workloads on machines with big number 
> of cores.
> 
> Experiment with profiling matrix multiplication code executing 128 
> threads on Intel Xeon Phi (KNM) with 272 cores, like below,
> demonstrates data loss metrics value of 98%:
> 
> /usr/bin/time perf record -o /tmp/perf-ser.data -a -N -B -T -R -g \
>     --call-graph dwarf,1024 --user-regs=IP,SP,BP \
>     --switch-events -e cycles,instructions,ref-cycles,software/period=1,name=cs,config=0x3/Duk -- \
>     matrix.gcc
> 
> Data loss metrics is the ratio lost_time/elapsed_time where 
> lost_time is the sum of time intervals containing PERF_RECORD_LOST 
> records and elapsed_time is the elapsed application run time 
> under profiling.

I like the idea and I think it's good direction to go, but could
you please share some from perf stat or whatever you used to meassure
the new performance?

thanks,
jirka
