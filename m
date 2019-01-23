Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043E8C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41DE2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpVK4CnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfAWVXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:23:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43965 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfAWVXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:23:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so1787614plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 13:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kMvEGohdbgzHXLbqMasWVSocy33cwNII+RxYNB+qKAs=;
        b=VpVK4CnMrfetk2FX7kRbZ6T/xoin0s/8Y7ilAFk3ysZ0fWiE+GfGoY5VQ4JMiVCffc
         LG3k6UlZvXNhcHcofyf2PquRq+3I+OifoV6+r4giy/iBCGIP8ANPz1DA8Chhc0VdXuVj
         yGw2qg8H7jXbpTSG24SXr+ns7PKT1/5xNIuFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kMvEGohdbgzHXLbqMasWVSocy33cwNII+RxYNB+qKAs=;
        b=UhgnrltpDCOMNMrGd0e0MGZDxXVypx1Vglab63GVnUuTbcoxlGpkpFa0ofn18oqnDq
         CyZ8O3HcOrZD8sXNsPZXoyRN0qACxSgLbP1qmINXIgJ+o2+Zk6fH1xsG+zgk6FZ87LvR
         3G4NC96Pz6CK6hnjmW50L6cl1+VDgkPBcOExtLA2BbWU5jWFNvd5PrRZJAezcmyexSxF
         PgLSZ7VdGxdxNgT2WzH6CZi73E7a+Q83QibR4oOQ9R7GukVVTmFtOA+D7k8M2C/dJ/R6
         fVhP8emJxSUKbEI4s1xyAbPbVJg3fw68VMBuNXLSi4GqxKuhOyT+oYuigB5v1fjvkZ5T
         wnQg==
X-Gm-Message-State: AJcUukfjx7ySNRQRwil0Y/+abYhRjVpDqgLbwyLc5iuYcXFLQJrQnNzb
        jU2qq4afjNTTmGflo3P0wbmgz7G14hRQRw==
X-Google-Smtp-Source: ALg8bN5rnthAxS//lzD29sMzwZmud4gLRPS4Kcfadbk0154OFPD9WVwMYiBHxw85qZ7vx9TZKqPCLA==
X-Received: by 2002:a17:902:7201:: with SMTP id ba1mr3884772plb.105.1548278617984;
        Wed, 23 Jan 2019 13:23:37 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k24sm28483745pfj.13.2019.01.23.13.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:23:37 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:23:34 -0700
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
Subject: Re: [PATCH v6 6/8] perf cs-etm: Add traceID in packet
Message-ID: <20190123212334.GF620@xps15>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-7-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119014347.27441-7-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 09:43:45AM +0800, Leo Yan wrote:
> Add traceID in packet, thus we can use traceID to retrieve metadata
> pointer from traceID-metadata tuple.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 ++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index cdd38ffd10d2..ba4c623cd8de 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -295,6 +295,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
>  		decoder->packet_buffer[i].last_instr_cond = 0;
>  		decoder->packet_buffer[i].flags = 0;
>  		decoder->packet_buffer[i].exception_number = UINT32_MAX;
> +		decoder->packet_buffer[i].trace_chan_id = UINT8_MAX;
>  		decoder->packet_buffer[i].cpu = INT_MIN;
>  	}
>  }
> @@ -331,6 +332,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
>  	decoder->packet_buffer[et].last_instr_cond = 0;
>  	decoder->packet_buffer[et].flags = 0;
>  	decoder->packet_buffer[et].exception_number = UINT32_MAX;
> +	decoder->packet_buffer[et].trace_chan_id = trace_chan_id;
>  
>  	if (decoder->packet_count == MAX_BUFFER - 1)
>  		return OCSD_RESP_WAIT;
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index 012b4728a46f..7e6a8850be4a 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -50,6 +50,7 @@ struct cs_etm_packet {
>  	u8 last_instr_cond;
>  	u8 last_instr_taken_branch;
>  	u8 last_instr_size;
> +	u8 trace_chan_id;
>  	int cpu;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  };
>  
> -- 
> 2.17.1
> 
