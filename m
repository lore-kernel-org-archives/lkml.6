Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EAFC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D07E20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPUAA2S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D07E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeLLSlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:41:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39483 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbeLLSlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:41:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so8719735pgl.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AQUGeZO51KzJnoqlQO0qPHq/gKBQeA0epVLv7slJukw=;
        b=MPUAA2S69XVZbGZM+4ddVx3ynmkB/gCcBUjkh5VfFH8k53dDWYN4hXppJNS9NrSped
         0KqKlHkca2bX3DDGwioKCKy64jgFh34KaktSOr48RSYCaIKwPyibtVUfu3x6D9AAEK5A
         zZMQIx000wdcptQbioSLCSLHLJ2qdsu6Ow4Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AQUGeZO51KzJnoqlQO0qPHq/gKBQeA0epVLv7slJukw=;
        b=Ao5wTNkAAbgKd+mPXs+krEtyFcrTKBDyevRUbDoufxvxcJo/LwaHDPdiatzW74/txc
         s7RNMQpEKeM7z6DZxwdUp6Sv11q5VpZ9ixd9VUkfzxe7xEI6dYXeyJ+wlsSUog9lCofV
         AUoyH1sD4XfGZTnSREnkShiZf8/wUKlr3ycU/R2RpZW4c8o4FecihvzSIg5fhJGE9hfv
         VI41nf6wnhqs6P4ovMt8l9eUtVzgF8Pa40rH2+HorxIAqdTlD3gCoUf3B5F6VHoYC1Gy
         Uf9CbOwoZS3P4VIpe1eASudxIjKiZFOaMcz2QBFjrTiqU/fUbRsk7pUhqJpsJtiqla9O
         YPPQ==
X-Gm-Message-State: AA+aEWbr6bu9iI+FcrJoqZ2Pdih/yYGVwUrAfoQ9Y4WpWLwzD098tdc0
        ZPYdxPIClkmOkG14dyrBCJEgHw==
X-Google-Smtp-Source: AFSGD/XUKu6LJif/wRxOlZTXmtOSD1giS0jdioQ4tRM+d2+pUg73nmRV/ljJbFvHWuxGBlp64tJj6Q==
X-Received: by 2002:a63:507:: with SMTP id 7mr18679965pgf.411.1544640068478;
        Wed, 12 Dec 2018 10:41:08 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id i21sm19044531pgm.17.2018.12.12.10.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:41:07 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:41:05 -0700
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
Subject: Re: [PATCH v3 3/8] perf cs-etm: Remove unused 'trace_on' in
 cs_etm_decoder
Message-ID: <20181212184105.GA24556@xps15>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-4-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544513908-16805-4-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 03:38:23PM +0800, Leo Yan wrote:
> cs_etm_decoder::trace_on is being assigned when TRACE_ON or NO_SYNC
> element is coming, but it is never used hence it is redundant and can
> be removed.
> 
> So let's remove 'trace_on' field from cs_etm_decoder struct.
> 
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 0b4c862..97b39b1 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -36,7 +36,6 @@
>  struct cs_etm_decoder {
>  	void *data;
>  	void (*packet_printer)(const char *msg);
> -	bool trace_on;
>  	dcd_tree_handle_t dcd_tree;
>  	cs_etm_mem_cb_type mem_access;
>  	ocsd_datapath_resp_t prev_return;
> @@ -411,12 +410,10 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
>  		break;
>  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> -		decoder->trace_on = false;
>  		break;
>  	case OCSD_GEN_TRC_ELEM_TRACE_ON:
>  		resp = cs_etm_decoder__buffer_trace_on(decoder,
>  						       trace_chan_id);
> -		decoder->trace_on = true;
>  		break;
>  	case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
>  		resp = cs_etm_decoder__buffer_range(decoder, elem,

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 
