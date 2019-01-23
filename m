Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507FCC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E2321872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 23:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S2rYUEe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfAWXg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 18:36:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34261 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfAWXg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 18:36:28 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so3633558otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 15:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QgTSh/+JhjfhoRAVqlJpbLvU8QVS+PcVDsomILGRKcM=;
        b=S2rYUEe5Gg36HKoxxQpFOyq4GGXWgwHD8V9Ce+qrikAh39Q6d81H4YGe53YU8dr/u2
         P77Nxq9BO9bin3GpLlu9Q8+foXiYkcGMDZ7Vea8Xp0pH37r5ZykAWVUICM4dupYZNikc
         A4GDWqvb25H/7eVRoDPcrsMmhNTIrJIUm0Kng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QgTSh/+JhjfhoRAVqlJpbLvU8QVS+PcVDsomILGRKcM=;
        b=H0Du7paAvPbjVFv3r18JhLjVWNRyZiEjieIWz8Enc9MigTFuzAEiUQZ2cCXS2TrhV3
         bok4xkCACQ2cV9mg8wfOS+sEtCSPEhdZRz57vGRZm4mXeQTUI/4H6PD7nmqaO0dmD5Uj
         NZ/00I001nyNaYGGqweIgfxJLTv6bDGY3ptEY/Jz5AVo4at+wk+1lRUoLS7WYC2hlWPt
         bpysE3gE3FWLyeDbDa3XxLlDDP+rMT8bQWxxmpf0X8REpncQ4YRY+ipNb/2IrCUmt2Wv
         IEEU4yDLZtNRZLO9c+lv3P6AkUoU45LUcYvcqxrLUgWYu4QiACZ4GLRKRTdyMIZDJB9Q
         JEwA==
X-Gm-Message-State: AJcUukcgmXZsF5IbUztPWgqfE121hdnmgn8voKohNNbIufDWBnuvEM14
        +2h5gmRLlzzkYax7AMdmCSfG2w==
X-Google-Smtp-Source: ALg8bN661jvI7A05kBajrkbBlCmj46PLxlAJ0SiJrVet9moMhv9yMdpONwJ5AWpPYwy63C9TjQpENA==
X-Received: by 2002:a9d:22a:: with SMTP id 39mr2900152otb.354.1548286586617;
        Wed, 23 Jan 2019 15:36:26 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1118-108.members.linode.com. [45.79.19.108])
        by smtp.gmail.com with ESMTPSA id s17sm9124333otp.36.2019.01.23.15.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:36:25 -0800 (PST)
Date:   Thu, 24 Jan 2019 07:36:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v6 8/8] perf cs-etm: Set sample flags for exception
 return packet
Message-ID: <20190123233619.GA3268@leoy-ThinkPad-X240s>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-9-leo.yan@linaro.org>
 <20190123215114.GH620@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123215114.GH620@xps15>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Wed, Jan 23, 2019 at 02:51:14PM -0700, Mathieu Poirier wrote:
> On Sat, Jan 19, 2019 at 09:43:47AM +0800, Leo Yan wrote:
> > When return from exception, we need to distinguish if it's system call
> > return or for other type exceptions for setting sample flags.  Due to
> > the exception return packet doesn't contain exception number, so we
> > cannot decide sample flags based on exception number.
> > 
> > On the other hand, the exception return packet is followed by an
> > instruction range packet; this range packet deliveries the start address
> > after exception handling, we can check if it is a SVC instruction just
> > before the start address.  If there has one SVC instruction is found
> > ahead the return address, this means it's an exception return for system
> > call; otherwise it is an normal return for other exceptions.
> > 
> > This patch is to set sample flags for exception return packet, firstly
> > it simply set sample flags as PERF_IP_FLAG_INTERRUPT for all exception
> > returns since at this point it doesn't know what's exactly the exception
> > type.  We will defer to decide if it's an exception return for system
> > call when the next instruction range packet comes, it checks if there
> > has one SVC instruction prior to the start address and if so we will
> > change sample flags to PERF_IP_FLAG_SYSCALLRET for system call
> > return.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 052805de6513..7547a7178f46 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1372,6 +1372,20 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
> >  		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
> >  			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
> >  					      PERF_IP_FLAG_TRACE_BEGIN;
> > +
> > +		/*
> > +		 * If the previous packet is an exception return packet
> > +		 * and the return address just follows SVC instuction,
> > +		 * it needs to calibrate the previous packet sample flags
> > +		 * as PERF_IP_FLAG_SYSCALLRET.
> > +		 */
> > +		if (prev_packet->flags == (PERF_IP_FLAG_BRANCH |
> > +					   PERF_IP_FLAG_RETURN |
> > +					   PERF_IP_FLAG_INTERRUPT) &&
> 
> Would it make more sense to just look for prev-packet->sample_type ==
> CS_ETM_EXCEPTION_RET ?

We cannot check 'prev-packet->sample_type == CS_ETM_EXCEPTION_RET',
since CS_ETM_EXCEPTION_RET is associated to its previous instruction
range packet but not a standalone instruction range packet, we don't
swap for exception and exception return packets, 'prev_packet' is
pointed to the previous instruction range packet at here.

This is why we need to use 'prev_packet->flags' but not
'prev_packet->sample_type' as checking condition.

Thanks,
Leo Yan

> > +		    cs_etm__is_svc_instr(etmq, packet, packet->start_addr))
> > +			prev_packet->flags = PERF_IP_FLAG_BRANCH |
> > +					     PERF_IP_FLAG_RETURN |
> > +					     PERF_IP_FLAG_SYSCALLRET;
> >  		break;
> >  	case CS_ETM_DISCONTINUITY:
> >  		/*
> > @@ -1422,6 +1436,36 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
> >  			prev_packet->flags = packet->flags;
> >  		break;
> >  	case CS_ETM_EXCEPTION_RET:
> > +		/*
> > +		 * When the exception return packet is inserted, since
> > +		 * exception return packet is not used standalone for
> > +		 * generating samples and it's affiliation to the previous
> > +		 * instruction range packet; so set previous range packet
> > +		 * flags to tell perf it is an exception return branch.
> > +		 *
> > +		 * The exception return can be for either system call or
> > +		 * other exception types; unfortunately the packet doesn't
> > +		 * contain exception type related info so we cannot decide
> > +		 * the exception type purely based on exception return packet.
> > +		 * If we record the exception number from exception packet and
> > +		 * reuse it for excpetion return packet, this is not reliable
> > +		 * due the trace can be discontinuity or the interrupt can
> > +		 * be nested, thus the recorded exception number cannot be
> > +		 * used for exception return packet for these two cases.
> > +		 *
> > +		 * For exception return packet, we only need to distinguish the
> > +		 * packet is for system call or for other types.  Thus the
> > +		 * decision can be deferred when receive the next packet which
> > +		 * contains the return address, based on the return address we
> > +		 * can read out the previous instruction and check if it's a
> > +		 * system call instruction and then calibrate the sample flag
> > +		 * as needed.
> > +		 */
> > +		if (prev_packet->sample_type == CS_ETM_RANGE)
> > +			prev_packet->flags = PERF_IP_FLAG_BRANCH |
> > +					     PERF_IP_FLAG_RETURN |
> > +					     PERF_IP_FLAG_INTERRUPT;
> > +		break;
> >  	case CS_ETM_EMPTY:
> >  	default:
> >  		break;
> > -- 
> > 2.17.1
> > 
