Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59248C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C54B20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfBKKUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:20:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfBKKUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:20:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2AE8C637E0;
        Mon, 11 Feb 2019 10:20:00 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id C9E7C61556;
        Mon, 11 Feb 2019 10:19:57 +0000 (UTC)
Date:   Mon, 11 Feb 2019 11:19:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in
 directory
Message-ID: <20190211101957.GB14253@krava>
References: <8d8b3f0d-cea8-2daf-249f-29f485c49a46@linux.intel.com>
 <20190204103643.GA18141@krava>
 <6bf24b7d-2bd3-8091-cf49-363c91e4e864@linux.intel.com>
 <20190204114144.GC18141@krava>
 <CABPqkBQpQX67NOysim7s-R84nAYipXJ+DgR=xYPi6zWQWgq4Zg@mail.gmail.com>
 <20190204192721.GI5593@kernel.org>
 <CABPqkBTcxkKkxBwLfToenAk0ubp-o08xVq=XqpkfzYHTNqgBkQ@mail.gmail.com>
 <20190204202818.GC4794@krava>
 <CABPqkBQTpt0dhinJZc+mJ-JNvkU2M9DVx1G65ngWxZxk-eGBVA@mail.gmail.com>
 <20190205133727.GF4794@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205133727.GF4794@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 11 Feb 2019 10:20:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 02:37:27PM +0100, Jiri Olsa wrote:
> On Mon, Feb 04, 2019 at 02:44:37PM -0800, Stephane Eranian wrote:
> > Jiri,
> > 
> > While you're looking at the output format, I think it would be good
> > time to simplify the code handling perf.data file.
> > Today, perf record can emit in two formats: file mode or pipe mode.
> > This adds complexity in the code and
> > is error prone as the file mode path is tested more than the pipe mode
> > path. We have run into multiple issues with
> > the pipe mode in recent years. There is no real reason why we need to
> > maintain two formats. If I recall, the pipe format
> > was introduced because on pipes you cannot lseek to update the headers
> > and therefore some of the information present as tables
> > updated on the fly needed to be generated as pseudo records by the
> > tool. I believe that the pipe format covers all the needs and could
> > supersede the file mode format. That would simplify code in perf
> > record and eliminate the risk of errors when new headers
> > are introduced.
> 
> yep, I think we have almost all the features covered for pipe mode,
> and we have all necessary events to describe events features
> 
> so with some effort we could switch off the superfluos file header
> and use only events to describe events ;-) make sense, I'll check
> on it

so following features are not synthesized:

        FEAT_OPN(TRACING_DATA,  tracing_data,   false),
        FEAT_OPN(BUILD_ID,      build_id,       false),
        FEAT_OPN(BRANCH_STACK,  branch_stack,   false),
        FEAT_OPN(AUXTRACE,      auxtrace,       false),
        FEAT_OPN(STAT,          stat,           false),
        FEAT_OPN(CACHE,         cache,          true),

I think all could be added and worked around with exception
of BUILD_ID, which we store at the end (after processing
all data) and we need it early in the report phase

maybe it's time to re-think that buildid -> mmap event
association again, because it's pain in current implementation
as well

looks like bpf code is actualy getting build ids and storing
it for the callchains in kernel.. we can check if we can do
something similar for mmap events

jirka
