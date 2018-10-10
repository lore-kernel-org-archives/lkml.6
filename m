Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0210C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984602086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cMSGNQFC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 984602086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeJKACa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:02:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbeJKACa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WWZciNnxygnRe4dInY3Xdj+pIhKQ8OOZrdEoCpy5LfI=; b=cMSGNQFC4vnutPOmF7tmnMota
        ok3PLTTBKl/AHivZxxNNk3umS0+yL7QdulRA0eMxhYaIZsli3on6XcYYPZgpBJtnJ87MqHNlQ0aCu
        Eq6yY/JX/mFZoY0oQmhiJEoOcLWJMSVFc5CRerx4+qAlcJRH7zpTiDPUiqhGIRxsfwxaC4wL2AGEf
        Ea7M57uaFvdDMeaDqEAYoKDThpZGvgMwyN4+qMqxZvFNw/7xgHEbjt+BNyn23vJg9bL7RGMf/0LCi
        v29ApMtdgeHsvR2iUVhbWWvPLkJCIGDz8wPC8lYao1YqhqIUCLS981iVmRtfM0P3/gqTLWooisqCf
        n/uZEyk1w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gAHWE-0005sk-LP; Wed, 10 Oct 2018 16:39:30 +0000
Subject: Re: Bug introduced in the of_get_named_gpiod_flags function.
To:     wzab@ise.pw.edu.pl, LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <90dbf770-5262-5128-e585-c44d086568f9@ise.pw.edu.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4695559c-3f80-584a-c943-37a3bd9c24a7@infradead.org>
Date:   Wed, 10 Oct 2018 09:39:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <90dbf770-5262-5128-e585-c44d086568f9@ise.pw.edu.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding linux-gpio + Linus W.]

On 10/10/18 9:13 AM, wzab wrote:
> Hi,
> 
> The function of_get_named_gpiod_flags in older versions of the kernel 
> (up to 4.7.10 - https://elixir.bootlin.com/linux/v4.7.10/source/drivers/gpio/gpiolib-of.c#L75 )
> contained an important workaround:
> 
> /* .of_xlate might decide to not fill in the flags, so clear it. */if (flags)
>    *flags = 0; Unfortunately, newer kernels do not contain it. Therefore if the
> "xlat" function in the gpiochip driver does not set flags, (like e.g.
> the Xilinx AXI GPIO driver: https://github.com/Xilinx/linux-xlnx/blob/c2ba891326bb472da59b6a2da29aca218d337687/drivers/gpio/gpio-xilinx.c#L262 )
> the random, unitialized value from the stack in of_find_gpio 
> ( https://elixir.bootlin.com/linux/v4.18.13/source/drivers/gpio/gpiolib-of.c#L228 )
> is used, which results in random settings of e.g., OPEN DRAIN or OPEN SOURCE mode.
> 
> I have also reported the problem in the Xilinx forum: https://forums.xilinx.com/t5/Embedded-Linux/Bug-in-of-get-named-gpiod-flags-function-in-the-kernel-random/td-p/897695
> 
> With best regards,
> Wojciech Zabolotny
> 
> 
> 


-- 
~Randy
