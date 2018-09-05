Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE5AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1D520645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="at/0e8BS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1D520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeIFEF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:05:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37643 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725741AbeIFEF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:05:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id f1-v6so4027717plt.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 16:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+pFLUnIq/1tjzvfuNqAOku0+CCp/mZKSt3lyp59mpWU=;
        b=at/0e8BSt7gdzfMUcJ4Kby+nEzpFNkNQKu4ie/5VIR4hEIdjEj95nPMalAQtj7isGf
         yIYe6t7mhiV8anS00AO8R0SLCp345k6OqV3QexIOrxT0QM02cP3XEtzVE/T9lUxKGbho
         OCIFber+/7HFhAcrnRlYqO/v4SiOyI6aIAg8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+pFLUnIq/1tjzvfuNqAOku0+CCp/mZKSt3lyp59mpWU=;
        b=ftCrpRhtGmYrZgTUImg/OlfsvtnQ+hrRikGJmk568iRs+5fboU9rptYq/jsnks06X4
         lqKwPKbSbPKL9qdTDBTB9enki3tLTbrUfZCerr5rC1lRSZYY5J4MqScm9rdXym0f16Qv
         fjZ4ZVr7Vb5VlL2YXRBO1jGpNg6TQ14YhEgVVn3hVvUH3GTM8EQ6DJZDn19JCj55h85Q
         WDeUu9K5t7DC8PaXB4wF9671lf7/k1QvmGXNGmKykAqzKkIx92VGpDujH5yR7nKlYn/m
         QCI0irBSPRll+VvhEcSGFX4/jfA3Ty0RAxXcGsbk0Gop96d53Md9sSjtuqrPM+D3kaII
         H4Jw==
X-Gm-Message-State: APzg51CZ1Q5OojdD3ln3fGZo4N6mfaFAG7hY1lmHCyswjy/Ntev0yYs3
        gjLGrwT+InT95gwPdLo+fEDi1g==
X-Google-Smtp-Source: ANB0VdYJIJFQXSytbT0uyiOXWVuyVpCfkdE8llOuCzCxC0RluJeoHDWJlFZfU5SRUlGT6Eyy0f4wTg==
X-Received: by 2002:a17:902:704c:: with SMTP id h12-v6mr34577plt.237.1536190380543;
        Wed, 05 Sep 2018 16:33:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id a15-v6sm6427433pfe.32.2018.09.05.16.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 16:32:59 -0700 (PDT)
Date:   Wed, 5 Sep 2018 16:32:59 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org,
        evgreen@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Fix serial when not used
 as console
Message-ID: <20180905233259.GA22824@google.com>
References: <20180905201146.261438-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180905201146.261438-1-dianders@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 01:11:46PM -0700, Douglas Anderson wrote:
> If you've got the "console" serial port setup to use just as a UART
> (AKA there is no "console=ttyMSMX" on the kernel command line) then
> certain initialization is skipped.  When userspace later tries to do
> something with the port then things go boom (specifically, on my
> system, some sort of exception hit that caused the system to reboot
> itself w/ no error messages).
> 
> Let's cleanup / refactor the init so that we always run the same init
> code regardless of whether we're using the console.
> 
> To make this work, we make rely on qcom_geni_serial_pm doing its job
> to turn resources on.
> 
> For the record, here is a trace of the order of things (after this
> patch) when console= is specified on the command line and we have an
> agetty on the port:
>   qcom_geni_serial_pm: 4 (undefined) => 0 (on)
>   qcom_geni_console_setup
>   qcom_geni_serial_port_setup
>   qcom_geni_serial_console_write
>   qcom_geni_serial_startup
>   qcom_geni_serial_start_tx
> 
> ...and here is the order of things (after this patch) when console= is
> _NOT_ specified on the command line and we have an agetty port:
>   qcom_geni_serial_pm: 4 => 0
>   qcom_geni_serial_pm: 0 => 3
>   qcom_geni_serial_pm: 3 => 0
>   qcom_geni_serial_startup
>   qcom_geni_serial_port_setup
>   qcom_geni_serial_pm: 0 => 3
>   qcom_geni_serial_pm: 3 => 0
>   qcom_geni_serial_startup
>   qcom_geni_serial_start_tx
> 
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/tty/serial/qcom_geni_serial.c | 55 +++++++++++++--------------
>  1 file changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 29ec34387246..99103c67e1dc 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -851,6 +851,23 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
>  {
>  	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>  	unsigned int rxstale = DEFAULT_BITS_PER_CHAR * STALE_TIMEOUT;
> +	u32 proto;
> +
> +	if (uart_console(uport))
> +		port->tx_bytes_pw = 1;
> +	else
> +		port->tx_bytes_pw = 4;
> +	port->rx_bytes_pw = RX_BYTES_PW;
> +
> +	proto = geni_se_read_proto(&port->se);
> +	if (proto != GENI_SE_UART) {
> +		dev_err(uport->dev, "Invalid FW loaded, proto: %d\n", proto);
> +		return -ENXIO;
> +	}
> +
> +	qcom_geni_serial_stop_rx(uport);

This wasn't done earlier in qcom_geni_serial_startup() (but it was in
qcom_geni_console_setup()). I guess this extra stop of RX for the
'uart' shouldn't do any harm.

