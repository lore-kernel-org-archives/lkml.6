Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D88C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0808120883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBq8oCIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731323AbeLQC5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 21:57:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41136 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbeLQC5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 21:57:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so3741195pgq.8;
        Sun, 16 Dec 2018 18:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rc8gPXiQqLn156m1XReqA2cndEyaq3ICkIfja/vtcAA=;
        b=MBq8oCIJajUnP0C7M34UnSI5a5p1GzjH9TG7iXcH8ARzdCxqHNS4lRVEyyApnvOmAZ
         WphCnkOKnuXMYmfC9uXLhJuP4n4rSbOFbHSNXTGI+IItIEypNX0A+YwUwkmoS9NOBHTe
         jLMcbTzgGboR5YRyHFSLAOcGofAajSotWxMnt4WXzceFGdEITFO8BKhyQJ+BI1IGHl+L
         PF9UWOPqTqX/eOi+GLDedqZWsFUCE2/AoxYG41s4gA19H31JiMvdeUWhZhhabHt0e/Ml
         SVko1mEtEn6jPPeL60Jzqam+aq3b4y+SsnmhN7vF9c1mVaVyEzpb2VEuJ6M+p+Ef7CAQ
         q/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rc8gPXiQqLn156m1XReqA2cndEyaq3ICkIfja/vtcAA=;
        b=AFh47MiaPuZz47bjr6R4w4iTihcPm7G9+vZQiQNHZr/iSgT8bwIT3I7Z0jF0kPI4tq
         mAFvHOwyBCSGSJapF4xglkxl5n6QPRiVAORv6LdBVk2EvIGOhrwuscKJuUrN4sbYjdmf
         pZI866/Le/9IcCrnazGFwVKh9YRCrq0uVnW71ue4hy3KZeidkjbL1HT3KHi78XJf3Qfn
         ICVEI0dFuj5NQVCFr23I9f4NYTZnCmMFVHDLZPBZ7sjdz10sNKS6jd3SEihnK27O6sb3
         P8F06iO3AvM91O34OaJdQdIqhJY7JNO76KxZ7/vvEzKKXQI/NGDCDx7560niM/0qplGA
         zeZQ==
X-Gm-Message-State: AA+aEWb2U8zs/8nPh+YRCvEBeqFqm8d59ncQw/BjYbgWbbUCroE5Ly5q
        lOsBwpUNmUyZdMj7nfNreaxHy+XN
X-Google-Smtp-Source: AFSGD/VSC8B/GrQiufV0AGBhb4V0Ss3DrcMIPUMsPsynk8hnjftcmLSFNvANW2EMBMdTDGzXOshzuQ==
X-Received: by 2002:a63:5f88:: with SMTP id t130mr10852046pgb.395.1545015433875;
        Sun, 16 Dec 2018 18:57:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y89sm15338439pfa.136.2018.12.16.18.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 18:57:12 -0800 (PST)
Subject: Re: [PATCH] usb: typec: tcpm: Extend the matching rules on PPS APDO
 selection
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, Adam.Thomson.Opensource@diasemi.com
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181217024805.122897-1-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3f116158-d900-1dcd-387f-d8129a0f0dd0@roeck-us.net>
Date:   Sun, 16 Dec 2018 18:57:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217024805.122897-1-kyletso@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/18 6:48 PM, Kyle Tso wrote:
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
> Currently accepted:
> 		|--------- source -----|
> 	|----------- sink ---------------|
> 
> Currently not accepted:
> 			|--------- source -----|
> 	|----------- sink ---------------|
> 
> 	|--------- source -----|
> 		|----------- sink ---------------|
> 
> 	|--------- source -----------------|
> 		|------ sink -------|
> 
> To improve the usability, change the matching rules to what listed
> below:
> a. The Source PDO is selectable if any portion of the voltage range
>     overlaps one of the Sink PDO's voltage range.
> b. The maximum operational voltage will be the lower one between the
>     selected Source PDO and the matching Sink PDO.
> c. The maximum power will be the maximum operational voltage times the
>     maximum current defined in the selected Source PDO
> d. Select the Source PDO with the highest maximum power
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> Changelog since v1:
> - updated the commit message as suggested by Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 29 +++++++++++++++++------------
>   1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3620efee2688..3001df7bd602 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2213,7 +2213,8 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>   	unsigned int i, j, max_mw = 0, max_mv = 0;
>   	unsigned int min_src_mv, max_src_mv, src_ma, src_mw;
>   	unsigned int min_snk_mv, max_snk_mv;
> -	u32 pdo;
> +	unsigned int max_op_mv;
> +	u32 pdo, src, snk;
>   	unsigned int src_pdo = 0, snk_pdo = 0;
>   
>   	/*
> @@ -2263,16 +2264,18 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>   					continue;
>   				}
>   
> -				if (max_src_mv <= max_snk_mv &&
> -				    min_src_mv >= min_snk_mv) {
> +				if (min_src_mv <= max_snk_mv &&
> +				    max_src_mv >= min_snk_mv) {
> +					max_op_mv = min(max_src_mv, max_snk_mv);
> +					src_mw = (max_op_mv * src_ma) / 1000;
>   					/* Prefer higher voltages if available */
>   					if ((src_mw == max_mw &&
> -					     min_src_mv > max_mv) ||
> +					     max_op_mv > max_mv) ||
>   					    src_mw > max_mw) {
>   						src_pdo = i;
>   						snk_pdo = j;
>   						max_mw = src_mw;
> -						max_mv = max_src_mv;
> +						max_mv = max_op_mv;
>   					}
>   				}
>   			}
> @@ -2285,14 +2288,16 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
>   	}
>   
>   	if (src_pdo) {
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
>   		port->pps_data.out_volt =
> -			min(pdo_pps_apdo_max_voltage(pdo), port->pps_data.out_volt);
> +			min(port->pps_data.max_volt, port->pps_data.out_volt);
>   		port->pps_data.op_curr =
>   			min(port->pps_data.max_curr, port->pps_data.op_curr);
>   	}
> 

