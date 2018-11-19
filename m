Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B03EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5484206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 20:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkVgG3OT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5484206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbeKTHNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:13:16 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40282 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730825AbeKTHNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:13:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22-v6so9691970pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 12:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hoF02J7c+stQE/lLRtgOOsSviFucfIidQxFb3CQQ4Us=;
        b=GkVgG3OTf830I8fRj09enNSThDhzxYiTujXjSqgvGs8r78OyBEMm/X+4iAxE3L1Y7h
         Vn7fW+lso9gWAtcZVmTJNF4FB23z+Xeak68cKJGJIApNPOMWbu0ATiiPntS9wliu3Uag
         j6xH2sr8eY0vB0b3TR7y53pcBVjJHay3B+wQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hoF02J7c+stQE/lLRtgOOsSviFucfIidQxFb3CQQ4Us=;
        b=YfKBpHwJqyCuLWVMhG+mwPuof24qhjLhhLW32WODDikzFMkXJ2KzHm3aJodHbNkMGL
         SCF4jUiH6angHP+J6Lk2juWODOlbcM8oHkIpuOPhmTLAw400ezo6D9NQ+zzOt6f8V5Hf
         pfl+l25nk9U6ogeVtNrHzHq1lgm+5BULsuKzZpE6fVtxYGoU1tEqhUhi6lcHxffnLZMi
         87/4iyt1v28Swl4jjb2Aa0L5UPsBq1QXrYrC8/IFBJ7JGUGVxzEM7DsgurLFK6IsXZNs
         CdzOforz33qYRIpA+Go2SLWuqnDhNqxTeR+Y0Kvpeu/AEDWlN8mBUAIGKCkQnZ288hHZ
         mvGw==
X-Gm-Message-State: AGRZ1gIK8wFvEe9K3CFE9rjmTR5zHct9H/oICgSKFx1+VDkcvxDVi/Bb
        A0bhs59YC5YOs7HoosHuHvkh4BeoRNg=
X-Google-Smtp-Source: AJdET5fUTRHqxUwBmRR+m+KHNkSkGhSsHvjWxj96pqU6hAhzIFGfgv1TppJ/2eSyvYpnQAWrwRyHzA==
X-Received: by 2002:a17:902:b282:: with SMTP id u2mr24216031plr.89.1542660472766;
        Mon, 19 Nov 2018 12:47:52 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t12sm35336601pfi.45.2018.11.19.12.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 12:47:51 -0800 (PST)
Date:   Mon, 19 Nov 2018 13:47:49 -0700
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
Subject: Re: [PATCH v1 5/5] perf cs-etm: Track exception number
Message-ID: <20181119204749.GB608@xps15>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-6-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541912383-19915-6-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:59:43PM +0800, Leo Yan wrote:
> When an exception packet comes, it contains the info for exception
> number; the exception number indicates the exception types, so from it
> we can know if the exception is taken for interrupt, system call or
> other traps, etc.  But because the exception return packet cannot
> delivery exception number correctly by decoder thus when prepare sample
> flags we cannot know what's type for exception return.
> 
> This patch adds a new 'exc_num' array in decoder structure to record
> exception number per CPU, the exception number is recorded in the array
> when the exception packet comes and this exception number can be used by
> exception return packet.  If detect there have discontinuous trace with
> TRACE_ON or TRACE_OFF packet, the exception number is set to invalid
> value.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 67 ++++++++++++++++++++++---
>  1 file changed, 59 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index b8cb7a3e..d1a6cbc 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -43,6 +43,7 @@ struct cs_etm_decoder {
>  	u32 packet_count;
>  	u32 head;
>  	u32 tail;
> +	u32 *exc_num;
>  	struct cs_etm_packet packet_buffer[MAX_BUFFER];
>  };
>  
> @@ -368,24 +369,64 @@ static ocsd_datapath_resp_t
>  cs_etm_decoder__buffer_trace_off(struct cs_etm_decoder *decoder,
>  				 const uint8_t trace_chan_id)
>  {
> -	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> -					     CS_ETM_TRACE_OFF);
> +	int ret;
> +	struct cs_etm_packet *packet;
> +
> +	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> +					    CS_ETM_TRACE_OFF);
> +	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> +		return ret;
> +
> +	packet = &decoder->packet_buffer[decoder->tail];
> +
> +	/* Clear execption number for discontinuous trace */
> +	decoder->exc_num[packet->cpu] = UINT32_MAX;
> +
> +	return ret;
>  }
>  
>  static ocsd_datapath_resp_t
>  cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
>  				const uint8_t trace_chan_id)
>  {
> -	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> -					     CS_ETM_TRACE_ON);
> +	int ret;
> +	struct cs_etm_packet *packet;
> +
> +	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> +					    CS_ETM_TRACE_ON);
> +	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> +		return ret;
> +
> +	packet = &decoder->packet_buffer[decoder->tail];
> +
> +	/* Clear execption number for discontinuous trace */
> +	decoder->exc_num[packet->cpu] = UINT32_MAX;
> +
> +	return ret;
>  }
>  
>  static ocsd_datapath_resp_t
>  cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
> +				 const ocsd_generic_trace_elem *elem,
>  				 const uint8_t trace_chan_id)
>  {
> -	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> -					     CS_ETM_EXCEPTION);
> +	int ret;
> +	struct cs_etm_packet *packet;
> +
> +	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> +					    CS_ETM_EXCEPTION);
> +	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> +		return ret;
> +
> +	packet = &decoder->packet_buffer[decoder->tail];
> +
> +	/*
> +	 * Exception number is recorded per CPU and later can be used
> +	 * for exception return instruction analysis.
> +	 */
> +	decoder->exc_num[packet->cpu] = elem->exception_number;

