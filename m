Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80331C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2828820851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VAA+kmeK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2828820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeLEDb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:31:56 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46742 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLEDb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:31:56 -0500
Received: by mail-wr1-f52.google.com with SMTP id l9so18080682wrt.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 19:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wlB088EpjbYek5NUXwNcHjHRuylhxCk0ZK1/tQY/sk0=;
        b=VAA+kmeKItk/BPU5YyORYApHXpEKcLqBlZ2zrXSWIYyciaPnf9bBiQg17/3Nh5bZou
         pro8CuOxcGIdlfPY9V028c+10gPduIHKtmlHgo0oMlYtsO1+83hOiRXagQcVoY6+DF2t
         SfOMDOktR3NFuwJYM3JwHdQUWwSsuKRUYAAYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wlB088EpjbYek5NUXwNcHjHRuylhxCk0ZK1/tQY/sk0=;
        b=XU/9p6ScioXG604rYYUySXcTmvqPFa6sO5HcV5xDnjB4cFZ+/Qy4l+8nF9WvtslJiM
         kXqvx7dznAlYqvk4SizH/2xhFjmwK3wHP65pDD7acaSqRM9UZgZYufnNTL5QTqthWJZA
         DsCD2c79XXur5xmXgv4iDoO0rYHFL4sPglq/j1sHpxvDBsXENv5Lqyv6xKW5pBMBrphZ
         U05tO2/FF5R1hPeqc4t1P9F3uqUy1T2Kx+krSsmO6yv8DUyCOCCuZDudPzmjujA/FQdO
         kZezE76X5fZ03UzJ3DG6M7ZVCl1XdfbVtJgeaojKwdjy+hDMxde4z/L3bEf12hZRoJ2c
         MAjg==
X-Gm-Message-State: AA+aEWbjZ+ucJnrto+xdifsfUThKFgFklIB3RncLZrO0LUS3Naz1hhoZ
        9RwBCLxvqX+2rL2lXEu6gLTWow==
X-Google-Smtp-Source: AFSGD/Vl8s3XYOM+zzdpiCJXzy0gKzWjIhjss1fXYwqw6EPg8PHIChEVrGdnCb8kPjgTouv3jyHZsw==
X-Received: by 2002:adf:92c7:: with SMTP id 65mr6836282wrn.228.1543980713789;
        Tue, 04 Dec 2018 19:31:53 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id w12sm15911882wrr.23.2018.12.04.19.31.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 19:31:52 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:31:45 +0800
From:   leo.yan@linaro.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v1 3/5] perf cs-etm: Support for NO_SYNC packet
Message-ID: <20181205033145.GA15964@leoy-ThinkPad-X240s>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-4-git-send-email-leo.yan@linaro.org>
 <20181119182759.GA608@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119182759.GA608@xps15>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 11:27:59AM -0700, Mathieu Poirier wrote:
> On Sun, Nov 11, 2018 at 12:59:41PM +0800, Leo Yan wrote:
> > As described in OpenCSD (CoreSight decoder lib), in the decoding stream
> > it includes one trace element with type OCSD_GEN_TRC_ELEM_NO_SYNC; the
> > element indicates 'either at start of decode, or after overflow / bad
> > packet', we should take it as a signal for the tracing off and this will
> > cause tracing discontinuity.  From the trace dump with 'perf script',
> > sometimes the element OCSD_GEN_TRC_ELEM_NO_SYNC collaborates with
> > element OCSD_GEN_TRC_ELEM_TRACE_ON to show the tracing flow have been
> > turned off and on, in this case the cs-etm code has handled TRACE_ON
> > packet well so we observe the tracing discontinuity; but in another case
> > it only inserts the element OCSD_GEN_TRC_ELEM_NO_SYNC into instructions
> > packets, we miss to handle the case if has only standalone NO_SYNC
> > element and users cannot receive the info for tracing discontinuity.
> > 
> > This patch introduces new type CS_ETM_TRACE_OFF to generate packet for
> > receiving element OCSD_GEN_TRC_ELEM_NO_SYNC from decoder; when generate
> > sample, CS_ETM_TRACE_OFF packet has almost the same behaviour with
> 
> Here you have used the word "almost", leading me to beleive there are cases
> where the handling of TRACE_ON and NO_SYNC packets differ, but the
> implementation enacts the same behavior for both.
> 
> Mike or Robert, can you confirm that TRACE_ON and NO_SYNC packets should be
> treated the same way?

I also would like to get suggestions/comments from Mike and Rob.

For NO_SYNC packet, Mike before has given some explination for it:

"looking at the decoder flow, when the decoder is reset, then it is
returned to an unsynchronised state and a NO_SYNC will be output.
With perf, it can concatenate multiple trace buffers into a single
section of the perf.data file. To ensure that the decode process can
see the start of a new buffer, the drivers will insert a barrier
packet between different buffers so that the decoder can spot the
boundaries. When the decoder hits a barrier packet it will
automatically reset so that it correctly decodes the next trace
buffer. This could be what you are seeing here."

