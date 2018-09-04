Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA1FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FD8206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FD8206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeIEA66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 20:58:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48265 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEA6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 20:58:55 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fxHzb-00077z-4z; Tue, 04 Sep 2018 22:32:07 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fxHzZ-0003VB-FR; Tue, 04 Sep 2018 22:32:05 +0200
Date:   Tue, 4 Sep 2018 22:32:05 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] tty: serial: imx: add lock for registers save/restore
Message-ID: <20180904203205.yboqvzkkrm6g7go5@pengutronix.de>
References: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 09, 2018 at 06:06:08PM +0800, Anson Huang wrote:
> In noirq suspend/resume stage with no_console_suspend enabled,
> .imx_console_write() may be called to print out log_buf
> message by .printk(), so there will be race condition between
> .imx_console_write() and .serial_imx_save/restore_context(),
> need to add lock to protect the registers save/restore operations.

The function names changes some time ago. Also I'd drop the leading dots
in the names which I would understand as members in a struct.

Is this a theoretical issue, or did you see actual breakage?

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/tty/serial/imx.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 239c0fa..a09ccef 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -2376,9 +2376,12 @@ static int imx_uart_remove(struct platform_device *pdev)
>  
>  static void imx_uart_restore_context(struct imx_port *sport)
>  {
> +	unsigned long flags;
> +
>  	if (!sport->context_saved)
>  		return;

Is it safe to check .context_saved without holding the lock?

> +	spin_lock_irqsave(&sport->port.lock, flags);
>  	imx_uart_writel(sport, sport->saved_reg[4], UFCR);
>  	imx_uart_writel(sport, sport->saved_reg[5], UESC);
>  	imx_uart_writel(sport, sport->saved_reg[6], UTIM);
> @@ -2390,11 +2393,15 @@ static void imx_uart_restore_context(struct imx_port *sport)
>  	imx_uart_writel(sport, sport->saved_reg[2], UCR3);
>  	imx_uart_writel(sport, sport->saved_reg[3], UCR4);
>  	sport->context_saved = false;
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
>  }
>  
>  static void imx_uart_save_context(struct imx_port *sport)
>  {
> +	unsigned long flags;
> +
>  	/* Save necessary regs */
> +	spin_lock_irqsave(&sport->port.lock, flags);
>  	sport->saved_reg[0] = imx_uart_readl(sport, UCR1);
>  	sport->saved_reg[1] = imx_uart_readl(sport, UCR2);
>  	sport->saved_reg[2] = imx_uart_readl(sport, UCR3);
> @@ -2406,6 +2413,7 @@ static void imx_uart_save_context(struct imx_port *sport)
>  	sport->saved_reg[8] = imx_uart_readl(sport, UBMR);
>  	sport->saved_reg[9] = imx_uart_readl(sport, IMX21_UTS);
>  	sport->context_saved = true;
> +	spin_unlock_irqrestore(&sport->port.lock, flags);
>  }
>  
>  static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
