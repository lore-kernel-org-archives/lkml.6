Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF68CC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955DF26986
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hGO4v6UP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955DF26986
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933795AbeFZLBL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:01:11 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45422 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933505AbeFZLBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:01:08 -0400
Received: by mail-pg0-f68.google.com with SMTP id z1-v6so7454653pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ehO+/O5bwcVKlVs2VX5itWmTLkU6hMqGC9Yprpku3mU=;
        b=hGO4v6UPJKJPqCPQ3c8wmiwF4e/d0Q9QXAN/cLGXO1Ho2SNFUu3EpK8xr6teeu+IyW
         4nDFEoR0aEvnV2wEnIgBcemXpq7but4CpMfJ65zqSFQb9bqt7ZfLILKJeKqBNZIOdO2D
         9NLoimV+54KuyImhrjQLh3nW2a5zu5XdJVVSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ehO+/O5bwcVKlVs2VX5itWmTLkU6hMqGC9Yprpku3mU=;
        b=GvgX5W6yXdKLY/lLk5RO91BYI7fMB0LywpyEEyYTSOX2q9lSDYnzImlv6pxHmszEcr
         BIoDylDHlSOhal+oiAZ/fWJv5v8yS+U3+3H7VN4DLk/eOckC7r05KZl8adzQqYHHdo/+
         z8oFv1VV0n2IDDkuPvG5ASgIhfud4DejRPkwuQJWGhiOLN8mm0LDS3shF9ry72r7RTrB
         LL+XrmIjLWOwyybexp21QgjKlRv80YxXhgDEnOk3FqbzfllRQdYPqo+2BDwDzKGaT4oY
         E3HeN2WYpzHbHkONWYrw4h8Udl/ggI3hloWl+F4jh1S3dN5sAqs1w3X6RzIjWUEXUG2L
         +DwA==
X-Gm-Message-State: APt69E2E+ERz5E9ve2jJNGMZKWnudWk+O8PwmhRedQMrBq0AZFx4Ltvf
        wy9szhqrbfiGQS96O3o8Z+5GjQ==
X-Google-Smtp-Source: ADUXVKKpro+MQU95llTTiHg9n+UFEWazozji3vFJlrdTRskxsrGgoNsuYqjjLTHpqYf7eoVI1AVz7Q==
X-Received: by 2002:a65:4d91:: with SMTP id p17-v6mr908031pgq.296.1530010868162;
        Tue, 26 Jun 2018 04:01:08 -0700 (PDT)
Received: from localhost ([122.172.137.133])
        by smtp.gmail.com with ESMTPSA id h8-v6sm2023476pgq.35.2018.06.26.04.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 04:01:07 -0700 (PDT)
Date:   Tue, 26 Jun 2018 16:31:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V10] powercap/drivers/idle_inject: Add an idle injection
 framework
Message-ID: <20180626110105.qqsrslavtfxuubcm@vireshk-i7>
References: <1530010416-30692-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530010416-30692-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-06-18, 12:53, Daniel Lezcano wrote:
> Initially, the cpu_cooling device for ARM was changed by adding a new
> policy inserting idle cycles. The intel_powerclamp driver does a
> similar action.
> 
> Instead of implementing idle injections privately in the cpu_cooling
> device, move the idle injection code in a dedicated framework and give
> the opportunity to other frameworks to make use of it.
> 
> The framework relies on the smpboot kthreads which handles via its
> main loop the common code for hotplugging and [un]parking.
> 
> This code was previously tested with the cpu cooling device and went
> through several iterations. It results now in split code and API
> exported in the header file. It was tested with the cpu cooling device
> with success.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Javi Merino <javi.merino@kernel.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Kevin Wangtao <kevin.wangtao@linaro.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Rui Zhang <rui.zhang@intel.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
> ---
> 
> V10:
>    - Remove set_freezable (Rafael J. Wysocki)
>    - Reduce the prefixed names 'injection' by 'inject" (Rafael J. Wysocki)
>    - Rename 'idle_injection_wakeup_fn()' to 'idle_inject_timer_fn()' (Rafael J. Wysocki)
>    - Shorten label 'out_rollback_per_cpu' to 'out_rollback' (Rafael J. Wysocki)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
