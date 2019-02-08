Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A5C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98F520855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mVKJUfhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfBHQ6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:58:47 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:44195 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfBHQ6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=XrzYbNiWpIzJe3u6TxnTmMcQ9hPdqgWmrHQ2pQFhDeE=; b=mVKJUfhGlC1TAC3NmbtGSOCc5W
        Joq/2FSVkPooBjOw6pFNkEO8A50YvsW6LBAn3rmkCXK6K6GN4KA4F2m+N3J1HVEuhqFC/Tw0TJffj
        Gvk4ly0aDvv0K0Kn97Cvy3FK85dx3wfRK2yLT/B43D8/mFSwylM+Zr3k4vdmDRwnQJDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gs9UB-0000Wg-R7; Fri, 08 Feb 2019 17:58:43 +0100
Date:   Fri, 8 Feb 2019 17:58:43 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] i2c:ocores: stop transfer on timeout
Message-ID: <20190208165843.GA1853@lunn.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
 <20190208161201.7860-2-federico.vaga@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208161201.7860-2-federico.vaga@cern.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 05:11:57PM +0100, Federico Vaga wrote:
> Detecting a timeout is ok, but we also need to assert a STOP command on
> the bus in order to prevent it from generating interrupts when there are
> no on going transfers.
> 
> Example: very long transmission.
> 
> 1. ocores_xfer: START a transfer
> 2. ocores_isr : handle byte by byte the transfer
> 3. ocores_xfer: goes in timeout [[bugfix here]]
> 4. ocores_xfer: return to I2C subsystem and to the I2C driver
> 5. I2C driver : it may clean up the i2c_msg memory
> 6. ocores_isr : receives another interrupt (pending bytes to be
>                 transferred) but the i2c_msg memory is invalid now
> 
> So, since the transfer was too long, we have to detect the timeout and
> STOP the transfer.
> 
> Another point is that we have a critical region here. When handling the
> timeout condition we may have a running IRQ handler. For this reason I
> introduce a spinlock.
> 
> In order to make easier to understan locking I have:
> - added a new function to handle timeout
> - modified the current ocores_process() function in order to be protected
>   by the new spinlock
> Like this it is obvious at first sight that this locking serializes
> the execution of ocores_process() and ocores_process_timeout()
> 
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
