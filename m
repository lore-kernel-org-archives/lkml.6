Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9BEC282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E652184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="iNhn3ZNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfBFAwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:52:18 -0500
Received: from onstation.org ([52.200.56.107]:56844 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfBFAwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:52:18 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 1606D167;
        Wed,  6 Feb 2019 00:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549414337;
        bh=DM+w/VKuEATLxtlkJ4VOxXd1djy3XiVnT8RYnPw4ha0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iNhn3ZNEKc4M8DyRGI744iImc+U0jM7/DCioVuTpm4rqfP2pVv4SOUls1mZDOYA08
         PDz4HNLkhcSQ7YIIeThRfFMxPWGBsqWNfgOLODYit2skSeJy8V+kiyTLmxHcn/P/Ke
         Z1nAQK6//TZYg5aZYEflqOSULjXi7SgOimVyCOso=
Date:   Tue, 5 Feb 2019 19:52:16 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH v3 2/3] Input: add new vibrator driver for various MSM
 SOCs
Message-ID: <20190206005216.GA16650@basecamp>
References: <20181025012937.2154-1-masneyb@onstation.org>
 <20181025012937.2154-3-masneyb@onstation.org>
 <20190205194246.GA19151@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205194246.GA19151@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 11:42:46AM -0800, Dmitry Torokhov wrote:
> > +		dev_err(&pdev->dev, "Failed to lookup pwm clock: %ld\n",
> > +			PTR_ERR(vibrator->clk));
> > +		return PTR_ERR(vibrator->clk);
> > +	}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get platform resource\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	vibrator->base = devm_ioremap(&pdev->dev, res->start,
> > +				     resource_size(res));
> > +	if (IS_ERR(vibrator->base)) {
> 
> devm_ioremap() returns NULL on error. You either need to check for NULL
> or see of you can use devm_ioremap_resource().

I originally tried to use devm_ioremap_resource() but the call to
devm_request_mem_region() would fail. I'll go with the NULL check here
for devm_ioremap().

Thanks for the review!

Brian
