Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81999C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4694121906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QB8nWJ/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLUV2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:28:34 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:55630 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbeLUV2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=z6OMmEdsHeHzCY0YGfZXMoK8GqjTwKd9dEqdGhjDXak=;
        b=QB8nWJ/SdtpofKlRXB1xGiypne9SgkeRl1nq5GTifmgha0eVgRT2YKoPqB9ROQI+uv/uqEpl4b2WatX2lxWPYLiVDjmIe/Nv8chUn2C3OITd+lQejJvMv+ZSlmG1wjp88boGpOHJV8mlV2ETfa8kk2enoSP5WOvEQZecDfAy8us=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gaSLP-0004Dg-KL; Fri, 21 Dec 2018 22:28:31 +0100
Date:   Fri, 21 Dec 2018 22:28:31 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20181221212831.GF5023@lunn.ch>
References: <1545152036-23239-1-git-send-email-andrew@lunn.ch>
 <20181221143505.GQ13248@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221143505.GQ13248@dell>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static int tqmx86_create_platform_device(const struct dmi_system_id *id)
> 
> This blows my mind.
> 
>  - The normal module_init() calls are initiated calling for a DMI scan
>  - Then the DMI device init()s
>  - You use the DMI init() to register this device as a platform device
>  - Then this platform device then probes
> 
> That seems very incestuous.
> 
> What is the reason for all the hoop jumping?

Hi Lee

It does seem like a lot of hoops to jump through. But i don't see a
way to avoid it. When you are matching on DMI tables, all you appear
to be able to do is register a callback to be called. This callback
cannot be used as a driver probe, you cannot return -EPROBE_DEFER and
expect it to be called again, etc. So if you do want to create a
device, you need to go via a platform_device.

If you know of a better way, i would be happy to implement it.

   Thanks
	Andrew
