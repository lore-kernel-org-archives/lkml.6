Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D6BC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCF72075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UTffeD/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCF72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbeJXT0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:26:41 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:42342 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJXT0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/SdBY9nYjNB+jbYBCtjAsAOyzdzJjeHLEKkKl38KPQU=; b=UTffeD/7kcn0JFRxXr0+ve6qt
        y4siw+5qyuknqD7Ea2HOzEwAuGRT9kluwFeu22xOb4scKRa5KzhGnKgFWnQehsuZ2yV2/hBSXIyDz
        j1IUP86kaU5dVtMhd9Jqnd5uQO2eeZX3goan6dLNe+lCRQq5F4ZBf80Tu99PB2FxfLgQU=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:44154)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gFGsN-0001ee-9v; Wed, 24 Oct 2018 11:58:59 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gFGsK-0008Ub-7F; Wed, 24 Oct 2018 11:58:56 +0100
Date:   Wed, 24 Oct 2018 11:58:54 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] i2c: cadence: Implement timeout
Message-ID: <20181024105854.GU30658@n2100.armlinux.org.uk>
References: <1540378203-1655-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540378203-1655-1-git-send-email-shubhrajyoti.datta@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 04:20:03PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> In some cases we are waiting in a loop. Replace the infinite wait with
> the  timeout.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/i2c/busses/i2c-cadence.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index b136057..9c38278 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -209,6 +209,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
>  	struct cdns_i2c *id = ptr;
>  	/* Signal completion only after everything is updated */
>  	int done_flag = 0;
> +	unsigned int timeout;
>  	irqreturn_t status = IRQ_NONE;
>  
>  	isr_status = cdns_i2c_readreg(CDNS_I2C_ISR_OFFSET);
> @@ -235,6 +236,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
>  	    ((isr_status & CDNS_I2C_IXR_COMP) ||
>  	     (isr_status & CDNS_I2C_IXR_DATA))) {
>  		/* Read data if receive data valid is set */
> +		timeout = 1000;
>  		while (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) &
>  		       CDNS_I2C_SR_RXDV) {
>  			/*
> @@ -253,6 +255,16 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
>  
>  			if (cdns_is_holdquirk(id, hold_quirk))
>  				break;
> +			timeout--;
> +			if (timeout)
> +				mdelay(1);
> +			else
> +				break;
> +		}
> +		if (!timeout) {
> +			id->err_status = -ETIMEDOUT;
> +			complete(&id->xfer_done);
> +			return IRQ_HANDLED;

Good kernel programming principle: Always check for the success
condition when exiting due to timeout rather than the fact that we
timed out.

Also, is this _really_ a loop that needs a timeout condition?  Looking
at the original code, it looks like the purpose of the loop is to read
more than one byte, and you are introducing a 1ms delay between the
read of each byte.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