Am I missing something or the information about the exception number that is
recorded here isn't used anywhere?  If you want to use this in perf report/script,
the exception number will have to be added to the cs_etm_packet struct.

I am done with the revision of this set.

Thanks,
Mathieu

> +
> +	return ret;
>  }
>  
>  static ocsd_datapath_resp_t
> @@ -423,7 +464,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  						    trace_chan_id);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_EXCEPTION:
> -		resp = cs_etm_decoder__buffer_exception(decoder,
> +		resp = cs_etm_decoder__buffer_exception(decoder, elem,
>  							trace_chan_id);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
> @@ -511,6 +552,10 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
>  	if (!decoder)
>  		return NULL;
>  
> +	decoder->exc_num = zalloc(sizeof(*decoder->exc_num) * num_cpu);
> +	if (!decoder->exc_num)
> +		goto err_free_decoder;
> +
>  	decoder->data = d_params->data;
>  	decoder->prev_return = OCSD_RESP_CONT;
>  	cs_etm_decoder__clear_buffer(decoder);
> @@ -531,7 +576,7 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
>  	decoder->dcd_tree = ocsd_create_dcd_tree(format, flags);
>  
>  	if (decoder->dcd_tree == 0)
> -		goto err_free_decoder;
> +		goto err_free_decoder_exc_num;
>  
>  	/* init library print logging support */
>  	ret = cs_etm_decoder__init_def_logger_printing(d_params, decoder);
> @@ -542,6 +587,9 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
>  	cs_etm_decoder__init_raw_frame_logging(d_params, decoder);
>  
>  	for (i = 0; i < num_cpu; i++) {
> +		/* init expcetion number to an invalid value */
> +		decoder->exc_num[i] = UINT32_MAX;
> +
>  		ret = cs_etm_decoder__create_etm_decoder(d_params,
>  							 &t_params[i],
>  							 decoder);
> @@ -553,6 +601,8 @@ cs_etm_decoder__new(int num_cpu, struct cs_etm_decoder_params *d_params,
>  
>  err_free_decoder_tree:
>  	ocsd_destroy_dcd_tree(decoder->dcd_tree);
> +err_free_decoder_exc_num:
> +	free(decoder->exc_num);
>  err_free_decoder:
>  	free(decoder);
>  	return NULL;
> @@ -613,5 +663,6 @@ void cs_etm_decoder__free(struct cs_etm_decoder *decoder)
>  
>  	ocsd_destroy_dcd_tree(decoder->dcd_tree);
>  	decoder->dcd_tree = NULL;
> +	free(decoder->exc_num);
>  	free(decoder);
>  }
> -- 
> 2.7.4
> 
