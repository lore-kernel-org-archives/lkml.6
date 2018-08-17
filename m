Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E1DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7971C219CA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 21:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DLRTnFqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7971C219CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeHRAcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 20:32:24 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:53409 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeHRAcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 20:32:24 -0400
Received: by mail-it0-f47.google.com with SMTP id 72-v6so13209710itw.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 14:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=96RUkf2/RVCHU/GurWkqgmy0IQTwvPUAge529uECmwI=;
        b=DLRTnFqr6enNtNTu8r9mEJb/tXaZmVRsn49NaIUuIUg1MQ0bSyMQaePyR4i8InN/N8
         B32/BlGCGa0P1CHbyShwS62RzdJuAYt2h6ZhBIcgK2TeB/yQalftfzafNp4ZbEnqtfIk
         uf725i6riLIdSX5ZeoLBOO+dcdSkS4bG3qd4YSVvFVmbKI1whmbxrWaZxgQUUAKayfd/
         5Ta2I1idNU5A75vp4ACe7cmxeFoxu6c1pN0SUOr20my/Qw8/sI27qRyD/RfI6+GBOK8D
         9q20GdbFBww0JvirrwT7CEOcO8cOOz5Vl1WXE5u4rPVurNKkaD4Vjer1QWw/jnBHWYGj
         cn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=96RUkf2/RVCHU/GurWkqgmy0IQTwvPUAge529uECmwI=;
        b=QqAJ9d4bioxytUtl6sfkRKXrXmOTClIq/5lyZuhZWjl1v8cQnmuYIibOzE9FXfrLQG
         3YHSMNIevYytvTUhWDyRnnH42dNe+xxDLmfC6rB4e9gEHkidIw402CzNpZRL9OtKJSGA
         QTfnNOtxAMYIaxJWyOOdaI44+r6jfSEcvwf7BHNoGVE6WPSxfQr0ys7Ci3BkAoTue7R3
         R9UCdM6xyTYlmlHE9hd7MqLRGX7sKth6mXkVDrKnv1njP4AYtRbLtxESqT+NB/xpCIkI
         7EZVikSKvUjemkew5I66ISn4pvkdZA65iEoVG5lGRK+NfWxV4JN3kciYj4xA0D8gHb0V
         /1VQ==
X-Gm-Message-State: AOUpUlG6+uvwk6htsxBZcIMeNLE44/rgsLM3EBPO63bTPXRtTdcgdVkd
        iPuwokAGo+5b6WL3rUgt3VmMpA==
X-Google-Smtp-Source: AA+uWPzmWbjmEjDy4yKh5VFuvErcSgLCMwi7/pYcsUeLk95UM9Y4VOeyv+Z4qzQxMODO9O4Xgc/LPQ==
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr32736112jaa.10.1534541243739;
        Fri, 17 Aug 2018 14:27:23 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id f1-v6sm1187748ioq.10.2018.08.17.14.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 14:27:23 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fqmHC-0001bT-8F; Fri, 17 Aug 2018 15:27:22 -0600
Date:   Fri, 17 Aug 2018 15:27:22 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
Message-ID: <20180817212722.GB28777@ziepe.ca>
References: <20180816215726.GA20526@ziepe.ca>
 <CA+55aFxgT8Hipm6bDrHMZ-nmdk3KZTP=J6D5k10UHTcajXAEHA@mail.gmail.com>
 <20180817201535.GI28676@mellanox.com>
 <CA+55aFzcp=a2sNOVR7DTEY9dehYamXaJ1bpSfF0FZir_9MhsVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzcp=a2sNOVR7DTEY9dehYamXaJ1bpSfF0FZir_9MhsVg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 01:27:02PM -0700, Linus Torvalds wrote:
> On Fri, Aug 17, 2018 at 1:15 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > We often have merge conflicts with RDMA, how do you prefer to get the
> > PR? I'm actually not very clear on this part of the process.
> 
> I  generally prefer the non-merged version, but with comments about
> the conflicts.
> 
> In fact, the really preferred model is generally to send me a
> non-merged pull request (say "tags/for-linus") but if the conflicts
> look even half-way nasty - or simply because you did the merge anyway
> just to get the proper diffstat because history is complex - mention
> that you have a merged branch for verification (say
> "branch/for-linus-merged").
> 
> When I get that kind of pull request, I'll just do the merge
> resolution myself, and after I've done it I'll generally then do
> 
>    git checkout -b test-merge
>    git pull <repoaddress> for-linus-merged
> 
> and then just compare the end result with my resolution as an extra
> verification step.
> 
> I may end up skipping the verification step if everything looks
> entirely trivial (and really, if you have no real reason for the
> pre-merged branch, don't bother even mentioning it even if you did it
> for the diffstat), but in practice whenever somebody does that, I have
> no reason not to just do that simple extra verification.
> 
> Most of the time the merges are exactly the same, possibly with
> whitespace or trivial ordering differences (things like Makefiles and
> Kconfig files often have add-add conflicts where the ordering really
> doesn't matter between two config options).
> 
> And then sometimes it shows that I missed something in my mmerge.
> 
> And sometimes it shows that  I do so many merges that I actually ended
> up noticing something that the submaintainer didn't.
> 
> So it can be uninteresting, and when it isn't uninteresting it can go
> either way, but so far for the people who do this, I've never been in
> the situation where I was *sorry* for the double merge and extra
> verification step.
> 
> Because when mis-merges happen (they are happily pretty rare) they are
> _so_ annoying and can be so hard to figure out later, that I'd rather
> spend a bit more time on the merge than have a dodgy one.

Thanks for the explanation. Doug and I will do this in future.

Jason
