Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A3EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC4E2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiRWQ1ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC4E2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeJBVIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbeJBVIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:08:37 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7C33206B2;
        Tue,  2 Oct 2018 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538490299;
        bh=Wxn12xJSvVXLFe2dHg4M/E2dTi/MSC6pJtIvzOkLYus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jiRWQ1tig9zqtqYxcSoChY55Oh6Yb77M9dKs+rCOJ0bMOa2KNF7ShJa1ZxHxFJAEZ
         11ccRctXfaIxqeMl8yQZCmhX4JYsE7IV28i77zjsgqrzrcWv0mVTfgXtbXy/ORO1kC
         mFHZnIm2S6bmpW7ebS+iwaa8UbBKa2TzcdxV2/x0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id B631C14024D; Tue,  2 Oct 2018 11:24:56 -0300 (-03)
Date:   Tue, 2 Oct 2018 11:24:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     leo.yan@linaro.org
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 3/5] tools, perf, script: Add --call-trace and
 --call-ret-trace
Message-ID: <20181002142456.GC3541@kernel.org>
References: <20180920180540.14039-1-andi@firstfloor.org>
 <20180920180540.14039-4-andi@firstfloor.org>
 <20180928102331.GA15533@leoy-ThinkPad-X240s>
 <20180928171944.sdejhgyqka4p3kc3@two.firstfloor.org>
 <20180929073903.GB4089@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929073903.GB4089@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 29, 2018 at 03:39:03PM +0800, leo.yan@linaro.org escreveu:
> On Fri, Sep 28, 2018 at 10:19:44AM -0700, Andi Kleen wrote:
> > > Seems to me, these two features are _NOT_ only benefit for intel_pt,
> > > other hardware tracing (e.g. Arm CoreSight) can enable these features
> > > as well.  This patch is to document only for intel_pt, later if we
> > > enable this feature on Arm platform we need to change the doc;
> > > alternatively we can use more general description for these two options
> > > at the first place.  How about you think for this?
> > 
> > Likely it already works for CoreSight
> 
> I think Kim played with this patch series and he also pointed me for
> this series.
> 
> > I specified intel_pt, because if we just say traces the users won't
> > know what PMU to specify for record. Being too abstract is
> > often not helpful.
> > 
> > If someone successfully tests it on CoreSight they could submit
> > a patch to the documentation to add "or <coresightpmu>" to these
> > two cases. That would make it then clear for those users too.
> 
> Okay, agree.
> 
> Actually I applied your patch series v6 on the perf latest core branch
> and tested on Arm Juno board, I observed there have couple issues, one
> is CoreSight trace data doesn't support timestamp so I need to use
> '-F,-time' to workaround the command failure; another issue is now
> CoreSight is absent to set sample flags so perf fails to resolve
> symbols [1]; these two issues are only related with CoreSight decoder
> and it's no matter with this patch, so I didn't mention in my previous
> replying.

Could I take that as a Tested-by? I.e. you actually applied the patches,
run it and saw that it works as advertised, right?

- Arnaldo
 
> I need a bit more time to work out more formal CoreSight fixing patches
> and will send for reviewing (also will include one patch to clarifying
> Arm Coresight support in doc as suggested).
> 
> Thanks,
> Leo Yan
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/builtin-script.c?h=perf/core#n1128
