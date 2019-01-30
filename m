Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15721C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D502B2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bruBO+FV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbfA3RMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:12:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34353 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfA3RMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:12:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so116871pfg.1;
        Wed, 30 Jan 2019 09:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MLtf03Fx2tOn4FxdxDWyDd/k+4vkXhZKYLZva0t9WDc=;
        b=bruBO+FVSgb7vfmpuoYTrcNQvhHxfvud1NEV0iEQwUiNg52nCYcWaBhUgcwEK2Rlbr
         tkRN2y747LMADKJuOjFS47P4nhaz4alvb6+kF89nvXRf4Ryh4kZ9OzVEAUTgkTeim+DJ
         blGTOLKrBzx0IIn17/fKnCy9HzDro1pjIwLXHQvtC/b/+VOW04CffubmuDs6VVkRPC31
         i3zOlgcYdZm9l0Kux08XyODd6o4gDRdXBZyf/DO7m9fTEqj8iD4r0vBkdKGmF0y1xYOP
         XDTiBwvK4y2aLE+nliVekaHuZ1k8tNV1MgYqfVqrdcxbvvg4pi8n2QSAx0lfEnwtVT2n
         hvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MLtf03Fx2tOn4FxdxDWyDd/k+4vkXhZKYLZva0t9WDc=;
        b=DqWM3mZquK1KzBH+lUkBjFC75oCOAOp+JmvnoBT2c8ms2KZoZ5bGj2j+f67dlwj5XE
         41S8iyaGn/XM9IBI/n3iyaJgAL0/Dblm2V7wt1jHp1EHrfWGTF1f/deyyOyiqe5/uydQ
         knt6f753IDkUIW178Wq0iuDLrc8NdErVBIKvGJPBpaJ3QOExSH8RnwBP7j1ZRanDQ8Mr
         aN76mpWeN4CNRVajpRpI70AzYI06qdYQXDWBbINSvHqWKBGbEnI4Upat+gGUnccXo5f9
         +Xn+8bMi0xtMeb0gTkjFMoGUEyyEzRvkt6mDRLw23RjWeaUXqdc0+ImsdfCZbmG3SWk3
         cXPA==
X-Gm-Message-State: AJcUukcvUdmCf5HkghERS7ue7POkSRvwtbnFdcowCmSONB1yLYq4/+UJ
        hj/cNRxiAEDsmmHkZ4oAvqo=
X-Google-Smtp-Source: ALg8bN4Yt49fI1zlErlf6gqK6fuCK0hjDe5JY2YUKxB6nct4F0K8y+CSgH5acoYRLBhw7rCgKLyo8w==
X-Received: by 2002:a63:5723:: with SMTP id l35mr27349470pgb.228.1548868365114;
        Wed, 30 Jan 2019 09:12:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v9sm3140302pfg.144.2019.01.30.09.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 09:12:43 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:12:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, Adam.Thomson.Opensource@diasemi.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Correct the PPS out_volt calculation
Message-ID: <20190130171242.GA14781@roeck-us.net>
References: <20190130031353.100228-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130031353.100228-1-kyletso@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:13:53AM +0800, Kyle Tso wrote:
> When Sink negotiates PPS, the voltage range of selected PPS APDO might
> not cover the previous voltage (out_volt). If the previous out_volt is
> lower than the new min_volt, the output voltage in RDO might be set to
> an invalid value. For instance, supposed that the previous voltage is
> 5V, and the new voltage range in the APDO is 7V-12V. Then the output
> voltage in the RDO should not be set to 5V which is lower than the
> possible min_volt 7V.
> 
> Fix this by choosing the maximal value between the previous voltage and
> the new min_volt first. And ensure that this value will not exceed the
> new max_volt. The new out_volt will fall within the new voltage range
> while being the closest value compared to the previous out_volt.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index f1d3e54210df..8f2af348bda5 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2297,7 +2297,8 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>  					      pdo_pps_apdo_max_voltage(snk));
>  		port->pps_data.max_curr = min_pps_apdo_current(src, snk);
>  		port->pps_data.out_volt = min(port->pps_data.max_volt,
> -					      port->pps_data.out_volt);
> +					      max(port->pps_data.min_volt,
> +						  port->pps_data.out_volt));
>  		port->pps_data.op_curr = min(port->pps_data.max_curr,
>  					     port->pps_data.op_curr);
>  	}
> -- 
> 2.20.1.495.gaa96b0ce6b-goog
> 
