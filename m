Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA7DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13ECA2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/9qP+xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ECA2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeK3Scq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:32:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38613 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeK3Scp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:32:45 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so2354776pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 23:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xpqa9QfGgQPgKWsLbdFpk9gVOqyBk7Vk2N49apuMnw4=;
        b=M/9qP+xVo1l+9r5yIMnCmbyg1ByEN8HrQIm+4yr+PyJfS73Nj7SJ336L2wyRc8sUlH
         1w9ncn3nz59ARRpi0MMEkyL7IkVb90Dj7XuBmqL+3NJiA5id9eGGWbF+s7lSjpPtDkOb
         NWGoddexHTXJDI7z9Xcqj17r/XNhhk0YiL9/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xpqa9QfGgQPgKWsLbdFpk9gVOqyBk7Vk2N49apuMnw4=;
        b=nkw6XS3ofgEkZ48f4VCS3gInSXJAtwBpaCDjVSeSfaWzdXKV9w6I9Qqt90KeQhaKpA
         VnTHjZe/Wv+F6qIrF7WYJd7L4FL8OI+E8xQc0izUC+WNQty1bJqwZqXRBb39zbxOTvPN
         3s0jxFp04xArGI6mX/30Dcud3kBauwUxAE14Frcu5cOzd7iYpWQ2VxL9H8Fwa8bd6Z2S
         xVVI6VfSlLuP5dSGRxb7EG1FKEdxYGhNl8AOG1MlPxMMkfjIyxyNA5aRVQfnVYv9QJ6t
         A8HbcwF5HWyEpXomyRy4ftoEgjxViPpX51DQHm+CC85BShfM+jMSM4lfWToVhKKheJFN
         72mA==
X-Gm-Message-State: AA+aEWak5RVGIFLBFg7N2G6buyrGtAGV+dIYG5ihaK5PA5uEicRbXVpX
        dg7j463rhS9FfA7Xayv0wuhV1g==
X-Google-Smtp-Source: AFSGD/XLOJEX0pQWPPUkugzWlQgEzLD0NkdCgqfJ12727c8REvhGJKCnvTXm24oQkxuZnLCzb5rY3A==
X-Received: by 2002:a62:6f49:: with SMTP id k70mr4516524pfc.7.1543562664209;
        Thu, 29 Nov 2018 23:24:24 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h15sm5376729pgl.43.2018.11.29.23.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 23:24:23 -0800 (PST)
Date:   Thu, 29 Nov 2018 23:24:20 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 1/3] clk: qcom: gcc-msm8998: Mark hmss_dvm and lpass_at
 critical
Message-ID: <20181130072420.GG5278@tuxbook-pro>
References: <20181130065259.26497-1-bjorn.andersson@linaro.org>
 <20181130065259.26497-2-bjorn.andersson@linaro.org>
 <154356151361.88331.1298482384404357982@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154356151361.88331.1298482384404357982@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29 Nov 23:05 PST 2018, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2018-11-29 22:52:57)
> > Keep the two clocks enabled, so that the platform passes
> > clk_disable_unused().
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/clk/qcom/gcc-msm8998.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-msm8998.c
> > index 9f0ae403d5f5..d89f8e7c2a59 100644
> > --- a/drivers/clk/qcom/gcc-msm8998.c
> > +++ b/drivers/clk/qcom/gcc-msm8998.c
> > @@ -1972,6 +1972,7 @@ static struct clk_branch gcc_hmss_dvm_bus_clk = {
> >                 .enable_mask = BIT(0),
> >                 .hw.init = &(struct clk_init_data){
> >                         .name = "gcc_hmss_dvm_bus_clk",
> > +                       .flags = CLK_IS_CRITICAL,
> 
> Please add a comment about why they're critical. This is a temporary
> solution?
> 

Disabling them in clk_disable_unused() are bad, mkay...


SDM845 marks the equivalent clocks as critical with a comment that they
must be on for system operation... I'm uncertain what the exact purpose
of these two clocks are, so I don't have a better explanation right now.

Regards,
Bjorn

> >                         .ops = &clk_branch2_ops,
> >                 },
> >         },
