Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D107CC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2D0217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfBLNJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:09:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbfBLNJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:09:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 835EECA375;
        Tue, 12 Feb 2019 13:09:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id D6DA35D97A;
        Tue, 12 Feb 2019 13:09:36 +0000 (UTC)
Date:   Tue, 12 Feb 2019 14:09:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] perf record: implement -z=<level> and
 --mmap-flush=<thres> options
Message-ID: <20190212130935.GO775@krava>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
 <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d676199-bfe0-d8e0-442e-41280046f819@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 12 Feb 2019 13:09:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:22:38PM +0300, Alexey Budankov wrote:
> 
> Implement -z,--compression_level=<n> and --mmap-flush=<dump_least_size>
> options as well as a special PERF_RECORD_COMPRESSED record that contains
> compressed parts of kernel data buffer.
> 
> Because compression requires auxilary memory to implement encoding of
> kernel data record->opts.nr_cblocks == -1 signifies to preallocate single
> AIO data buffer aio.data[0] without accompnying AIO control blocks.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
> Changes in v2:
> - enabled allocation aio data buffers for compression
> 
> ---
>  tools/perf/Documentation/perf-record.txt |   9 ++
>  tools/perf/builtin-record.c              | 110 +++++++++++++++++++----
>  tools/perf/perf.h                        |   2 +
>  tools/perf/util/env.h                    |  10 +++
>  tools/perf/util/event.c                  |   1 +
>  tools/perf/util/event.h                  |   7 ++
>  tools/perf/util/evlist.c                 |   6 +-
>  tools/perf/util/evlist.h                 |   3 +-
>  tools/perf/util/header.c                 |  45 +++++++++-
>  tools/perf/util/header.h                 |   1 +
>  tools/perf/util/mmap.c                   |  98 ++++++++++++--------
>  tools/perf/util/mmap.h                   |   7 +-
>  tools/perf/util/session.h                |   2 +
>  13 files changed, 240 insertions(+), 61 deletions(-)

this patch is super complicated.. please think of reviewers
when writing code ;-)

it needs to be split to small logical patches,
where each change is explained in changelog

jirka
