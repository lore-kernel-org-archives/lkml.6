Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F4EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B3B21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8GRzmmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfAWXpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:45:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34803 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAWXpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:45:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so3649775otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a3th3BKt1EQbGJOKU8oizYvxZ8/FDSRcU1watEvglZY=;
        b=J8GRzmmb+RYWJS+uMs/9xie4QPR1lTnfvKcmFiOrNBDuNGHenKIlH3hBeg2WaLiq6z
         w7h8auWxHllDUuocciDn7NYF0eu3uw7M6FCs0QCzPdiAwFiOwySCJcGApBGQiE2lhFh0
         a7Y7OTb90q0abhigjRr94WVFMz0p1//jNvN2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a3th3BKt1EQbGJOKU8oizYvxZ8/FDSRcU1watEvglZY=;
        b=ReB8fDlNWYkySmdMM2j7TqA0mz1ZU4gOM/jVAjnA3i7Ho8j+tcrI0F5xcaTkovQxzc
         57bztlMx2QhzkBmoCTwzVR6fODAfx/9JoEiCmwDh1Us9zoOE7HEqAZY4tJZN4MIOgHMJ
         oWM+Vup391oaaOse2fNRO5WMuYIxHg7GUFbz8CURbjr1vmHsfAqrQRvYrY6aaFj2QCO2
         UuNzXReWT+V7PbB8bW/94j7wfUMC6X1LMgPAQK0NaUH26gJTmjn6m+HlIRmfGs9m7VN3
         NZWAuh7Mrj8aQ75lFCBcLAXgHGVCT1ZDLnctXDiEs80MR6INdPyGJVk4KM+G6bJb3yFm
         9AyA==
X-Gm-Message-State: AJcUukdTreD1xyxfiZDY5WO5uuw3F/xZRZF69EavSa+s7WEjEYrzBYo0
        m5jp+QBcfV1PMDfynQdA2j4A9A==
X-Google-Smtp-Source: ALg8bN6dupU3zeKkd1JJr9ER4sChtX/C+3HJ4kq0r7sDpLOcxBRptmnNucd2o6OoMtOmCRHKuYJ9Cg==
X-Received: by 2002:a9d:2aea:: with SMTP id e97mr2888299otb.206.1548287122477;
        Wed, 23 Jan 2019 15:45:22 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1118-108.members.linode.com. [45.79.19.108])
        by smtp.gmail.com with ESMTPSA id y25sm8406759otk.50.2019.01.23.15.45.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:45:21 -0800 (PST)
Date:   Thu, 24 Jan 2019 07:45:14 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v6 5/8] perf cs-etm: Change tuple from traceID-CPU# to
 traceID-metadata
Message-ID: <20190123234514.GB3268@leoy-ThinkPad-X240s>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-6-leo.yan@linaro.org>
 <20190123211300.GE620@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123211300.GE620@xps15>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 02:13:00PM -0700, Mathieu Poirier wrote:
> On Sat, Jan 19, 2019 at 09:43:44AM +0800, Leo Yan wrote:
> > If packet processing wants to know the packet is bound with which ETM
> > version, it needs to access metadata to decide that based on metadata
> > magic number; but we cannot simply to use CPU logic ID number as index
> > to access metadata sequential array, especially when system have
> > hotplugged off CPUs, the metadata array are only allocated for online
> > CPUs but not offline CPUs, so the CPU logic number doesn't match with
> > its index in the array.
> > 
> > For this reason, a reliable way for accessing metadata array is to use
> > traceID to find associated metadata; by accessing metadata content we
> > can know not only the CPU number but also for ETM version, which can be
> > used for sequential change for setting sample flags for exception
> > packets.
> 
> This paragraph is not needed to understand why this patch is needed.  Please
> remove.

Will do.

