Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C263CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE75206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfAIQ6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:58:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726639AbfAIQ6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:58:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15DBFC05E74D;
        Wed,  9 Jan 2019 16:58:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id 632525D75D;
        Wed,  9 Jan 2019 16:58:34 +0000 (UTC)
Date:   Wed, 9 Jan 2019 17:58:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/4] perf record: introduce z, mmap-flush options and
 PERF_RECORD_COMPRESSED record
Message-ID: <20190109165833.GD19455@krava>
References: <eaa8b5da-103f-61c8-bdca-2a2a27bf1715@linux.intel.com>
 <d8b15698-67da-3fea-8bd5-32e18d223e99@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b15698-67da-3fea-8bd5-32e18d223e99@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 09 Jan 2019 16:58:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 04:45:21PM +0300, Alexey Budankov wrote:
> 
> Introduce --compression_level=n, --mmap-flush options and PERF_RECORD_COMPRESSED 
> event record that contains compressed parts of mmap kernel buffer data.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 11 +++
>  tools/perf/builtin-record.c              | 97 ++++++++++++++++++++----
>  tools/perf/perf.h                        |  2 +
>  tools/perf/util/env.h                    | 10 +++
>  tools/perf/util/event.c                  |  1 +
>  tools/perf/util/event.h                  |  7 ++
>  tools/perf/util/evlist.c                 |  6 +-
>  tools/perf/util/evlist.h                 |  2 +-
>  tools/perf/util/header.c                 | 47 +++++++++++-
>  tools/perf/util/header.h                 |  1 +
>  tools/perf/util/mmap.c                   |  4 +-
>  tools/perf/util/mmap.h                   |  3 +-
>  12 files changed, 169 insertions(+), 22 deletions(-)

also I'm getting here similar error (like for the affinity patchset)

[jolsa@krava perf]$ git am /tmp/comp
Applying: feature: build libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines
Applying: perf record: introduce z, mmap-flush options and PERF_RECORD_COMPRESSED record
error: corrupt patch at line 526
Patch failed at 0002 perf record: introduce z, mmap-flush options and PERF_RECORD_COMPRESSED record

again the raw patch applies correctly:

[jolsa@krava perf]$ patch -p3 < /tmp/comp2
patching file Documentation/perf-record.txt
patching file builtin-record.c
patching file perf.h
patching file util/env.h
patching file util/event.c
patching file util/event.h
patching file util/evlist.c
patching file util/evlist.h
patching file util/header.c
patching file util/header.h
patching file util/mmap.c
patching file util/mmap.h


jirka
