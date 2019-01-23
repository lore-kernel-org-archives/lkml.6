Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045F5C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52ED21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEkdUoNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfAWVvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:51:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36565 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfAWVvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:51:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so1833610plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Un+ddWOkrcLIgcdYaVmErVN+SdzigN0j9GGeHRptMoo=;
        b=eEkdUoNNh9LMxCmSkRnBatUg64bUk2CRLGuYq4jPvAFodhiYnkcuCyuBi3UwyPTUE3
         YQAVq8xUHy2zT0eK2l0l2wDqgIxd1lGXBImoYakKSCs7WXYnCbd0LijXqy5A1SvFnKC1
         nfrQi5eiB3sf31qcEgIw18lTlTEyqlXxDPAq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Un+ddWOkrcLIgcdYaVmErVN+SdzigN0j9GGeHRptMoo=;
        b=IA7GnjZREswoCH80B2+jeoBkUKGBoOALV+2n+m+OtXX2Jt9F/D4bpAfeSYJaNwOVn/
         ZtebgPNn5XbpTmBVkNvT8/+vi/9Hlnvo55LfjkIg6MvVJ5KsrIOzKXouy1KXsi/9DKjT
         pgJ3e0Dv2FJqa4FGYyuzQeaebLotXws3q9L3F8ehkC8n9bfCaqZhNR6jVSbzunU1gi7D
         aoaO3g9Frs+eE5yROqTOOCVop4aPXQX1SwZn0YYSzKqHNZtaxVN+vGbRCavMsrhdIbF5
         ZSYzM4jZiDYd8nLuhfkXIN+lpUmx6T/SprbHaHPD1UtMedQ9mSbPbnB+V4eO7wKXR07p
         xnLQ==
X-Gm-Message-State: AJcUukeDoRDBHYjg5o04jXn+5djvL9qRkV+ih2c51+cx0ic70rzTNvaM
        FnqGA8QkJqqls1aD3dYQaMHUbQ==
X-Google-Smtp-Source: ALg8bN7llw7Cbe+fDZE2zaKxL2R0lB+Y1xOkgy/EbdJS2qcmASmFFWyDk+Z97ikucEQRIB77Uxe6bQ==
X-Received: by 2002:a17:902:ba89:: with SMTP id k9mr4022026pls.189.1548280277555;
        Wed, 23 Jan 2019 13:51:17 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r4sm41423684pgn.54.2019.01.23.13.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:51:16 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:51:14 -0700
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
Subject: Re: [PATCH v6 8/8] perf cs-etm: Set sample flags for exception
 return packet
Message-ID: <20190123215114.GH620@xps15>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-9-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119014347.27441-9-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 09:43:47AM +0800, Leo Yan wrote:
> When return from exception, we need to distinguish if it's system call
> return or for other type exceptions for setting sample flags.  Due to
> the exception return packet doesn't contain exception number, so we
> cannot decide sample flags based on exception number.
> 
> On the other hand, the exception return packet is followed by an
> instruction range packet; this range packet deliveries the start address
> after exception handling, we can check if it is a SVC instruction just
> before the start address.  If there has one SVC instruction is found
> ahead the return address, this means it's an exception return for system
> call; otherwise it is an normal return for other exceptions.
> 
> This patch is to set sample flags for exception return packet, firstly
> it simply set sample flags as PERF_IP_FLAG_INTERRUPT for all exception
> returns since at this point it doesn't know what's exactly the exception
> type.  We will defer to decide if it's an exception return for system
> call when the next instruction range packet comes, it checks if there
> has one SVC instruction prior to the start address and if so we will
> change sample flags to PERF_IP_FLAG_SYSCALLRET for system call
> return.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 052805de6513..7547a7178f46 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1372,6 +1372,20 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
>  		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
>  			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
>  					      PERF_IP_FLAG_TRACE_BEGIN;
> +
> +		/*
> +		 * If the previous packet is an exception return packet
> +		 * and the return address just follows SVC instuction,
> +		 * it needs to calibrate the previous packet sample flags
> +		 * as PERF_IP_FLAG_SYSCALLRET.
> +		 */
> +		if (prev_packet->flags == (PERF_IP_FLAG_BRANCH |
> +					   PERF_IP_FLAG_RETURN |
> +					   PERF_IP_FLAG_INTERRUPT) &&

Would it make more sense to just look for prev-packet->sample_type ==
CS_ETM_EXCEPTION_RET ?

> +		    cs_etm__is_svc_instr(etmq, packet, packet->start_addr))
> +			prev_packet->flags = PERF_IP_FLAG_BRANCH |
> +					     PERF_IP_FLAG_RETURN |
> +					     PERF_IP_FLAG_SYSCALLRET;
>  		break;
>  	case CS_ETM_DISCONTINUITY:
>  		/*
> @@ -1422,6 +1436,36 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
>  			prev_packet->flags = packet->flags;
>  		break;
>  	case CS_ETM_EXCEPTION_RET:
> +		/*
> +		 * When the exception return packet is inserted, since
> +		 * exception return packet is not used standalone for
> +		 * generating samples and it's affiliation to the previous
> +		 * instruction range packet; so set previous range packet
> +		 * flags to tell perf it is an exception return branch.
> +		 *
> +		 * The exception return can be for either system call or
> +		 * other exception types; unfortunately the packet doesn't
> +		 * contain exception type related info so we cannot decide
> +		 * the exception type purely based on exception return packet.
> +		 * If we record the exception number from exception packet and
> +		 * reuse it for excpetion return packet, this is not reliable
> +		 * due the trace can be discontinuity or the interrupt can
> +		 * be nested, thus the recorded exception number cannot be
> +		 * used for exception return packet for these two cases.
> +		 *
> +		 * For exception return packet, we only need to distinguish the
> +		 * packet is for system call or for other types.  Thus the
> +		 * decision can be deferred when receive the next packet which
> +		 * contains the return address, based on the return address we
> +		 * can read out the previous instruction and check if it's a
> +		 * system call instruction and then calibrate the sample flag
> +		 * as needed.
> +		 */
> +		if (prev_packet->sample_type == CS_ETM_RANGE)
> +			prev_packet->flags = PERF_IP_FLAG_BRANCH |
> +					     PERF_IP_FLAG_RETURN |
> +					     PERF_IP_FLAG_INTERRUPT;
> +		break;
>  	case CS_ETM_EMPTY:
>  	default:
>  		break;
> -- 
> 2.17.1
> 
