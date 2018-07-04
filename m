Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB67C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94CF21AA6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pwe0WO1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94CF21AA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752833AbeGDOqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752173AbeGDOqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:46:05 -0400
Received: from [192.168.1.125] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1216B21AA6;
        Wed,  4 Jul 2018 14:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530715564;
        bh=bvxzE+UQZmDtXs1tiMS8jPcndb1kHodE8Bw1EmDQMiE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Pwe0WO1gSCPUk47+a3pZYDSJ+xbXiZVUk5WBUt21M/9BgekT7FMS4EicaenQflKPr
         cBv98kJ3wuoIMCWyCNxKoCg0yaMk6hbp04s1ePyuDk1cYHhkeqRIrYOVDCHzxYzXo8
         +X8AAlV1yWg1domR69JdvE4FUM9jNUwqdsjcnD3w=
Subject: Re: [PATCH v4 6/6] crypto: qcom: Add ACPI support
To:     Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Timur Tabi <timur@codeaurora.org>
References: <20180704114427.29953-1-vkoul@kernel.org>
 <20180704114427.29953-7-vkoul@kernel.org>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <b06a0327-bbfe-5f7c-c0e1-43227ce089ae@kernel.org>
Date:   Wed, 4 Jul 2018 09:46:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704114427.29953-7-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/18 6:44 AM, Vinod Koul wrote:
> +	if (has_acpi_companion(&pdev->dev)) {
> +		rng->skip_init = 1;
> +	} else {
> +		rng->clk = devm_clk_get(&pdev->dev, "core");
> +		if (IS_ERR(rng->clk))
> +			return PTR_ERR(rng->clk);
> +
> +		rng->skip_init =
> +			(unsigned long)of_device_get_match_data(&pdev->dev);
> +	}

There is a device_get_match_data() function, if you want to be 
consistent between ACPI and DT.
