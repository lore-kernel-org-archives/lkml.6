Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65962C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37652217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfAVToy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:44:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfAVToy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:44:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C6CE80462;
        Tue, 22 Jan 2019 19:44:53 +0000 (UTC)
Received: from krava (ovpn-204-73.brq.redhat.com [10.40.204.73])
        by smtp.corp.redhat.com (Postfix) with SMTP id 68F4065F72;
        Tue, 22 Jan 2019 19:44:50 +0000 (UTC)
Date:   Tue, 22 Jan 2019 20:44:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v11 perf, bpf-next 7/9] perf tools: synthesize
 PERF_RECORD_* for loaded BPF programs
Message-ID: <20190122194449.GI27625@krava>
References: <20190117161521.1341602-8-songliubraving@fb.com>
 <20190118144655.GM5823@kernel.org>
 <20190122141320.GF14973@kernel.org>
 <20190122143117.GG14973@kernel.org>
 <20190122145119.GF27625@krava>
 <20190122145805.GI14973@kernel.org>
 <20190122152145.GG27625@krava>
 <101BF88D-2DA4-4B54-A710-D0641C427136@fb.com>
 <20190122191555.GH27625@krava>
 <CF447261-1B9C-423B-9508-60B32EAC4A5C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF447261-1B9C-423B-9508-60B32EAC4A5C@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 22 Jan 2019 19:44:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 07:24:43PM +0000, Song Liu wrote:
> 
> 
> > On Jan 22, 2019, at 11:15 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Tue, Jan 22, 2019 at 06:38:56PM +0000, Song Liu wrote:
> > 
> > SNIP
> > 
> >>>> in perf_session__process_event, this happens right when processing
> >>>> buildids in 'perf record', and also in 'perf report', so that is
> >>>> something badly synthesized that hits perf.data for PERF_RECORD_KSYMBOL.
> >>> 
> >>> it's reproducible with simple:
> >>> perf record -e cycles,instructions ls
> >>> 
> >>> as you said on irc, it's the machine->id_hdr_size size missing
> >>> there's one more glitch, attached patch fixes that for me
> >>> you can't use sizeof(struct ksymbol_event), because it includes
> >>> the name as well.. which screws the size
> >>> 
> >>> but I don't know that code that much.. might be still something
> >>> missing
> >>> 
> >>> jirka
> >> 
> >> Hi Arnaldo and Jiri,
> >> 
> >> Thanks for catching and fixing the bug. 
> >> 
> >> I guess the following is OK?
> >> 
> >>        *bpf_event = (struct bpf_event){
> >>                .header = {
> >>                        .type = PERF_RECORD_BPF_EVENT,
> >>                        .size = sizeof(struct bpf_event),
> >>                },
> >>                .type = PERF_BPF_EVENT_PROG_LOAD,
> >>                .flags = 0,
> >>                .id = info.id,
> >>        };
> >> 
> >> as struct bpf_event doesn't have variable length name:
> >> 
> >>        struct bpf_event {
> >>                struct perf_event_header header;
> >>                u16 type;
> >>                u16 flags;
> >>                u32 id;
> >> 
> >>                /* for bpf_prog types */
> >>                u8 tag[BPF_TAG_SIZE];  // prog tag
> >>        };
> >> 
> >> Or we need similar fix? 
> > 
> > yep, looks good.. also don't forget to add the 'machine->id_hdr_size'
> > 
> > jirka
> 
> So we still need something like?
> 
> diff --git i/tools/perf/util/bpf-event.c w/tools/perf/util/bpf-event.c
> index 01e1dc1bb7fb..d7bf45485820 100644
> --- i/tools/perf/util/bpf-event.c
> +++ w/tools/perf/util/bpf-event.c
> @@ -4,6 +4,7 @@
>  #include <bpf/bpf.h>
>  #include <bpf/btf.h>
>  #include <linux/btf.h>
> +#include "machine.h"
>  #include "bpf-event.h"
>  #include "debug.h"
>  #include "symbol.h"
> @@ -187,7 +188,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
>                 *bpf_event = (struct bpf_event){
>                         .header = {
>                                 .type = PERF_RECORD_BPF_EVENT,
> -                               .size = sizeof(struct bpf_event),
> +                               .size = sizeof(struct bpf_event) + machine->id_hdr_size,
>                         },
>                         .type = PERF_BPF_EVENT_PROG_LOAD,
>                         .flags = 0,
> 
> Would you send the official patch? Or would you prefer me sending it?

plese send it, thanks

jirka
