Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D1AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6C021019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfAVTQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:16:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34596 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfAVTQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:16:00 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0A96811AC;
        Tue, 22 Jan 2019 19:15:59 +0000 (UTC)
Received: from krava (ovpn-204-73.brq.redhat.com [10.40.204.73])
        by smtp.corp.redhat.com (Postfix) with SMTP id EE39F5D9C8;
        Tue, 22 Jan 2019 19:15:56 +0000 (UTC)
Date:   Tue, 22 Jan 2019 20:15:55 +0100
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
Message-ID: <20190122191555.GH27625@krava>
References: <20190117161521.1341602-1-songliubraving@fb.com>
 <20190117161521.1341602-8-songliubraving@fb.com>
 <20190118144655.GM5823@kernel.org>
 <20190122141320.GF14973@kernel.org>
 <20190122143117.GG14973@kernel.org>
 <20190122145119.GF27625@krava>
 <20190122145805.GI14973@kernel.org>
 <20190122152145.GG27625@krava>
 <101BF88D-2DA4-4B54-A710-D0641C427136@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101BF88D-2DA4-4B54-A710-D0641C427136@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 22 Jan 2019 19:16:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 06:38:56PM +0000, Song Liu wrote:

SNIP

> >> in perf_session__process_event, this happens right when processing
> >> buildids in 'perf record', and also in 'perf report', so that is
> >> something badly synthesized that hits perf.data for PERF_RECORD_KSYMBOL.
> > 
> > it's reproducible with simple:
> >  perf record -e cycles,instructions ls
> > 
> > as you said on irc, it's the machine->id_hdr_size size missing
> > there's one more glitch, attached patch fixes that for me
> > you can't use sizeof(struct ksymbol_event), because it includes
> > the name as well.. which screws the size
> > 
> > but I don't know that code that much.. might be still something
> > missing
> > 
> > jirka
> 
> Hi Arnaldo and Jiri,
> 
> Thanks for catching and fixing the bug. 
> 
> I guess the following is OK?
> 
>         *bpf_event = (struct bpf_event){
>                 .header = {
>                         .type = PERF_RECORD_BPF_EVENT,
>                         .size = sizeof(struct bpf_event),
>                 },
>                 .type = PERF_BPF_EVENT_PROG_LOAD,
>                 .flags = 0,
>                 .id = info.id,
>         };
> 
> as struct bpf_event doesn't have variable length name:
> 
>         struct bpf_event {
>                 struct perf_event_header header;
>                 u16 type;
>                 u16 flags;
>                 u32 id;
> 
>                 /* for bpf_prog types */
>                 u8 tag[BPF_TAG_SIZE];  // prog tag
>         };
> 
> Or we need similar fix? 

yep, looks good.. also don't forget to add the 'machine->id_hdr_size'

jirka
