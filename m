Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A9EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB3920A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="EmOdLT1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB3920A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maine.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbeHYAps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:45:48 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36782 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeHYAps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:45:48 -0400
Received: by mail-qt0-f196.google.com with SMTP id t5-v6so11700398qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 14:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NFmMHGWpphaZlRgkjWQwaHICII65kQYMGQOqE4IfmG8=;
        b=EmOdLT1AlXq0oOgtTnd50bH5IltK1jg7l9842IvfQWn0JUyela/RpnCUmI02i1R1+N
         dqHCtaOYq2URxwSSgYwLJ2rXHImFA85aowAjNhxXA1bkXBOBxa+kSEouhqqRKdxCwxas
         3By0MvqDyY7fkT2AfqbOD8nm553/ows0n7zr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NFmMHGWpphaZlRgkjWQwaHICII65kQYMGQOqE4IfmG8=;
        b=F4xZpbf8jt8XstiXSIF09XvZxKm2PEUTIcZ+oo0zyOQKB5gsFFi28jGwhI5draE+7H
         1BSyf8QuRGCBeHG+OdHXRswutyS5poodFEKFXZAfFXT9AqJXP3gm5TZ9+uL/80ek0mjZ
         lWdcXJwHekSBCYYH7Y6QMAmRgn98XTSdACqHGx6L2F7vEzL26PsYOXORqVdX7bK5Ho7Z
         5JueAWkPrxFx0E6cj6BEeWwZvcbfOYO58zgU6VG+GPZgd50D+PajTSzikzZ9rpoQuArX
         ArOwy3greEwFPTXVEOaGnTFbENcgerAHScrwbX0PnGVJB+LuyuHpLNzM3FbAgWXEn8Hj
         o5+w==
X-Gm-Message-State: APzg51BhjZ2WQ6CYLdehrnRmBoJZpDIB4+8dPGOHJ5QwBJUERoviiGyf
        7v4eo1skYzpmG5z09+qv3sw/yA==
X-Google-Smtp-Source: ANB0VdYIFgAtlH9ytK9VcN+YX57VmlCQOaZWmuCzeuYDVyhdoxvH2BfpsVEwHxvzWCvEsiuUx9qFMA==
X-Received: by 2002:aed:22e5:: with SMTP id q34-v6mr3785744qtc.179.1535144969412;
        Fri, 24 Aug 2018 14:09:29 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id s35-v6sm5511261qtj.79.2018.08.24.14.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 14:09:28 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 24 Aug 2018 17:09:27 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [perf] perf_event.h ABI visibility question
In-Reply-To: <20180824085042.GL24124@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1808241706120.12717@macbook-air>
References: <alpine.DEB.2.21.1808231401440.28868@macbook-air> <20180824085042.GL24124@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018, Peter Zijlstra wrote:

> > +++ b/include/uapi/linux/perf_event.h
> > @@ -143,6 +143,8 @@ enum perf_event_sample_format {
> >         PERF_SAMPLE_PHYS_ADDR                   = 1U << 19,
> >  
> >         PERF_SAMPLE_MAX = 1U << 20,             /* non-ABI */
> > +
> > +       __PERF_SAMPLE_CALLCHAIN_EARLY           = 1ULL << 63,
> >  };
> > 
> 
> Hurphm.. visible yes, but as you say, also quite useless. Does it really
> make sense to document that?

Well, it should probably be documented either in the manpage or else in 
perf_event.h  (even if it's just "internal use, don't use") as we can't 
really expect people to download a git tree and do a git-blame to try to 
figure out what this mysterious field is all about.

Also, this change increased the size of the enum from 32 to 64 bits on 
32-bit machines, though that only really matters if the user is doing 
something really weird with enum variables.

Vince
