Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC559C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451C920881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 00:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0kr3bTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451C920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbeLCA6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 19:58:47 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39704 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLCA6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 19:58:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id f81so1574223wmd.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 16:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NcjtOCYw/6QcEDkBwqPK/9c48OIQd9jaQJkVCXyxaFg=;
        b=U0kr3bTIduMEARm+wZRSyq1VqUwd3FSq1Q3N8WZmX8HRYkPLIh+XkFxsg0mGJvCtgu
         Jil9CO5MWURHBdVUK/w7EkJz+6/s3LcsNGO9hip+yljr/D0fPeFWFl5MbJ1yGvLrTr8p
         fgrrsxt+yNSOMmoAY7/V0P5EkPIajLTgYk5Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NcjtOCYw/6QcEDkBwqPK/9c48OIQd9jaQJkVCXyxaFg=;
        b=RudJgKjptj5OBK+LvPsiLVH8etEa27S89qojVsA93uU8fMejxSpLgmuhmJChQWsUWY
         osE1uEpdwtou7Mr2jrrWl5nlfKDXw6CuydcEWWtg/bSdc8XmEphVaewHp+gIrsHVlvrU
         kYdEZ51X/HlR9745FcLU7OSgWK/BgiP6i+yrD0+wxKmjnyXzVZVsAwlaCRbI2vgjeS3D
         BOL8UqLwIiBrANN8l4xN5qjAZupY4sVal2DWJtCr/BNRd277rrSAeFI6hmAyhqTHKLFg
         fg5xB9KwOKdUeHb9G9TzuE7T+JPAZPa/SHHEHlJWILR6D9oCJbKAHXWemX5wve4KV1L7
         KMEA==
X-Gm-Message-State: AA+aEWZsN5YNXEglvFlIjlOQZpyaiZPMkQSA4oUR3QmeCnpEdo86T/Z1
        U0cLHOKxTYvP8Bx0aVePXjC2Yw==
X-Google-Smtp-Source: AFSGD/UIPp3ohROEYEea4rulb3EHxdedwCz3iEcNSdr8kOi0JKiuHb2gXRwXjlRlV5OaP739i9zdxQ==
X-Received: by 2002:a1c:5dd1:: with SMTP id r200mr6577063wmb.93.1543798720454;
        Sun, 02 Dec 2018 16:58:40 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id n15sm16903937wrt.21.2018.12.02.16.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 16:58:39 -0800 (PST)
Date:   Mon, 3 Dec 2018 08:58:28 +0800
From:   leo.yan@linaro.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] perf evsel: Correct clock unit to nanosecond
Message-ID: <20181203005828.GC12322@leoy-ThinkPad-X240s>
References: <1543572365-11706-1-git-send-email-leo.yan@linaro.org>
 <20181130102154.GA3617@krava>
 <20181130142140.GB11833@leoy-ThinkPad-X240s>
 <20181130152521.GA10748@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130152521.GA10748@kernel.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 12:25:21PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Nov 30, 2018 at 10:21:40PM +0800, leo.yan@linaro.org escreveu:
> > On Fri, Nov 30, 2018 at 11:21:54AM +0100, Jiri Olsa wrote:
> > > On Fri, Nov 30, 2018 at 06:06:05PM +0800, Leo Yan wrote:
> > > > Since commit 0aa802a79469 ("perf stat: Get rid of extra clock display
> > > > function"), the cpu and task clock unit has been changed from
> > > > nanosecond value to millisecond value.  This introduces confusion for
> > > > CPU run time statistics, we can see in below flow the clock value is
> > > > scaled from nanosecond value to millisecond value; but this is
> > > > contradiction with statistics type 'STAT_NSECS', which always takes
> > > > clock as nanosecond unit.
> > 
> > [...]
> > 
> > > there was fix for this recently, could you please check
> > > if it's working for you:
> > >   6e269c85dcea perf stat: Fix shadow stats for clock events
> > 
> > Ah, I missed this patch ...
> > 
> > Yeah, I tested this patch and can confirm this patch fixes
> > this issue.
> 
> My fault, new notebook update process got in the way causing
> acme/perf/core to pile up, a perf/core pull req is about to be sent to
> Ingo now tho :-)

No worry :)  This patch has been passed by my email filter, so I
should check inbox carefully.

Thanks,
Leo Yan
