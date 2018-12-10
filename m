Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A58C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCF42084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6TJCEvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCF42084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbeLJWxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:53:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36323 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbeLJWxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:53:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so5942549plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 14:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LPg3oUpZHEnWx9O7rTLdZ2aDIdl1EKNxaEX9UC5JeT0=;
        b=X6TJCEvgujaWaoSvbu4e853EtnZzmHzldHliAtmYT+cl0bqttsH5TeaZs/Tzgn7YO5
         +YsM+SSE3eZwc+j9aWXeklWfRd4ZUYoOeggVhrQ4ZSr5AS3DJ1fv4s4a4T6G0p5mI27p
         hnwS86lzkCMlnmAxlCHd8Y3BjoRoL/Xn814VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LPg3oUpZHEnWx9O7rTLdZ2aDIdl1EKNxaEX9UC5JeT0=;
        b=In5YKgVCzPpg6E0UvseQ3oqHFDUlm+kEswbNyFwTAxGJuw5SEEB7D7XrlGadddYRtI
         D5LBgRzVVCdfO0F8NENWIinFqXKAbWqgtKyrXKBoZFWjyNo0NxAEAkVwJeKwWX+Plh+b
         cRpahjkriCe068l6kWq16TGkYa21rEibYlBxJ406hu570Ji12TMhq9CzJU4C4DnFTTsr
         RnJZ+lRkl/kqKND5AHyY0DDsjR3lQhUqQ19uq30vDI06eqoAW/5INVA57I2SaPbr+v/x
         YZuieldi5mjTHDKIJoArBHsUtAT2R8FjviPNENTLaIUXKFyGb2DscUVZBGxiI0oBnueH
         6Ohg==
X-Gm-Message-State: AA+aEWZgsVrNnMNWKwU11hVp07pPqm+5/s+dUdDeEO4nD8+ORjrT/SA4
        PfOMAVpM2DMCHxbOz7rgJHsLsQ==
X-Google-Smtp-Source: AFSGD/WDG7ADSFkKZ50eAzp09duznXizg9DvJvPJoc4x5p9KAc9sQcl4xF1A7qOB2r5AHqrGxHnJIA==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr13947570plc.108.1544482385151;
        Mon, 10 Dec 2018 14:53:05 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q195sm16359249pgq.7.2018.12.10.14.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 14:53:04 -0800 (PST)
Date:   Mon, 10 Dec 2018 15:53:02 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>
Subject: Re: [PATCH v2 4/6] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Message-ID: <20181210225302.GC12152@xps15>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
 <1544431981-24144-5-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544431981-24144-5-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:52:59PM +0800, Leo Yan wrote:
> CoreSight tracer driver might insert barrier packet between different
> buffers, thus the decoder can spot the boundaries based on the barrier
> packet; the decoder is possible to hit a barrier packet and emit a
> NO_SYNC element, then the decoder will find a periodic synchronisation
> point inside that next trace block that starts trace again but does not
> have the TRACE_ON element as indicator - usually because this block of
> trace has wrapped the buffer so we have lost the original point that
> trace was enabled.
> 
> In upper case, it results in the trace stream only inserts the
> OCSD_GEN_TRC_ELEM_NO_SYNC element in the middle of tracing stream, but
> we don't handle NO_SYNC element properly and at the end users miss to
> see the info for trace discontinuity.
> 
> Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
> output from the decoder, but both of them indicate the trace data is
> discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as trace
> discontinuity and generates CS_ETM_DISCONTINUITY packet for it, so
> cs-etm can handle discontinuity for this case, finally it saves the last
> trace data for previous trace block and restart samples for new block.
> 
> Credit to Mike Leach and Robert Walker who made me clear for underlying
> mechanism for NO_SYNC element, Mike also shared with me for detailed
> explanation for why we can treat NO_SYNC and TRACE_ON elements as the
> same, so this commit log reused most of his explanation.

Credit and thank you note such as this one go in the cover letter.  With this
change:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index a3994f1..46b67f1 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -411,6 +411,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
>  		break;
>  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> +		resp = cs_etm_decoder__buffer_discontinuity(decoder,
> +							    trace_chan_id);
>  		decoder->trace_on = false;
>  		break;
>  	case OCSD_GEN_TRC_ELEM_TRACE_ON:
> -- 
> 2.7.4
> 
