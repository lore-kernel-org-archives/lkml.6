Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3DAC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C1D2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ywXRpYIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C1D2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeJEBDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:03:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54073 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbeJEBDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=Rc2BejUY+DGC78oQJZ/wNVi17aLhtRmkPLlU9vHL27I=;
        b=ywXRpYIeQmqC4WYSoOLZyLUNvbIQlNc+arAaz430JrAJ8Uh1jH4+RYKo9S753+u30vMr6eANDVBL3il6Z+2h8xUVt+/YAbAitWv8DsJizE8qVbiQsmkZsfDtDKxmRh/HKPO11iYjDveNDWq3LaK3M7NlvJ8qz8ixPPY6eocCjcM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g883T-0008ST-6p; Thu, 04 Oct 2018 20:08:55 +0200
Date:   Thu, 4 Oct 2018 20:08:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: Reboot using an i2c power-system-controller ?
Message-ID: <20181004180855.GG4730@lunn.ch>
References: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 06:23:37PM +0200, Nicolas Cavallari wrote:
> So i got this ARM board with a rtc controlled by i2c that can also cut
> power.  I want to use it to reboot, because it will also cut power to
> clumsy USB and MMC devices.
> So the natural thing to do would be to just register a restart_handler
> that will kindly do i2c (saw at least a driver doing it), or use
> arm_pm_restart and be done with it.
> 
> Well that what I though.  Most of my naive attempts were met with
> occasional failures and now my understanding is that I do not
> understand why anything works in the first place.

Hi Nicolas

I doubt you can use the platform i2c driver.

If you look at how this is done for sending commands over a UART to a
micro-controller, you will see the reset driver hijack the UART
device. They poke registers with the require baud rate settings, and
then poke registers with the bytes to send, polling for completion of
each byte if needed.

To get this working reliably, i suspect you are going to need to do
the same with your i2c bus controller. Directly control it, stop any
in progress transfers, setup a new transfer, and hope you can do it
polled IO, not DMA.

       Andrew
