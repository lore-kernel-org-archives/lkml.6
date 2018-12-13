Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3C5C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B12220849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwgYHu3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B12220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbeLMNKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:10:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33303 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbeLMNKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:10:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so13866895wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 05:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=38mbt+BqVhFnc/CjZGS2t6U4Vp7zJP4jXDTl/C7yvYY=;
        b=DwgYHu3D5WYQJRF4/72VhnR6oNXBOgmN/Uo1a62KHbYyC8jN6zL4KZNhUXO/c0OeCL
         pSGIakLqb8mRF+NG6S7fq9N6IdlyD27dYvw7u+csVxpsScCu+jYlDk8dQqyxGe54z4iI
         n+viNKVVnSNRk2DPDrVV/tdg5S4Xx0ei2a3Eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=38mbt+BqVhFnc/CjZGS2t6U4Vp7zJP4jXDTl/C7yvYY=;
        b=UHk/+DL1nTlTbEd79hx3qHux+sEUA3kkzprrG5BA7v60vXkiIC5mpYCCc5h2JCm00r
         f5DJPDMqQf69wuAJhgJ/y7umVZSZy6IkJZNUDrOmuCvRFDAYAw4UlUiFNJVFy/yWtemn
         Ud2tOtymIVFRpqx+ICGUnOIntDCdjknvf5floZxTvZBEOZDU1CNCLWbvxxCVQ9SREH2T
         rNXiAWsgXuidLguZJujFME7KT6zfvEV6efpuA18mhxVQDV+BxDOH8L1qwGC8Wz9HSk+o
         Dj//1WdmozGuy3TvNR8oo0NVvrAa7OXCwLiRXkkBZOJO+G4as6AMk7r9LhJ+zkerY2JY
         8k4Q==
X-Gm-Message-State: AA+aEWaBY9zRSDT++kzMpvzpicqpz67e5DREjcBNW6/RXNiEj1ylPmhM
        eH9PVYvJePh2EkyXu0UlPexz0tuUrd/69JIw
X-Google-Smtp-Source: AFSGD/WyFLVEfjsdKtOcn9yelNWlk6saP74A/ECCNprpBA7mXmBpPy2H53+CUCvHQfsVKeb/aVqOaQ==
X-Received: by 2002:a1c:b515:: with SMTP id e21mr10258132wmf.82.1544706608515;
        Thu, 13 Dec 2018 05:10:08 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id o5sm3727983wmg.25.2018.12.13.05.10.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 05:10:07 -0800 (PST)
Date:   Thu, 13 Dec 2018 21:09:49 +0800
From:   leo.yan@linaro.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>
Subject: Re: [PATCH v3 6/8] perf cs-etm: Treat NO_SYNC element as trace
 discontinuity
Message-ID: <20181213130949.GB17663@leoy-ThinkPad-X240s>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
 <20181213123854.GE21027@kernel.org>
 <20181213124154.GF21027@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213124154.GF21027@kernel.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Dec 13, 2018 at 09:41:54AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 13, 2018 at 09:38:54AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Dec 11, 2018 at 03:38:26PM +0800, Leo Yan escreveu:
> > > CoreSight tracer driver might insert barrier packet between different
> > > buffers, thus the decoder can spot the boundaries based on the barrier
> > > packet; the decoder is possible to hit a barrier packet and emit a
> > > NO_SYNC element, then the decoder will find a periodic synchronisation
> > > point inside that next trace block that starts trace again but does not
> > > have the TRACE_ON element as indicator - usually because this block of
> > > trace has wrapped the buffer so we have lost the original point that
> > > trace was enabled.
> > > 
> > > In upper case, it results in the trace stream only inserts the
> > > OCSD_GEN_TRC_ELEM_NO_SYNC element in the middle of tracing stream, but
> > > we don't handle NO_SYNC element properly and at the end users miss to
> > > see the info for trace discontinuity.
> > 
> > 
> > "In upper case"? Maybe:
> > 
> > In the former case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
> > in the middle of the the tracing stream, but as we were npt handling the
> > NO_SYNC element properly which ends up making users miss the
> > discontinuity indication"?
> 
> > > Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
> > > output from the decoder, but both of them indicate the trace data is
> > 
> > can we remove the "but" and "of them" (redundant) above?
> > 
> > > discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as trace
> >                                                                a
> > > discontinuity and generates CS_ETM_DISCONTINUITY packet for it, so
> > > cs-etm can handle discontinuity for this case, finally it saves the last
> >                        it (way too many "discontinuity")
> > > trace data for previous trace block and restart samples for new block.
> 
> I've tentatively done those changes (and a few more) in my local branch,
> resulting in the wording below, plese let me know if you are ok with it:

Very appreciate your helping.  Please see some minor typos in below
commit:

> commit 148068b45fe2e93b19c06cfc1140ea12ca72eb59
> Author: Leo Yan <leo.yan@linaro.org>
> Date:   Tue Dec 11 15:38:26 2018 +0800
> 
>     perf cs-etm: Treat NO_SYNC element as trace discontinuity
>     
>     The CoreSight tracer driver might insert a barrier packets between
                                                         packet
>     different buffers, thus the decoder can spot the boundaries based on the
>     barrier packet; it is possible for the decoder to hit a barrier packet
>     and emit a NO_SYNC element, then the decoder will find a periodic
>     synchronisation point inside that next trace block that starts the trace
>     again but does not have the TRACE_ON element as indicator - usually
>     because this trace block has wrapped the buffer so we have lost the
>     original point when the trace was enabled.
>     
>     In the first case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
             former
>     in the middle of the the tracing stream, but as we were npt handling the
                                                              not
>     NO_SYNC element properly which ends up making users miss the
>     discontinuity indication"?
                              s/?/.

Thanks a lot for helping.  If you prefer me to resend the patch set,
also let me know.

>     Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
>     output from the decoder, both indicate that the trace data is
>     discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as a trace
>     discontinuity and generates a CS_ETM_DISCONTINUITY packet for it, so
>     cs-etm can handle the discontinuity for this case, finally it saves the
>     last trace data for the previous trace block and restart samples for the
>     new block.
>     
>     Signed-off-by: Leo Yan <leo.yan@linaro.org>
>     Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Jiri Olsa <jolsa@redhat.com>
>     Cc: Mike Leach <mike.leach@linaro.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Robert Walker <robert.walker@arm.com>
>     Cc: coresight ml <coresight@lists.linaro.org>
>     Cc: linux-arm-kernel@lists.infradead.org
>     Link: http://lkml.kernel.org/r/1544513908-16805-7-git-send-email-leo.yan@linaro.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 1039f364f4cc..bee026e76a4c 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -410,7 +410,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
>  		break;
>  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> -		break;
>  	case OCSD_GEN_TRC_ELEM_TRACE_ON:
>  		resp = cs_etm_decoder__buffer_discontinuity(decoder,
>  							    trace_chan_id);
> 
> 
