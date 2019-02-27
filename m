Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E8DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ED02133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfB0NVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:21:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfB0NVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:21:11 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 262462DE407;
        Wed, 27 Feb 2019 13:21:11 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id DB7955D6AA;
        Wed, 27 Feb 2019 13:21:06 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:21:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v4 perf,bpf 14/15] perf: introduce side band thread
Message-ID: <20190227132105.GC18893@krava>
References: <20190226002019.3748539-1-songliubraving@fb.com>
 <20190226002019.3748539-15-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226002019.3748539-15-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 27 Feb 2019 13:21:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 04:20:18PM -0800, Song Liu wrote:

SNIP

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 8c902276d4b4..61b87c8111e6 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -19,6 +19,7 @@
>  #include "debug.h"
>  #include "units.h"
>  #include "asm/bug.h"
> +#include "bpf-event.h"
>  #include <signal.h>
>  #include <unistd.h>
>  
> @@ -1841,3 +1842,102 @@ struct perf_evsel *perf_evlist__reset_weak_group(struct perf_evlist *evsel_list,
>  	}
>  	return leader;
>  }
> +
> +static struct perf_evlist *sb_evlist;
> +pthread_t poll_thread;

so some of the things are static and some like poll_args
you alloced on the stack.. I dont like this interface,
could we come up with something generic? perhaps
encapsulated in perf_evlist, like:

struct perf_evlist {
	...
	struct {
		pthread_t	th;
		int		state;
	} thread;
};

typedef int (perf_evlist__thread_cb_t)(perf_evlist, union perf_event *event,....)

perf_evlist__start_thread(perf_evlist, perf_evlist__thread_cb_t cb);
perf_evlist__stop_thread(perf_evlist);


jirka
