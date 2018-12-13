Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12ECC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BCD2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 13:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eEVGDG2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BCD2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbeLMNXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 08:23:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35170 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbeLMNXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 08:23:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so2384235wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 05:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mUJDGb3j8mgfr9OUxKwbLGWVKSmeSht45XUpgDFnH8k=;
        b=eEVGDG2k5fyXu7Amxoylg3M4fDQ3Goq066JaGSqReXkSZBw7gHsI/hBCfMWDjLSwnJ
         GXBCrY5OeUFN3TQ0kl2cMQXpxO/ifVVLhliGM0BQg+fxIzy7yzUr3CB/6T6g8nrmAaSw
         4NYxcIp5HxzmTbs6zjZIQCMR+H11rkvovlvEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUJDGb3j8mgfr9OUxKwbLGWVKSmeSht45XUpgDFnH8k=;
        b=GCB2Yl8Dsj1JMKCFSmLnBNStDL8VjEc8YuqgxULOu8UNY8GLGbkceWAADVVX7ACrXY
         evm7RoYw31DjIvS53p+ntt65l7/O5500wvJNjQAIOvEAxReL/N0wzSoHWG2AQCX/mfad
         gwEC5VZuyCbiVpQXXHx14UorKjlpA9QinW/H671rsrDUMH5fu0afbq94knp51H5xpJIt
         ZImzYGxq1X6LY/tcVrgLyQkGMxdeMb0ALZ9N6F/xg09YinIeN+f/kVYbwtuSrBY3fJ5g
         kpRd09zdtBEBvSwjXtF/SjSsodqlWefB0YlhivZOMplRWkFHooUDUuKlZBL+WYqLQbcF
         ImEw==
X-Gm-Message-State: AA+aEWbUXi+4dVxcmvxeFLSVXACKUJV/RqQZjuvvwvoJgfuyDAaXg9O9
        3ZQT+uyOdP3hem8zsLQwPRv2sg==
X-Google-Smtp-Source: AFSGD/UWx+FWz8MIYSDKKxn9upjV/fwmTtsn22qpAhzUeOF055wfXuZl/0eGCOHlMABLXl2sNnW3NQ==
X-Received: by 2002:a1c:b94b:: with SMTP id j72mr10133416wmf.11.1544707430043;
        Thu, 13 Dec 2018 05:23:50 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id x15sm2737297wrs.27.2018.12.13.05.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 05:23:49 -0800 (PST)
Date:   Thu, 13 Dec 2018 21:23:40 +0800
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
Message-ID: <20181213132340.GC17663@leoy-ThinkPad-X240s>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
 <20181213123854.GE21027@kernel.org>
 <20181213124154.GF21027@kernel.org>
 <20181213130949.GB17663@leoy-ThinkPad-X240s>
 <20181213132126.GI21027@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213132126.GI21027@kernel.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:21:26AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > > commit 148068b45fe2e93b19c06cfc1140ea12ca72eb59
> > > Author: Leo Yan <leo.yan@linaro.org>
> > > Date:   Tue Dec 11 15:38:26 2018 +0800
> > > 
> > >     perf cs-etm: Treat NO_SYNC element as trace discontinuity
> > >     
> > >     The CoreSight tracer driver might insert a barrier packets between
> >                                                          packet
> 
>                                              I'll remove the 'a' instead, ok?

Yeah.

> > >     different buffers, thus the decoder can spot the boundaries based on the
> > >     barrier packet; it is possible for the decoder to hit a barrier packet
> > >     and emit a NO_SYNC element, then the decoder will find a periodic
> > >     synchronisation point inside that next trace block that starts the trace
> > >     again but does not have the TRACE_ON element as indicator - usually
> > >     because this trace block has wrapped the buffer so we have lost the
> > >     original point when the trace was enabled.
> > >     
> > >     In the first case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
> >              former
> > >     in the middle of the the tracing stream, but as we were npt handling the
> >                                                               not
> > >     NO_SYNC element properly which ends up making users miss the
> > >     discontinuity indication"?
> >                               s/?/.
> > 
> > Thanks a lot for helping.  If you prefer me to resend the patch set,
> > also let me know.
> 
> I can fix it, here.

Thanks a lot!

> > >     Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
> > >     output from the decoder, both indicate that the trace data is
> > >     discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as a trace
> > >     discontinuity and generates a CS_ETM_DISCONTINUITY packet for it, so
> > >     cs-etm can handle the discontinuity for this case, finally it saves the
> > >     last trace data for the previous trace block and restart samples for the
> > >     new block.
> > >     
> > >     Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > >     Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > >     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > >     Cc: Jiri Olsa <jolsa@redhat.com>
> > >     Cc: Mike Leach <mike.leach@linaro.org>
> > >     Cc: Namhyung Kim <namhyung@kernel.org>
> > >     Cc: Robert Walker <robert.walker@arm.com>
> > >     Cc: coresight ml <coresight@lists.linaro.org>
> > >     Cc: linux-arm-kernel@lists.infradead.org
> > >     Link: http://lkml.kernel.org/r/1544513908-16805-7-git-send-email-leo.yan@linaro.org
> > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > index 1039f364f4cc..bee026e76a4c 100644
> > > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > > @@ -410,7 +410,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> > >  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
> > >  		break;
> > >  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> > > -		break;
> > >  	case OCSD_GEN_TRC_ELEM_TRACE_ON:
> > >  		resp = cs_etm_decoder__buffer_discontinuity(decoder,
> > >  							    trace_chan_id);
> > > 
> > > 
> 
> -- 
> 
> - Arnaldo
