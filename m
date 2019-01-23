Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2A1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D799F218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UpokBVX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfAWVEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:04:40 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43476 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfAWVEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:04:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so1781001pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 13:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u2iNqCv7TOhC/4UqBgffEhFyn0TxD69aDUz67Y7wuUQ=;
        b=UpokBVX+S3di5cVpj4vmVr0VO89zxM2F7TEyP2nvow0WIvXu5UIQIQ78SJB1mls57W
         fXXXfwY+Xz3TdZ1pXPeeT/14CRTF9sQQEG+6OqgYQagZJZHgHnwOVS+VP17IkpC9jBub
         AziVjG397BLX2I8E1iCPwKHyrLFv0Erh+os3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u2iNqCv7TOhC/4UqBgffEhFyn0TxD69aDUz67Y7wuUQ=;
        b=mXr7HM9/aFAjxXAzNBNh5f9WSeW+Zfe6vx6OV/7uLFfEGwId45tCLeL/ZsLlmwdSc6
         SCzz2wdeyUnmunh5wpcm32RxQvFmFB5bxUAO76ai+r7DQE4i+7Q5N/flbeBkd1cUkttA
         NMfG9guzL0ENKKR4BZKTuM/xbVpQvGlIPhdtMNo2aKckfr71unke7D3qiWPWm9Gx/nVX
         7Cgd4cUYxLgXeL17aF9sQdBbvPbVE99LYOExXwnGLLJt4o4IU6Pq7ZWZ1ARzHB+7vucR
         NhUAyGlNAIhnoLKK1dCHkeYZZYkZm89uiuwLlOcSyIXykyuW7NR8UN9tSkLuNMYBK2ol
         Ga/Q==
X-Gm-Message-State: AJcUukcATyOthpwWspnbDWdgGrINqW5oocJ4+J7H1TBz24niBsd54A+2
        C7JdFtk9Pa3W7IeOXRiVyxpwZg==
X-Google-Smtp-Source: ALg8bN5BBMz4/Mfq982/5yU+ouWDKvlqAZz2NJanW5P1lN5l4I0S/sb3e5bi2HhjZij6PXG3bRzVMQ==
X-Received: by 2002:a63:c64f:: with SMTP id x15mr3378936pgg.16.1548277478810;
        Wed, 23 Jan 2019 13:04:38 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j73sm28881726pge.13.2019.01.23.13.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:04:38 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:04:35 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v6 3/8] perf cs-etm: Set sample flags for trace
 discontinuity
Message-ID: <20190123210435.GC620@xps15>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-4-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119014347.27441-4-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 09:43:42AM +0800, Leo Yan wrote:
> In the middle of trace stream, it might be interrupted thus the trace
> data is not continuous, the trace stream firstly is ended for previous
> trace block and restarted for next block.
> 
> To display related information for showing trace is restarted, this
> patch set sample flags for trace discontinuity:
> 
> - If one discontinuity packet is coming, append flag
>   PERF_IP_FLAG_TRACE_END to the previous packet to indicate the trace
>   has been ended;
> - If one instruction packet is following discontinuity packet, this
>   instruction packet is the first one packet to restarting trace.  So
>   set flag PERF_IP_FLAG_TRACE_START to discontinuity packet, this flag
>   will be used to generate sample when connect with the sequential
>   instruction packet.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index d05cac5295f1..1aa29633ce77 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1111,6 +1111,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
>  static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
>  {
>  	struct cs_etm_packet *packet = etmq->packet;
> +	struct cs_etm_packet *prev_packet = etmq->prev_packet;
>  
>  	switch (packet->sample_type) {
>  	case CS_ETM_RANGE:
> @@ -1170,8 +1171,26 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
>  		    packet->last_instr_subtype == OCSD_S_INSTR_V8_RET)
>  			packet->flags = PERF_IP_FLAG_BRANCH |
>  					PERF_IP_FLAG_RETURN;
> +
> +		/*
> +		 * Decoder might insert a discontinuity in the middle of
> +		 * instruction packets, fixup prev_packet with flag
> +		 * PERF_IP_FLAG_TRACE_BEGIN to indicate restarting trace.
> +		 */
> +		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
> +			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
> +					      PERF_IP_FLAG_TRACE_BEGIN;
>  		break;
>  	case CS_ETM_DISCONTINUITY:
> +		/*
> +		 * The trace is discontinuous, if the previous packet is
> +		 * instruction packet, set flag PERF_IP_FLAG_TRACE_END
> +		 * for previous packet.
> +		 */
> +		if (prev_packet->sample_type == CS_ETM_RANGE)
> +			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
> +					      PERF_IP_FLAG_TRACE_END;
> +		break;
>  	case CS_ETM_EXCEPTION:
>  	case CS_ETM_EXCEPTION_RET:
>  	case CS_ETM_EMPTY:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.17.1
> 
