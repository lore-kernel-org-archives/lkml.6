Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE0FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91BD213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KEyepbLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91BD213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbeLEGim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:38:42 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:41662 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbeLEGim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:38:42 -0500
Received: by mail-wr1-f45.google.com with SMTP id x10so18382423wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 22:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YaiSxZ5zkOGPVEb7SNIkGxQnViLDgHomOE3rkzH+wJQ=;
        b=KEyepbLfn5jgV2F/LPX1AhONZV1ZhSYUqc9vpS9PODTbg4yDlHzDBVaC2JHadV0X+Y
         dudr3lrwALsby41XvGFezJtr7Ufsf+EBNykIzCiGWoQzNVcoBQO6GgScrd2VKLv4cqa3
         5bOoUw1WU8SxOmPkr3ES8cwADkVOj+p69XXAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YaiSxZ5zkOGPVEb7SNIkGxQnViLDgHomOE3rkzH+wJQ=;
        b=Gc9zzkoqXNEUOlsflC7zLKhzN//jWJUEZrs1pF+kN+otVP0IkmmgC4NSPrlJmmRKnl
         Z56/OGw72AdnxqBGZ5B3eJfjP2djP6WJ4yb49JiSdNXPI1atPFY0x+eFfm1huTjg22q6
         a/yktFQdU5ZG1Fmu57HFbBtPE2qYzLo2dd2mRZ0V2eR7xaw95doHl3YwyQ3jGujv10af
         /z/obHYukCkucUDU5C4nKcDKQ0lk78yswJVK1NmK4ixJJH5a2RVMPb0HLP5Fpc5HwQ0p
         kH/LztsdQu8ZDi3tcx8sN+xa1DvMjF0/Ve56Z6qV96hVUej+CUbyEM2IUlfJOVxr1VB2
         W/7A==
X-Gm-Message-State: AA+aEWZonRDTynZOOmdnx6b3AxrwBpXn9fp2bP3iSPAHwtMabvPOqFHB
        BBglaKB62aX+go3hdW7YpCJUQA==
X-Google-Smtp-Source: AFSGD/UIBxZhPvwSzO4XP9p0z5SPl3sTHAnRmegI2zn8LoIhY6PXVWK5gLRTW52hhnRmgK2M+jx1cA==
X-Received: by 2002:a5d:49cd:: with SMTP id t13mr6227276wrs.144.1543991920382;
        Tue, 04 Dec 2018 22:38:40 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id k135sm18248835wmd.42.2018.12.04.22.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 22:38:39 -0800 (PST)
Date:   Wed, 5 Dec 2018 14:38:32 +0800
From:   leo.yan@linaro.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Al Grant <Al.Grant@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v2 2/2] perf cs-etm: Add support sample flags
Message-ID: <20181205063832.GD15964@leoy-ThinkPad-X240s>
References: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
 <1541912876-20967-3-git-send-email-leo.yan@linaro.org>
 <20181119232202.GA7001@xps15>
 <CANLsYkxQVpSP1D2M_bCni=nkZyo4qC=d33bWC1Xy0_vDfX9Agg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkxQVpSP1D2M_bCni=nkZyo4qC=d33bWC1Xy0_vDfX9Agg@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 09:53:41AM -0700, Mathieu Poirier wrote:

[...]

> > > +static void cs_etm__fixup_flags(struct cs_etm_queue *etmq)
> > > +{
> > > +     /*
> > > +      * Decoding stream might insert one TRACE_OFF packet in the
> > > +      * middle of instruction packets, this means it doesn't
> > > +      * contain the pair packets with TRACE_OFF and TRACE_ON.
> > > +      * For this case, the instruction packet follows with
> > > +      * TRACE_OFF packet so we need to fixup prev_packet with flag
> > > +      * PERF_IP_FLAG_TRACE_BEGIN, this flag finally is used by the
> > > +      * instruction packet to generate samples.
> > > +      */
> > > +     if (etmq->prev_packet->sample_type == CS_ETM_TRACE_OFF &&
> > > +         etmq->packet->sample_type == CS_ETM_RANGE)
> > > +             etmq->prev_packet->flags = PERF_IP_FLAG_BRANCH |
> > > +                                        PERF_IP_FLAG_TRACE_BEGIN;
> > > +
> > > +     if (etmq->prev_packet->sample_type == CS_ETM_RANGE) {
> > > +             /*
> > > +              * When the exception packet is inserted, update flags
> > > +              * so tell perf it is exception related branches.
> > > +              */
> > > +             if (etmq->packet->sample_type == CS_ETM_EXCEPTION ||
> > > +                 etmq->packet->sample_type == CS_ETM_EXCEPTION_RET)
> > > +                     etmq->prev_packet->flags = etmq->packet->flags;
> > > +
> > > +             /*
> > > +              * The trace is discontinuous, weather this is caused by
> > > +              * TRACE_ON packet or TRACE_OFF packet is coming, if the
> > > +              * previous packet is instruction packet, simply set flag
> > > +              * PERF_IP_FLAG_TRACE_END for previous packet.
> > > +              */
> > > +             if (etmq->packet->sample_type == CS_ETM_TRACE_ON ||
> > > +                 etmq->packet->sample_type == CS_ETM_TRACE_OFF)
> > > +                     etmq->prev_packet->flags |= PERF_IP_FLAG_TRACE_END;
> > > +     }
> > > +}
> > > +
> >
> > I think it would be better to keep all the flag related processing in
> > cs-etm-decoder.c so that things in cs-etm.c are only concered with dealing with
> > perf.
> >
> > Look at function cs_etm__alloc_queue(), there you'll find "d_params.data = etmq".
> >
> > In function cs_etm_decoder__new(), decoder->data = d_params->data;
> >
> > This means that anywhere you have a decoder, decoder->data is an etmq.  I've
> > used this profusely in my work on CPU-wide trace scenarios.  Because you're
> > getting there ahead of me you'll need to fix the declaration of struct
> > cs_etm_queue but that's easy.
> 
> I've been thinking further about this and manipulating the etmq packet
> and prev_packet from the cs-etm-decoder.c won't work because all we
> have at that time is the decoder's packet queue.  My goal is to
> manipulate the flags in only one place - either in cs-etm.c or
> cs-etm-decoder.c but not in both.  It might be worth trying to do the
> implementation in cs-etm.c since there is already a lot of packet flow
> intelligence happening there.

Agree.  cs-etm.c has more context info than cs-etm-decoder.c, will
try to refactor in single place in cs-etm.c.

[...]

Thanks,
Leo Yan
