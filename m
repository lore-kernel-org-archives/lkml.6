Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE57C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EABB021019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfAVOvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:51:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728318AbfAVOvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:51:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B766B87638;
        Tue, 22 Jan 2019 14:51:23 +0000 (UTC)
Received: from krava (ovpn-204-197.brq.redhat.com [10.40.204.197])
        by smtp.corp.redhat.com (Postfix) with SMTP id D9C9C1001F45;
        Tue, 22 Jan 2019 14:51:20 +0000 (UTC)
Date:   Tue, 22 Jan 2019 15:51:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v11 perf, bpf-next 7/9] perf tools: synthesize
 PERF_RECORD_* for loaded BPF programs
Message-ID: <20190122145119.GF27625@krava>
References: <20190117161521.1341602-1-songliubraving@fb.com>
 <20190117161521.1341602-8-songliubraving@fb.com>
 <20190118144655.GM5823@kernel.org>
 <20190122141320.GF14973@kernel.org>
 <20190122143117.GG14973@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122143117.GG14973@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 22 Jan 2019 14:51:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 12:31:17PM -0200, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 22, 2019 at 12:13:20PM -0200, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Jan 18, 2019 at 11:46:55AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Jan 17, 2019 at 08:15:19AM -0800, Song Liu escreveu:
> > > > This patch synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for
> > > > BPF programs loaded before perf-record. This is achieved by gathering
> > > > information about all BPF programs via sys_bpf.
> > > 
> > > Ditto
> > 
> > This is breaking 'perf sched', see below, the fix seems trivial:
> > 
> > [root@quaco ~]# perf sched record -a sleep 2
> > [ perf record: Woken up 1 times to write data ]
> > 0x5b60 [0x138]: failed to process type: 17
> > [ perf record: Captured and wrote 1.539 MB perf.data ]
> > [root@quaco ~]# perf sched lat
> > 0x5b60 [0x138]: failed to process type: 17
> > Failed to process events, error -22
> > [root@quaco ~]#
> 
> So:
> 
>    perf_session__process_event (event->header.type = 17 (PERF_RECORD_KSYMBOL)
>      if (tool->ordered_events)
>        ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
>        if (ret && ret != -1)
>             return ret;
> 
> So it returns here with -EFAULT, i.e. this is failing:
> 
> int perf_evlist__parse_sample_timestamp(struct perf_evlist *evlist,
>                                         union perf_event *event,
>                                         u64 *timestamp)
> {
>         struct perf_evsel *evsel = perf_evlist__event2evsel(evlist, event);
> 
>         if (!evsel)
>                 return -EFAULT;
>         return perf_evsel__parse_sample_timestamp(evsel, event, timestamp);
> }
> 
> It isn't mapping the event ID it finds back to an evsel.. Jiri, ideas?
> 
> This is happening so far only for 'perf sched', perf record with two
> events works.

I saw also perf mem failing because of this.. will check

jirka
