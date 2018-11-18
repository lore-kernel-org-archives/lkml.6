Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0192CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 06:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B194520815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 06:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dg4jEBV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B194520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeKRQ6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 11:58:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51141 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeKRQ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 11:58:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id 125so236459wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 22:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dD7BzDCnhRhOgR3C0f/N2/i+PDSNifRbl9oSl1vDRvY=;
        b=Dg4jEBV3YSL6wxWztr1TdxDMq6YmHT1tFBNCxvvsdWzTH+lpKEhAiLCHuD+u9G1mMs
         3/uGhv8N4q9O/cHNoBcEMEXaC3L5PchboLKPPvjFBFsIfJIl2YYsUxpbf8/eR9Q7k7P4
         MQvWMz7jtkC+c4eofmrZ0CNQoSHdVW762OYfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dD7BzDCnhRhOgR3C0f/N2/i+PDSNifRbl9oSl1vDRvY=;
        b=AprX714WPbcXQAkW2rT7a7vdhQhYc2hemWd5f9JL7tfjYk76YuSebeLBBtXAkdbxDN
         exnXGR6xNCok5qp4M0/J1ZoEm9ifFUuOLWc2vSoMqX1GiNaxKi31PBhuzFFa9CZUtxHl
         F63bDOHiBN08ogYOlax4YiLC32rTBTDbSTGeaP8evaxSFwWRNqDVOYwCdeJOjM0iiGfw
         g8xv5UFMcnXDvnUnweAbyJ7Gwuz4zjwvvQSeQju5jezZj0o5WQNrB/JkAsT7nkr9rzrl
         dHNhnfP9fxHbu7YrGvU75DYuLiiwCzI5YjAXfS37YYM5OFNEqOLgkPhMe90ZRuHSc8NK
         jNyA==
X-Gm-Message-State: AGRZ1gI4Wm2KIbbNu9wKv7lld22HNyCPaf8ZsH71RHT9lm4/IuXwtPkM
        rGhfD+QgmNC1CKh0VABhVD3pWA==
X-Google-Smtp-Source: AFSGD/U/5ehsBcTfQIY55lNhIP6QX5ySHnAx/xJAs/edQPcqxysM+G/Ut8LmloPMcnr5S5vOVSoeog==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr3150907wme.21.1542523137521;
        Sat, 17 Nov 2018 22:38:57 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id 133sm6193420wme.9.2018.11.17.22.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 22:38:56 -0800 (PST)
Date:   Sun, 18 Nov 2018 14:38:48 +0800
From:   leo.yan@linaro.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
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
Message-ID: <20181118063848.GA8751@leoy-ThinkPad-X240s>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-3-git-send-email-leo.yan@linaro.org>
 <20181116230511.GB25258@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116230511.GB25258@xps15>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 04:05:11PM -0700, Mathieu Poirier wrote:

[...]

> > -static int cs_etm__flush(struct cs_etm_queue *etmq)
> > +static int cs_etm__flush(struct cs_etm_queue *etmq, bool new_packet)
> >  {
> >  	int err = 0;
> >  	struct cs_etm_auxtrace *etm = etmq->etm;
> > @@ -989,6 +989,20 @@ static int cs_etm__flush(struct cs_etm_queue *etmq)
> >  
> >  	}
> >  
> > +	/*
> > +	 * If 'new_packet' is false, this time call has no a new packet
> > +	 * coming and 'etmq->packet' contains the stale packet which is
> > +	 * set at the previous time with packets swapping.  In this case
> > +	 * this function is invoked only for flushing branch stack at
> > +	 * the end of buffer handling.
> > +	 *
> > +	 * Simply to say, branch samples should be generated when every
> > +	 * time receive one new packet; otherwise, directly bail out to
> > +	 * avoid generate branch sample with stale packet.
> > +	 */
> > +	if (!new_packet)
> > +		return 0;
> > +
> >  	if (etm->sample_branches &&
> >  	    etmq->prev_packet->sample_type == CS_ETM_RANGE) {
> >  		err = cs_etm__synth_branch_sample(etmq);
> > @@ -1075,7 +1089,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
> >  					 * Discontinuity in trace, flush
> >  					 * previous branch stack
> >  					 */
> > -					cs_etm__flush(etmq);
> > +					cs_etm__flush(etmq, true);
> >  					break;
> >  				case CS_ETM_EMPTY:
> >  					/*
> > @@ -1092,7 +1106,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
> >  
> >  		if (err == 0)
> >  			/* Flush any remaining branch stack entries */
> > -			err = cs_etm__flush(etmq);
> > +			err = cs_etm__flush(etmq, false);
> 
> I understand what you're doing and it will yield the correct results.  What I'm
> not sure about is if we wouldn't be better off splitting cs_etm__flush()
> in order to reduce the complexity of the main decoding loop.  That is rename
> cs_etm__flush() to something like cs_etm__trace_on() and spin off a new
> cs_etm__end_block().  
> 
> It does introduce a little bit of code duplication but I think we'd win in terms
> of readability and flexibility.

Thanks for reviewing, Mathieu.

I agree with your suggestion to split cs_etm__flush() into two
functions,  will spin this patch with the suggestion in next
series for reviewing.

Thanks,
Leo Yan