> > This patch is to change tuple from traceID-CPU# to traceID-metadata,
> > thus it can use the tuple to retrieve metadata pointer according to
> > traceID.
> > 
> > For safe accessing metadata fields, this patch provides helper function
> > cs_etm__get_cpu() which is used to return CPU number according to
> > traceID; cs_etm_decoder__buffer_packet() is the first consumer for this
> > helper function.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  8 ++--
> >  tools/perf/util/cs-etm.c                      | 37 ++++++++++++++++---
> >  tools/perf/util/cs-etm.h                      |  4 +-
> >  3 files changed, 37 insertions(+), 12 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index 294efa76c9e3..cdd38ffd10d2 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -305,14 +305,12 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
> >  			      enum cs_etm_sample_type sample_type)
> >  {
> >  	u32 et = 0;
> > -	struct int_node *inode = NULL;
> > +	int cpu;
> >  
> >  	if (decoder->packet_count >= MAX_BUFFER - 1)
> >  		return OCSD_RESP_FATAL_SYS_ERR;
> >  
> > -	/* Search the RB tree for the cpu associated with this traceID */
> > -	inode = intlist__find(traceid_list, trace_chan_id);
> > -	if (!inode)
> > +	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
> >  		return OCSD_RESP_FATAL_SYS_ERR;
> >  
> >  	et = decoder->tail;
> > @@ -322,7 +320,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
> >  
> >  	decoder->packet_buffer[et].sample_type = sample_type;
> >  	decoder->packet_buffer[et].isa = CS_ETM_ISA_UNKNOWN;
> > -	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
> > +	decoder->packet_buffer[et].cpu = cpu;
> >  	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
> >  	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
> >  	decoder->packet_buffer[et].instr_count = 0;
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 1aa29633ce77..e89989fe0a5c 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -97,6 +97,20 @@ static u32 cs_etm__get_v7_protocol_version(u32 etmidr)
> >  	return CS_ETM_PROTO_ETMV3;
> >  }
> >  
> > +int cs_etm__get_cpu(u8 trace_chan_id, int *cpu)
> > +{
> > +	struct int_node *inode;
> > +	u64 *metadata;
> > +
> > +	inode = intlist__find(traceid_list, trace_chan_id);
> > +	if (!inode)
> > +		return -EINVAL;
> > +
> > +	metadata = inode->priv;
> > +	*cpu = (int)metadata[CS_ETM_CPU];
> > +	return 0;
> > +}
> > +
> >  static void cs_etm__packet_dump(const char *pkt_string)
> >  {
> >  	const char *color = PERF_COLOR_BLUE;
> > @@ -252,7 +266,7 @@ static void cs_etm__free(struct perf_session *session)
> >  	cs_etm__free_events(session);
> >  	session->auxtrace = NULL;
> >  
> > -	/* First remove all traceID/CPU# nodes for the RB tree */
> > +	/* First remove all traceID/metadata nodes for the RB tree */
> >  	intlist__for_each_entry_safe(inode, tmp, traceid_list)
> >  		intlist__remove(traceid_list, inode);
> >  	/* Then the RB tree itself */
> > @@ -1519,9 +1533,20 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >  				    0xffffffff);
> >  
> >  	/*
> > -	 * Create an RB tree for traceID-CPU# tuple. Since the conversion has
> > -	 * to be made for each packet that gets decoded, optimizing access in
> > -	 * anything other than a sequential array is worth doing.
> > +	 * Create an RB tree for traceID-metadata tuple.
> > +	 *
> > +	 * The conversion between traceID and CPU logic ID number has to
> > +	 * be made for each packet that gets decoded: firstly retrieve
> > +	 * metadata pointer from trace ID by using traceID-metadata tuple,
> > +	 * then read CPU logic ID number in metadata.
> > +	 *
> > +	 * It's not safe to directly use CPU logic ID number as index to
> > +	 * access metadata sequential array, e.g. when system have
> > +	 * hotplugged out CPUs, the metadata array are only allocated for
> > +	 * online CPUs but not offline CPUs, thus the CPU logic number is
> > +	 * not consistent with its index in the arrary.  For this reason,
> > +	 * we need to fallback to use TraceID-metadata tuple as a reliable
> > +	 * method to access metadata.
> 
> Why adding this long comment?  To me all that is needed is
> s/traceID-CPU#/traceID-metadata .

Here just want to give more information for why we create
traceID-metadata tuple (and hope can give the reason why we need
to use traceID-metadata rather than traceID-CPU# tuple).

If you think it's redundant, will drop it.

> >  	 */
> >  	traceid_list = intlist__new(NULL);
> >  	if (!traceid_list) {
> > @@ -1587,8 +1612,8 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >  			err = -EINVAL;
> >  			goto err_free_metadata;
> >  		}
> > -		/* All good, associate the traceID with the CPU# */
> > -		inode->priv = &metadata[j][CS_ETM_CPU];
> > +		/* All good, associate the traceID with the metadata pointer */
> > +		inode->priv = metadata[j];
> >  	}
> >  
> >  	/*
> > diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> > index 37f8d48179ca..5d70d10f3907 100644
> > --- a/tools/perf/util/cs-etm.h
> > +++ b/tools/perf/util/cs-etm.h
> > @@ -53,7 +53,7 @@ enum {
> >  	CS_ETMV4_PRIV_MAX,
> >  };
> >  
> > -/* RB tree for quick conversion between traceID and CPUs */
> > +/* RB tree for quick conversion between traceID and metadata pointers */
> >  struct intlist *traceid_list;
> >  
> >  #define KiB(x) ((x) * 1024)
> > @@ -78,4 +78,6 @@ cs_etm__process_auxtrace_info(union perf_event *event __maybe_unused,
> >  }
> >  #endif
> >  
> > +int cs_etm__get_cpu(u8 trace_chan_id, int *cpu);
> 
> This function is part of a public header that can theoretically be included by
> any other file.  As such it has to be defined within the HAVE_CSTRACE_SUPPORT
> define.

My stupid.  Will move it into HAVE_CSTRACE_SUPPORT blocks.

Thanks a lot for reviewing.

> > +
> >  #endif
> > -- 
> > 2.17.1
> > 
