Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75DAC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C79F205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 13:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uu2uIgUJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C79F205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbeJHUtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 16:49:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37958 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeJHUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 16:49:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so1443196pgq.5;
        Mon, 08 Oct 2018 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6aONoaXIzkWA5edBXyaot+zmKh6isNaHJTf5YXUhZC0=;
        b=uu2uIgUJhX76HgJ9X7Ls7dR+X0Lo888Ttl7zgkc6ui9BiOw5NB2CGjVxPqgkggRiDR
         awVd3eLIbEuYvQnI4Irqm5wEqtSsKmzTsOnFHIOJMUQiP2G8uyjhNWjiHVRDenoN1XqN
         VJPgVFWR4GzlEiUf0//Jd/GLrVSfZ3Nj6y14Uji2NwJ+NeUPsgfFRIMx6CLKT1x46n5E
         33JEaIGp72xdKZLEEBpe8H8U0UyjA2OCpnNClF/67n5kAmg56XfVmHvoFsAjWdoP2Phz
         +t5IiQgtpMUdqrKxaMwmt8Ovvf3LrCh9vyBEhcGL1na6rDFjiEeldZraXtI6vC8P7oMp
         omIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6aONoaXIzkWA5edBXyaot+zmKh6isNaHJTf5YXUhZC0=;
        b=ReufkgasIc4QF7CkPuI4EEIBVeTLdXfyF6ZxjFFHWjXJKJ8HOnzTbPRrUIowXhgYbs
         Lt6y+Mp3igce6xYE3VOU7X7/J4jJ6mQMgeFO/2PFzSexuuubpQ2c/VNrowL/Y/EYhuTU
         WmIkLXsMQvrvwcpW9dsEmYfPR73V9BlqzYC8kVxDZgasarylGcU6jiTsbJSg9bdZ+m/b
         0IQHV65++wvWA1/DFK+zg6UkW2gP0P3Ueu4isiivke4yEIyPqI6+ZgF99GA90kImwanB
         w084uFbEs++AWfFuvw8IYvyEHMB8XiHjEtNjga2Pa4ptL19hHKOUZBunxlxjMe9MI63t
         5aMQ==
X-Gm-Message-State: ABuFfoiTVdrGuzGCqC/TBiPkruQXPNTwEJE4PqFtqmwFnjZ8OXGrI31v
        AaLFV7Ys/iWHohEbJmPNrTg=
X-Google-Smtp-Source: ACcGV60XvaKbRa5L9z7IZBAr5COxUfWkLFJUd2IUtnddHvzZ6y3koNtFluSrBhPtz0dDYkEY/BcbRA==
X-Received: by 2002:a62:9fc4:: with SMTP id v65-v6mr25364534pfk.130.1539005841685;
        Mon, 08 Oct 2018 06:37:21 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l2-v6sm16404567pgp.20.2018.10.08.06.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 06:37:21 -0700 (PDT)
Subject: Re: [PATCH v2] usb: typec: tcpm: Report back negotiated PPS voltage
 and current
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        support.opensource@diasemi.com
References: <20181008125359.2D56E3FB79@swsrvapps-01.diasemi.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b318a285-331c-3e7e-dbbc-04446aacf302@roeck-us.net>
Date:   Mon, 8 Oct 2018 06:37:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008125359.2D56E3FB79@swsrvapps-01.diasemi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2018 05:53 AM, Adam Thomson wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes are based on usb-testing (e7a2c3fa2857)
> 
> Changes in v2:
>   - Rounding down of PPS voltage and current values moved to relevant API
>     functions so stored values are correctly updated prior to all subsequent
>     usage and decision making, as discuessed with Guenter.
> 
>   drivers/usb/typec/tcpm/tcpm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index b06eac8..dbbd71f 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4113,6 +4113,9 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
>   		goto port_unlock;
>   	}
>   
> +	/* Round down operating current to align with PPS valid steps */
> +	op_curr = op_curr - (op_curr % RDO_PROG_CURR_MA_STEP);
> +
>   	reinit_completion(&port->pps_complete);
>   	port->pps_data.op_curr = op_curr;
>   	port->pps_status = 0;
> @@ -4166,6 +4169,9 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
>   		goto port_unlock;
>   	}
>   
> +	/* Round down output voltage to align with PPS valid steps */
> +	out_volt = out_volt - (out_volt % RDO_PROG_VOLT_MV_STEP);
> +
>   	reinit_completion(&port->pps_complete);
>   	port->pps_data.out_volt = out_volt;
>   	port->pps_status = 0;
> 

