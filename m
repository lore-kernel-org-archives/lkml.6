Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B3FC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3CF20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="koWvXWbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3CF20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbeLJWsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:48:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45799 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeLJWsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:48:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id y4so5644063pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 14:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hGe7qh3okuyxooCLsgUyfOmoqYrSDkgBoKxwLswAXg0=;
        b=koWvXWbfmhws346COuZgCbvBbaa0sSZxmbEBuI/o8nwwhV0k+rrg9xxidl4KsOwa3R
         ey48SgNcf7PE30JHBlDQw8qBw9ISUaRhDXdK1n16FlypnXb2aKPBaU0GMchaLiHeIkHa
         gUV2p/a6/8BweVZvrK9o7rSynZxJXKdZUU/Yk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGe7qh3okuyxooCLsgUyfOmoqYrSDkgBoKxwLswAXg0=;
        b=GQQRIxUZjM4GeC/fwriL+10PNRH1z3kdFBRtcX0BxokSdiIV+bgTBMcob1wbcZj66J
         US33MR5S0KdyVDQN5jHC8yeFvJaA3uJJdjgSXNmrUSY628zNgDlBekgRdkWt86CmctYt
         +AE+wWcWwEsiM+RVR8yPCJ2AWgfBqEtVJHN62z1bBuY9he3qkiuhCLTZmLwERV2ucIUL
         VpE1yo+/zeWHTPj4xJRyNkNszMgfkvFL1pyYGAszMKlN/Ov+I7to0M/IP1LorPXIlRyL
         sLtNCaWTXa955jnHSfjpChmfeJP4aIU9ctHl7KdV6BPoSjgePDfZj79aZltaS1oWXVhu
         07EQ==
X-Gm-Message-State: AA+aEWYkRc4ARMc4XGVB7Aj1TJPwC9LJiyQgPe1I15mR6uKOMU+SkrLz
        qk6UcGt00oCIFbBZVhpZqWlyyQ==
X-Google-Smtp-Source: AFSGD/VnE4FdwJgoPAFlY9fwqdmwzqqIIvMAmPZROPT2tYSnlIYT60fQJg+h3nlMVHyF9sdbE4jcMQ==
X-Received: by 2002:a62:824c:: with SMTP id w73mr14005099pfd.150.1544482098381;
        Mon, 10 Dec 2018 14:48:18 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g136sm19265654pfb.154.2018.12.10.14.48.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 14:48:17 -0800 (PST)
Date:   Mon, 10 Dec 2018 15:48:15 -0700
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
Subject: Re: [PATCH v2 2/6] perf cs-etm: Avoid stale branch samples when
 flush packet
Message-ID: <20181210224815.GA12152@xps15>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
 <1544431981-24144-3-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544431981-24144-3-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 04:52:57PM +0800, Leo Yan wrote:
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
> This patch introduces a new function cs_etm__end_block(), at the end of
> trace block this function is invoked to only flush branch stack entries
> and thus can avoid to generate branch sample for stale packet.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 789707b..ffc4fe5 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1055,6 +1055,39 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
>  	return err;
>  }
>  
> +static int cs_etm__end_block(struct cs_etm_queue *etmq)
> +{
> +	int err;
> +
> +	/*
> +	 * It has no new packet coming and 'etmq->packet' contains the stale
> +	 * packet which was set at the previous time with packets swapping;
> +	 * so skip to generate branch sample to avoid stale packet.
> +	 *
> +	 * For this case only flush branch stack and generate a last branch
> +	 * event for the branches left in the circular buffer at the end of
> +	 * the trace.
> +	 */
> +	if (etmq->etm->synth_opts.last_branch &&
> +	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
> +		/*
> +		 * Use the address of the end of the last reported execution
> +		 * range.
> +		 */
> +		u64 addr = cs_etm__last_executed_instr(etmq->prev_packet);
> +
> +		err = cs_etm__synth_instruction_sample(
> +			etmq, addr,
> +			etmq->period_instructions);
> +		if (err)
> +			return err;
> +
> +		etmq->period_instructions = 0;
> +	}
> +
> +	return 0;
> +}
> +
>  static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  {
>  	struct cs_etm_auxtrace *etm = etmq->etm;
> @@ -1137,7 +1170,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
>  
>  		if (err == 0)
>  			/* Flush any remaining branch stack entries */
> -			err = cs_etm__flush(etmq);
> +			err = cs_etm__end_block(etmq);
>  	}
>  
>  	return err;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> -- 
> 2.7.4
> 
