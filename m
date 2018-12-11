Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B2BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452062084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CuqTKsB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452062084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbeLKAjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:39:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37107 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeLKAjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:39:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id j10so12338160wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 16:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fKIR4P7y/Lu6Yb8WVUlkSDD3877cMUmbBO+/z1d0K18=;
        b=CuqTKsB2uVD1U/jhVZfzTEgut76Yy1Mpz6QRhDIhtzadIX3y7g79MxsZX0dFi4h7JO
         wWtztnE3kkcI3OD6Zd2QqXL9/iUAs6XCdoLsJAONzNXkHtULVRpzdPh/PmaW7dxbUq6B
         SrE2kVMwtF7vTcSFnDgcTx+qWz/m0yvYmJbJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fKIR4P7y/Lu6Yb8WVUlkSDD3877cMUmbBO+/z1d0K18=;
        b=lGD8ZqB4OTCnKlyYVLJTvzGSIBdxjOakTE2ykLGtEi3Yp5s8EjQQPAi2L2hx9TxP+R
         z4xNkD0CF4PRla+N6h+Ofwc573ugnxXJmu9G54QgU8UuhE72HtAOJRKYWtQDR8odv90M
         vWP44MBYETwBuLbYV6YWIsGg8UC679T3xgaebqRgeFIZb2XBbqVUUiUdUwaeujBQbg2+
         YkDpvwFqMIUfucsqGqhZ9fI0mniCXjQ90e9E+R0SMV6PkDJe/QoMZnOVQX2pebo2tIUj
         H4G01cguRWROrQteSGc8X4udQ+F+DzffqucVEDZRCTkdkXy4fU35l7g7QJcsAa9YHmlx
         tt/g==
X-Gm-Message-State: AA+aEWa5RnToqB4jKDzVMm5UxZyihL5j11K0eYxAbgrCtTC4sd6Hqeeb
        J/fEV7Du9Jh4O0k1dbWWPI6DUA==
X-Google-Smtp-Source: AFSGD/Vv53aD3t+pRR7wWDZGhm9sfdbIqhUexenG//DhDlO4aMb5OXnGwPkmmoUWtw/vi/RN+GZi+A==
X-Received: by 2002:adf:e64d:: with SMTP id b13mr11942983wrn.276.1544488774546;
        Mon, 10 Dec 2018 16:39:34 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id q12sm11584257wrx.31.2018.12.10.16.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:39:33 -0800 (PST)
Date:   Tue, 11 Dec 2018 08:39:05 +0800
From:   leo.yan@linaro.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
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
Message-ID: <20181211003905.GA21018@leoy-ThinkPad-X240s>
References: <1544431981-24144-1-git-send-email-leo.yan@linaro.org>
 <1544431981-24144-6-git-send-email-leo.yan@linaro.org>
 <20181210230445.GD12152@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210230445.GD12152@xps15>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Mon, Dec 10, 2018 at 04:04:45PM -0700, Mathieu Poirier wrote:
> On Mon, Dec 10, 2018 at 04:53:00PM +0800, Leo Yan wrote:
> > If decoder outputs EO_TRACE element, it means the end of the trace
> > buffer; this is a discontinuity and in this case the end of trace data
> > needs to be saved.
> > 
> > This patch generates CS_ETM_DISCONTINUITY packet for EO_TRACE element
> > hereby flushing the end of trace data in cs-etm.c.
> > 
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Robert Walker <robert.walker@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index 46b67f1..bcb5c98 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -411,6 +411,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> >  	case OCSD_GEN_TRC_ELEM_UNKNOWN:
> >  		break;
> >  	case OCSD_GEN_TRC_ELEM_NO_SYNC:
> > +	case OCSD_GEN_TRC_ELEM_EO_TRACE:
> >  		resp = cs_etm_decoder__buffer_discontinuity(decoder,
> >  							    trace_chan_id);
> 
> If you were to get rid of decoder::trace_on at the beginning of this set you
> could put NO_SYNC, EO_TRACE and TRACE_ON together and call
> cs_etm_decoder__buffer_discontinuity() only once.  I wouldn't mention it if you did
> not have to respin but since you do, might as well just do it.  But that's
> entirely up to you considering, at least in my opinion, that you have addressed
> all of Mike and Rob' comments.

Thanks for suggestion, this makes sense.  Will spin new patch series to
address this and also follow up other suggestions for this series.

Thanks,
Leo Yan

> If you do not want to deal with decoder::trace_on as part of this set:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> >  		decoder->trace_on = false;
> > @@ -431,7 +432,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> >  		decoder->packet_buffer[decoder->tail].exc_ret = true;
> >  		break;
> >  	case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
> > -	case OCSD_GEN_TRC_ELEM_EO_TRACE:
> >  	case OCSD_GEN_TRC_ELEM_ADDR_NACC:
> >  	case OCSD_GEN_TRC_ELEM_TIMESTAMP:
> >  	case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
> > -- 
> > 2.7.4
> > 
