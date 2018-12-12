Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7734AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F27D20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UppuU56p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F27D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeLLSlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:41:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35345 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbeLLSlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:41:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so8735534pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=efV+QfoYMImiv+O28VK5AtKXQCgSf0+gFBOPIfYpmfc=;
        b=UppuU56prMVuXoaYyGWrtmaIomyrJ9Rvwa1lOcUAiJ2emzlFxhOIcTod2wLW9ZdpoX
         YeTMVDPPLWtJoeF/IqU5941+YOkDA43wk4FwOe+zYkrxhLxhVsDRPA7cXV+Vf70Vn+qV
         Koy7chXleyoNG0h0iSB515sO6rsBaZ5tVmCMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=efV+QfoYMImiv+O28VK5AtKXQCgSf0+gFBOPIfYpmfc=;
        b=ptyvPgtuaLHz7HkuMTCHILSFBjBsZiWwj2H8T6s9qh1QbqTKfh9pvxtBOxPHQ76WGU
         mK607MLPUppXD94pWpuNsI5hZnK4X/276Dr9iykM6qLf++prpZU6xEAozvsULsOSfD29
         +m1Vjdq254VCe9VenqqAx+SHMQoQghWt/mZNh9ACp0pacFseyNAazTdSCRmqaRE58uKZ
         1hOqKEeAyUkSZPtDmMXKWHM4Zta3OnqmRfnadu1+SAAHXWl2CaPdM4C//WdOLku35nDq
         yW9kDtvI0HJvIvGwtJf4hEvEGb6SLwKILOpT14ntnXdG9nqN++emjFH9j9Eee8IeL2Lk
         jkWA==
X-Gm-Message-State: AA+aEWZtpDj/GA7sASIA0Vsr5m07voCEAEYmwLBiz+U+/GkW/iN3mOW0
        NIsKn/w+e2KoaxLQumLv+6L44g==
X-Google-Smtp-Source: AFSGD/Us00OmxZhZYqPcCXCaFK21WwTMuxmQML5yOPVXNj9SG1y9T3G95COi+I0cHJn3FZ+rjynVjQ==
X-Received: by 2002:a63:8e43:: with SMTP id k64mr19034125pge.346.1544640104757;
        Wed, 12 Dec 2018 10:41:44 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y71sm43270324pfi.123.2018.12.12.10.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 10:41:44 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:41:42 -0700
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
Subject: Re: [PATCH v3 4/8] perf cs-etm: Refactor enumeration
 cs_etm_sample_type
Message-ID: <20181212184142.GB24556@xps15>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-5-git-send-email-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544513908-16805-5-git-send-email-leo.yan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 03:38:24PM +0800, Leo Yan wrote:
> The values in enumeration cs_etm_sample_type are defined with setting
> bit N for each packet type, this is not suggested in the usual case.
> 
> This patch refactor cs_etm_sample_type by converting from bit shifting
> values to continuous numbers.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index b295dd2..3819a04 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -23,9 +23,9 @@ struct cs_etm_buffer {
>  };
>  
>  enum cs_etm_sample_type {
> -	CS_ETM_EMPTY = 0,
> -	CS_ETM_RANGE = 1 << 0,
> -	CS_ETM_TRACE_ON = 1 << 1,
> +	CS_ETM_EMPTY,
> +	CS_ETM_RANGE,
> +	CS_ETM_TRACE_ON,
>  };

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  enum cs_etm_isa {
> -- 
> 2.7.4
> 
