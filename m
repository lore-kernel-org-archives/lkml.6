Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BA9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2419521104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 05:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c4+ByzLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2419521104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeKUQOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:14:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34482 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbeKUQOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:14:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id f12-v6so3808032plo.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 21:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FFhMeDyNqan2INPwai6c6EnLF8MI8kDq3oeRMdMPLA0=;
        b=c4+ByzLkt1C2ngGxGNuTs3WRfMs1VCmCGWyAy7wQpfvIVxYaxvUuENQ5OvIuPVmNQk
         8EUpFGUG2XWsosw6kgkr7q4Y6tMxaWXdG6XCKSjJaRMT933V9J5aqItQke2TxfH0SOR3
         PVf0AhoV3OZVrXqa5l4gQYobzFqG1aoXylyKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FFhMeDyNqan2INPwai6c6EnLF8MI8kDq3oeRMdMPLA0=;
        b=FWWXw6Z/aNr1CV/MGYlhiXXgMrZZ+As+Itup2n0ciQPmU0UjCji/PnSx98Cf7fLkGH
         8Oa3tjeMvN6vWR4Uvne07J3um1qEoQjXyGu6uvlwzI4OkHiey6unZrxG4Ux/Xbmdh0Sf
         f/0rg6o7nXuy6D5aBtuIUndHN+oSguse6KQBdcvakZ5bJdlpPCHKrI1dw8KfZmvBZGTl
         rmpQy78k7ppEWAegFgV5JmX0nVJiDOAj0Gqdacbws+DJV42N/08Z0EesYLxZdSV4x3r8
         YktWGlwfAhBSiGxNaecZPoQg7qeQygYOoeqWek0ZmHb8JbWXwyDjaU2BnZV7BuAhLp7g
         LesA==
X-Gm-Message-State: AA+aEWZ7sZLwntguGGCUujzOCetAUczjrpwLELfN/Z+PV+iYmpmd9p0E
        jkxr9KKVBXxv9NL+A2+p8ccPpg==
X-Google-Smtp-Source: AFSGD/UndfkEED2895jYg3aw2CQivd7NBr8nuJW1ZnrB9W4lmR/3UYlz/4Sd8mRYs5TuektOySTc4g==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37-v6mr5376116pla.256.1542778903307;
        Tue, 20 Nov 2018 21:41:43 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id f22-v6sm56607963pff.29.2018.11.20.21.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 21:41:42 -0800 (PST)
Date:   Wed, 21 Nov 2018 11:11:40 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] PM / Domains: Propagate performance state updates
Message-ID: <20181121054140.c64qf6m2kl2rfc5d@vireshk-i7>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <7e1ea283f9eebce081af80ddb8d3ca5c9c76cd3b.1541399301.git.viresh.kumar@linaro.org>
 <71530b01-eefa-4778-0b17-d7774eb48356@codeaurora.org>
 <20181121051626.izb6dem62zoaf2c4@vireshk-i7>
 <68a3294f-5556-4b5f-f8c7-79c20b5c70fb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a3294f-5556-4b5f-f8c7-79c20b5c70fb@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18, 11:01, Rajendra Nayak wrote:
> I would think this is analogous to a driver calling clk_set_rate() first and
> then a clk_enable(), which is certainly valid.
> So my question is, if calling a dev_pm_genpd_set_performance_state()
> and then runtime enabling the device would work (and take care of propagating the performance
> state).

Two things here..

- First, it should work.

- Second, we don't look at device RPM states but only if a genpd is on
  or off. Maybe we should look at device states as well, but then we
  need to initiate set-performance-state routine from runtime enable
  as well. But that is completely different work and would require its
  own series.

> In my testing I found it does not.

As I said, we don't do anything in RPM enable of the device currently,
but only during genpd_power_on(). So if the genpd was previously
disabled, RPM enable of the device should have done propagation of
states as well. Otherwise, we should already have take care of the
vote from the device. So, it should have worked.

Needs some investigation on why this isn't working for you.

-- 
viresh
