Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52ACEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0045C20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 03:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bj8ToTz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0045C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeLEDuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 22:50:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41568 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLEDuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 22:50:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so18114232wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 19:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MzhuMjMGrWaYPBgj7NxnknHks4PiChgmdxDKPESvPbc=;
        b=bj8ToTz0U/XeuaDa194Kl5Fl8S7aXHODD+Ff7zXQmX6p4ifH4Y/OPI5I/f0rCJWtme
         Yq0mg3AGrXPioOAY6IqTuIHcLHCulJcFpDRInk9BPvuscwmlAqwh+rWAvUA7jnT7idkZ
         unhkBB09ZourdALAM9IH0NIgtUAL8XW52qnOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MzhuMjMGrWaYPBgj7NxnknHks4PiChgmdxDKPESvPbc=;
        b=ohiz6Pq/mf9VOcheEVyks2glpm1iXmuIBaZeXoKMoRP9T9A+8St7tLEnZdoUo5BWAb
         aHjbFw2if1VfMQsYdK4LqTDtkK0bsFh+RFQyC7pUlrnOTCd0ySLXSB2dG+rzsrLOKvIn
         lhHdrA269ZtQ7dxxVdQfFJnC/VOkNRr++eEgDMVE+GZ0R/hUeJCkgtBZyAZwH+tWmGn5
         AR1ht9Xci5QwfkMY5UtLe6DjFVw01k8NTcygjQ+Ehb1nLH+2Q78tbzsZg7LHxIzdeb9F
         RxonyE1rYmVq7Vq8KerGkx9P38KOJICZcDleb3lNhilr4XYEP7bKO/tWUxRsGUHeP9bw
         vf0w==
X-Gm-Message-State: AA+aEWbhKtlQ1wRl2j38M7ialm0zqqnNRof+WHBgTt0Sr/urjHhj5nla
        RQO+mqidda5DWxxn6tr8VfXgDQ==
X-Google-Smtp-Source: AFSGD/W5ZXFHJS9SIZlY4c7hLN0kpMIFwaRXz5fh+wyBPSX2RK0gyp5GQwHplqzUevvj1yrL7cQFEA==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr20015207wrv.288.1543981797276;
        Tue, 04 Dec 2018 19:49:57 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id y13sm3195946wrn.73.2018.12.04.19.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 19:49:56 -0800 (PST)
Date:   Wed, 5 Dec 2018 11:49:50 +0800
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
Subject: Re: [PATCH v1 5/5] perf cs-etm: Track exception number
Message-ID: <20181205034950.GB15964@leoy-ThinkPad-X240s>
References: <1541912383-19915-1-git-send-email-leo.yan@linaro.org>
 <1541912383-19915-6-git-send-email-leo.yan@linaro.org>
 <20181119204749.GB608@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119204749.GB608@xps15>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 01:47:49PM -0700, Mathieu Poirier wrote:
> On Sun, Nov 11, 2018 at 12:59:43PM +0800, Leo Yan wrote:
> > When an exception packet comes, it contains the info for exception
> > number; the exception number indicates the exception types, so from it
> > we can know if the exception is taken for interrupt, system call or
> > other traps, etc.  But because the exception return packet cannot
> > delivery exception number correctly by decoder thus when prepare sample
> > flags we cannot know what's type for exception return.
> > 
> > This patch adds a new 'exc_num' array in decoder structure to record
> > exception number per CPU, the exception number is recorded in the array
> > when the exception packet comes and this exception number can be used by
> > exception return packet.  If detect there have discontinuous trace with
> > TRACE_ON or TRACE_OFF packet, the exception number is set to invalid
> > value.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 67 ++++++++++++++++++++++---
> >  1 file changed, 59 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > index b8cb7a3e..d1a6cbc 100644
> > --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> > @@ -43,6 +43,7 @@ struct cs_etm_decoder {
> >  	u32 packet_count;
> >  	u32 head;
> >  	u32 tail;
> > +	u32 *exc_num;
> >  	struct cs_etm_packet packet_buffer[MAX_BUFFER];
> >  };
> >  
> > @@ -368,24 +369,64 @@ static ocsd_datapath_resp_t
> >  cs_etm_decoder__buffer_trace_off(struct cs_etm_decoder *decoder,
> >  				 const uint8_t trace_chan_id)
> >  {
> > -	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > -					     CS_ETM_TRACE_OFF);
> > +	int ret;
> > +	struct cs_etm_packet *packet;
> > +
> > +	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > +					    CS_ETM_TRACE_OFF);
> > +	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > +		return ret;
> > +
> > +	packet = &decoder->packet_buffer[decoder->tail];
> > +
> > +	/* Clear execption number for discontinuous trace */
> > +	decoder->exc_num[packet->cpu] = UINT32_MAX;
> > +
> > +	return ret;
> >  }
> >  
> >  static ocsd_datapath_resp_t
> >  cs_etm_decoder__buffer_trace_on(struct cs_etm_decoder *decoder,
> >  				const uint8_t trace_chan_id)
> >  {
> > -	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > -					     CS_ETM_TRACE_ON);
> > +	int ret;
> > +	struct cs_etm_packet *packet;
> > +
> > +	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > +					    CS_ETM_TRACE_ON);
> > +	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > +		return ret;
> > +
> > +	packet = &decoder->packet_buffer[decoder->tail];
> > +
> > +	/* Clear execption number for discontinuous trace */
> > +	decoder->exc_num[packet->cpu] = UINT32_MAX;
> > +
> > +	return ret;
> >  }
> >  
> >  static ocsd_datapath_resp_t
> >  cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
> > +				 const ocsd_generic_trace_elem *elem,
> >  				 const uint8_t trace_chan_id)
> >  {
> > -	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > -					     CS_ETM_EXCEPTION);
> > +	int ret;
> > +	struct cs_etm_packet *packet;
> > +
> > +	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
> > +					    CS_ETM_EXCEPTION);
> > +	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
> > +		return ret;
> > +
> > +	packet = &decoder->packet_buffer[decoder->tail];
> > +
> > +	/*
> > +	 * Exception number is recorded per CPU and later can be used
> > +	 * for exception return instruction analysis.
> > +	 */
> > +	decoder->exc_num[packet->cpu] = elem->exception_number;
> 
> Am I missing something or the information about the exception number that is
> recorded here isn't used anywhere?

The exception number will be used to set branch flag patch [1].
According to exception number we can know it's for system call,
interrupt or other traps.

[1] http://archive.armlinux.org.uk/lurker/message/20181111.050755.d1c1b257.en.html

> If you want to use this in perf report/script,
> the exception number will have to be added to the cs_etm_packet struct.

Actually before has discussed this with Mike but found it's hard to
save the exception number in cs_etm_packet struct.  The reason is the
exception packet contains the correct exception number, but the
exception return packet doesn't contain exception number.  Thus this
patch uses cs_etm_decoder struct to save exception number per CPU
context when receive exception packet, and later the saved exception
number will be used by exception return packet.

Please see related discussion at the end of page [2].

[2] https://lists.linaro.org/pipermail/coresight/2018-October/001832.html

> I am done with the revision of this set.

Thanks a lot for reviewing.

[...]

Thanks,
Leo Yan
