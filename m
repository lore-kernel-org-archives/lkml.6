Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765AAC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7D2253CA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WlZMrY8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7D2253CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeGBCf6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:35:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39267 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753042AbeGBCfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:35:53 -0400
Received: by mail-pg0-f67.google.com with SMTP id n2-v6so6419811pgq.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 19:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b8PPriMWRG9naR04wUtYox1sKTGzCo4cFOu8fGakX0E=;
        b=WlZMrY8/U1kzvGkhmEgBSY0t9+3SbD9OAVASlP7j8EMlmzeZVce/4CUigTiCtFGdY2
         sdRWyiMNLaAaq1wt1uN5CaRdRYRDr1Dt3sbPFbheagOD9FmrQFsKJ3meBkgWw7XLdzmb
         i4j3Yb9bi9NEhhIf/+XiXcMoXyq8A1/MlFy84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b8PPriMWRG9naR04wUtYox1sKTGzCo4cFOu8fGakX0E=;
        b=ckt6/YReN+veIsUZzm9VVAUtBShJvxFl3abLhOMFTZTv0we5YeIA6uEmPbH3X4NiIh
         zjEerRaEoaWICBbff4i2So0h9yc3QSyB1LQfz4gIkyybzq9IDKr15NQ6eLdFd0PxmLmP
         kR+WNZ2jUONxExpDOvmrc1+Du+rYQIQw29vrXQzIieKCUU1Xv/7m+AwbD10OV5mecA8o
         r3nf3iNyMrM7NPx5ixZ+xyG4rtT0LsSVpU9kAU4vGdEnBeymwIyo9Tg5Pzzj1Thr3t8U
         jKXvfqFSkSOL+r/6HohTWAY73u8u3fgcWXby8wGSZTysdySoo1BGScRv+2E61wXW68IN
         r8zg==
X-Gm-Message-State: APt69E0qpgUTr0KuuqW5Fs3BkWm7C2fReKx0uxfy2yef+MMCQpe4uHbN
        tCPEJPTb1ZZpQYFrTotOjeUBlg==
X-Google-Smtp-Source: AAOMgped45kDQ8oRhux7Cv386oW1Hq/Ims1CJc2Alzg2vHfzSlLrl32T43jyv4hxY1pAeVyaKs0wCw==
X-Received: by 2002:a63:6383:: with SMTP id x125-v6mr3313148pgb.127.1530498953113;
        Sun, 01 Jul 2018 19:35:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1192-169.members.linode.com. [45.79.93.169])
        by smtp.gmail.com with ESMTPSA id v1-v6sm9338538pfg.101.2018.07.01.19.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 19:35:52 -0700 (PDT)
Date:   Mon, 2 Jul 2018 10:35:45 +0800
From:   leo.yan@linaro.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH v1 0/6] perf cs-etm: Fix tracing packet handling and
 minor refactoring
Message-ID: <20180702023545.GA13629@leoy-ThinkPad-X240s>
References: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
 <CANLsYkyxuz+tPrC7wb1omsw+qj=7ZB5t6FRbqZz54994g62q6g@mail.gmail.com>
 <20180619181943.GL20477@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619181943.GL20477@kernel.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Jun 19, 2018 at 03:19:43PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 19, 2018 at 11:46:02AM -0600, Mathieu Poirier escreveu:
> > On Sun, 17 Jun 2018 at 23:10, Leo Yan <leo.yan@linaro.org> wrote:
> > >
> > > Due the current code is missing to handle cs-etm start tracing packet
> > > and CS_ETM_TRACE_ON packet, we fail to generate branch sample for them.
> > >
> > > This patch series is to fix cs-etm tracing packet handling:
> > >
> > > Patch 0001 is to add invalid address macro for readable coding;
> > >
> > > Patch 0002 is one minor fixing to return error code for instruction
> > > sample failure;
> > >
> > > Patches 0003~0006 are fixing patches for start tracing packet
> > > and CS_ETM_TRACE_ON packet.
> > >
> > > This patch series is applied on acme tree [1] on branch perf/core with
> > > latest commit: e238cf2e3d2e ("perf intel-pt: Fix packet decoding of CYC
> > > packets").  Also applied successfully this patch series on Linus tree
> > > on 4.18-rc1.
> > >
> > > This patch series has been verified on Hikey620 platform with below two
> > > commands:
> > > perf script --itrace=i10000il128 -F cpu,event,ip,addr,sym -k ./vmlinux
> > > perf script -F cpu,event,ip,addr,sym -k ./vmlinux
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> > >
> > >
> > > Leo Yan (6):
> > >   perf cs-etm: Introduce invalid address macro
> > >   perf cs-etm: Bail out immediately for instruction sample failure
> > >   perf cs-etm: Fix start tracing packet handling
> > >   perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
> > >   perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON
> > >     packet
> > >   perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet
> > >
> > >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++--
> > >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
> > >  tools/perf/util/cs-etm.c                        | 71 +++++++++++++++++++++----
> > >  3 files changed, 68 insertions(+), 14 deletions(-)
> > 
> > Good day Arnaldo,
> > 
> > I am good with this set:
> > 
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> > Please consider for inclusion in your tree if you are satisfied with the work.
> 
> I'll take a look and get it into perf/core, now I'm concentrating on
> perf/urgent work.

Gentle ping for this patch series.

I tested this patch series on perf/core branch with latest commit
87b40003b17a ("perf tests: Check that complex event name is parsed
correctly"), this patch series is still valid and can pass testing.

Could you pick up them?  If you want me to resend this patch series,
please let me know.

Thanks,
Leo Yan
