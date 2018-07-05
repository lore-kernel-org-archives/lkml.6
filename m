Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD36C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991B323F39
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRIK+M53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991B323F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeGEGHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbeGEGHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:07:41 -0400
Received: from localhost (unknown [223.226.33.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A05923F39;
        Thu,  5 Jul 2018 06:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530770861;
        bh=+nsstnDEPrJB7eXcKJSAkxUMGx3kBBm29Kat8Je+4MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vRIK+M53zcwA/iFMfOhgrjQppdGitni5ZcGjFNq/XmPa3wgE/hSqvxOwjEUHSbxuk
         EGfQ+rqsf+pwokpIIPoXoCy00zDjMWq4QwC6xyKMGqqTPtaAQTOYc56+1FZbulkL94
         9dUsFjUXyjBz+lbUHCMB8e659aqi5ZPhYISmRsp0=
Date:   Thu, 5 Jul 2018 11:37:33 +0530
From:   Vinod <vkoul@kernel.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v4 6/6] crypto: qcom: Add ACPI support
Message-ID: <20180705060733.GH22377@vkoul-mobl>
References: <20180704114427.29953-1-vkoul@kernel.org>
 <20180704114427.29953-7-vkoul@kernel.org>
 <b06a0327-bbfe-5f7c-c0e1-43227ce089ae@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b06a0327-bbfe-5f7c-c0e1-43227ce089ae@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-07-18, 09:46, Timur Tabi wrote:
> On 7/4/18 6:44 AM, Vinod Koul wrote:
> > +	if (has_acpi_companion(&pdev->dev)) {
> > +		rng->skip_init = 1;
> > +	} else {
> > +		rng->clk = devm_clk_get(&pdev->dev, "core");
> > +		if (IS_ERR(rng->clk))
> > +			return PTR_ERR(rng->clk);
> > +
> > +		rng->skip_init =
> > +			(unsigned long)of_device_get_match_data(&pdev->dev);
> > +	}
> 
> There is a device_get_match_data() function, if you want to be consistent
> between ACPI and DT.

Yes we can add driver data in ACPI ID as well so code can be:

        if (!has_acpi_companion(&pdev->dev)) {
                rng->clk = devm_clk_get(&pdev->dev, "core");
                if (IS_ERR(rng->clk))
                        return PTR_ERR(rng->clk);
        }
        rng->skip_init = device_get_match_data(&pdev->dev);

Looks much neater.

I will wait for feedback on other patches before updating this.

Meanwhile any word from testing on ACPI systems?

Thanks
-- 
~Vinod
