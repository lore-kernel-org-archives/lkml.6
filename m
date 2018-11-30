Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB2DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DE42082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMkRrWEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DE42082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeLABbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:31:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35747 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeLABbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:31:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so5487268wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 06:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hrz6jHuLdhjE2uhw2f7vRbC/QCZBWo7QMTqDcGV57oc=;
        b=GMkRrWEChzP4d00iC/Jm4I3/50OeDGaJQyFG3faVCG4F0itlTaPdnrCPMQWZ0FyM9J
         pI7kNbgXD8pmTIu0M0vbgUj3sc1TDZrV4SC01h8g906slR84hwXKTosce3oil8y0Fev1
         gtTuJ5pWnGw1UAXRSG/mbLrXuiGcEpx/oBl78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hrz6jHuLdhjE2uhw2f7vRbC/QCZBWo7QMTqDcGV57oc=;
        b=XSrll02rbYzpvSKrdup2dtdK9//U9k+3eEMVBwSWrRVMafWwxhXYHEMHZl6XsPTjaq
         1CQ/o3I41nEgBvFosqr74Y4C+L4QDTQ4/kULQKgqLCiOaD/dw+IcdVRCbD1BWErdmz1e
         Wb1XVPxRCIeK3NxK91ODfQcVALYvhgkmy+W22lHMxRJAPa6Zzn80Xsf7NuXXQpF808h8
         IB2AQSd8zbDUFpSJ0pKw7aaeBtQamDOVmvdGpMYtBOGgL/u0MliDYH5TSONtnRHtMORo
         t9geZUlmqNLRP7Z5Bw4bYukq9/r3Y0FitOo7kFwwmk3ug5P7BkqOI5NG6iMey2D5bxU8
         9t7w==
X-Gm-Message-State: AA+aEWZANte+PeALu6cewnkIHLRE0/tD4GFODcklYRnhWthh/nXNfEa+
        IwQFTRJz3wRXNuPKdVVGM6IfdQ==
X-Google-Smtp-Source: AFSGD/X57sH87ghbVG0V8fxFCYa12nnxKNcEHe4GcNv71wfeJCAEvbcMXpCFNC5/em0GC1M6Dio1Kw==
X-Received: by 2002:a5d:660e:: with SMTP id n14mr5054675wru.19.1543587707710;
        Fri, 30 Nov 2018 06:21:47 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([209.250.228.18])
        by smtp.gmail.com with ESMTPSA id t6sm1645962wru.11.2018.11.30.06.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 06:21:46 -0800 (PST)
Date:   Fri, 30 Nov 2018 22:21:40 +0800
From:   leo.yan@linaro.org
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] perf evsel: Correct clock unit to nanosecond
Message-ID: <20181130142140.GB11833@leoy-ThinkPad-X240s>
References: <1543572365-11706-1-git-send-email-leo.yan@linaro.org>
 <20181130102154.GA3617@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130102154.GA3617@krava>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 11:21:54AM +0100, Jiri Olsa wrote:
> On Fri, Nov 30, 2018 at 06:06:05PM +0800, Leo Yan wrote:
> > Since commit 0aa802a79469 ("perf stat: Get rid of extra clock display
> > function"), the cpu and task clock unit has been changed from
> > nanosecond value to millisecond value.  This introduces confusion for
> > CPU run time statistics, we can see in below flow the clock value is
> > scaled from nanosecond value to millisecond value; but this is
> > contradiction with statistics type 'STAT_NSECS', which always takes
> > clock as nanosecond unit.

[...]

> there was fix for this recently, could you please check
> if it's working for you:
>   6e269c85dcea perf stat: Fix shadow stats for clock events

Ah, I missed this patch ...

Yeah, I tested this patch and can confirm this patch fixes
this issue.

Thanks,
Leo Yan
