Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE2CC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735692098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZV0h+Gf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 735692098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeHVP2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:28:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50188 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbeHVP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:28:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so1801585wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+T0B0xKuHc6PmkV7Nqp2zDRINoJzHXAWhbbqChYAyY=;
        b=fZV0h+GflwtpC51Vcm1oDJzJMcGXjs0cbovopM3YgoFm2f16VeaHNajuQhjVfGC7Oy
         kunslYkozEXA7GktpPnSS2G0AGZPnby+ly0X9RV+Wn4PRbs67AfDS+3A8suo4hjiAZ6V
         orE4cSmYbODBAF6wDDvxEYOqHl7fW6Dyy5hds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+T0B0xKuHc6PmkV7Nqp2zDRINoJzHXAWhbbqChYAyY=;
        b=Cg4rlbHXhOzzkWoZcZB1ImON5+R7LM5npZrN/4MmHAC8RNVs37jJCDQd58tT4Wt5dG
         9vMIQfN4GDDSY/axP1T+F7/3TDK/UriRCTsk9C05dwXx5iYBepqoUfapJRUwYm8mxUTm
         JK1xwBagqcvN2JpCstntuqf99gu8l7VGzzjZs7CIbDlU3JdIiBZuZOXaaUCHh4EkTKJ/
         KaFt8SyUmc8of1KwdjN6SrPPM4YIZXC07+YCXgWJ2MRYN0MWkZuwnDuZMNLquYFiGXCY
         Mc5b0zWJXEiXx32SmprY9yXOZtFQaMRbQKu7a6eGX5s/THq7ROw9W+PU8DHccsz6k7H+
         FNmg==
X-Gm-Message-State: APzg51Cg33yX45ymZ7Gi3pFyQ0pjAvZrYW5sgycx/b5TUJzGpeeitsd4
        YIldLkGX+3nvsWtqzGVWtZeJvA==
X-Google-Smtp-Source: ANB0VdYLxzVwsj90De3ivEF5R08ATroTdc5HOWelDjoQXd0ZU4W7REm1kN3YW7lf7D7IUc1C5UZM4Q==
X-Received: by 2002:a1c:ec06:: with SMTP id k6-v6mr2272867wmh.39.1534939416710;
        Wed, 22 Aug 2018 05:03:36 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([45.76.138.171])
        by smtp.gmail.com with ESMTPSA id z141-v6sm2637210wmc.3.2018.08.22.05.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 05:03:35 -0700 (PDT)
Date:   Wed, 22 Aug 2018 20:03:30 +0800
From:   leo.yan@linaro.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] cpuidle: menu: Retain tick when shallow state is selected
Message-ID: <20180822120330.GB8949@leoy-ThinkPad-X240s>
References: <34910476.pgRhNDWo5t@aspire.rjw.lan>
 <20180822120200.GA8949@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822120200.GA8949@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 08:02:00PM +0800, Leo Yan wrote:

[...]

> > +			if (!tick_nohz_tick_stopped()) {
> > +				/*
> > +				 * If the state selected so far is shallow,
> > +				 * waking up early won't hurt, so retain the
> > +				 * tick in that case and let the governor run
> > +				 * again in the next iteration of the loop.
> > +				 */
> > +				expected_interval = drv->states[idx].target_residency;
> > +				break;
> > +			}
> > +
> 
> This is reliable, how we can rely on a shallow idle state target
> residency to decide if need to stop a tick or not?

s/This is reliable/This isn't reliable

> 
> >  			/*
> >  			 * If the state selected so far is shallow and this
> >  			 * state's target residency matches the time till the
> > 
