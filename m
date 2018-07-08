Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEEEC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 22:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42FF2089B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 22:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY5532Pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42FF2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeGHWua (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 18:50:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46676 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754360AbeGHWu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 18:50:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id l123-v6so12228657pfl.13;
        Sun, 08 Jul 2018 15:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wyt9oL6NkCy5tvzmV4N9QaMRZtCnBBRT6MHHuG7VL3k=;
        b=kY5532PeR/3uBH9mnck+uKifif4ACXoXiNl/zF1dFZfG/nAEw91k8KmzU6sEKFhnSh
         LJpeRR/vt1UN0BiyozFDUGPIeFG18C4RQCubYOhJGnci0WQlexT33QzE9BFG1IGq3pZX
         HWl/X6a3GJ+merZ9rDc+huy3djtjjWDeIui2r+2ytJPap/E7FcQgw3JKIiq8h9xC2dw1
         3HJrk04H06Y6g+ZvSxqH1FAg3G1eeXZaHgIyqTWIOWfdTJYRDGryGx9qQEn2ht3k0WcZ
         cNi9O4HQv3GZvS/lGch8DqnrWX96IbJKoXeYnqOyHH1BKrXlcioh8LEEBnZSLITLc3q5
         FK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wyt9oL6NkCy5tvzmV4N9QaMRZtCnBBRT6MHHuG7VL3k=;
        b=J+HrjVc1gQ3SPgmBBopcT6MlNtSA8wXJyL3kn+DGwrIyNKdEg98rpVZ2q9J2RpOazW
         gu+G2KEP7zEGDVcY6FRXRrsbfeJL64UvYJe63P96Od8tTHJahL5twl0YdSEHSRAg/+uY
         ++kDHO3E2FShxUo3VqpGrdaoXKvKeTlCEzhd3WBImcz7NU4Lm1UN06zCEdFw7OHsoCSr
         SdsnFc88TB6d00WSmnmKLBVK3HzaJqNiYkets15iyuB4Ed0Wi6KlHhZSnC2W37l+fNex
         Z5ipTp8AgYFflpXAifz0ETB/DyBEyXSBsijZuq1S8RqvzzerI4Lf0Lr7CbHW+dM/2o+p
         baKg==
X-Gm-Message-State: APt69E2bCHB1zAsb3ESPe1lHIekzr+lSOW2xhwg+JCqZ6X7BmTJUobYM
        peqrZXxEhiYsIZFcmSv6fQuO0w==
X-Google-Smtp-Source: AAOMgpdBPm4qnkNI+jr8xAayWdkvy8a+JneuBCMRi6a0g0pQ7rhQd9NCVHQr3dQ/waOTGyRPK2JA0A==
X-Received: by 2002:a63:7c5c:: with SMTP id l28-v6mr17038497pgn.352.1531090228500;
        Sun, 08 Jul 2018 15:50:28 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a190-v6sm372146pge.6.2018.07.08.15.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 15:50:27 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] hwmon: Document the sensor enable attribute
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
References: <1530878166-12589-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1530878166-12589-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7f9c672a-ae52-0bb3-8820-22049c445a4e@roeck-us.net>
Date:   Sun, 8 Jul 2018 15:50:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530878166-12589-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 04:56 AM, Shilpasri G Bhat wrote:
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Applied to hwmon-next, after updating the commit description.
I also removed the text "This attribute can be used as per-sensor or
per-sub-group attribute depending on what is supported by the hardware."
from the attribute descriptions; this is an implementation detail
which should be described in driver documentations.

Thanks,
Guenter

> ---
>   Documentation/hwmon/sysfs-interface | 62 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index fc337c3..f865dd7 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -171,6 +171,15 @@ in[0-*]_label	Suggested voltage channel label.
>   		user-space.
>   		RO
>   
> +in[0-*]_enable
> +		Enable or disable the sensors.
> +		When disabled the sensor read will return -ENODATA. This
> +		attribute can be used as per-sensor or per-sub-group attribute
> +		depending on what is supported by the hardware.
> +		1: Enable
> +		0: Disable
> +		RW
> +
>   cpu[0-*]_vid	CPU core reference voltage.
>   		Unit: millivolt
>   		RO
> @@ -236,6 +245,15 @@ fan[1-*]_label	Suggested fan channel label.
>   		In all other cases, the label is provided by user-space.
>   		RO
>   
> +fan[1-*]_enable
> +		Enable or disable the sensors.
> +		When disabled the sensor read will return -ENODATA. This
> +		attribute can be used as per-sensor or per-sub-group attribute
> +		depending on what is supported by the hardware.
> +		1: Enable
> +		0: Disable
> +		RW
> +
>   Also see the Alarms section for status flags associated with fans.
>   
>   
> @@ -409,6 +427,15 @@ temp_reset_history
>   		Reset temp_lowest and temp_highest for all sensors
>   		WO
>   
> +temp[1-*]_enable
> +		Enable or disable the sensors.
> +		When disabled the sensor read will return -ENODATA. This
> +		attribute can be used as per-sensor or per-sub-group attribute
> +		depending on what is supported by the hardware.
> +		1: Enable
> +		0: Disable
> +		RW
> +
>   Some chips measure temperature using external thermistors and an ADC, and
>   report the temperature measurement as a voltage. Converting this voltage
>   back to a temperature (or the other way around for limits) requires
> @@ -468,6 +495,15 @@ curr_reset_history
>   		Reset currX_lowest and currX_highest for all sensors
>   		WO
>   
> +curr[1-*]_enable
> +		Enable or disable the sensors.
> +		When disabled the sensor read will return -ENODATA. This
> +		attribute can be used as per-sensor or per-sub-group attribute
> +		depending on what is supported by the hardware.
> +		1: Enable
> +		0: Disable
> +		RW
> +
>   Also see the Alarms section for status flags associated with currents.
>   
>   *********
> @@ -566,6 +602,15 @@ power[1-*]_crit			Critical maximum power.
>   				Unit: microWatt
>   				RW
>   
> +power[1-*]_enable		Enable or disable the sensors.
> +				When disabled the sensor read will return
> +				-ENODATA. This attribute can be used as
> +				per-sensor or per-sub-group attribute depending
> +				on what is supported by the hardware.
> +				1: Enable
> +				0: Disable
> +				RW
> +
>   Also see the Alarms section for status flags associated with power readings.
>   
>   **********
> @@ -576,6 +621,14 @@ energy[1-*]_input		Cumulative energy use
>   				Unit: microJoule
>   				RO
>   
> +energy[1-*]_enable		Enable or disable the sensors.
> +				When disabled the sensor read will return
> +				-ENODATA. This attribute can be used as
> +				per-sensor or per-sub-group attribute depending
> +				on what is supported by the hardware.
> +				1: Enable
> +				0: Disable
> +				RW
>   
>   ************
>   * Humidity *
> @@ -586,6 +639,15 @@ humidity[1-*]_input		Humidity
>   				RO
>   
>   
> +humidity[1-*]_enable		Enable or disable the sensors
> +				When disabled the sensor read will return
> +				-ENODATA. This attribute can be used as
> +				per-sensor or per-sub-group attribute depending
> +				on what is supported by the hardware.
> +				1: Enable
> +				0: Disable
> +				RW
> +
>   **********
>   * Alarms *
>   **********
> 

