Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD32C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BE62147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwnYsV93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfBHHRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:17:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40975 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfBHHRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:17:30 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so1259138pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 23:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FsIYsxEIqBscnFcelcBiL1zQ4XvUS8w5wcOoGC+EPI8=;
        b=nwnYsV93mWADDtWq8UFp12U3lm4rmg2gHzKyC7DO71L6J6GQxryB8MQmIoD85KTAtu
         xwfgvVy0VnsavAhayr+z5l6L9Mi31B9EIT0j6FLgoDpG2MDdk7aKx3xHpSC7zV5HifdM
         awJkYg4D53WWsWxC4gj39TsXPad4vkIpO8TPjH9eRGuWKTKXaiZ6+RIki4MNRNTS37cY
         Clf3sJtKVna7y9CG+ZDnku3k3qn8wx1rIHPmKLR64sk8gVXV/ki0OzvYxzefyJRDpVq5
         aZrcNKJ/12XQK2FI4U19Y8McMJyqZQa+sd0RQQaYXTVwUSZ2nevJRGlZRePw5Pkbijvj
         AgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FsIYsxEIqBscnFcelcBiL1zQ4XvUS8w5wcOoGC+EPI8=;
        b=dBb/SgUDV58DuUxLGT7BGNbEjmVpqC+u4tQW4PZVxlXm5C0vWWy1NsjPZNDlIhR0lP
         0FgkE7CVp72/256S2/FwI+Q7uCXtIAt505pewDprj+qBGG3e0WjZpBijZCQr4pM8ZoF0
         bg4b+pmocuZnvZxO/Loe/fmmVZMEqTpS9AY8E/iBKrr+fGYMcwDN5bcSL19g2PSQ3uRj
         VJ+sFns8cgT3LSNkgz26vyddLc6YzhoQBfyYkzTy4uis5tPD+4IxFg6rK72WF9uLC3+q
         xQ4K4+sfYatUy9iYlWGXvHfErRsewFWV29k3L6kO33aja6fzu5fHvnRNzofE7XHVNDsx
         loFQ==
X-Gm-Message-State: AHQUAuYcxX2hbBNeKtcR/R7e8LOYt3F7RtlV5Ts9QoY+Ti8vClGEm3g0
        bSdOCy14V+npL5FG2cZhWa2gcQ==
X-Google-Smtp-Source: AHgI3Ibk5qm5sSrhyoRyNa14nNoLzvCYCMNMFIP5WX7YvZG7Ol8gaOwDIsO+UCsEI+iuJULn5eh7nw==
X-Received: by 2002:aa7:8759:: with SMTP id g25mr11710618pfo.248.1549610249686;
        Thu, 07 Feb 2019 23:17:29 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id n68sm2057498pfb.62.2019.02.07.23.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 23:17:28 -0800 (PST)
Date:   Fri, 8 Feb 2019 12:47:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Graham Roff <grahamr@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
Message-ID: <20190208071726.urevxs5a3vaf7gwh@vireshk-i7>
References: <20190129015547.213276-1-swboyd@chromium.org>
 <20190131092349.fksfqemm23qddkhw@vireshk-i7>
 <154952629766.115909.11259861549408107064@swboyd.mtv.corp.google.com>
 <CAPDyKFrrncpfEfbZJ1LHvqDbkc29CaJxZnXwh4Mz7PT6Efbctg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrrncpfEfbZJ1LHvqDbkc29CaJxZnXwh4Mz7PT6Efbctg@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-19, 14:37, Ulf Hansson wrote:
> I think we also need to consider cross SoC drivers. One SoC may have
> both clocks and OPPs to manage, while another may have only clocks.

We already have that case with CPUs as well and dev_pm_opp_set_rate()
takes care of it.

> Even it this may be fairly uncommon, we should consider it, before we
> decide to fold in additional clock management, like
> clk_prepare|unprepare() for example, behind the dev_pm_opp_set_rate()
> API.
> 
> The point is, the driver may need to call clk_prepare|enable()
> anyways, unless we make that conditional depending on a DT compatible
> string, for example. Of course, because the clock prepare/enable is
> reference counted, there may not be a problem in practice to have both
> the OPP and driver to deal with it.

-- 
viresh
