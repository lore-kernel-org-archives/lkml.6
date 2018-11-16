Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EFEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71482086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LAH+U5vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71482086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeKQJTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:19:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46031 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQJTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:19:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so11206945pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 15:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CmU0ypN2uBNgVuQePI33oHrQC1mVLrfBCLqLPyWeIP0=;
        b=LAH+U5vfSQvoEjYUOCEfCIK5GQRvvSpIrmhtTViTlXY4d7+ZyOYmtM9OJw1dpkGdEz
         /t08vyd/CVEw1y/d5RvIyZ0peuS+oSKucEjQiI9csaYwWhKSm28epo29UPj9w7yWCMb2
         fhWt9XREPQd/KZbIKuah31Ob04dX89TQ3knWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CmU0ypN2uBNgVuQePI33oHrQC1mVLrfBCLqLPyWeIP0=;
        b=k8SYXiXppd2yJnP/m0yOmRnL3ZBSvcLjClrCKwYgZCwEDU1Ur8+FAgTEAUJtIE5reG
         62D1+rXaEWpoT51pMeGvfdAEi6i/W//aNsefMaMRmO+3UVXZgBr4aseH1PszXer+hJfj
         H/SIWh3sS0DvJubfYQ/8CTj5GJYKd+VFzWLuSD97MvObvN9HL4bL/ZHzM+8hbTZaTiFH
         LysfzUACs7O0CkNnuGOqmvcmmU2RPXqnQlvGVp/gMsrL+657Er1ICRlZINwt74j46OF6
         nqsF8rz8al91NdP/W07kZYEKNn86ag98AXsZnsDNRCsgs29NA5IAOWWXxeHORjNHsz1U
         EJJA==
X-Gm-Message-State: AGRZ1gK89HbFwDrHQzYqzdePOMBsxzCICxpKKIvO4IPDP90s/TUlHfG2
        7V5wltV/+Nk1Hbo+j7KwW5k6dw==
X-Google-Smtp-Source: AJdET5chqBLmMk3b90pRr2e2NGuvaoZjlGzefkVnJyx/IvA3blemMwRjquog2+46ex1o7j8hJaQyKA==
X-Received: by 2002:a63:1258:: with SMTP id 24mr11572361pgs.114.1542409514846;
        Fri, 16 Nov 2018 15:05:14 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c127-v6sm34822429pfa.31.2018.11.16.15.05.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 15:05:14 -0800 (PST)
Date:   Fri, 16 Nov 2018 16:05:11 -0700
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
Subject: Re: [PATCH v1 2/5] perf cs-etm: Avoid stale branch samples when
 flush packet
Message-ID: <20181116230511.GB25258@xps15>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-3-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541912383-19915-3-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:59:40PM +0800, Leo Yan wrote:
> At the end of trace buffer handling, function cs_etm__flush() is invoked
> to flush any remaining branch stack entries.  As a side effect, it also
> generates branch sample, because the 'etmq->packet' doesn't contains any
> new coming packet but point to one stale packet after packets swapping,
> so it wrongly makes synthesize branch samples with stale packet info.
> 
> We could review below detailed flow which causes issue:
> 
>   Packet1: start_addr=0xffff000008b1fbf0 end_addr=0xffff000008b1fbfc
>   Packet2: start_addr=0xffff000008b1fb5c end_addr=0xffff000008b1fb6c
> 
>   step 1: cs_etm__sample():
> 	sample: ip=(0xffff000008b1fbfc-4) addr=0xffff000008b1fb5c
> 
>   step 2: flush packet in cs_etm__run_decoder():
> 	cs_etm__run_decoder()
> 	  `-> err = cs_etm__flush(etmq, false);
> 	sample: ip=(0xffff000008b1fb6c-4) addr=0xffff000008b1fbf0
> 
> Packet1 and packet2 are two continuous packets, when packet2 is the new
> coming packet, cs_etm__sample() generates branch sample for these two
> packets and use [packet1::end_addr - 4 => packet2::start_addr] as branch
> jump flow, thus we can see the first generated branch sample in step 1.
> At the end of cs_etm__sample() it swaps packets so 'etm->prev_packet'=
> packet2 and 'etm->packet'=packet1, so far it's okay for branch sample.
> 
> If packet2 is the last one packet in trace buffer, even there have no
> any new coming packet, cs_etm__run_decoder() invokes cs_etm__flush() to
> flush branch stack entries as expected, but it also generates branch
> samples by taking 'etm->packet' as a new coming packet, thus the branch
> jump flow is as [packet2::end_addr - 4 =>  packet1::start_addr]; this
> is the second sample which is generated in step 2.  So actually the
> second sample is a stale sample and we should not generate it.
> 
> This patch is to add new argument 'new_packet' for cs_etm__flush(), we
> can pass 'true' for this argument if there have a new packet, otherwise
> it will pass 'false' for the purpose of only flushing branch stack
> entries and avoid to generate sample for stale packet.

Very good explanation, thanks for taking the time to write this.

> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index fe18d7b..f4fa877 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -955,7 +955,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq)
>  	return 0;
>  }
>  
> -static int cs_etm__flush(struct cs_etm_queue *etmq)
> +static int cs_etm__flush(struct cs_etm_queue *etmq, bool new_packet)
>  {
>  	int err = 0;
>  	struct cs_etm_auxtrace *etm = etmq->etm;
> @@ -989,6 +989,20 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
>  
>  	}
>  
> +	/*
> +	 * If 'new_packet' is false, this time call has no a new packet
> +	 * coming and 'etmq->packet' contains the stale packet which is
> +	 * set at the previous time with packets swapping.  In this case
> +	 * this function is invoked only for flushing branch stack at
> +	 * the end of buffer handling.
> +	 *
> +	 * Simply to say, branch samples should be generated when every
> +	 * time receive one new packet; otherwise, directly bail out to
> +	 * avoid generate branch sample with stale packet.
> +	 */
> +	if (!new_packet)
> +		return 0;
> +
>  	if (etm->sample_branches &&
>  	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
>  		err = cs_etm__synth_branch_sample(etmq);
> @@ -1075,7 +1089,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  					 * Discontinuity in trace, flush
>  					 * previous branch stack
>  					 */
> -					cs_etm__flush(etmq);
> +					cs_etm__flush(etmq, true);
>  					break;
>  				case CS_ETM_EMPTY:
>  					/*
> @@ -1092,7 +1106,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  
>  		if (err == 0)
>  			/* Flush any remaining branch stack entries */
> -			err = cs_etm__flush(etmq);
> +			err = cs_etm__flush(etmq, false);

I understand what you're doing and it will yield the correct results.  What I'm
not sure about is if we wouldn't be better off splitting cs_etm__flush()
in order to reduce the complexity of the main decoding loop.  That is rename
cs_etm__flush() to something like cs_etm__trace_on() and spin off a new
cs_etm__end_block().  

It does introduce a little bit of code duplication but I think we'd win in terms
of readability and flexibility.

Thanks,
Mathieu


>  	}
>  
>  	return err;
> -- 
> 2.7.4
> 