So I think there still have some difference between TRACE_ON and
NO_SYNC packets, TRACE_ON packet indicates the start of trace and it's
also possible caused by tracing discontinuity; NO_SYNC packets usually
caused by an unsynchronised state.  But both of them presents
discontinuity in perf trace data.

I prefer to use two different packet types to present them, this can
let the code to be more readable and easier to be maintained later.

If you agree with this, I also will rephrase the commit log to avoid
confusion that these two packets are the same thing.

> Leo, if handling of the TRACE_ON and NO_SYNC packets is the same then we should
> treat them the same way in cs_etm_decoder__gen_trace_elem_printer(), i.e simply
> call cs_etm_decoder__buffer_trace_on().  That way packet handling in cs-etm.c
> doesn't change.  Otherwise see my comments below.
> 
> > CS_ETM_TRACE_ON packet: both of them invokes cs_etm__flush() to generate
> > samples for the previous instructions packet, and in cs_etm__sample() it
> > also needs to generate samples if TRACE_OFF packet is followed by one
> > sequential instructions packet.  This patch also converts the address to
> > 0 for TRACE_OFF packet, this is same with TRACE_ON packet as well.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++++++
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  7 ++++---
> >  tools/perf/util/cs-etm.c                        | 15 +++++++++++----
> >  3 files changed, 25 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index 5efb616..9d52727 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -369,6 +369,14 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
> >  }
> >  
> >  static ocsd_datapath_resp_t
> > +cs_etm_decoder__buffer_trace_off(struct cs_etm_decoder *decoder,
> > +				 const uint8_t trace_chan_id)
> > +{
> > +	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > +					     CS_ETM_TRACE_OFF);
> > +}
> > +
> > +static ocsd_datapath_resp_t
> >  cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
> >  				const uint8_t trace_chan_id)
> >  {
> > @@ -389,6 +397,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> >  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
> >  		break;
> >  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> > +		resp = cs_etm_decoder__buffer_trace_off(decoder,
> > +							trace_chan_id);
> 
> If we want to handle NO_SYNC element types, why introduce a "trace_off"
> function?  Wouldn't it make more sense to call it
> cs_etm_decoder__buffer_no_sync() ?

Will change to cs_etm_decoder__buffer_no_sync().

> >  		decoder->trace_on = false;
> >  		break;
> >  	case OCSD_GEN_TRC_ELEM_TRACE_ON:
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> > index 9351bd1..a38c97c 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> > @@ -23,9 +23,10 @@ struct cs_etm_buffer {
> >  };
> >  
> >  enum cs_etm_sample_type {
> > -	CS_ETM_EMPTY = 0,
> > -	CS_ETM_RANGE = 1 << 0,
> > -	CS_ETM_TRACE_ON = 1 << 1,
> > +	CS_ETM_EMPTY		= 0,
> > +	CS_ETM_RANGE		= 1 << 0,
> > +	CS_ETM_TRACE_ON		= 1 << 1,
> > +	CS_ETM_TRACE_OFF	= 1 << 2,
> 
> CS_ETM_NO_SYNC, see above comment.  And please don't use indentation.

Will do this.

> >  };
> >  
> >  enum cs_etm_isa {
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index f4fa877..2a0cef9 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -517,8 +517,9 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
> >  
> >  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
> >  {
> > -	/* Returns 0 for the CS_ETM_TRACE_ON packet */
> > -	if (packet->sample_type == CS_ETM_TRACE_ON)
> > +	/* Returns 0 for TRACE_ON and TRACE_OFF packets */
> > +	if (packet->sample_type == CS_ETM_TRACE_ON ||
> > +	    packet->sample_type == CS_ETM_TRACE_OFF)
> >  		return 0;
> >  
> >  	return packet->start_addr;
> > @@ -527,8 +528,9 @@ static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
> >  static inline
> >  u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
> >  {
> > -	/* Returns 0 for the CS_ETM_TRACE_ON packet */
> > -	if (packet->sample_type == CS_ETM_TRACE_ON)
> > +	/* Returns 0 for TRACE_ON and TRACE_OFF packets */
> > +	if (packet->sample_type == CS_ETM_TRACE_ON ||
> > +	    packet->sample_type == CS_ETM_TRACE_OFF)
> >  		return 0;
> >  
> >  	return packet->end_addr - packet->last_instr_size;
> > @@ -930,6 +932,10 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
> >  		if (etmq->prev_packet->sample_type == CS_ETM_TRACE_ON)
> >  			generate_sample = true;
> >  
> > +		/* Generate sample for tracing off packet */
> > +		if (etmq->prev_packet->sample_type == CS_ETM_TRACE_OFF)
> > +			generate_sample = true;
> > +
> >  		/* Generate sample for branch taken packet */
> >  		if (etmq->prev_packet->sample_type == CS_ETM_RANGE &&
> >  		    etmq->prev_packet->last_instr_taken_branch)
> > @@ -1085,6 +1091,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
> >  					cs_etm__sample(etmq);
> >  					break;
> >  				case CS_ETM_TRACE_ON:
> > +				case CS_ETM_TRACE_OFF:
> >  					/*
> >  					 * Discontinuity in trace, flush
> >  					 * previous branch stack
> > -- 
> > 2.7.4
> > 
