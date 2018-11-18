Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A85C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAF62089D
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ts27+K/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAF62089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeKSDaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:30:19 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:39543 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbeKSDaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=7b5ix6wrAjwf67caF1mwc9vPowzeyPAkuSkhl6MUJxY=;
        b=ts27+K/Ma1oE5utdu8DNhFsCU9DkTf/qDoo4+RbAoJfT5tNBHcQlnli5mETodkan9uwTsbC1l5pi20r3+TkdgseWYi0w0Vom5PL33d4jHTX1q2j40xWQ+7WJQmzumyfSQGW0PzpeWkmzm66e5zCf6Dw1882RIIxi/wpab3zjn2g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gOQZY-0001lA-N5; Sun, 18 Nov 2018 18:09:24 +0100
Date:   Sun, 18 Nov 2018 18:09:24 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        f.fainelli@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] net: phy: icplus: implement .did_interrupt for
 IP101A/G
Message-ID: <20181118170924.GF5591@lunn.ch>
References: <20181117182007.14791-1-martin.blumenstingl@googlemail.com>
 <20181117182007.14791-7-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117182007.14791-7-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 07:20:06PM +0100, Martin Blumenstingl wrote:
> The IP101A_G_IRQ_CONF_STATUS register has bits to detect which
> interrupts have fired. Implement the .did_interrupt callback to let the
> PHY core know whether the interrupt was for this specific PHY.
> 
> This is useful for debugging interrupt problems with 32-pin IP101GR PHYs
> where the interrupt line is shared with the RX_ERR (receive error
> status) signal. The default values are:
> - RX_ERR is enabled by default (LOW means that there is no receive
>   error)
> - the PHY's interrupt line is configured "active low" by default
> 
> Without any additional changes there is a flood of interrupts if the
> RX_ERR/INTR32 signal is configured in RX_ERR mode (which is the
> default). Having a did_interrupt ensures that the PHY core returns
> IRQ_NONE instead of endlessly triggering the PHY state machine.
> Additionally the kernel will report this after a while:
>   irq 28: nobody cared (try booting with the "irqpoll" option)

That is a useful hint.

> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
