Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D2AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F232E214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547215264;
	bh=akPNRKJFG3urVkePStUWw7av6HEoDxtLgKCvdM9YJNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZQMGegAvRifjC6qYdyFdTu6vqdcu/a9cX9iwrEQApAYPu/KeE+B4/D0S6C4pImEf7
	 KjGemHo2RhETUZZmmpKizk/ZlsUp+zJPVbtIVnoBmrso4FF/4Yg5d5NNtef63PXnut
	 NXpJ1FzyYa2oQIZd5CCUYysrmiinwvnqKE3gUQGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbfAKOBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:01:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfAKOBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:01:02 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7B3F20872;
        Fri, 11 Jan 2019 14:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547215261;
        bh=akPNRKJFG3urVkePStUWw7av6HEoDxtLgKCvdM9YJNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sL4HmWyvJEIEUgwv+KZ6iiNeuJm7FRfV6nrCtkl2QWFX83LapyTyAtw++sQcmJK1m
         y0gDY5/4+K43op7NAyZv/ChrrhTB6Qayw/UV7NEDS5l+yMA3164qFAp7tUlHtr74Rr
         v0GJkbr3LDYy+8W1cUR5ze5glufHogiWKL9J+ykY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 572AB41AB5; Fri, 11 Jan 2019 11:00:59 -0300 (-03)
Date:   Fri, 11 Jan 2019 11:00:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [Patch 1/4] perf report: Add function for verbose dump of raw
 data
Message-ID: <20190111140059.GV22483@kernel.org>
References: <20190111115259.99438-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111115259.99438-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 11, 2019 at 12:52:56PM +0100, Thomas Richter escreveu:
> Add support to call an architecture dependend function to interpret
> raw data verbatim when dumping the perf.data file with
> option -D.

Please add "per-arch" to the summary, so that just by looking at my
inbox main page I can see what this is about.

Also how this will deal with processing a perf.data file generated on a
S/390 machine in another arch? I.e.

on s/390:

perf record -a sleep 10

on a x86_64:

scp that file
perf report -i perf.data.from.s390

?

report code should lookup a function for the architecture the perf.data
was recorded on, using the perf.data file header, etc.

        const char *arch_name = perf_env__arch(session->header->env);

Then lookup a table to find the right function, ok? See arch__find() for
an example used in the annotation code.

- Arnaldo
 
> This allows to display the event's raw data more verbatim
> than just plain hex data.
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/session.c | 7 +++++++
>  tools/perf/util/session.h | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 7d2c8ce6cfad..1c8d6d0ef300 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1050,6 +1050,12 @@ static void sample_read__printf(struct perf_sample *sample, u64 read_format)
>  			sample->read.one.id, sample->read.one.value);
>  }
>  
> +void __weak arch__trace_event(struct perf_evlist *evlist __maybe_unused,
> +			      union perf_event *event __maybe_unused,
> +			      struct perf_sample *sample __maybe_unused)
> +{
> +}
> +
>  static void dump_event(struct perf_evlist *evlist, union perf_event *event,
>  		       u64 file_offset, struct perf_sample *sample)
>  {
> @@ -1060,6 +1066,7 @@ static void dump_event(struct perf_evlist *evlist, union perf_event *event,
>  	       file_offset, event->header.size, event->header.type);
>  
>  	trace_event(event);
> +	arch__trace_event(evlist, event, sample);
>  
>  	if (sample)
>  		perf_evlist__print_tstamp(evlist, event, sample);
> diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> index d96eccd7d27f..160d9cd6a3ae 100644
> --- a/tools/perf/util/session.h
> +++ b/tools/perf/util/session.h
> @@ -128,4 +128,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool,
>  				    struct perf_evlist *evlist,
>  				    struct machine *machine);
>  
> +void arch__trace_event(struct perf_evlist *evlist __maybe_unused,
> +		       union perf_event *event __maybe_unused,
> +		       struct perf_sample *sample __maybe_unused);
>  #endif /* __PERF_SESSION_H */
> -- 
> 2.14.3

-- 

- Arnaldo
