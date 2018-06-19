Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6385BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241A0205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zTNqu0Fn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241A0205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967208AbeFSSTt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967022AbeFSSTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:19:48 -0400
Received: from jouet.infradead.org (179.176.7.12.dynamic.adsl.gvt.net.br [179.176.7.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7060E205C9;
        Tue, 19 Jun 2018 18:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529432387;
        bh=FSxjvmbBgYA2qWx0aQERtINeV4bPNneWazpd/Daj9/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zTNqu0FnGEC2Cqd9dwpabkn6RH7CFtHs0heb9WblyKx4Oao5JpeW4iIvAJYbfHAnu
         x+glLmyIOm94/Vo3BLsFb2IZooGniDULGe/lYtfmBFlGNeSlYZA5/XdOYtaV84wEGO
         ASLIpMAJlr2eRqRuX1xwAD1Ny6BFzM4BK07zjqBI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 9811E1401E5; Tue, 19 Jun 2018 15:19:43 -0300 (-03)
Date:   Tue, 19 Jun 2018 15:19:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
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
Message-ID: <20180619181943.GL20477@kernel.org>
References: <1529298599-3876-1-git-send-email-leo.yan@linaro.org>
 <CANLsYkyxuz+tPrC7wb1omsw+qj=7ZB5t6FRbqZz54994g62q6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkyxuz+tPrC7wb1omsw+qj=7ZB5t6FRbqZz54994g62q6g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 19, 2018 at 11:46:02AM -0600, Mathieu Poirier escreveu:
> On Sun, 17 Jun 2018 at 23:10, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Due the current code is missing to handle cs-etm start tracing packet
> > and CS_ETM_TRACE_ON packet, we fail to generate branch sample for them.
> >
> > This patch series is to fix cs-etm tracing packet handling:
> >
> > Patch 0001 is to add invalid address macro for readable coding;
> >
> > Patch 0002 is one minor fixing to return error code for instruction
> > sample failure;
> >
> > Patches 0003~0006 are fixing patches for start tracing packet
> > and CS_ETM_TRACE_ON packet.
> >
> > This patch series is applied on acme tree [1] on branch perf/core with
> > latest commit: e238cf2e3d2e ("perf intel-pt: Fix packet decoding of CYC
> > packets").  Also applied successfully this patch series on Linus tree
> > on 4.18-rc1.
> >
> > This patch series has been verified on Hikey620 platform with below two
> > commands:
> > perf script --itrace=i10000il128 -F cpu,event,ip,addr,sym -k ./vmlinux
> > perf script -F cpu,event,ip,addr,sym -k ./vmlinux
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> >
> >
> > Leo Yan (6):
> >   perf cs-etm: Introduce invalid address macro
> >   perf cs-etm: Bail out immediately for instruction sample failure
> >   perf cs-etm: Fix start tracing packet handling
> >   perf cs-etm: Support dummy address value for CS_ETM_TRACE_ON packet
> >   perf cs-etm: Generate branch sample when receiving a CS_ETM_TRACE_ON
> >     packet
> >   perf cs-etm: Generate branch sample for CS_ETM_TRACE_ON packet
> >
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++--
> >  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
> >  tools/perf/util/cs-etm.c                        | 71 +++++++++++++++++++++----
> >  3 files changed, 68 insertions(+), 14 deletions(-)
> 
> Good day Arnaldo,
> 
> I am good with this set:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Please consider for inclusion in your tree if you are satisfied with the work.

I'll take a look and get it into perf/core, now I'm concentrating on
perf/urgent work.

Thanks,

- Arnaldo
