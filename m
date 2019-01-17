Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E34C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A94820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQKx2Wmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfAQOas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:30:48 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37796 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:30:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so4916268pfb.4;
        Thu, 17 Jan 2019 06:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vPE0iJH00uw3g29XdpOWj4FUNR/fWr5PSPg5JASa3T4=;
        b=RQKx2Wmr1EIzy8KrI0FcG/Cj+y3OidW4W4o6VJDIh4MH3P5s3f7H2BrcxxdU71m2uN
         z1e7uPNp+vlTCi2Ds53R8uJj0NdqB0Ioa0qr21OKkhBQJiV3LYVarWpNj+goSl7NHjjE
         jhKJNcdGwWluHmoipQ9PJK/uCO7JxyMz2qcTcMdssSOXF3nT4DN6sxk0g0zXip6YbFGQ
         M5YBdYZxcDUJFkH5IUyOEtSnS4NhJp7jfSiYCwgZmW9DG7VKciHODyme/+BJi9jRcEUi
         G8LgwstwY6qw42ll9SVmtVNHg2HfY2NE75F6O+DtOeQWr/vc3ld5isaFuz6BKRCLUN4h
         Psxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vPE0iJH00uw3g29XdpOWj4FUNR/fWr5PSPg5JASa3T4=;
        b=So6aT+I/oZx9g7meNzkYCsIDYq27Gg/GoVM3nHcLP9zh12//+Pud9CflXj8RUUdYxi
         GiqPw4D/AmEn6XBYNY/tpF5pcwjY5fnGzEerOIE3c+l6Yv6bUeqnIGK8/GlZuThMt87O
         hqTPfjM7KknGIkiCZi0CgLpaUyntStQyknd0QApoRQJx/B81P/WxdyBgBLwW3PUxE80L
         SRY9j2UnbB7Av3hhgHF+69WMmasyKzAhPjDiKqPcsE7Se+W8R/2T8giDs61CgvAdL+5n
         BBjFtqR68RG/5LAgrLfuV+5mVxRgZpA3QLMIUnwoDGim5WlEZxgOtCRHhBUA/m3Cwr1r
         KGqw==
X-Gm-Message-State: AJcUukdx6CppoofVMwBA++LgGjNDz3gwVB/bbQQ2CWXmIVdCqLSeZPun
        mL/Jc8nM7cS1meEIgRXDfLM=
X-Google-Smtp-Source: ALg8bN7scCulcV6ZI4hjZ5rcT2zWWnBwK7E7cCHqYdj6Yvq2Ge+p1DbVb0QknU4Q+XJwjw+usKpjag==
X-Received: by 2002:a62:1289:: with SMTP id 9mr15352393pfs.102.1547735446408;
        Thu, 17 Jan 2019 06:30:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s130sm2363225pgc.60.2019.01.17.06.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 06:30:45 -0800 (PST)
Date:   Thu, 17 Jan 2019 06:30:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] watchdog: qcom: Add suspend/resume support
Message-ID: <20190117143044.GA30757@roeck-us.net>
References: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
 <20190117093113.GA23389@basecamp>
 <91108b9b-fe05-1068-b07e-872cb4cd4012@codeaurora.org>
 <20190117112730.GA25198@basecamp>
 <b9f573ec-3787-2b05-52e3-60f11c061dd7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f573ec-3787-2b05-52e3-60f11c061dd7@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 06:30:41PM +0530, Sai Prakash Ranjan wrote:
> On 1/17/2019 4:57 PM, Brian Masney wrote:
> >
> >That attribute suppresses a warning from the compiler if the function is
> >unused when PM_SLEEP is disabled.  I don't consider it hackish since the
> >function name no longer appears outside the #ifdef. For example:
> >
> >	#ifdef CONFIG_PM_SLEEP
> >	static int qcom_wdt_suspend(struct device *dev)
> >	{
> >		...
> >	}
> >	#endif /* CONFIG_PM_SLEEP */
> >
> >	static SIMPLE_DEV_PM_OPS(..., qcom_wdt_suspend, ...);
> >
> >SIMPLE_DEV_PM_OPS (actually SET_SYSTEM_SLEEP_PM_OP) includes the check
> >for PM_SLEEP and its a noop if PM_SLEEP is disabled so this works.
> >
> >Now here's the code with __maybe_unused:
> >
> >	static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> >	{
> >		...
> >	}
> >
> >	static SIMPLE_DEV_PM_OPS(..., qcom_wdt_suspend, ...);
> >
> >This will still be a NOOP when power management is disabled, but have
> >the benefit of increased compile-time test coverage in that situation.
> >The symbols won't be included in the final executable. I personally
> >think the code a is cleaner with __maybe_unused.
> >
> >This pattern is already in use across various subsystems in the kernel
> >for suspend and resume functions:
> >
> >$ git grep __maybe_unused | egrep "_suspend|_resume"  | wc -l
> >767
> >
> 
> Thanks for the explanation Brian.
> 
> But I did see the maybe_unused attribute usage in other suspend and resume
> functions before posting and decided to go with ifdef because
> I think this attribute wastes CPU time by building and later discarding if
> the function is unused (it may be negligible).
> 
Your argument is that the increased build time test coverage, the improved
code readability, and the reduced risk of dependency errors are not worth
the additional compile time. You might want to take that up with the upstream
kernel community.

> I did not understand the increased compile-time test coverage
> you mentioned when PM_SLEEP=n because why would we need to compile
> when the config is disabled? We could just discard it. We would just

It is beneficial to know that a future change in the conditional code,
or an infrastructure change affecting it, doesn't cause a build error,
even if the person submitting the change didn't bother compiling with
PM_SLEEP=y.

> increase the build time with this attribute (although for this case it would
> be negligible but say we compile with PM_SLEEP disabled for all those
> suspend/resume functions with maybe_unused attribute).
> 
> Looking at previous discussions in LKML[1] as to why the pm suspend/resume
> functions used __maybe_unused seemes to be because of
> wrong ifdef usage. For ex: Using #ifdef CONFIG_PM instead of
> #ifdef CONFIG_PM_SLEEP would result in a warning when
> CONFIG_PM_SLEEP=n but CONFIG_PM=y.
> 

Do you realize that you are proving a point here, and that it isn't
your point ?

I personally very much prefer __maybe_unused over #ifdef, for the reasons
stated above. Other maintainers may think differently.

Guenter

> Anyways, *I am OK with either of them*, after some more review on the
> patch I can make the change in next version of the patch.
> 
> [1] https://lore.kernel.org/patchwork/patch/732981/
> 
> - Sai
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
