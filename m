Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EC6C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C5820892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwxeC5Wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0C5820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeLNKrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:47:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34367 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:47:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so1330848pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xhw6ncEjQ60lIj0jN2vfwEh1OlRmF1+fjw0az21rJd8=;
        b=GwxeC5WaWqFxeMw6e4ffgWtFv7Z5uul3ZWtCcBbwVVA73nsEWU5xHQZucvZmzJLhK7
         HZlJRzdgh+db5SH+uThjECs+X+Ge6DCA0uihfYzVBtj3qReM1vF5+1nmqwUCgRQ1fIIS
         XRnnW5fhOOEmU/6RFodsRl1Qk1/XwqneXYMvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xhw6ncEjQ60lIj0jN2vfwEh1OlRmF1+fjw0az21rJd8=;
        b=EeumUF/wXm7pycIrhRyW9UB/XhVdDCf/dwoMJ4r2eJX4l3qEeOFBy7vK+N7Uufq5Lp
         H7Ha+CS0zqghwyAIuJhtxD4wtjJ+0aMg9yu8es+Ut+4gBcXeeIMFPvP2rcHH53i3dnfP
         zwLU7NjksYAErSj8qU1s9VHIH8d2K3BIivhWZzSuco1OPYgDzdL7WypmbF9tBHCXxu+2
         QV3GWgybC6rbSNICPRH3gNG7KcLQPnUpnt1XfHqZ78qJQkv4VEwO6MSydl2geHTlYVkB
         RBxISoF49PiB2c0aSDhglp6uMQ9o5YSGpDiSoOcuiWmdrb7vrPOONrJNT2qcZ1Ido60R
         Tbvw==
X-Gm-Message-State: AA+aEWZxQfqOY1G2GeRBUjd3jvy3mELcblXGSmNFRJsGiht7wJ4CCXYM
        5u7hu3TP846fsn14fgPgTzvDbQ==
X-Google-Smtp-Source: AFSGD/VjoMo4YgbkXExh4bZwnkSxRXv+KSe0ohaWOsttUZvSaJ5svDMZ3KhaHrWhHyH52skljny7zQ==
X-Received: by 2002:a63:4c04:: with SMTP id z4mr2302595pga.312.1544784466103;
        Fri, 14 Dec 2018 02:47:46 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id e16sm6024989pfn.46.2018.12.14.02.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 02:47:45 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:17:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 6/7] PM / Domains: Factorize
 dev_pm_genpd_set_performance_state()
Message-ID: <20181214104742.szicfipdffaegcoy@vireshk-i7>
References: <cover.1544782279.git.viresh.kumar@linaro.org>
 <f6153683d88cce25319945e4308bef46edaaaa54.1544782279.git.viresh.kumar@linaro.org>
 <CAPDyKFr7_Cn0N=pctuTdqzcUy9fg-fmpd5OgEFS9eRz-SFh1Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr7_Cn0N=pctuTdqzcUy9fg-fmpd5OgEFS9eRz-SFh1Fw@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-12-18, 11:40, Ulf Hansson wrote:
> Nitpick: Would be nice to remove the beginning "_" from both
> _genpd_reeval_performance_state() and _genpd_set_performance_state(),
> as to be consistent with existing function naming in genpd. However,
> it's not a big deal and can be done on top.

Actually it is used at some places and so I did the same for the
internal routines:

_genpd_power_on
_genpd_power_off
__genpd_runtime_suspend
__genpd_runtime_resume
__genpd_dev_pm_attach

-- 
viresh
