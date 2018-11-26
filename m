Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A8BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F29D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQCt3flI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F29D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeK0Xdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:33:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbeK0Xdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:33:44 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1EF72145D;
        Tue, 27 Nov 2018 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322156;
        bh=KuQb8BvjPlv4fRoRfmFftOWsJyQtJunVOBjjBtb1H4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQCt3flI3+wxTI3jeYoPFvYeQZUDH+TKJpMe8KNb/XKtRZwa9CyctZn3PihbOhCtS
         QGS/raxjWN23pdYzqnV+Vqxjwe78eGb3vl6jrZgysoj6Crmf9BhHeqrRe6darxhVRK
         LJNaBmZQMhiY317odgpvhE6ZG0+qeTI4u58yB0NU=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 457CB41115; Mon, 26 Nov 2018 16:44:14 -0300 (-03)
Date:   Mon, 26 Nov 2018 16:44:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 1/5] perf tools: Add fallback functions for cases where
 cpumode is insufficient
Message-ID: <20181126194414.GF18491@kernel.org>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
 <20181031091043.23465-2-adrian.hunter@intel.com>
 <20181105172946.GH11147@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C313381@IRSMSX106.ger.corp.intel.com>
 <20181105193615.GG7077@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C3133B4@IRSMSX106.ger.corp.intel.com>
 <20181126190217.GC18491@kernel.org>
 <20181126194145.GE18491@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126194145.GE18491@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 26, 2018 at 04:41:45PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 26, 2018 at 04:02:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Nov 05, 2018 at 07:53:17PM +0000, Hunter, Adrian escreveu:
> > > > From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> > > > Em Mon, Nov 05, 2018 at 07:21:44PM +0000, Hunter, Adrian escreveu:
> > > > > > > +static bool machine__single_ku_as(struct machine *machine) {
> > > > > > > +	return strcmp(perf_env__arch(machine->env), "sparc"); }
> 
> > > > > > Can we avoid having this strcmp be done repeatedly?
> 
> > > > > It is only done if there are mapping errors
> 
> > > > > > Can we avoid having this strcmp be done repeatedly? I.e. just
> > > > > > make this a boolean initialized at session start, when
> > > > > > machine->env is setup, so we'd have:
> 
> > > > > >    machine->single_address_space
> 
> > > > > > Instead of a function?
> 
> > > > > Sure  thing.
> > 
> > Have you sent an update to this patch series addressing the concerns? I
> > think that renaming that _fb to __fallback and having this
> > machine->single_address_space is what is missing, I'll try to take a
> > stab at this now and have it in my perf/core branch soon.
>  
> > But you have this already done, please send it.
> 
> So, here is the patch on top of yours and at the end a patch that I'm
> inserting just before yours, please check and ack, thanks:


Argh, nevermind, just saw your V2, /me goes to read it ;-\

- Arnaldo
