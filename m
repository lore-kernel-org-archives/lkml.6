Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FB2C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E417B21A34
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RROYp1T5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E417B21A34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbeHFQCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:02:15 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56384 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbeHFQCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=F1b8heVRoDa1lGDJgz4V431dJDpfyPryjRXcSuVX62E=;
        b=RROYp1T5p2bIx6FR33cmMFfDMyWLciJNu2F+eW6Z+WyOaZQz6GueVoDd/1jVNiZLa5Ksl0DwIH3B/rYGJevxOAFkNwOU08lBtXccfnzvF6aoA1nP4mVSmkbpjPFpfn2vjpuOTad2PbHInxS4DmBpCy5t2HkG3KKSw6yMyUYBK7U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fmfwP-000227-Hn; Mon, 06 Aug 2018 15:52:57 +0200
Date:   Mon, 6 Aug 2018 15:52:57 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Aditya Prayoga <aditya@kobol.io>
Cc:     linux-gpio@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Gauthier Provost <gauthier@kobol.io>,
        Alban Browaeys <alban.browaeys@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Gilmore <dennis@ausil.us>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>
Subject: Re: [PATCH RESEND 2/2] gpio: mvebu: Allow to use non-default PWM
 counter
Message-ID: <20180806135257.GB6584@lunn.ch>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-3-git-send-email-aditya@kobol.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533522556-55055-3-git-send-email-aditya@kobol.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 10:29:16AM +0800, Aditya Prayoga wrote:
> On multiple PWM lines, if the other PWM counter is unused, allocate it
> to next PWM request. The priority would be:
> 1. Default counter assigned to the bank
> 2. Unused counter that is assigned to other bank
> 3. Fallback to default counter
> 
> For example on second bank there are three PWM request, first one would
> use default counter (counter B), second one would try to use counter A,
> and the third one would use counter B.

Hi Aditya

There are only two PWM counters for all the GPIO lines. So you cannot
support 3 PWM requests. You have to enforce a maximum of two PWMs.

When i implemented this PWM code, i only needed one PWM. So it took
the easy option. GPIO bank 0 uses counter A, GPIO bank1 uses counter
B. For the hardware you have, this is not sufficient, so you need to
generalise this. Any PWM can use any counter, whatever is available
when the PWM is requested.

Rather than have a linked list of PWM, i think it would be better to
have a static array of two mvebu_pwm structures. Index 0 uses counter
A, index 1 uses counter B. You can then keep with the concept of
pwm->pgiod != NULL means the counter is in use. The request() call can
then find an unused PWM, set pwm->gpiod, and point mvchip->mvpwm to
one of the two static instances.

    Andrew
