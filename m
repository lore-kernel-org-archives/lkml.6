Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EDFC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684302081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jd2XerM9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684302081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbeLEC6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:58:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35787 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEC6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 21:58:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so18072292wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 18:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JtHvc1wKR8UzHTWCRtECIwbWEcC9WmtTV1sPBssAB/8=;
        b=jd2XerM9WriBcE6UWG5K+DgtOKnCM5pYBNbTHSuHJZt7/xbuBc2ndhYzORMnpLFOkY
         sjHBYAboFCueFIbGZy38z6mkZ8CDt1/3b24ZjbtyoAFhRH9Ci3aO1bBR3o0krWw/us/R
         Y0bXKhiKav/++dV38NcUYRTuUK5ATnRZOf6PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JtHvc1wKR8UzHTWCRtECIwbWEcC9WmtTV1sPBssAB/8=;
        b=LIbw7oLyUagNJwZ4guK0Zdj6fhM0gkBUYLTsBtMN2092vub4oVAwACoXHRgNGxPzyv
         zJZZn0mKtUEZLLeQIkrUzrvuXxd7colAoa3o19bz89AwuOzbg8ghlDAyD6LRPiEhdrP4
         fUxXwBsMGL4dimYWzHrbZbOHIGTIpLKcM9IKZ8yiMIu/2RI1+EgV9TofYt0TSaEVaDr3
         YKMsNu6G0Jzu/T6zG5g4zuu/EQJyxq7fI7lPvByl4pZPAyW6I52qqqYkuIzYVeF/ExdC
         Nrcrss82d05A5R/VrlvbjXhr5XXi8RoSznabESQvEJUIOwrzYFOK3YJDOvH5chSqTE9E
         5jBA==
X-Gm-Message-State: AA+aEWbJKmffPt4yaEG0phBvILNNV22jH62bJPcMooUIoHicwxbJkcGm
        yq1+JaJ1ztWiAIIsiTPOxLSObQ==
X-Google-Smtp-Source: AFSGD/UYNE+Z9Y+lPzomXCXMPB4q8JvtSTdyv/YDAGH96l05K0+ArBt+APEwc4U1f9R3ikyIpNAjgQ==
X-Received: by 2002:adf:c612:: with SMTP id n18mr19396951wrg.174.1543978720427;
        Tue, 04 Dec 2018 18:58:40 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id t6sm16910200wru.11.2018.12.04.18.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 18:58:39 -0800 (PST)
Date:   Wed, 5 Dec 2018 10:58:32 +0800
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
Message-ID: <20181205025832.GA13305@leoy-ThinkPad-X240s>
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

Sorry for long delay, Mathieu.

Agree with the idea of splitting cs_etm__flush() into two functions.
Will spin patch for new version.

Thanks,
Leo Yan

> >  	}
> >  
> >  	return err;
> > -- 
> > 2.7.4
> > 
