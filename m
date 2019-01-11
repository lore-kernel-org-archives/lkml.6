Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C82C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6C72084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FN7qan2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfAKDcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:32:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38893 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730120AbfAKDcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:32:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so6286443pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 19:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DOEoOTFnCJtH0Vw91l1W7H3fMhcZNKrRGlpTflF9xMo=;
        b=FN7qan2z1uCWFu1klGhxb5ItOCIy9qs7wXE97ddNl8haasScXvBfxqd4T25tTOtuR6
         4OjJmDahxiM0RkQyBygRba9pveUN2RgJ+vJ+q2/tDfdepO8z/tMF1AAHITcmfOmI4lr0
         A6ZhGogIt0yh4np5bd8KK5ifAXBpgutoAqyoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DOEoOTFnCJtH0Vw91l1W7H3fMhcZNKrRGlpTflF9xMo=;
        b=Mi6cNxOXAJJNu1n5tnKtGMZQhuz0CJxkQBuq9RIjZ1KQr1HYApsyxVulAqU6Vx3/a6
         IikN/PYsiuubz5xbePtFqyEu12NdkOmdm7qIot5oYx3Xyv06nJpUfCT9jF9Cd93QoUUu
         YLc/ef+/mDUTMxfphcurotJoh7GTj7B6Le2doVPpaGLzFGhKAEdhAX0PKhs6synvromz
         efQlBJHW1bpi2mR5IkNO9c86Qj+BeQ8yRegYT73YSOrab49SzecCiSfPcy7C7PWnoBIC
         DT0P2JSXLt3Y5AsLELZuBFzC5xyLj6emnElQWUL6mRUSHcKTGfk95UtH6gXi34Jp0598
         OtCA==
X-Gm-Message-State: AJcUukdzNk/Eooi29ZbZvZ/o+46fLhBM12FvIP3dQzbZrTYcsI7rEUUR
        eiHnZWWIz25fR0f4uKfYy6XgMA==
X-Google-Smtp-Source: ALg8bN4BK35qiCCMFn/RTPIQXqB74gv+dnrjLRI3+9ZjKHLsLdXzz4xD3gU6PKekNWxYm9XM4X/aIA==
X-Received: by 2002:a62:220d:: with SMTP id i13mr12775103pfi.162.1547177539994;
        Thu, 10 Jan 2019 19:32:19 -0800 (PST)
Received: from localhost ([122.172.34.203])
        by smtp.gmail.com with ESMTPSA id b2sm130779484pgg.87.2019.01.10.19.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 19:32:18 -0800 (PST)
Date:   Fri, 11 Jan 2019 09:02:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 6/7] arm64: dts: sdm845: Increase alert trip point to
 95 degrees
Message-ID: <20190111033216.u3ic5it3lygot4sb@vireshk-i7>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
 <041258d65883df964890249a24d2a4788c419304.1547078153.git.amit.kucheria@linaro.org>
 <20190110011533.GV261387@google.com>
 <20190110021522.GW261387@google.com>
 <CAHLCerM+p+GkVsR_WuC0xF1oFvj=8cZ+OmU=pMssfZGGs-eS7w@mail.gmail.com>
 <20190110200034.GZ261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110200034.GZ261387@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-19, 12:00, Matthias Kaehlcke wrote:
> Viresh helped me understand that we currently need to add cooling
> device entries for all CPUs to the DT, even though at most one will be
> active per freq domain at any time (I wonder if this could be changed
> though).

Actually we were only adding cooling-cells in CPU0 until now and I
fixed that, so that is going to stay :)

The idea is that the hardware should be described properly and not
partially. Even if all the CPUs are part of the same freq-domain, they
are all capable of being a cooling device here and the DT should
describe that. Kernel will ofcourse create a single cooling device.

-- 
viresh
