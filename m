Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FA8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6A820896
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="TITJ/CQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfAQJbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:31:16 -0500
Received: from onstation.org ([52.200.56.107]:55440 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfAQJbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:31:15 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 323C017F;
        Thu, 17 Jan 2019 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547717474;
        bh=/QsjZEGIpt5Da8VNhfyvB/zWQZrnsZNtz4RzdivxsE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TITJ/CQ1Cm33wAial7ZB4vJoqhQQZeWMMajczPw67zquYBrovugGtbR3x4FP7kLP3
         cO+v7b2AzlQ7EbLUu9D/X+BYV8YU3r+TUONpM2wAET2rv68D2hf3Gh/emUWdNGj0YU
         CDQ1VF7e5OeR2W6NyD6PolT3HHmCaHMbg4ei08ho=
Date:   Thu, 17 Jan 2019 04:31:13 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
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
Message-ID: <20190117093113.GA23389@basecamp>
References: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 02:45:55PM +0530, Sai Prakash Ranjan wrote:
> +#ifdef CONFIG_PM_SLEEP
> +static int qcom_wdt_suspend(struct device *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd))
> +		qcom_wdt_stop(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static int qcom_wdt_resume(struct device *dev)
> +{
> +	struct qcom_wdt *wdt = dev_get_drvdata(dev);
> +
> +	if (watchdog_active(&wdt->wdd))
> +		qcom_wdt_start(&wdt->wdd);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */

You can use the __maybe_unused attribute to remove the #ifdef:

static int __maybe_unused qcom_wdt_suspend(struct device *dev)

Brian
