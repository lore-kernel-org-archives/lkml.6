Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6716C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFD920855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="azxt4IIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFD920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeKZTjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:39:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38125 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeKZTjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:39:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so13534896plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=46CET2+Q2IdzQ/i3quwG541JRfuR6CuxmXLMvtEzmwc=;
        b=azxt4IIP8t82KkeRGVKgYwr8GL3OVXxJkcu4hpOQ8QNA5Z8YQDlm7VHImFPTN7yK+P
         hdd4Hzshq5cDXCbxeAZ6qOTB2iq1/o5gsS76w7Ie7s6JLLmA2DKY97lkK8RUWxDoBkUO
         8SNAxpuwRM4OoOG1144iebWkrqp4AfRJioaZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=46CET2+Q2IdzQ/i3quwG541JRfuR6CuxmXLMvtEzmwc=;
        b=n6SjIU3E+pDXukjfvYXxlq8BrmLYWJ9YB9A8pfe0Dlku273Z8Mw+3Cvfcc8px0TDP7
         oaqejBMKNaRmpmJzESf/bL8kOBwRZPixfzCRpnwvXoYXODjkevv/P5udscZrNgePdo9L
         ga6vu+KIjOHcMeFHe/nfS3FVAH+Uasroj6vvGvSWPy0lbA3vAtwwI0HHgtGcQtrtV7dg
         il5oPCa7ofL6J0XwWGgqh5jAsi9Vyt9u3UidMHxvSb/YA3M9gFSSs4/nCunOpnHh516h
         yTdqEHgMToT/9gmshspfKGFNpUnG7vu0wH8pRC/zKyDM+bHWprEoC3/GTzMyPygIJxxX
         zGeA==
X-Gm-Message-State: AA+aEWaQ4XK5pwgToojRdJq2VfK2zBQk7WIlRWmkLfthDcxXP4B6pX1z
        KpHV1PHYvIDmQry9YhQjEaAR+Q==
X-Google-Smtp-Source: AFSGD/WDkNQlSvKH4zRg050vAHXYvOwuYXkYm1grgNRDa/dq/Xz2+lTE0o7e+FN8EXbLN9qJsAYgEA==
X-Received: by 2002:a17:902:2862:: with SMTP id e89mr27180376plb.158.1543221936838;
        Mon, 26 Nov 2018 00:45:36 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id w80-v6sm95740479pfk.11.2018.11.26.00.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:45:36 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:15:33 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
Message-ID: <20181126084533.f5kydkdhukjez2kg@vireshk-i7>
References: <1543221866-19671-1-git-send-email-daniel.lezcano@linaro.org>
 <1543221866-19671-2-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543221866-19671-2-git-send-email-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-11-18, 09:44, Daniel Lezcano wrote:
> In the case of asymmetric SoC with the same micro-architecture, we
> have a group of CPUs with smaller OPPs than the other group. One
> example is the 96boards dragonboard 820c. There is no dmips/MHz
> difference between both groups, so no need to specify the values in
> the DT. Unfortunately, without these defined, there is no scaling
> capacity computation triggered, so we need to write
> 'capacity-dmips-mhz' for each CPU with the same value in order to
> force the scaled capacity computation.
> 
> In order to fix this situation, allocate 'raw_capacity' so the pointer
> is set and the init_cpu_capacity_callback() function can be called.
> 
> This was tested on db820c:
>  - specified values in the DT (correct results)
>  - partial values defined in the DT (error + fallback to defaults)
>  - no specified values in the DT (correct results)
> 
> correct results are:
>   cat /sys/devices/system/cpu/cpu*/cpu_capacity
>    758
>    758
>   1024
>   1024
> 
>   ... respectively for CPU0, CPU1, CPU2 and CPU3.
> 
> That reflects the capacity for the max frequencies 1593600 and 2150400.
> 
> Cc: Chris Redpath <chris.redpath@linaro.org>
> Cc: Quentin Perret <quentin.perret@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> Cc: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/base/arch_topology.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
