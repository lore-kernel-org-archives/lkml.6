Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0FBC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090AB2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfhzyC7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090AB2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754829AbeF2LD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751750AbeF2LD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:03:57 -0400
Received: from localhost (unknown [122.167.66.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25F7827BC4;
        Fri, 29 Jun 2018 11:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530270236;
        bh=Bi4algpCg3NoHdo+tctOsfFiL8VDptSMsQ9Ojkyk2Ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hfhzyC7W1B/jufn8hFivgRRWZQubMNhaKizgIQJGRAq6FkgkQ4Jy8bEaZfnqmCKjN
         pZT1420UNba5NoNakFNhiImG/TVKYOerOy/yIkY3ss3pOGTmDbGJhdza6qb079LpPT
         94UG2zxLQdgi4pseHUwmwCUuuBUWn5KWz96Nzvfk=
Date:   Fri, 29 Jun 2018 16:33:46 +0530
From:   Vinod <vkoul@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Robin Gong <yibin.gong@nxp.com>, s.hauer@pengutronix.de,
        l.stach@pengutronix.de, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        dmaengine@vger.kernel.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/7] tty: serial: imx: correct dma cookie status
Message-ID: <20180629110346.GD22377@vkoul-mobl>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
 <1529427424-12321-2-git-send-email-yibin.gong@nxp.com>
 <20180626192252.6qdpwzpbpn6s5sd3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180626192252.6qdpwzpbpn6s5sd3@pengutronix.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-06-18, 21:22, Uwe Kleine-König wrote:
> On Wed, Jun 20, 2018 at 12:56:58AM +0800, Robin Gong wrote:
> > Correct to check the right rx dma cookie status in spit of it
> > works because only one cookie is running in the current sdma.
> > But it will not once sdma driver support multi cookies
> > running based on virt-dma.
> > 
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Looks wrong (because of tx_status vs rx_cookie), but is right
> nevertheless I think:

hehe, tx refers to transfer status for rx (receive) cookie and not
transmit .. yeah notations can be better!

> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Thanks
> Uwe
> 
> > ---
> >  drivers/tty/serial/imx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 4e85357..2879407 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1051,7 +1051,7 @@ static void imx_uart_dma_rx_callback(void *data)
> >  	unsigned int r_bytes;
> >  	unsigned int bd_size;
> >  
> > -	status = dmaengine_tx_status(chan, (dma_cookie_t)0, &state);
> > +	status = dmaengine_tx_status(chan, sport->rx_cookie, &state);
> >  
> >  	if (status == DMA_ERROR) {
> >  		imx_uart_clear_rx_errors(sport);
> > -- 
> > 2.7.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |

-- 
~Vinod
