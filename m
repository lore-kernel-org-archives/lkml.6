Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFB3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36838222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uvt4l4U9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405829AbfBNT25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:28:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41139 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfBNT25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:28:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so3543531pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 11:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gBqIfKsCtR6NSnAzbURnQ4JIzuSfGeTDH9ZcgF/BChA=;
        b=Uvt4l4U9ZqfyD5D5FI0zlLAohl+8AnmwGicsKUQFtR2VfxDbE8bOdy+Sf2sOa5GjqN
         Y3gZsjtx/kp/4J494Qun4kNC9/iIwEtfL8Ko0nkhF3vYe5DReIEPnnB7KEvAnJCEkvo2
         ksleHSE1SKlG3aJuoVsQZxxRthGxfxdhp35Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gBqIfKsCtR6NSnAzbURnQ4JIzuSfGeTDH9ZcgF/BChA=;
        b=b3UuF/zTjC79eo8yL1n4DvPtOMQIxXw0Mq+Q0H0QnY+3IN9FUb/nPPhI53QlYFHh02
         QwaHrSxQb2KFy4aUsQR2iKJwCXWCbieR5p88ub+kb/9lvPwFPUi26ChxM4KZNz+DIb9I
         jZtuBP7kagYHRqEgeP4SRd2TTeKn0cQjvSrZ6TZiFGUKG7VnuygN9xyu1CguxdCIrU+H
         7U0PPyMkN2dsUdAny8lCrVvNyjw7wzC8belAs2kxA6QOx1Adk15yTJzLQ7u9dzfohlvg
         phWXMHtmctSlcWXq2uJqFWfIMftBv2Glmvhm14z3d63+zufeSVbLiKHH/NLiXNgOGDnV
         cXTA==
X-Gm-Message-State: AHQUAuZLQlFLtQQT3Sxulu+a6MP0RwIrDD79IQQ56W7S8oo79m87DAXF
        AR36gbuF03NauiKBEcFSd/Uz/w==
X-Google-Smtp-Source: AHgI3IbEavNTyZTdsFfGJ3s2d2i049hD5LUu7KQxNPcwzjcCTM3E89ogZScv3VAVx4XdWkVBdp7yyA==
X-Received: by 2002:aa7:87c6:: with SMTP id i6mr5695060pfo.208.1550172536376;
        Thu, 14 Feb 2019 11:28:56 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e63sm8977550pfc.47.2019.02.14.11.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 11:28:55 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:28:55 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH 4/4] PM / devfreq: Handle monitor start/stop in the
 devfreq core
Message-ID: <20190214192855.GD117604@google.com>
References: <20190214013042.254790-1-mka@chromium.org>
 <20190214013042.254790-5-mka@chromium.org>
 <CAGTfZH118diXgKHetWwiNMXHALxXqt=MSh9oVv+nt4-SJkzN2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGTfZH118diXgKHetWwiNMXHALxXqt=MSh9oVv+nt4-SJkzN2Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On Thu, Feb 14, 2019 at 11:17:36PM +0900, Chanwoo Choi wrote:
> Hi Matthias,
> 
> As I commented on the first patch, it is not possible to call some codes
> according to the intention of each governor between 'devfreq_moniotr_*()'
> and some codes which are executed before or after 'devfreq_moniotr_*()'
> 
> For example, if some governor requires the following sequence,
> after this patch, it is not possible.
> 
> case DEVFREQ_GOV_xxx:
>         /* execute some code before devfreq_monitor_xxx() */
>         devfreq_monitor_xxx()
>         /* execute some code after devfreq_monitor_xxx() */

As for the suspend/resume case I agree that the patch introduces this
limitation, but I'm not convinced that this is an actual problem.

For governor_start(): why can't the governor execute the code
before polling started, does it make any difference to the governor
that a work is scheduled?

For governor_stop(): why would the governor require polling to be
active during stop? If it needs update_devfreq() to run (called by
devfreq_monitor()) it can call it directly, instead of waiting for the
monitor to run at some later time.

Cheers

Matthias



