Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CD7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C627320673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C627320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbeGSPi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:38:28 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33322 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730521AbeGSPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:38:28 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fgAKR-0001SA-LY; Thu, 19 Jul 2018 16:54:51 +0200
Date:   Thu, 19 Jul 2018 16:54:48 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Daniel Kurtz <djkurtz@chromium.org>
cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Ken Xue <Ken.Xue@amd.com>, Daniel Drake <drake@endlessm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pinctrl/amd: only handle irq if it is pending and
 unmasked
In-Reply-To: <20180717005719.258905-1-djkurtz@chromium.org>
Message-ID: <alpine.DEB.2.21.1807191654230.1693@nanos.tec.linutronix.de>
References: <20180717005719.258905-1-djkurtz@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2018, Daniel Kurtz wrote:

> The AMD pinctrl driver demultiplexes GPIO interrupts and fires off their
> individual handlers.
> 
> If one of these GPIO irqs is configured as a level interrupt, and its
> downstream handler is a threaded ONESHOT interrupt, the GPIO interrupt
> source is masked by handle_level_irq() until the eventual return of the
> threaded irq handler.  During this time the level GPIO interrupt status
> will still report as high until the actual gpio source is cleared - both
> in the individual GPIO interrupt status bit (INTERRUPT_STS_OFF) and in
> its corresponding "WAKE_INT_STATUS_REG" bit.
> 
> Thus, if another GPIO interrupt occurs during this time,
> amd_gpio_irq_handler() will see that the (masked-and-not-yet-cleared)
> level irq is still pending and incorrectly call its handler again.
> 
> To fix this, have amd_gpio_irq_handler() check for both interrupts status
> and mask before calling generic_handle_irq().
> 
> Note: Is it possible that this bug was the source of the interrupt storm
> on Ryzen when using chained interrupts before commit ba714a9c1dea85
> ("pinctrl/amd: Use regular interrupt instead of chained")?
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
