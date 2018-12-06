Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58F8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD222146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OT5slp1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD222146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbeLFFrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:47:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53724 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeLFFrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:47:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so15441211wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 21:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r/LCm/PIII5ixONfxT5d8IeI+92VrPuxYpOqN8TpFlY=;
        b=OT5slp1JSIQiMzeuLnOdPnVBwWYnXEeq8rMeHECnXYR5GtfxycpFt9uOXeEinrksL4
         AQ/nW+RiXoSXy2S6yU/PyKdZsZmX30UUZX1UJy4AdnLruCFxS2n7z8s9PwXL/JJIJwxY
         Xn4c5PhjytNVX2kGuPPhL7LNAfoRfqKVtSmT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/LCm/PIII5ixONfxT5d8IeI+92VrPuxYpOqN8TpFlY=;
        b=ZOIjjJQCPJP1Sx9oGHAxuLVg/aWCunu5qOTaaPdS1UeHxUu9hoLOXM0ATzbBwteG97
         193HzR2ewEYxl7Ym7+iNVyKYIO5QUz0NuBbHzh20CNkPt+NZKuC2b12lKkYy8OXtHcBe
         OYHvJnRE1Nttx6H3wkIpYxmTAk1eoHKtuIRhiaVqKUoWbWOy6ktziwsftF7BO/rF1VDX
         OkdTZCcCTIFj6s+KQd4qqNq0JR1GynQd7IoOEyJAB28ZVPI8m5eAbvg4xR1CIC+HM2y8
         Bf3zQYUq+Yt8qc3h9g8aYtqGPxEP6BJqALKrpBf/+w9yJFH23b8XNJ2k5PImmWzZBwAc
         i/hQ==
X-Gm-Message-State: AA+aEWZeTpegPgcBU7gvEjBJqrKSI6FTAwAn9AZciHuqAD8jXB5TXQnB
        SZnnsrT0VSrZKTYOii7RnFaTQQ==
X-Google-Smtp-Source: AFSGD/UzqxK5925AhONzys+Ms4XgUswpjFmXUX86B0p6l4QsSTy70r0K8RQTak/irpc/5boUSWbrKw==
X-Received: by 2002:a1c:8484:: with SMTP id g126mr19097697wmd.117.1544075265108;
        Wed, 05 Dec 2018 21:47:45 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id m15sm15746598wrr.95.2018.12.05.21.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 21:47:44 -0800 (PST)
Date:   Thu, 6 Dec 2018 13:47:38 +0800
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
Subject: Re: [PATCH v1 5/5] perf cs-etm: Track exception number
Message-ID: <20181206054738.GC4244@leoy-ThinkPad-X240s>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-6-git-send-email-leo.yan@linaro.org>
 <20181119204749.GB608@xps15>
 <20181205034950.GB15964@leoy-ThinkPad-X240s>
 <CANLsYkxY1K-TmJKQb3F=T7MGND5pzOZ5ZrK=UZuVihoOAq5p=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkxY1K-TmJKQb3F=T7MGND5pzOZ5ZrK=UZuVihoOAq5p=w@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 11:03:29AM -0700, Mathieu Poirier wrote:

[...]

> > > >  static ocsd_datapath_resp_t
> > > >  cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
> > > > +                            const ocsd_generic_trace_elem *elem,
> > > >                              const uint8_t trace_chan_id)
> > > >  {
> > > > -   return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > > -                                        CS_ETM_EXCEPTION);
> > > > +   int ret;
> > > > +   struct cs_etm_packet *packet;
> > > > +
> > > > +   ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > > > +                                       CS_ETM_EXCEPTION);
> > > > +   if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > > > +           return ret;
> > > > +
> > > > +   packet = &decoder->packet_buffer[decoder->tail];
> > > > +
> > > > +   /*
> > > > +    * Exception number is recorded per CPU and later can be used
> > > > +    * for exception return instruction analysis.
> > > > +    */
> > > > +   decoder->exc_num[packet->cpu] = elem->exception_number;
> > >
> > > Am I missing something or the information about the exception number that is
> > > recorded here isn't used anywhere?
> >
> > The exception number will be used to set branch flag patch [1].
> 
> Right, I realised that when I started reviewing that set.  The rule of
> thumb here is to introduce code in the same patchset it is used so
> that we avoid adding needless code to the kernel.

Will move this patch into sample flag series.

Thanks,
Leo Yan
