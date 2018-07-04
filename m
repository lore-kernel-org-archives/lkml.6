Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB7DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8997C246FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcKKYFzC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8997C246FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932644AbeGDEMB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932188AbeGDEL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:11:58 -0400
Received: from localhost (unknown [171.76.122.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12CE1246FD;
        Wed,  4 Jul 2018 04:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530677517;
        bh=o0+RWh+P+7LHcyEpD4Uh3M75++66C8JESPt6p4PCGh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZcKKYFzCALvD5UdN1LkOaXV1UNLItSPzg4zqNZvNicVXuVRrfel1zk9x9l1mynM4z
         YqzWMI+8NeI2CtNBl3mRNPqU5UHvAO38jVPpBELh9n3T7Pqa4PSNq4vrOPGGY8X8e2
         GsC6bay5o7MhiE29HjUVc4NdIfvL2C8ukHPZfREU=
Date:   Wed, 4 Jul 2018 09:41:54 +0530
From:   Vinod <vkoul@kernel.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH v3 6/6] crypto: qcom: Add ACPI support
Message-ID: <20180704041154.GU22377@vkoul-mobl>
References: <20180703060434.19293-1-vkoul@kernel.org>
 <20180703060434.19293-7-vkoul@kernel.org>
 <0d523023-52e8-4154-2e5d-69d54458caa0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d523023-52e8-4154-2e5d-69d54458caa0@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-07-18, 09:10, Timur Tabi wrote:
> On 7/3/18 1:04 AM, Vinod Koul wrote:
> > Add support for probing on ACPI systems, with ACPI HID QCOM8160.
> > 
> > On ACPI systems, clocks are always enabled, the PRNG should
> > already be enabled, and the register region is read-only.
> > The driver only verifies that the hardware is already
> > enabled never tries to disable or configure it.
> > 
> > Signed-off-by: Timur Tabi<timur@codeaurora.org>
> > [port to crypto API]
> > Signed-off-by: Vinod Koul<vkoul@kernel.org>
> 
> I've asked a colleague who still works at Qualcomm to test this code on
> silicon.  It looks okay, but I just want to be sure.
> 
> > +	/*
> > +	 * ACPI systems have v2 hardware. The clocks are always enabled,
> > +	 * the PRNG register space is read-only and the PRNG should
> > +	 * already be enabled.
> > +	 */
> > +	if (has_acpi_companion(&pdev->dev)) {
> > +		val = readl(rng->base + PRNG_CONFIG);
> > +		if (!(val & PRNG_CONFIG_HW_ENABLE)) {
> > +			dev_err(&pdev->dev, "device is not enabled\n");
> > +			return -ENODEV;
> > +		}
> 
> I'm having second thoughts about this PRNG_CONFIG_HW_ENABLE check.  The PRNG
> on the QDF2400 is the same as the one on the 8996, so it should have the
> same register interface.  Currently, the ACPI table points to a full PRNG
> register block, but I'm beginning to believe that it should instead point to
> a "reduced" block that doesn't have a PRNG_CONFIG register.

That was my doubt too. I will go ahead and make it skip this then...

-- 
~Vinod
