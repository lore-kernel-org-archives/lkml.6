Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDEBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3847D2175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/VMJkUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3847D2175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeHCN0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:26:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44598 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbeHCN0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:26:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so4636771ljq.11;
        Fri, 03 Aug 2018 04:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=me97colI25uy3TCPRNy1m2h/mCI6MmyTM+QgqCGmwhg=;
        b=i/VMJkUCL6AimOKjWqo0uGN79NmoGDzCwJovbSIcCNry8PchUAFvEvo8Wya2ZKYh/p
         ZP4+RtlIsrzHjGus/Njyd5tK7cpYIgBa90+52L+TjsR2Q1PFuTgQbVeKm4pB2lI+DPG8
         d3n33q7ayS70UVix8MtTCC367CFoLegi7MJ3sSszf2l2L5q1jy3whK9N64y1/n88XWk4
         mtmAglDOYFwCG8hFYaleAT/a4Gewv/qsAwhpdl/YDdM4lCDnE7CLD9H8TSPSsrVuTKby
         5RF5aa8fXwUF0JsKJmjMQ9c27XE9L+iFoXUjBbIW8AtSiUewDPlyXFnmzh9yL/m4C0AB
         w9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=me97colI25uy3TCPRNy1m2h/mCI6MmyTM+QgqCGmwhg=;
        b=Dny0TLi4RITN9a2GfpWePyxYRcawZIf/tYR4pKtKXIY+zF60q+9pCS0LHXyaJhfzzH
         KtT9Uu1m6I2sJMz8tF+APqnlu8nUQ5tl7ZEYq7xS6gDs5+oD/j3Nv1NvBJbWyXjCEymr
         QNtn4JzcKMmPJfV+X6bvli033cvZTSbxW08OPHuCIetfyub/KkIVxOHcm1kKvZOl6D8D
         GbEiJhWfKySujdnuzz8Aveh0dGqP70yRxp6GMJuW4V+GyXIP0Y5mOdlPuiuyeDuEcxGu
         UZBqe04o++WRwiZ+ZumMXXfW7QTBS9afvWoSv4cvqrjJd7EtgWQDRKKgzKt8wTtIHJ+R
         DQ/Q==
X-Gm-Message-State: AOUpUlGSlJp5Zf08rZEWN04irJW+za8r+76Av+ekxQP8CnxSMNbFsga5
        sz+RfTjLeqcHMaCY/+aZWA+V1pGK
X-Google-Smtp-Source: AAOMgpfAtTpLBPbqd4M/XOzEurbFOX6UNzjXA9+JU8dV+4Tvm4mFlUotzPiN1JZa48rCOAWiLDpo3w==
X-Received: by 2002:a2e:7113:: with SMTP id m19-v6mr5056962ljc.66.1533295854963;
        Fri, 03 Aug 2018 04:30:54 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id j64-v6sm683814lfe.56.2018.08.03.04.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 04:30:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, Kyle Evans <kvans32@gmail.com>,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] gpu: host1x: Ignore clients initialization failure
Date:   Fri, 03 Aug 2018 14:30:47 +0300
Message-ID: <4457259.6qKMIOUXSS@dimapc>
In-Reply-To: <20180803105055.GC28546@ulmo>
References: <20180801150807.15926-1-digetx@gmail.com> <20180803105055.GC28546@ulmo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 3 August 2018 13:50:55 MSK Thierry Reding wrote:
> On Wed, Aug 01, 2018 at 06:08:07PM +0300, Dmitry Osipenko wrote:
> > From time to time new bugs are popping up, causing some host1x client to
> > fail its initialization. Currently a single clients initialization failure
> > causes whole host1x device registration to fail, as a result a single DRM
> > sub-device initialization failure makes whole DRM initialization to fail.
> > Let's ignore clients initialization failure, as a result display panel
> > lights up even if some DRM clients (say GR2D or VIC) fail to initialize.
> > 
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> > 
> >  drivers/gpu/host1x/bus.c | 18 +++++++-----------
> >  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> This is actually done on purpose. I can't think of a case where we would
> actively like to keep a half-broken DRM device operational. The errors
> that you're talking about should only happen during development,

[only in a perfect world]

> and the
> device not showing up is a pretty good indicator that something is wrong
> as opposed to everything booting normally and then getting some cryptic
> error at runtime because one of the clients didn't initialize.

If machine doesn't have a serial port and it doesn't have ssh server running 
or network doesn't come up, you'll end up with a completely dysfunctional 
piece of hardware. Hence there is no chance for you to even check what is 
wrong. The argument about a cryptic error doesn't make much sense, you have to 
improve your runtime as well (and you'll get a error message in the kernels 
log).

> From my perspective, all clients should always be operational in
> whatever baseline version you use. If it isn't that's a bug that should
> be fixed. Ideally those bugs should get fixed before making it into a
> baseline version (mainline, linux-next, ...), so that this never impacts
> even developers, unless they break it themselves, in which case refusing
> to register the DRM device is a pretty good incentive to fix it.

Sounds like you're assuming that only kernel developers are supposed to use 
Tegra, though at least (for now) for upstream it is kinda true. Of course that 
could be changed ;-)



