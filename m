Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA90C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAEA20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kh2p3bsT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Kh2p3bsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfAUOfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:35:13 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57484 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbfAUOfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:35:12 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C35AF6083E; Mon, 21 Jan 2019 14:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548081311;
        bh=FOiN1HkEmm2lqQPcXiD2FfTbXUvTeNZCLs23EHUCGQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kh2p3bsT2z29cIBRdguFqFPYdZB/QQv8nZtXFj5SLTWC9j8fsCTGFoeF/r3q8B2li
         6W/s+Cj0SHPRHtgVeGYf6aAHz00wc+rKJagpXUQnkDRR7kf9NJK0JmJR0pRJllBQcg
         UahwOI2Cs2QYdSe3xYNsPCMXnAxvmFyK2g/X0wzE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 084396079C;
        Mon, 21 Jan 2019 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548081311;
        bh=FOiN1HkEmm2lqQPcXiD2FfTbXUvTeNZCLs23EHUCGQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kh2p3bsT2z29cIBRdguFqFPYdZB/QQv8nZtXFj5SLTWC9j8fsCTGFoeF/r3q8B2li
         6W/s+Cj0SHPRHtgVeGYf6aAHz00wc+rKJagpXUQnkDRR7kf9NJK0JmJR0pRJllBQcg
         UahwOI2Cs2QYdSe3xYNsPCMXnAxvmFyK2g/X0wzE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 21 Jan 2019 20:05:10 +0530
From:   msavaliy@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Allow mctrl when flow
 control is disabled
In-Reply-To: <20190119002305.16639-1-mka@chromium.org>
References: <20190119002305.16639-1-mka@chromium.org>
Message-ID: <3d739661db11d669cf8a9cba3f0853fa@codeaurora.org>
X-Sender: msavaliy@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-19 05:53, Matthias Kaehlcke wrote:
> The geni set/get_mctrl() functions currently do nothing unless
> hardware flow control is enabled. Remove this arbitrary limitation.
> 
> Suggested-by: Johan Hovold <johan@kernel.org>
> Fixes: 8a8a66a1a18a ("tty: serial: qcom_geni_serial: Add support for
> flow control")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c
> b/drivers/tty/serial/qcom_geni_serial.c
> index a72d6d9fb9834..38016609c7fa9 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -225,7 +225,7 @@ static unsigned int
> qcom_geni_serial_get_mctrl(struct uart_port *uport)
>  	unsigned int mctrl = TIOCM_DSR | TIOCM_CAR;
>  	u32 geni_ios;
> 
> -	if (uart_console(uport) || !uart_cts_enabled(uport)) {
> +	if (uart_console(uport)) {
>  		mctrl |= TIOCM_CTS;
>  	} else {
>  		geni_ios = readl_relaxed(uport->membase + SE_GENI_IOS);
> @@ -241,7 +241,7 @@ static void qcom_geni_serial_set_mctrl(struct
> uart_port *uport,
>  {
>  	u32 uart_manual_rfr = 0;
> 
> -	if (uart_console(uport) || !uart_cts_enabled(uport))
> +	if (uart_console(uport))
>  		return;
> 
>  	if (!(mctrl & TIOCM_RTS))

Though late but wanted to check on why flow control is disabled in a BT 
case ?
If i understand, CRTSCTS at serial core is what makes flow as enabled 
with UPSTAT_CTS_ENABLE set and that in turn returned by 
uart_cts_enabled(uport).
So is there any settings or configuration missing to enable flow control 
?
There could be a case to have 2 wire UART without flow control 
enablement, In that case we may need check for uart_cts_enabled() right 
?
Please add/correct if i missed something.

