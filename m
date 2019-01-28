Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF9BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66B42148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcoVniot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfA1GrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:47:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46405 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfA1GrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:47:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so6798105pgp.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WdOG/w3P4xjPkdGVh+Q+rKQqSzzNarUNy0xmDXfHpuo=;
        b=BcoVniotemf9eSeL4a1+Rp342oPn8DLhzCvfu9nxJdTfchiqpwxcPqTvHHg7MI54kY
         3hAEoOLAbUJg40K8lEz/Vbplhj0X+QpJmy3zPF44Qc0gemSkR0/z6BCCW+3ONATawu1A
         DYaUXLKJrNlmIJQkRTPF9P9izkjd8r81jRS9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WdOG/w3P4xjPkdGVh+Q+rKQqSzzNarUNy0xmDXfHpuo=;
        b=fnDwITOyMwwel9uvRw8ckt93UXcGYTlrdNun4CqN/9Ksah5AbOdfhF49pVL1XE3WYK
         dkj8fUFMumaFqs5f7Ip3bIefRSU5iYylmEeZ/+nLCGAxmoLeVGd6LQdzXOewVgKUDWe3
         JvnfLKq5PVEwht4NyCiVECsTGlVTVnfPnGrUkA1E4H85hg42Pc0SlozsPosnNNrR93XP
         7alBV4w8orq+rZim6sUi/ff+TesiYv+SLUJPckfLU/gG7XsM4o0WhY8N3CVz9Y94nt6H
         xm4SlFson58KfuO3EevZMYI6iZuVo5/O+VzoJPkoRkKYu1J3kw1xXpiM8eiCWWRQRno1
         10fg==
X-Gm-Message-State: AJcUukczNFtoSH+rH9/kz3YCDsNXMFwzryHX1x3FrPqYvlnmCEc0bp3q
        58cHpi1YSmNyKUImgeZspHb71g==
X-Google-Smtp-Source: ALg8bN5yYo4VGXt8OEN/cZnih/mHBIoypyl6/+N/aaNPSw43V6sSZxZQoOL7FQ/tGPcPwWzLWODdzw==
X-Received: by 2002:a62:46d0:: with SMTP id o77mr20985490pfi.172.1548658024889;
        Sun, 27 Jan 2019 22:47:04 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id h8sm35618916pgv.27.2019.01.27.22.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 22:47:04 -0800 (PST)
Date:   Mon, 28 Jan 2019 12:17:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 0/9] cpufreq: Add flag to auto-register as cooling
 device
Message-ID: <20190128064701.r25ffs5ixzkcd5r6@vireshk-i7>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-01-19, 12:11, Amit Kucheria wrote:
> Add a flag for cpufreq drivers to tell cpufreq core to auto-register
> themselves as a thermal cooling device.
> 
> There series converts over all the drivers except arm_big_little.c.
> Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> others.
> 
> Things needing fixing (but not a blocker for the series):
>  - Look at how to detect that we're not in IKS mode in arm_big_little's
>    .ready callback.
> 
> Chnages since v3:
>  - Got rid of wrapper function to register/unregister cooling devices.
>    Directly call the function in cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
