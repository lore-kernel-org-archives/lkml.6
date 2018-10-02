Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D73C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238B420878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWvl3ntV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238B420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJCFzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:55:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42982 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:55:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id g15-v6so1388907wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 16:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x6wTmwti4MjaAOIwv8GwVZijWZeuuO3cTdPqzdmBLXs=;
        b=UWvl3ntVuclRHUBEf61HmZ06U9RtI7Fa5+oZ+IFsJZz8V65OXZdZVgMxk53ynUfvYx
         xU1CL3Kq1b+N+pcLXn7qYOY9ZubNOTUeTg1tFRJy1lBG/C2vfc8jID7J0ss46xtyo338
         KoRxnodRnNWoSDDB4nzrnwDh8QD7l51rPsZlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x6wTmwti4MjaAOIwv8GwVZijWZeuuO3cTdPqzdmBLXs=;
        b=JNHyTdK0L+/EArLwEU1r7FBmUUsj7XwtWgFSxy8CHMrKaNwz1Bzdyas7EGba8D2Tib
         oou2SODBnY7133qz0kaG+QSkSBtlBBPdK2b316FqDurKousIxK35Aa9wL3lZiXrEANsE
         fZnfsTzBpjTLGv0M9xbXoIWz6o0R6V+ekP+pT0p6XiqoyiAtwY91Qf0zK0oUiTHIvG1Z
         t26umoFrtVWCliIndogywm/9MWcFDynW0Sq7tYEcsaV1JixWO/zwZgHVksy3+S2jS7qy
         oTrDKHM/C10bQp38BldwXV+cFhbBcWfkWfZV+tS0fl/l100bK6iqiug9mi9XgY2xLtcE
         s3/Q==
X-Gm-Message-State: ABuFfojyw1k2ObrL5psOs95zh7CI+pPDjKHRMq4bQa/3xlQPviCA/NUC
        8jh4uLZjtz2mUeVsHvRvJiqLeQ==
X-Google-Smtp-Source: ACcGV61PT84PiiXHmS6mcFivASppN8KpdkRz6opv4sbDdbV+NDvGU2rxHXQNQv0cXGlQj+pXeiLHQQ==
X-Received: by 2002:a5d:44ce:: with SMTP id z14-v6mr12813867wrr.286.1538521767767;
        Tue, 02 Oct 2018 16:09:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id o17-v6sm1451864wro.2.2018.10.02.16.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 16:09:26 -0700 (PDT)
Date:   Wed, 3 Oct 2018 07:09:21 +0800
From:   leo.yan@linaro.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 3/5] tools, perf, script: Add --call-trace and
 --call-ret-trace
Message-ID: <20181002230921.GB17418@leoy-ThinkPad-X240s>
References: <20180920180540.14039-1-andi@firstfloor.org>
 <20180920180540.14039-4-andi@firstfloor.org>
 <20180928102331.GA15533@leoy-ThinkPad-X240s>
 <20180928171944.sdejhgyqka4p3kc3@two.firstfloor.org>
 <20180929073903.GB4089@leoy-ThinkPad-X240s>
 <20181002142456.GC3541@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002142456.GC3541@kernel.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 11:24:56AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Sep 29, 2018 at 03:39:03PM +0800, leo.yan@linaro.org escreveu:
> > On Fri, Sep 28, 2018 at 10:19:44AM -0700, Andi Kleen wrote:
> > > > Seems to me, these two features are _NOT_ only benefit for intel_pt,
> > > > other hardware tracing (e.g. Arm CoreSight) can enable these features
> > > > as well.  This patch is to document only for intel_pt, later if we
> > > > enable this feature on Arm platform we need to change the doc;
> > > > alternatively we can use more general description for these two options
> > > > at the first place.  How about you think for this?
> > > 
> > > Likely it already works for CoreSight
> > 
> > I think Kim played with this patch series and he also pointed me for
> > this series.
> > 
> > > I specified intel_pt, because if we just say traces the users won't
> > > know what PMU to specify for record. Being too abstract is
> > > often not helpful.
> > > 
> > > If someone successfully tests it on CoreSight they could submit
> > > a patch to the documentation to add "or <coresightpmu>" to these
> > > two cases. That would make it then clear for those users too.
> > 
> > Okay, agree.
> > 
> > Actually I applied your patch series v6 on the perf latest core branch
> > and tested on Arm Juno board, I observed there have couple issues, one
> > is CoreSight trace data doesn't support timestamp so I need to use
> > '-F,-time' to workaround the command failure; another issue is now
> > CoreSight is absent to set sample flags so perf fails to resolve
> > symbols [1]; these two issues are only related with CoreSight decoder
> > and it's no matter with this patch, so I didn't mention in my previous
> > replying.
> 
> Could I take that as a Tested-by? I.e. you actually applied the patches,
> run it and saw that it works as advertised, right?

Yes, Arnaldo.  This is my testing tag:

Tested-by: Leo Yan <leo.yan@linaro.org>

> - Arnaldo
>  
> > I need a bit more time to work out more formal CoreSight fixing patches
> > and will send for reviewing (also will include one patch to clarifying
> > Arm Coresight support in doc as suggested).
> > 
> > Thanks,
> > Leo Yan
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/builtin-script.c?h=perf/core#n1128
