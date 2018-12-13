Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4246DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF07E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544704920;
	bh=X6/laEwHkioF+G7AUlizJqCkKKFXXyzX74qJHQWy8bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yj2k/CuByhgdtvFh0vkMLIB6M3g3fT7/MgjeZjsiY81CJoUsv/UnndF6Y1Ij+SHoS
	 eCzXYgDj51I6t+RJkxOg6Kwfw4Qq2EEgOLhudInP474GXSdOzy3qcfjcsmABIzt/2C
	 dxjcPX4/mcG7Xmyu8y8PBmXidyKppFOeidRP3OTQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF07E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbeLMMl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbeLMMl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:41:58 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70932086D;
        Thu, 13 Dec 2018 12:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544704917;
        bh=X6/laEwHkioF+G7AUlizJqCkKKFXXyzX74qJHQWy8bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hN9M4/oQRB9t0l6ah3y9UXyUt6u+bRaQy+NvvqzetzQUbDRbgr6CzsH1zw8I1HyiN
         4yFwFC6l8Cs0gI49RDWu6mJT3MuCQxHo7HnjxmnuWR4sJ6QL2VLWQ8W3f6gGe/me6W
         kEid+q1ujxyvkqL8mEaMU74X2qU68FLZen6C0gPI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC88341B1D; Thu, 13 Dec 2018 09:41:54 -0300 (-03)
Date:   Thu, 13 Dec 2018 09:41:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <20181213124154.GF21027@kernel.org>
References: <1544513908-16805-1-git-send-email-leo.yan@linaro.org>
 <1544513908-16805-7-git-send-email-leo.yan@linaro.org>
 <20181213123854.GE21027@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213123854.GE21027@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 13, 2018 at 09:38:54AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 11, 2018 at 03:38:26PM +0800, Leo Yan escreveu:
> > CoreSight tracer driver might insert barrier packet between different
> > buffers, thus the decoder can spot the boundaries based on the barrier
> > packet; the decoder is possible to hit a barrier packet and emit a
> > NO_SYNC element, then the decoder will find a periodic synchronisation
> > point inside that next trace block that starts trace again but does not
> > have the TRACE_ON element as indicator - usually because this block of
> > trace has wrapped the buffer so we have lost the original point that
> > trace was enabled.
> > 
> > In upper case, it results in the trace stream only inserts the
> > OCSD_GEN_TRC_ELEM_NO_SYNC element in the middle of tracing stream, but
> > we don't handle NO_SYNC element properly and at the end users miss to
> > see the info for trace discontinuity.
> 
> 
> "In upper case"? Maybe:
> 
> In the former case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
> in the middle of the the tracing stream, but as we were npt handling the
> NO_SYNC element properly which ends up making users miss the
> discontinuity indication"?

> > Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
> > output from the decoder, but both of them indicate the trace data is
> 
> can we remove the "but" and "of them" (redundant) above?
> 
> > discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as trace
>                                                                a
> > discontinuity and generates CS_ETM_DISCONTINUITY packet for it, so
> > cs-etm can handle discontinuity for this case, finally it saves the last
>                        it (way too many "discontinuity")
> > trace data for previous trace block and restart samples for new block.

I've tentatively done those changes (and a few more) in my local branch,
resulting in the wording below, plese let me know if you are ok with it:


commit 148068b45fe2e93b19c06cfc1140ea12ca72eb59
Author: Leo Yan <leo.yan@linaro.org>
Date:   Tue Dec 11 15:38:26 2018 +0800

    perf cs-etm: Treat NO_SYNC element as trace discontinuity
    
    The CoreSight tracer driver might insert a barrier packets between
    different buffers, thus the decoder can spot the boundaries based on the
    barrier packet; it is possible for the decoder to hit a barrier packet
    and emit a NO_SYNC element, then the decoder will find a periodic
    synchronisation point inside that next trace block that starts the trace
    again but does not have the TRACE_ON element as indicator - usually
    because this trace block has wrapped the buffer so we have lost the
    original point when the trace was enabled.
    
    In the first case it causes the insertion of a OCSD_GEN_TRC_ELEM_NO_SYNC
    in the middle of the the tracing stream, but as we were npt handling the
    NO_SYNC element properly which ends up making users miss the
    discontinuity indication"?
    
    Though OCSD_GEN_TRC_ELEM_NO_SYNC is different from CS_ETM_TRACE_ON when
    output from the decoder, both indicate that the trace data is
    discontinuous; this patch treats OCSD_GEN_TRC_ELEM_NO_SYNC as a trace
    discontinuity and generates a CS_ETM_DISCONTINUITY packet for it, so
    cs-etm can handle the discontinuity for this case, finally it saves the
    last trace data for the previous trace block and restart samples for the
    new block.
    
    Signed-off-by: Leo Yan <leo.yan@linaro.org>
    Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Mike Leach <mike.leach@linaro.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Robert Walker <robert.walker@arm.com>
    Cc: coresight ml <coresight@lists.linaro.org>
    Cc: linux-arm-kernel@lists.infradead.org
    Link: http://lkml.kernel.org/r/1544513908-16805-7-git-send-email-leo.yan@linaro.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 1039f364f4cc..bee026e76a4c 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -410,7 +410,6 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 	case OCSD_GEN_TRC_ELEM_UNKNOWN:
 		break;
 	case OCSD_GEN_TRC_ELEM_NO_SYNC:
-		break;
 	case OCSD_GEN_TRC_ELEM_TRACE_ON:
 		resp = cs_etm_decoder__buffer_discontinuity(decoder,
 							    trace_chan_id);


