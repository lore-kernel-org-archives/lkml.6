Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3DFC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4222E20882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcNmju34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfA3Ge7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:34:59 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:47039 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfA3Ge7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:34:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so10944958pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 22:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jNE+4udC0izqltLgoNQtEx1CbuDQNuojldpq4eIFanM=;
        b=PcNmju34AKOJkMXvsX37WqzCFdsnHpkdz2LmjdOnUruddbhgMa0AW8Ur/jaTbFmUsL
         Dk9t63qixe79JTpMPsw5XwIiU3S8vMWSnBnTcpUuHYTvmsGMt9ppoutuCdWMy7z2lNzZ
         na4L3ZLldkTd3V86Yl1kyCK0eBRfukiQIugwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jNE+4udC0izqltLgoNQtEx1CbuDQNuojldpq4eIFanM=;
        b=F+J3jt+vBCzXWepkH7JBZarQQHPErA7vErHNeZHljjmD7054cF1RCubH+DGaNh4giG
         v/VcV3PpuI8RdKgmSGXCfWfGWuil4jn2zpBkMi9zS8qvLMlk/YX311TVXJvq1WPgZsig
         YYuZr3X44jlKEQq5BVOfbORaSadRj6utxhg9GkpGOQQeu0m3sagmbkjpCUqmwiL1w8Z0
         ZfenE2p4e7w+nV07X3XvesXAPwhZBkPrfTZ663eLq+tps/6f9+DDH3GNBT3WXlZNXu7o
         ngYcxiNckAKngkO8Xh8Geizvhvfgc/fA5DPbcMDg6T37LAE2guPqeXKSpZjEjm7AGP+r
         eP8g==
X-Gm-Message-State: AJcUukdobY4CwN28yYk1A6kSfOP6RjSksbAXYMxeisAtOm2WGSwKU+cL
        ApiRxnm86AYSzq/rnuTnOfC7VE5TtGw=
X-Google-Smtp-Source: ALg8bN4wqACNmNwBQWEkThd6R4S/oVreQdOj09EK79gW9oVxRIJvHJE26c4SfvGxNbfS+hBCyCcaVw==
X-Received: by 2002:a63:184a:: with SMTP id 10mr26170579pgy.81.1548830098223;
        Tue, 29 Jan 2019 22:34:58 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id w128sm1093953pfw.79.2019.01.29.22.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 22:34:57 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:04:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Auto-register the driver as a thermal cooling
 device if asked
Message-ID: <20190130063455.f7wuv27zias5k5kp@vireshk-i7>
References: <CAJZ5v0iwq15mwoa-LBN07fgNNurtBGodG6urgfnvMbGWj8vyAw@mail.gmail.com>
 <fdff26d908c5338df44574085701ed93a64af079.1548825443.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdff26d908c5338df44574085701ed93a64af079.1548825443.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-01-19, 10:52, Amit Kucheria wrote:
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> to register the cooling device on their behalf. This allows us to get
> rid of duplicated code in the drivers.
> 
> In order to allow this, we add a struct thermal_cooling_device pointer
> to struct cpufreq_policy so that drivers don't need to store it in a
> private data structure.
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 11 +++++++++++
>  include/linux/cpufreq.h   |  9 +++++++++
>  2 files changed, 20 insertions(+)

Thanks for the rework. This looks good now.

-- 
viresh
