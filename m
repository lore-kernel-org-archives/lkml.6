Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A352C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2318F2152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LfgwQBXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2318F2152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388205AbeIUAmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:42:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37868 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUAmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:42:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id q5-v6so1297926pli.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4QekagQZVSM6kezMoxi06jvmyWULqWqxwwYlzCjtwqk=;
        b=LfgwQBXSIZXE5/TBW1xCHACz8QF8LXfakD8xDJS5uWCqQzt8vl6HCTb4GhSjo+N0Ux
         QYnTH1oLJjc4jUprOhlAGWJZpmp8YttmMKO1BtjpMUJCk/vXRRdsyfq8AKV4sBLrbaPy
         XH3AQZZ5toMph9YA1jMZKCxSvvHQ6VAbV5O3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4QekagQZVSM6kezMoxi06jvmyWULqWqxwwYlzCjtwqk=;
        b=Ldc0b9/9GzqhCl4XBwefsDafEx8CgeZfqgR0ZeoRWl/mmz2JsARxgMiLCTuqK7kM6P
         uG51G6IcbMoGmZmaVS0/HVcF921D2tEZ3renVB9p5MUvc0LEaPRPuMUr4ngCqz0Y/n+t
         QfeTOamKKjCOy1rbJ9/hWGd5SZQwBJKdyZ1Q32WvZfPHJ63GbubVsZgl0uCMzVezHBzJ
         9SuHV9qYQMOeamD8/z8PiDbEZXxkkQ4ttF+3rlVXat37Pc7Tz3aa3fZKGLeb60DZe8Ev
         haArIOAGUVvMK4FpdwtqeEKXpRcUw5lej4p/qsNKt08McIkFe0MYi2AyKCk+GmchktE7
         2aWg==
X-Gm-Message-State: APzg51AgK1XOWXGZVOsi5kyu53qHSI99FRACYhHZ5FJSPI7S6o7U8BOB
        0COiewIq4McVXJf4SChz/SRnkQ==
X-Google-Smtp-Source: ANB0VdYNDxlCdq7Fh1tDOhTkvAeaJiFZEKGHy44Tn8daf5+EFTKN62eC38VS23fpOmifWhre8//8sQ==
X-Received: by 2002:a17:902:7614:: with SMTP id k20-v6mr40639620pll.170.1537469850778;
        Thu, 20 Sep 2018 11:57:30 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id h69-v6sm59393021pfh.13.2018.09.20.11.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 11:57:29 -0700 (PDT)
Date:   Thu, 20 Sep 2018 11:57:28 -0700
From:   Andy Gross <andy.gross@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, smohanad@codeaurora.org,
        dianders@chromium.org, mka@chromium.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 09/16] arm: dts: msm8974: thermal: split address space
 into two
Message-ID: <20180920185728.GA28458@hector.localdomain>
References: <cover.1536744310.git.amit.kucheria@linaro.org>
 <088724896f21d556ecf1e16a6c59c0e404444fa6.1536744310.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <088724896f21d556ecf1e16a6c59c0e404444fa6.1536744310.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 03:22:54PM +0530, Amit Kucheria wrote:
> We've earlier added support to split the register address space into TM
> and SROT regions. Split up the regmap address space into two for msm8974
> that has a similar register layout.
> 
> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT).  This is OK since the
> code doesn't really use the SROT functionality yet.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Acked-by: Andy Gross <andy.gross@linaro.org>
