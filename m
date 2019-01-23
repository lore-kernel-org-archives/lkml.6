Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A96C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FCA21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGOySgWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAWVFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:05:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39215 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfAWVFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:05:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so1796727pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 13:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Um5Owx2PZ+cWE2aTU1iit32Xs0VOzk8bkixgF58pEFE=;
        b=dGOySgWcV6Pw48djtIKVzyc/SNYn5ilF/jKajV8oMaREDn94xgmI2Z59oPJtbKNocW
         UzxmvlgkLg/3yW1ssJ8YPUgCaeDsb/+0nGqpYLFA8GsXpkBjJxWmby1JQak4or5z8UvT
         nZQdU7KtPjuqTUh9nv6DZ7qYwScEoiEuLRM50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Um5Owx2PZ+cWE2aTU1iit32Xs0VOzk8bkixgF58pEFE=;
        b=Qx31gDBZCm1Dd3Qn06B9AdHwfSgRzrFTNsLmTMrgY7KneH/wUxrAPXrseUAr4Ljips
         ujTbfVJ3GMvZ7OeO/K9JrTkiuK09ItKJbMf4lcNIzoADCucBjmYlvPV06M6NT9jGbcVi
         mSYgRWuCHnleU92wFkMAD3YRHcWfCGpcUVmRthqWoFT5iseqi0RxxYO+Tf/WWdi6z+ip
         P6VU1Flq8LZEgZQfKowqb5qIlIDUepOWdFbEUOtSJE2S+mMLOU9z9823cmhd3jf+QS1v
         IvnaeWNSoagHYLztgNguRo9ej5qsX5zI4BEQppCDSuzs+KBgxDYA3ZPz3ku09QClMdSA
         tOQQ==
X-Gm-Message-State: AJcUukelbCNjDyuzVCFOIlHY+Cg9M5ZhlI5pc93u2pW8dG4VoodrEVbj
        PGNsn0f5OS9apNVWdCrNBFkZPg==
X-Google-Smtp-Source: ALg8bN6M98STrR8TVeZxsL6rsxPMIrFC3XoqlQOZO2BycCzfZ12gHpUajYkKIulsWjCvyHP7ibo/Bw==
X-Received: by 2002:aa7:8802:: with SMTP id c2mr3620470pfo.20.1548277529541;
        Wed, 23 Jan 2019 13:05:29 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f20sm24183091pfn.177.2019.01.23.13.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:05:28 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:05:26 -0700
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
Subject: Re: [PATCH v6 4/8] perf cs-etm: Add exception number in exception
 packet
Message-ID: <20190123210526.GD620@xps15>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-5-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119014347.27441-5-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 09:43:43AM +0800, Leo Yan wrote:
> When an exception packet comes, it contains the information for
> exception number; the exception number indicates the exception types,
> so from it we can know if the exception is taken for interrupt,
> system call or other traps, etc.
> 
> This patch simply adds a field in cs_etm_packet struct, it records
> exception number for exception packet that will then be used to
> properly identify exception types to the perf synthesize mechanic.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 20 +++++++++++++++----
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index e98ee49a1527..294efa76c9e3 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -294,6 +294,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
>  		decoder->packet_buffer[i].last_instr_subtype = 0;
>  		decoder->packet_buffer[i].last_instr_cond = 0;
>  		decoder->packet_buffer[i].flags = 0;
> +		decoder->packet_buffer[i].exception_number = UINT32_MAX;
>  		decoder->packet_buffer[i].cpu = INT_MIN;
>  	}
>  }
> @@ -331,6 +332,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
>  	decoder->packet_buffer[et].last_instr_subtype = 0;
>  	decoder->packet_buffer[et].last_instr_cond = 0;
>  	decoder->packet_buffer[et].flags = 0;
> +	decoder->packet_buffer[et].exception_number = UINT32_MAX;
>  
>  	if (decoder->packet_count == MAX_BUFFER - 1)
>  		return OCSD_RESP_WAIT;
> @@ -406,10 +408,20 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
>  
>  static ocsd_datapath_resp_t
>  cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
> +				 const ocsd_generic_trace_elem *elem,
>  				 const uint8_t trace_chan_id)
> -{
> -	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> -					     CS_ETM_EXCEPTION);
> +{	int ret = 0;
> +	struct cs_etm_packet *packet;
> +
> +	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> +					    CS_ETM_EXCEPTION);
> +	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> +		return ret;
> +
> +	packet = &decoder->packet_buffer[decoder->tail];
> +	packet->exception_number = elem->exception_number;
> +
> +	return ret;
>  }
>  
>  static ocsd_datapath_resp_t
> @@ -443,7 +455,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  						    trace_chan_id);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_EXCEPTION:
> -		resp = cs_etm_decoder__buffer_exception(decoder,
> +		resp = cs_etm_decoder__buffer_exception(decoder, elem,
>  							trace_chan_id);
>  		break;
>  	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 23600e57a215..012b4728a46f 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -46,6 +46,7 @@ struct cs_etm_packet {
>  	u32 last_instr_type;
>  	u32 last_instr_subtype;
>  	u32 flags;
> +	u32 exception_number;
>  	u8 last_instr_cond;
>  	u8 last_instr_taken_branch;
>  	u8 last_instr_size;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.17.1
> 
