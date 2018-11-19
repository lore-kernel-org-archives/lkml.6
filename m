Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB14C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05AF20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ETGuln5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05AF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbeKTJsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:48:08 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37379 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeKTJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:48:08 -0500
Received: by mail-pf1-f194.google.com with SMTP id u3-v6so18175pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NFQekV+v93HdzEVK5NBAMzGIAsQcp7WkUEUOdVfKvwE=;
        b=ETGuln5llaYgh6gTgIkM659OvBzyFMqReeEar2moGqF44yTr3GYwjDBbD6v+3bDrfn
         qvfpgMrDzG/7FFiPve2r5Ll4P5sQmSs0BcqIatr9S2O+S2pXiD/ShcCEgyhCE1b3joIA
         GbqfSr7dsX2oAonQeicKbboqDQJFwDeMeZJ4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NFQekV+v93HdzEVK5NBAMzGIAsQcp7WkUEUOdVfKvwE=;
        b=EgyJMxXslcgyvYFzpdfBjJTQBRNaF84Gr/QY9NG/wXpHshtGxnQey549rb0jaVO7lI
         ySCRQ1vZtfhZw6/fc97vp30YhCt4b7a1oygp/4KI+5xANlYYAuPPkqX9lDL7PJMBH1eM
         7T8s6wOCCtLQ0qgIa7+LkuChotxwCWQEs8WbCArmpzlKAbec1+dxn4WxSkqYXuwmgU1Z
         kYkRXNfy1fj6bW7rCUxHmKVPDgyb17BRwAHcw8tPzuxdWaIX8kO6WfovlmiYjyQqYJfl
         Cf+L+VQ1t0jXH7ntGmSPGIgx8t6tMCCuq5ugBTTqQodlM9/vd3PTXEZdVC4/cp+EClUq
         MVZA==
X-Gm-Message-State: AGRZ1gJICDKztJJU0mlW3pzJK3xVCGFtSSK5a4wMbXpuBGOEB07rQ5Ly
        9n2ne/OlKOZ/bwvYByflW+0FMQ==
X-Google-Smtp-Source: AJdET5dMtWVpYwLRZbh1NfUT8Oo9pDBmK3tJMBdsNsSL9VSBlkjGReXqLyziDfSzyHLHZ10C+OrvTw==
X-Received: by 2002:a63:2141:: with SMTP id s1mr22117631pgm.148.1542669726181;
        Mon, 19 Nov 2018 15:22:06 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m3sm6207633pff.173.2018.11.19.15.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 15:22:04 -0800 (PST)
Date:   Mon, 19 Nov 2018 16:22:02 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v2 2/2] perf cs-etm: Add support sample flags
Message-ID: <20181119232202.GA7001@xps15>
References: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
 <1541912876-20967-3-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541912876-20967-3-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 01:07:56PM +0800, Leo Yan wrote:
> We have prepared the flags in the packet structure, so need to copy
> the related value into sample structure thus perf tool can facilitate
> sample flags.
> 
> The PREV_PACKET contains the branch instruction flags and PACKET
> actually contains the flags for next branch instruction.  So this patch
> is to set sample flags with 'etmq->prev_packet->flags'.
> 
> This patch includes three fixing up for sample flags based on the
> packets context:
> 
> - If the packet is exception packet or exception return packet, update
>   the previous packet for exception specific flags;
> - If there has TRACE_ON or TRACE_OFF packet in the middle of instruction
>   packets, this indicates the trace is discontinuous, so append the flag
>   PERF_IP_FLAG_TRACE_END to the previous packet to indicate the trace
>   has been ended;
> - If one instruction packet is behind TRACE_OFF packet, this instruction
>   is restarting trace packet.  So set flag PERF_IP_FLAG_TRACE_START to
>   TRACE_OFF packet if one, this flag isn't used by TRACE_OFF packet but
>   used to indicate trace restarting when generate sample.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 43 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 455f132..afca6f3 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -676,7 +676,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>  	sample.stream_id = etmq->etm->instructions_id;
>  	sample.period = period;
>  	sample.cpu = etmq->packet->cpu;
> -	sample.flags = 0;
> +	sample.flags = etmq->prev_packet->flags;
>  	sample.insn_len = 1;
>  	sample.cpumode = event->sample.header.misc;
>  
> @@ -735,7 +735,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
>  	sample.stream_id = etmq->etm->branches_id;
>  	sample.period = 1;
>  	sample.cpu = etmq->packet->cpu;
> -	sample.flags = 0;
> +	sample.flags = etmq->prev_packet->flags;
>  	sample.cpumode = event->sample.header.misc;
>  
>  	/*
> @@ -878,6 +878,43 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
>  	return 0;
>  }
>  
> +static void cs_etm__fixup_flags(struct cs_etm_queue *etmq)
> +{
> +	/*
> +	 * Decoding stream might insert one TRACE_OFF packet in the
> +	 * middle of instruction packets, this means it doesn't
> +	 * contain the pair packets with TRACE_OFF and TRACE_ON.
> +	 * For this case, the instruction packet follows with
> +	 * TRACE_OFF packet so we need to fixup prev_packet with flag
> +	 * PERF_IP_FLAG_TRACE_BEGIN, this flag finally is used by the
> +	 * instruction packet to generate samples.
> +	 */
> +	if (etmq->prev_packet->sample_type == CS_ETM_TRACE_OFF &&
> +	    etmq->packet->sample_type == CS_ETM_RANGE)
> +		etmq->prev_packet->flags = PERF_IP_FLAG_BRANCH |
> +					   PERF_IP_FLAG_TRACE_BEGIN;
> +
> +	if (etmq->prev_packet->sample_type == CS_ETM_RANGE) {
> +		/*
> +		 * When the exception packet is inserted, update flags
> +		 * so tell perf it is exception related branches.
> +		 */
> +		if (etmq->packet->sample_type == CS_ETM_EXCEPTION ||
> +		    etmq->packet->sample_type == CS_ETM_EXCEPTION_RET)
> +			etmq->prev_packet->flags = etmq->packet->flags;
> +
> +		/*
> +		 * The trace is discontinuous, weather this is caused by
> +		 * TRACE_ON packet or TRACE_OFF packet is coming, if the
> +		 * previous packet is instruction packet, simply set flag
> +		 * PERF_IP_FLAG_TRACE_END for previous packet.
> +		 */
> +		if (etmq->packet->sample_type == CS_ETM_TRACE_ON ||
> +		    etmq->packet->sample_type == CS_ETM_TRACE_OFF)
> +			etmq->prev_packet->flags |= PERF_IP_FLAG_TRACE_END;
> +	}
> +}
> +

I think it would be better to keep all the flag related processing in
cs-etm-decoder.c so that things in cs-etm.c are only concered with dealing with
perf.

Look at function cs_etm__alloc_queue(), there you'll find "d_params.data = etmq".

In function cs_etm_decoder__new(), decoder->data = d_params->data;

This means that anywhere you have a decoder, decoder->data is an etmq.  I've
used this profusely in my work on CPU-wide trace scenarios.  Because you're
getting there ahead of me you'll need to fix the declaration of struct
cs_etm_queue but that's easy.

Regards,
Mathieu 

>  static int cs_etm__sample(struct cs_etm_queue *etmq)
>  {
>  	struct cs_etm_auxtrace *etm = etmq->etm;
> @@ -1100,6 +1137,8 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  					 */
>  					break;
>  
> +				cs_etm__fixup_flags(etmq);
> +
>  				switch (etmq->packet->sample_type) {
>  				case CS_ETM_RANGE:
>  					/*
> -- 
> 2.7.4
> 
