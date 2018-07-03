Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E7C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3933624B1C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 14:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChDK2pq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3933624B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeGCOKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 10:10:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752088AbeGCOKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 10:10:09 -0400
Received: from [192.168.1.125] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFAF224B1C;
        Tue,  3 Jul 2018 14:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530627008;
        bh=cL3D3RkLE8+n7vTl58HpGLxZSVtwFc+02re0uwD0SpQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ChDK2pq2BJb6seJ2DfGLmdl+xdlT+xMNMbVTxqtPCXo/lxdn6K8QGFOYrufYuU5Ed
         Bb2fYNlkpnAKvqJf7F2YpYyX91+uBNhAu+w4JrWaiw67PjoVflE7JhCbbL5KWLECKs
         haP0vI/T7Lawb62RsvmIfEzQXb9OQWUL8dhly8ks=
Subject: Re: [PATCH v3 6/6] crypto: qcom: Add ACPI support
To:     Vinod Koul <vkoul@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <20180703060434.19293-1-vkoul@kernel.org>
 <20180703060434.19293-7-vkoul@kernel.org>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <0d523023-52e8-4154-2e5d-69d54458caa0@kernel.org>
Date:   Tue, 3 Jul 2018 09:10:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703060434.19293-7-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/18 1:04 AM, Vinod Koul wrote:
> Add support for probing on ACPI systems, with ACPI HID QCOM8160.
> 
> On ACPI systems, clocks are always enabled, the PRNG should
> already be enabled, and the register region is read-only.
> The driver only verifies that the hardware is already
> enabled never tries to disable or configure it.
> 
> Signed-off-by: Timur Tabi<timur@codeaurora.org>
> [port to crypto API]
> Signed-off-by: Vinod Koul<vkoul@kernel.org>

I've asked a colleague who still works at Qualcomm to test this code on 
silicon.  It looks okay, but I just want to be sure.

> +	/*
> +	 * ACPI systems have v2 hardware. The clocks are always enabled,
> +	 * the PRNG register space is read-only and the PRNG should
> +	 * already be enabled.
> +	 */
> +	if (has_acpi_companion(&pdev->dev)) {
> +		val = readl(rng->base + PRNG_CONFIG);
> +		if (!(val & PRNG_CONFIG_HW_ENABLE)) {
> +			dev_err(&pdev->dev, "device is not enabled\n");
> +			return -ENODEV;
> +		}

I'm having second thoughts about this PRNG_CONFIG_HW_ENABLE check.  The 
PRNG on the QDF2400 is the same as the one on the 8996, so it should 
have the same register interface.  Currently, the ACPI table points to a 
full PRNG register block, but I'm beginning to believe that it should 
instead point to a "reduced" block that doesn't have a PRNG_CONFIG register.
