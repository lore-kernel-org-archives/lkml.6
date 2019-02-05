Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EA2C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A6020844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 13:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfBENhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 08:37:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfBENhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 08:37:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3008653C6;
        Tue,  5 Feb 2019 13:37:30 +0000 (UTC)
Received: from krava (unknown [10.43.17.224])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6071683BB0;
        Tue,  5 Feb 2019 13:37:28 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:37:27 +0100
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
Message-ID: <20190205133727.GF4794@krava>
References: <20190203153018.9650-1-jolsa@kernel.org>
 <8d8b3f0d-cea8-2daf-249f-29f485c49a46@linux.intel.com>
 <20190204103643.GA18141@krava>
 <6bf24b7d-2bd3-8091-cf49-363c91e4e864@linux.intel.com>
 <20190204114144.GC18141@krava>
 <CABPqkBQpQX67NOysim7s-R84nAYipXJ+DgR=xYPi6zWQWgq4Zg@mail.gmail.com>
 <20190204192721.GI5593@kernel.org>
 <CABPqkBTcxkKkxBwLfToenAk0ubp-o08xVq=XqpkfzYHTNqgBkQ@mail.gmail.com>
 <20190204202818.GC4794@krava>
 <CABPqkBQTpt0dhinJZc+mJ-JNvkU2M9DVx1G65ngWxZxk-eGBVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQTpt0dhinJZc+mJ-JNvkU2M9DVx1G65ngWxZxk-eGBVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 05 Feb 2019 13:37:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 02:44:37PM -0800, Stephane Eranian wrote:
> Jiri,
> 
> While you're looking at the output format, I think it would be good
> time to simplify the code handling perf.data file.
> Today, perf record can emit in two formats: file mode or pipe mode.
> This adds complexity in the code and
> is error prone as the file mode path is tested more than the pipe mode
> path. We have run into multiple issues with
> the pipe mode in recent years. There is no real reason why we need to
> maintain two formats. If I recall, the pipe format
> was introduced because on pipes you cannot lseek to update the headers
> and therefore some of the information present as tables
> updated on the fly needed to be generated as pseudo records by the
> tool. I believe that the pipe format covers all the needs and could
> supersede the file mode format. That would simplify code in perf
> record and eliminate the risk of errors when new headers
> are introduced.

yep, I think we have almost all the features covered for pipe mode,
and we have all necessary events to describe events features

so with some effort we could switch off the superfluos file header
and use only events to describe events ;-) make sense, I'll check
on it

> 
> Related to your effort to make perf record multi-threaded, I was
> wondering how this would impact pipe mode.
> Could you explain?

there's no support for threaded pipe processing at the moment,
currently the data are stored in directory:

  $ ls -l perf.data
  total 344
  -rw-------. 1 jolsa jolsa 43864 Jan 20 22:26 data.0
  -rw-------. 1 jolsa jolsa 30464 Jan 20 22:26 data.1
  -rw-------. 1 jolsa jolsa 53816 Jan 20 22:26 data.2
  -rw-------. 1 jolsa jolsa 30368 Jan 20 22:26 data.3
  -rw-------. 1 jolsa jolsa 40088 Jan 20 22:26 data.4
  -rw-------. 1 jolsa jolsa 42592 Jan 20 22:26 data.5
  -rw-------. 1 jolsa jolsa 56136 Jan 20 22:26 data.6
  -rw-------. 1 jolsa jolsa 25992 Jan 20 22:26 data.7

  ^^^^ those are raw data files, contains only events with common header
        as stored by perf or kernel

  -rw-------. 1 jolsa jolsa  8832 Jan 20 22:26 header

  ^^^^ this one currently holds perf.data file header, describing events
       and features

if we switched to pipe mode by default we could omit the header file
and find a way to push the data streams through single file, like with
a new event describing the data stream.. we can have an option for that
so you could do something like:

  # perf record --threads --single-file -a ... | perf report -i -

however having single thread storing storing into single file without
any other processing is important on record side (for minimal overhead),
so I think we should keep creating the directory with data files also
for pipe mode to have minimal overhead

jirka
