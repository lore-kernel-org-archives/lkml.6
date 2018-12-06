Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F57C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D5120878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCyJLsq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70D5120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbeLFR4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:56:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41153 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeLFR43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:56:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so502410plm.8;
        Thu, 06 Dec 2018 09:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K1bJobq+6IyFctrcOVfpMg7q56Mu2MnUFGm2OlX2Z4k=;
        b=YCyJLsq4gS5QEzKTlyyEqt6cce7Gl4aHrtuGpncCnxWcLJZQ+wYAgbk5WmuTB01DBj
         uf9T9DDGA0KCy5cUjGkzjKpHDXa6nuNNb2ua5fkOlhBf957q/i4vvh6e9Mgon1c0XiWY
         jzGCpQjV7Sg9OOuVIG0yMzYxqagCbjZJGFYgsXdK6fE8VTEh4SfeXfpnxU3+oD19Oy0p
         T/ScWqPKVYMQXT87XSltQk4UMiQqTqxW04ru0n/myPMwlHePVn16kv8vxElgkTNu5F3g
         qWH+BZFKZRlNM3lCxGK135ZmeP+Q6kCCVtaMquXOQU0ts4RxDLz5vciAg3OioKzY5/F6
         k9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K1bJobq+6IyFctrcOVfpMg7q56Mu2MnUFGm2OlX2Z4k=;
        b=LTACKg7oFOs8C10A525zTKR78lC68ztnO+D8F0P3sPR/wDZiac4YmGPsf/4K31is4C
         oOoK63uYbOasDvHiVoMkhGT5ErMJ2SVbQd2TWfYOfpGN2NLuaZ9cFMbJonSF6JbHM9Ud
         IDZbEoP6s7pA/B1iBR3uup8AVFk7biRhoAdvElNHsKboYyr8SipvZ9l1Th8aOuXVl2dg
         JfRROKCiJ3cpaap+OqgXfmamVxYviP7aHHTcqtVwGZ6DzsUUQ1Ry/br7h6AOVGCbkZwP
         U7VSbSlS55Dn/1D3yoH0KE7KIMod9ZtvjDZkYocfa5AcL+5p5Ycj/7RN03tw63/MJtuU
         Hq1Q==
X-Gm-Message-State: AA+aEWYty244T9Q/BEpRrlncDBeobOpPTj9Z3VdP1qiVJvG3By59rukH
        9o46HUVh5GTQ2czubvpn/YA=
X-Google-Smtp-Source: AFSGD/WHJ1QAubSxghEiA9HWjaeYLymda5phAjeS1dT28tD0bZPDMOkbHX0qaOcHMo1QEzk4chWoVg==
X-Received: by 2002:a17:902:6848:: with SMTP id f8mr28401934pln.300.1544118988671;
        Thu, 06 Dec 2018 09:56:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a4sm993522pgv.70.2018.12.06.09.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:56:27 -0800 (PST)
Date:   Thu, 6 Dec 2018 09:56:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO
 selection
Message-ID: <20181206175625.GA11808@roeck-us.net>
References: <20181206030227.9507-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206030227.9507-1-kyletso@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 11:02:27AM +0800, Kyle Tso wrote:
> Current matching rules ensure that the voltage range of selected Source
> Capability is entirely within the range defined in one of the Sink
> Capabilities. This is reasonable but not practical because Sink may not
> support wide range of voltage when sinking power while Source could
> advertise its capabilities in raletively wider range. For example, a
> Source PDO advertising 3.3V-11V@3A (9V Prog of Fixed Nominal Voltage)
> will not be selected if the Sink requires 5V-12V@3A PPS power. However,
> the Sink could work well if the requested voltage range in RDOs is
> 5V-11V@3A.
> 

Maybe a graphical description would help ?

Currently accepted:
		|--------- source -----|
	|----------- sink ---------------|

Currently not accepted:

			|--------- source -----|
	|----------- sink ---------------|

	|--------- source -----|
		|----------- sink ---------------|

	|--------- source -----------------|
		|------ sink -------|

> To improve the usability, change the matching rules to what listed
> below:
> a. The Source PDO is selectable if any portion of the voltage range
>    overlaps one of the Sink PDO's voltage range.
> b. The maximum operational voltage will be the lower one between the
>    selected Source PDO and the matching Sink PDO.
> c. The maximum power will be the maximum operational voltage times the
>    maximum current defined in the selected Source PDO
> d. Select the Source PDO with the highest maximum power
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Makes sense to me. I am a bit concerned that it might cause odd regressions,
though. Did you test it with a few adapters ?

With the expectation that you did,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3620efee2688..3001df7bd602 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2213,7 +2213,8 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  	unsigned int i, j, max_mw = 0, max_mv = 0;
>  	unsigned int min_src_mv, max_src_mv, src_ma, src_mw;
>  	unsigned int min_snk_mv, max_snk_mv;
> -	u32 pdo;
> +	unsigned int max_op_mv;
> +	u32 pdo, src, snk;
>  	unsigned int src_pdo = 0, snk_pdo = 0;
>  
>  	/*
> @@ -2263,16 +2264,18 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  					continue;
>  				}
>  
> -				if (max_src_mv <= max_snk_mv &&
> -				    min_src_mv >= min_snk_mv) {
> +				if (min_src_mv <= max_snk_mv &&
> +				    max_src_mv >= min_snk_mv) {
> +					max_op_mv = min(max_src_mv, max_snk_mv);
> +					src_mw = (max_op_mv * src_ma) / 1000;
>  					/* Prefer higher voltages if available */
>  					if ((src_mw == max_mw &&
> -					     min_src_mv > max_mv) ||
> +					     max_op_mv > max_mv) ||
>  					    src_mw > max_mw) {
>  						src_pdo = i;
>  						snk_pdo = j;
>  						max_mw = src_mw;
> -						max_mv = max_src_mv;
> +						max_mv = max_op_mv;
>  					}
>  				}
>  			}
> @@ -2285,14 +2288,16 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  	}
>  
>  	if (src_pdo) {
> -		pdo = port->source_caps[src_pdo];
> -
> -		port->pps_data.min_volt = pdo_pps_apdo_min_voltage(pdo);
> -		port->pps_data.max_volt = pdo_pps_apdo_max_voltage(pdo);
> -		port->pps_data.max_curr =
> -			min_pps_apdo_current(pdo, port->snk_pdo[snk_pdo]);
> +		src = port->source_caps[src_pdo];
> +		snk = port->snk_pdo[snk_pdo];
> +
> +		port->pps_data.min_volt = max(pdo_pps_apdo_min_voltage(src),
> +					      pdo_pps_apdo_min_voltage(snk));
> +		port->pps_data.max_volt = min(pdo_pps_apdo_max_voltage(src),
> +					      pdo_pps_apdo_max_voltage(snk));
> +		port->pps_data.max_curr = min_pps_apdo_current(src, snk);
>  		port->pps_data.out_volt =
> -			min(pdo_pps_apdo_max_voltage(pdo), port->pps_data.out_volt);
> +			min(port->pps_data.max_volt, port->pps_data.out_volt);
>  		port->pps_data.op_curr =
>  			min(port->pps_data.max_curr, port->pps_data.op_curr);
>  	}
> -- 
> 2.20.0.rc2.403.gdbc3b29805-goog
> 