> +
> +	get_tx_fifo_size(port);
>  
>  	set_rfr_wm(port);
>  	writel_relaxed(rxstale, uport->membase + SE_UART_RX_STALE_CNT);
> @@ -874,30 +891,19 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
>  			return -ENOMEM;
>  	}
>  	port->setup = true;
> +
>  	return 0;
>  }
>  
>  static int qcom_geni_serial_startup(struct uart_port *uport)
>  {
>  	int ret;
> -	u32 proto;
>  	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>  
>  	scnprintf(port->name, sizeof(port->name),
>  		  "qcom_serial_%s%d",
>  		(uart_console(uport) ? "console" : "uart"), uport->line);
>  
> -	if (!uart_console(uport)) {
> -		port->tx_bytes_pw = 4;
> -		port->rx_bytes_pw = RX_BYTES_PW;
> -	}
> -	proto = geni_se_read_proto(&port->se);
> -	if (proto != GENI_SE_UART) {
> -		dev_err(uport->dev, "Invalid FW loaded, proto: %d\n", proto);
> -		return -ENXIO;
> -	}
> -
> -	get_tx_fifo_size(port);
>  	if (!port->setup) {
>  		ret = qcom_geni_serial_port_setup(uport);
>  		if (ret)
> @@ -1056,6 +1062,7 @@ static int __init qcom_geni_console_setup(struct console *co, char *options)
>  	int bits = 8;
>  	int parity = 'n';
>  	int flow = 'n';
> +	int ret;
>  
>  	if (co->index >= GENI_UART_CONS_PORTS  || co->index < 0)
>  		return -ENXIO;
> @@ -1071,21 +1078,10 @@ static int __init qcom_geni_console_setup(struct console *co, char *options)
>  	if (unlikely(!uport->membase))
>  		return -ENXIO;
>  
> -	if (geni_se_resources_on(&port->se)) {
> -		dev_err(port->se.dev, "Error turning on resources\n");
> -		return -ENXIO;
> -	}
> -
> -	if (unlikely(geni_se_read_proto(&port->se) != GENI_SE_UART)) {
> -		geni_se_resources_off(&port->se);
> -		return -ENXIO;
> -	}
> -
>  	if (!port->setup) {
> -		port->tx_bytes_pw = 1;
> -		port->rx_bytes_pw = RX_BYTES_PW;
> -		qcom_geni_serial_stop_rx(uport);
> -		qcom_geni_serial_port_setup(uport);
> +		ret = qcom_geni_serial_port_setup(uport);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	if (options)
> @@ -1203,11 +1199,12 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
>  {
>  	struct qcom_geni_serial_port *port = to_dev_port(uport, uport);
>  
> +	/* If we've never been called, treat it as off */
> +	if (old_state == UART_PM_STATE_UNDEFINED)
> +		old_state = UART_PM_STATE_OFF;
> +
>  	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
>  		geni_se_resources_on(&port->se);
> -	else if (!uart_console(uport) && (new_state == UART_PM_STATE_ON &&
> -				old_state == UART_PM_STATE_UNDEFINED))
> -		geni_se_resources_on(&port->se);
>  	else if (new_state == UART_PM_STATE_OFF &&
>  			old_state == UART_PM_STATE_ON)
>  		geni_se_resources_off(&port->se);

Seems like a good refactoring, besides fixing the problem when booting
without 'console=ttyMSMx'.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
