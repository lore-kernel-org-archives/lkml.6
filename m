Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A045C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B9821929
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 21:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lZ1JHJ3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBIVd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:33:59 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45486 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfBIVd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 16:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5Iu7a4Jy5kWO21IKeKsAKXoePMvF3BOx8RjgF65xhr8=; b=lZ1JHJ3bdEU6+j8ASDDwmzwyW7
        9YNncFKoQKQhG41QH5NUnfMg9KE66m81AEbRlwUq74wXRvh+adiberIwDXSio3UUOouqGInmMHQAZ
        w9lyx1x14gjWoeQdMrM+SWI7P98i7rWKzePRUCWRI3Jycr7FkFwVJBvu3UX6bhGVO+kM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gsaG1-0002PQ-Vc; Sat, 09 Feb 2019 22:33:54 +0100
Date:   Sat, 9 Feb 2019 22:33:53 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] i2c:ocores: add polling interface
Message-ID: <20190209213353.GA9061@lunn.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
 <20190208161201.7860-4-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208161201.7860-4-federico.vaga@cern.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int ocores_poll_wait(struct ocores_i2c *i2c)
> +{
> +	u8 mask;
> +	int err;
> +
> +	if (i2c->state == STATE_DONE || i2c->state == STATE_ERROR) {
> +		/* transfer is over */
> +		mask = OCI2C_STAT_BUSY;
> +	} else {
> +		/* on going transfer */
> +		mask = OCI2C_STAT_TIP;
> +		udelay((8 * 1000) / i2c->bus_clock_khz);
> +	}
> +
> +	/*
> +	 * once we are here we expect to get the expected result immediately
> +	 * so if after 1ms we timeout then something is broken.
> +	 */
> +	err = ocores_wait(i2c, OCI2C_STATUS, mask, 0, msecs_to_jiffies(1));

Hi Federico

I did some timing tests for this. On my box, we request a udelay of
80uS. The kernel actually delays for about 79uS. We then spin in
ocores_wait() for an additional 10-11uS, which is 3 to 4 iterations.

There are actually 9 bits on the wire, not 8, since there is an
ACK/NACK bit after the actual data transfer. So i changed the delay to
(9 * 1000) / i2c->bus_clock_khz. That resulted in ocores_wait() mostly
not looping at all. But for reading an 4K AT24 EEPROM, it increased
the read time by 10ms, from 424ms to 434ms. So we should probably keep
with 8.

Tested-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
