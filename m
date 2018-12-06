Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5451EC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B412146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 05:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I34AoiPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B412146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeLFFdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 00:33:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40656 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeLFFdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 00:33:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so15052604wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 21:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K/0v5WsEOS95YHMihmb1ceT2OejWWg9+cldLrWV4ZHU=;
        b=I34AoiPZd47vges221fbfioEoynXNeS9nxQwaLH6gvIl51B+SDrBrD9yHIhnTQJrG1
         kobyw78oQS4V66Otur0YRMnZxV81wySUV5iIQ8nJ4R3W39S1an+mY+P35FiFR3L2in8V
         gjJmxBOESxrK2FVLhKjhCeC5OTBqMYVdKJWTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/0v5WsEOS95YHMihmb1ceT2OejWWg9+cldLrWV4ZHU=;
        b=RGQxCA4rhfWkcxM5VipE9uBY8u9Ki2QtXO4A3wPpAJYQajDnUZzYX5insR8KylZzxS
         rH1r1untup/er3h5iP/DipovEkp7hnySm/tinz+RUfthfs08njnLekoaGTT5EYk5FWwL
         3R1FZvZqrAoNGNlYXKuCWwl4eZ7ebRmnah24GhELGSTfZgJ4OxDhjVfbJMQOlxSwq7UN
         9OdssefQ07Tz3kdF52g41yTuDZY/W+F4vmdgHPJLO5bRLeGlncdDrhjGs+2L3whzxTJr
         7UC0gGpAFcGEXeY+bR/lqRXjFTuMPOJXdIpTlWPyLlrjxvPF5TLncUkaNcfPV6vvNbsZ
         H53A==
X-Gm-Message-State: AA+aEWbvO9XXGnu4B4pDqFEO3Ybhu39ChrUy2U2HbPdqgriee3uV7Hci
        UKnG6G+BDc2GUTImcFoEKn5TnA==
X-Google-Smtp-Source: AFSGD/X0xieekHvJaABdiU0HaCJvLwu4fO8IyDgjePpY+LjFxr0Z5WnuhSWys1DyfdIKku9Ge4tuNA==
X-Received: by 2002:a1c:c10f:: with SMTP id r15mr11818176wmf.27.1544074391720;
        Wed, 05 Dec 2018 21:33:11 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id j202sm20927950wmf.15.2018.12.05.21.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 21:33:10 -0800 (PST)
Date:   Thu, 6 Dec 2018 13:33:03 +0800
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
        Coresight ML <coresight@lists.linaro.org>,
        Andi Kleen <andi@firstfloor.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 1/2] perf cs-etm: Set branch instruction flags in
 packet
Message-ID: <20181206053303.GA4244@leoy-ThinkPad-X240s>
References: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
 <1541912876-20967-2-git-send-email-leo.yan@linaro.org>
 <20181119222617.GA5628@xps15>
 <20181205062550.GC15964@leoy-ThinkPad-X240s>
 <CANLsYkzTJdKtXBwMMLStgjoUEKz8nsvOpKYcoULh7kHejGAGsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzTJdKtXBwMMLStgjoUEKz8nsvOpKYcoULh7kHejGAGsg@mail.gmail.com>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:40:07AM -0700, Mathieu Poirier wrote:

[...]

> > > >  static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> > > >                             const void *context,
> > > >                             const ocsd_trc_index_t indx __maybe_unused,
> > > > @@ -484,6 +650,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
> > > >             break;
> > > >     }
> > > >
> > > > +   cs_etm_decoder__set_sample_flags(context, elem);
> > > > +
> > >
> > > I was toying with the idea of setting the flags in each of the case statement
> > > found in cs_etm_decoder__gen_trace_elem_printer().  But that would move more
> > > code around and the end result would be the same so let's keep it that way until
> > > we have a good reason to split it.
> >
> > Do you sugguest to keep current implementation rather than to
> > split flags setting in each of the case statement in
> > cs_etm_decoder__gen_trace_elem_printer()?
> >
> > I am not 100% sure if I understand correctly for "split it" (split flags
> > setting vs split functions).  So please correct me if I misunderstand
> > this.
> 
> I find function cs_etm_decoder__set_sample_flags() overly long.  Since
> the case statements in it are the same as the ones in
> cs_etm_decoder__gen_trace_elem_printer() a different way to proceed
> would be to do flag setting there rather than all in
> cs_etm_decoder__set_sample_flags().  But that would introduce more
> code modification and tighter coupling.  Since I don't have another
> alternative I am suggesting to keep the current implementation.

Thanks for clarification.
