Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651F7C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A63F2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dGh9X8SZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A63F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbeLCKeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:34:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42319 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeLCKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:34:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so6129241pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zTlk1KezwY6D9J0ZZ91vq4UIVebg1Y7HqZFlx2zC3B4=;
        b=dGh9X8SZJbTszNZ6diB3GoLjFvZbVxNkyEgBk1eyCKCTlp4KH9/i1I2lv+rosCrW+H
         fA0mMAs+IFStNB3VQBLifr3pfXxp7GHYmulnjnM8VdS74x+61vw0pMYZitgU5Rr5FHdT
         4TUdYIImFNTZWX/AtlYzGhcWDnLFKuzJO48mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zTlk1KezwY6D9J0ZZ91vq4UIVebg1Y7HqZFlx2zC3B4=;
        b=TdWuc5YeJBkpl7dCphFZvtos6dFbS28UoBXJpDqiQOLg/0lZFjj32xdZXpQXjZHNcz
         4Whf2fPOtJntIXQeD6TV/xEGFxSqW4YwQ84T15FpIDx1LF637qzc200ubZvLe5tO3msV
         R56CGHVGvKgPT6CljWxrFKFo1zb3IxgG8sB4Gk2O1sXZyBNw1YYTakh6/DnkBoXGiuOK
         /K2FGfV1aGXSNmdCMeN+J4k6GgpxLJV5I2QEubPJVxVEVWhIM5FbbNMHWT5oAJvCj1Wp
         yTzoazwPt/VEaDkZnRI3pBldzcEySIyUVQrRSfzHQ+cbil8cjmBKjjhmUuHtvHwPKxje
         CrXg==
X-Gm-Message-State: AA+aEWYQYo08aUvA2FHp9LcioGwwErAEQ2IhIa0rSuBwEDHFsFz6mZcE
        7brpaPHql7X/dm9Xz4Jp7G+J+w==
X-Google-Smtp-Source: AFSGD/VtumnY8KI8c4WpJ74Vv0Aun/yzqFEhEdExNH+HFl/bj/lgR5KIcy5WUwAi8/RSQoMpKb1NSw==
X-Received: by 2002:a63:5026:: with SMTP id e38mr12830563pgb.123.1543833212386;
        Mon, 03 Dec 2018 02:33:32 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id z186sm20599545pfz.119.2018.12.03.02.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 02:33:31 -0800 (PST)
Date:   Mon, 3 Dec 2018 16:03:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH RESEND] sched/cpufreq: Add the SPDX tags
Message-ID: <20181203103329.qxoquo46yeznbvpe@vireshk-i7>
References: <CAJZ5v0hRgBShA_MkqTtvX+Y9QVYKKyLW5jtTzEsNpZYaRTcEFQ@mail.gmail.com>
 <1543832969-8440-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543832969-8440-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-12-18, 11:29, Daniel Lezcano wrote:
> The SPDX tags are not present in cpufreq.c and cpufreq_schedutil.c.
> 
> Add them and remove the license descriptions
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  kernel/sched/cpufreq.c           | 5 +----
>  kernel/sched/cpufreq_schedutil.c | 5 +----
>  2 files changed, 2 insertions(+), 8 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
