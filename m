Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EEEC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED90620657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 16:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1bpEFBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED90620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbeI1W2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:28:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33001 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbeI1W2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:28:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id y18-v6so4813308pge.0;
        Fri, 28 Sep 2018 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1oxWUr4Yz5vO5tthZOImQqqhgQTmD4zFt+6C8ckZEGg=;
        b=k1bpEFBfRFUveThpgoi41y603CezUZny0YrXLer2V7bUj7dCWpNSCzpVW3YLQ0fo8X
         C3VcpqxEirVlPjejbYbudvBe4HW7sAcHBiK1WgNslvywdPT0b/TddngUGU+K4HLC4zJj
         muMDzvjNgHLnbKQO3iMhKZ5QQXIHZyzxcnl3HSTbXv7gyGHAGsad6tCA3Yflturun263
         rS8cDi1USJi2uZAsiYlJhJX0z7Va7CYIAslZP990fS0JVX56Rjrt/q8g3U6gb5CyPVBT
         jL9kIIloe4rQKk+b4xtRAgO8crdRMMAP/roY5CM+jxBgitGJDpKMhbFQCHVJJGTuvAgc
         sBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1oxWUr4Yz5vO5tthZOImQqqhgQTmD4zFt+6C8ckZEGg=;
        b=XfWsVC57hrU29nhq0APF+Pg+BUyEfnXdIJtqmWPzuiPGyjmsUY1EV25zLNUrrSOglz
         gwfuq3enoqnJjtLqpqKm78zDpV0IAza1V+5R7kbQb8OKtjhrPZ7SHjp6jyyHvLanTTFo
         ND2QEPh+ZTjdpp2ljmnmkrtRf546KCYVhEcGYM3AvFS7H1oeiGQkmxDTXfYm9tVuhVNt
         1EYkFlZdvq+CXoul7OdCuv4tQ4U/QSKkh9p2rDuA6oWM21S01FMsw3LTYDt+ClBmcaO+
         k3w+r5vpcBFKAm0ipgBZxptpM4NpE2IVcRnyjeNZR3PJeC1NHbVdRCI5hX8VdnLpQG4h
         JMPg==
X-Gm-Message-State: ABuFfogjOMsC7jzbQJOF99YX8L43OVdacNYv5IlO75888ei7zelT8XMG
        QO1ZGkIV86i/a5YFDFYwdp32KXB+
X-Google-Smtp-Source: ACcGV62IyGI0CNWEdDzVm3IM1/hwP9uU/A+YlEjSTi0/wt915XDi584PoQ0m5etPKPL4rlx7R8UAtw==
X-Received: by 2002:a17:902:3143:: with SMTP id w61-v6mr3744282plb.85.1538150652322;
        Fri, 28 Sep 2018 09:04:12 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q25-v6sm7186719pfh.113.2018.09.28.09.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 09:04:11 -0700 (PDT)
Date:   Fri, 28 Sep 2018 09:04:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
Subject: Re: [PATCH] usb: typec: tcpm: Report back negotiated PPS voltage and
 current
Message-ID: <20180928160409.GA10409@roeck-us.net>
References: <20180928153349.DC14D3FAF0@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928153349.DC14D3FAF0@swsrvapps-01.diasemi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 04:33:49PM +0100, Adam Thomson wrote:
> Currently when requesting a specific voltage or current through
> the psy interface, for PPS, when reading back from that interface
> the values will always be the same as previously given, if the
> request was successful. However PPS only allows for 20mV voltage
> steps and 50mA current steps, and the psy class expects microvolt
> and micro amp requests, so inbetween values can be provided through
> this interface. Really when reading back the true values negotiated
> should be given, and not the ones originally asked for.
> 
> To report the actual values negotiated with the Source, the values
> stored are now rounded down to the relevant step units prior to
> building the PPS request, so that those values are later correctly
> reported through the psy interface. In addition this improves the
> adjustments made to meet the operating power requirements of the
> platform, which previously could have been slightly out due to not
> using valid PPS units of voltage and current.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
> Changes are based on usb-testing (ae8a2ca8a221)
> 
>  drivers/usb/typec/tcpm/tcpm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 4f1f421..33b3981 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2433,6 +2433,10 @@ static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
>  
>  	flags = RDO_USB_COMM | RDO_NO_SUSPEND;
>  
> +	/* Round down output voltage and current to align with PPS valid steps */
> +	out_mv = out_mv - (out_mv % RDO_PROG_VOLT_MV_STEP);
> +	op_ma = op_ma - (op_ma % RDO_PROG_CURR_MA_STEP);
> +

The original intent was to have out_mv (ie out_volt) set to valid values.
Some remnants of that are still in the code.

	out_mv += RDO_PROG_VOLT_MV_STEP - (out_mv % RDO_PROG_VOLT_MV_STEP);

	port->pps_data.out_volt =
		min(pdo_pps_apdo_max_voltage(pdo), port->pps_data.out_volt);

Somehow that got lost over time. Personally I think it would be better to set 
port->pps_data.out_vol and port->pps_data.op_curr to valid step sizes instead
of post-adjusting the values when used.

Thanks,
Guenter

>  	op_mw = (op_ma * out_mv) / 1000;
>  	if (op_mw < port->operating_snk_mw) {
>  		/*
> -- 
> 1.9.1
> 
