Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881C4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465172084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H6UQrq8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465172084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbeLJXEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:04:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35451 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeLJXEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:04:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so5686871pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 15:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hINzrVelB9T/aQFX4msXU++fDns10Zd4lk+L9kApzq4=;
        b=H6UQrq8Gw7l9XhwWSGmB31G/kq6Jquc0Q85jqgVJVtyOA2t7AZreIfscWmuZXczXmW
         357ceCRu6X8bqv3lwgaWOW/AsS5hvzSxPdMfAjQUPG1ysqwxdWn9Xl/S0BNn+ZOvGXEm
         Ru70TdzKwmbnb6YEv7vTEhqxHmEnbXFTF5m8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hINzrVelB9T/aQFX4msXU++fDns10Zd4lk+L9kApzq4=;
        b=cvkPMvuLj3LPfZnq127G2L0XdcMC9sodZR6jfqpxqoRP9J7XN/jLebzuvP78GnjV7m
         RGqJsWorP3aQT/VdWbDrv0HalvNsjuHfmj5pBxpeq9N8/6nniPQu3G9RDsOgP70aHgMs
         YfEnhfMsinirjC2/nwxj42WB05HEl4gqqnPWp/hZ9kPFFCjBJBapIuZUL/h9aPbc6ATC
         EIN0HRFL+Oi1fv9j0Ha8E/HnVmF0o9cK7BzmZJ4wFYm7FYliLSz/QddqbqKhshiS+Utg
         /JqaMXp6VDUnQ9CZPyNk/vDAbpiPAhUOjqSeEvZoa1aB3xru/8Vh0OZJUt1GF17iHHKV
         e8tw==
X-Gm-Message-State: AA+aEWYlILQj22Jox9/b/1Op2lwDEnJaKCk1mfwEVCHKCH8pHrNfRPWS
        jyQOqDRBxTxNxhhAIPgPpK8BYw==
X-Google-Smtp-Source: AFSGD/W3oBIwBUqStyEYbfLUmp7pEsrP9axmV9vesJHMRjX+nd736Vto3mtWKk/tmc1obuT54qqfhw==
X-Received: by 2002:a63:c503:: with SMTP id f3mr12154702pgd.431.1544483088673;
        Mon, 10 Dec 2018 15:04:48 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w5sm15951184pfn.89.2018.12.10.15.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 15:04:47 -0800 (PST)
Date:   Mon, 10 Dec 2018 16:04:45 -0700
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
Subject: Re: [PATCH v2 5/6] perf cs-etm: Treat EO_TRACE element as trace
 discontinuity
Message-ID: <20181210230445.GD12152@xps15>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
 <1544431981-24144-6-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544431981-24144-6-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:53:00PM +0800, Leo Yan wrote:
> If decoder outputs EO_TRACE element, it means the end of the trace
> buffer; this is a discontinuity and in this case the end of trace data
> needs to be saved.
> 
> This patch generates CS_ETM_DISCONTINUITY packet for EO_TRACE element
> hereby flushing the end of trace data in cs-etm.c.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 46b67f1..bcb5c98 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -411,6 +411,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
>  		break;
>  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> +	case OCSD_GEN_TRC_ELEM_EO_TRACE:
>  		resp = cs_etm_decoder__buffer_discontinuity(decoder,
>  							    trace_chan_id);

If you were to get rid of decoder::trace_on at the beginning of this set you
could put NO_SYNC, EO_TRACE and TRACE_ON together and call
cs_etm_decoder__buffer_discontinuity() only once.  I wouldn't mention it if you did
not have to respin but since you do, might as well just do it.  But that's
entirely up to you considering, at least in my opinion, that you have addressed
all of Mike and Rob' comments.

If you do not want to deal with decoder::trace_on as part of this set:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  		decoder->trace_on = false;
> @@ -431,7 +432,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  		decoder->packet_buffer[decoder->tail].exc_ret = true;
>  		break;
>  	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
> -	case OCSD_GEN_TRC_ELEM_EO_TRACE:
>  	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
>  	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
>  	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
> -- 
> 2.7.4
> 
