Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD75C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8AB20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547565208;
	bh=1VT7WnISCxThCHYN77Cmzani0TjlRWMH3nlr9IggGYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MF8o/mOlBVWdrK33acTGrPUnL0DmwRYNAqJE+hTsnNjhiEn/RR6tQD5ndzV0FqzRG
	 3sRpTuqH3/6c0t3Siz9hTy+6a5r6yWygRVEZ/CbK3Qz3+iUWAO7UBacbZ+x1z3U8Pg
	 4ZCmcrfIXrvmtIwCIQqaWYXyU33cckUR2GImwMHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfAOPN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:13:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbfAOPNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:13:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3453320866;
        Tue, 15 Jan 2019 15:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547565199;
        bh=1VT7WnISCxThCHYN77Cmzani0TjlRWMH3nlr9IggGYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQh+7lY36DLwGOQzxnqtEltlrKiCqSgtIvvC22Z7Ve646jQFpcgmg75JX2hOaAVM2
         yzYmIy1HIu13yrWSBhKKQuc38eUWcBL1kOXoAn6t1mmmARPtfHcm0tlLmgf2Z8Jgh4
         XGtU29BeVm3OFFJGhH+BXvWXqrHLMjAeHNkRwJqc=
Date:   Tue, 15 Jan 2019 16:13:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, devel@driverdev.osuosl.org,
        Alex Elder <elder@kernel.org>, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH v7 1/3] staging: greybus: gpio: switch GPIO portions to
 use GPIOLIB_IRQCHIP
Message-ID: <20190115151317.GA17860@kroah.com>
References: <cover.1547476997.git.nishadkamdar@gmail.com>
 <b547970693963d6e62845c7925a75ef68122f1ba.1547476997.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b547970693963d6e62845c7925a75ef68122f1ba.1547476997.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 08:26:16PM +0530, Nishad Kamdar wrote:
> Convert the GPIO driver to use the GPIO irqchip library
> GPIOLIB_IRQCHIP instead of reimplementing the same.
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Did you test build this patch?

It fails horribly for me:

drivers/staging/greybus/gpio.c: In function ‘gb_gpio_request_handler’:
drivers/staging/greybus/gpio.c:389:34: error: ‘struct gpio_chip’ has no member named ‘irq’
  irq = irq_find_mapping(ggc->chip.irq.domain, event->which);
                                  ^
  CC [M]  drivers/staging/rtl8712/usb_intf.o
drivers/staging/greybus/gpio.c: In function ‘gb_gpio_probe’:
drivers/staging/greybus/gpio.c:577:8: error: implicit declaration of function ‘gpiochip_irqchip_add’; did you mean ‘gpiochip_add’? [-Werror=implicit-function-declaration]
  ret = gpiochip_irqchip_add(gpio, irqc, 0, handle_level_irq,
        ^~~~~~~~~~~~~~~~~~~~
        gpiochip_add


Please be more careful...

greg k-h
