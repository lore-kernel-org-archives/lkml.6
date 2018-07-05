Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA3C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2B824110
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTPYBk1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2B824110
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753421AbeGEPb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:31:27 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:39338 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753335AbeGEPbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:31:25 -0400
Received: by mail-pf0-f195.google.com with SMTP id s21-v6so5751989pfm.6;
        Thu, 05 Jul 2018 08:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VZ6GkbTlUNj0vycztCYWoBIMpbHwRPaaW+LSvyasHoA=;
        b=QTPYBk1foK725I/mrUY+F/xW9aWCAUrwEOPftaa5RHQqCin1wTR7iwrAlT6YBnpRo/
         1FE3dRzno/qTouGGPsphPMJTAzlC3ZdFccphEKk4tKhR5X37qk1o0bhQ4eaa5n/9KOzM
         2U4tATTi3iFTNEBa3AtkHGzVwIdRq1V3Ex9zc3nZEezsggOADBCU1ury+Yw/QZysxSt8
         OeXoEIeK7Gb3IEu6D4PUffeS9SymZkUMoAimzG9R4bVnQB7dAbvSybU+TuTTk6oo3k8S
         fu6b9xd5ZNjZROREr5jRez8rYE43z0JAgka4wQsFi0/Uu0agX944aRywGO9cpTaw/MSQ
         mNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VZ6GkbTlUNj0vycztCYWoBIMpbHwRPaaW+LSvyasHoA=;
        b=n8rwufrzPBipNI/3yi9LHLtnF2DTWJ1ZvTVUsKtKNhRnuq1X/mGoxY8/H+3Jk548kJ
         hqJZ3bQGqJ73csdM9B490AjU55GCu+ihuBfxApfFvpB0M+KHb0r4STL0UPDa5dyHjP/d
         4RE6OOLVjdPEyqn97tBEAwWZn8f1mEEumAX8eA28CB0lE2B5vN5N6GbMpTY8bEn96p8m
         C1tRfNXLgVCCund657s1TF3e9Ed+8tivR+KTSnVs9kcVpkBcmpy2rPJlNnEzaA/usEYF
         FXzHaWvvyaQgQnXK8YBQp/k3rnED+L2UO3MQvTLc3q7JlRZzdw+04C1aJECGfYivTErH
         jfnA==
X-Gm-Message-State: APt69E1T2uJOmzblgHU7+VyT4OXxXeTWXtI6RfxvCZR/KCYeiUmWCg4/
        CJRV9AbDssCdaB64CYqQq+c=
X-Google-Smtp-Source: AAOMgpef/jZgRoBC8Lk4gXkIbepW6pd5GP04KO+S8e7y8mGWWJ8xkjR/924oO6sxQiJTnlpUEKPUoQ==
X-Received: by 2002:a63:686:: with SMTP id 128-v6mr4034pgg.338.1530804684962;
        Thu, 05 Jul 2018 08:31:24 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q10-v6sm19318078pfj.7.2018.07.05.08.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 08:31:24 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] hwmon: Document the sensor enable attribute and
 update ibmpowernv
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        ego@linux.vnet.ibm.com
References: <1530798689-27742-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1530798689-27742-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4355fd2a-8cd1-ffff-e308-dcd621baad53@roeck-us.net>
Date:   Thu, 5 Jul 2018 08:31:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530798689-27742-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 06:51 AM, Shilpasri G Bhat wrote:
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>   Documentation/hwmon/ibmpowernv      | 35 +++++++++++++++-
>   Documentation/hwmon/sysfs-interface | 82 +++++++++++++++++++++++++++++++++++++

I guess I wasn't specific enough. The sysfs ABI change must be a separate patch,
independent of the driver (and driver documentation) changes. If you want to document
the driver changes with the same patch as the driver or in a separate patch is up
to you, but I'll want the ABI changes in a separate patch.

Guenter

>   2 files changed, 115 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hwmon/ibmpowernv b/Documentation/hwmon/ibmpowernv
> index 8826ba2..77ddba7 100644
> --- a/Documentation/hwmon/ibmpowernv
> +++ b/Documentation/hwmon/ibmpowernv
> @@ -33,9 +33,40 @@ fanX_input		Measured RPM value.
>   fanX_min		Threshold RPM for alert generation.
>   fanX_fault		0: No fail condition
>   			1: Failing fan
> +
>   tempX_input		Measured ambient temperature.
>   tempX_max		Threshold ambient temperature for alert generation.
> -inX_input		Measured power supply voltage
> +tempX_highest		Historical maximum temperature
> +tempX_lowest		Historical minimum temperature
> +temp1_enable		Enable/disable all temperature sensors
> +			1: Enable
> +			0: Disable
> +temp[2-N]_enable	State of the sensor (enabled/disabled)
> +
> +inX_input		Measured power supply voltage (millivolt)
>   inX_fault		0: No fail condition.
>   			1: Failing power supply.
> -power1_input		System power consumption (microWatt)
> +inX_highest		Historical maximum voltage
> +inX_lowest		Historical minimum voltage
> +in1_enable		Enable/disable all voltage sensors
> +			1: Enable
> +			0: Disable
> +in[2-N]_enable		State of the sensor (enabled/disabled)
> +
> +powerX_input		Power consumption (microWatt)
> +powerX_input_highest	Historical maximum power
> +powerX_input_lowest	Historical minimum power
> +power1_enable		Enable/disable all power sensors
> +			1: Enable
> +			0: Disable
> +power[2-N]_enable	State of the sensor (enabled/disabled)
> +
> +currX_input		Measured current (milliampere)
> +currX_highest		Historical maximum current
> +currX_lowest		Historical minimum current
> +curr1_enable		Enable/disable all current sensors
> +			1: Enable
> +			0: Disable
> +curr[2-N]_enable	State of the sensor (enabled/disabled)
> +
> +energyX_input		Cumulative energy (microJoule)
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index fc337c3..d81109c 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -171,6 +171,17 @@ in[0-*]_label	Suggested voltage channel label.
>   		user-space.
>   		RO
>   
> +in[0-*]_enable
> +		Enable or disable the sensor.
> +		When disabled the sensor read will return -ENODATA. For chips
> +		which do not have the capability to disable/enable single sensor
> +		but have support for sensor-group disable/enable, will only have
> +		the first attribute with write permission. In such cases write
> +		to the first attribute will affect all the sensors of this type.
> +		1: Enable
> +		0: Disable
> +		RW/RO
> +
>   cpu[0-*]_vid	CPU core reference voltage.
>   		Unit: millivolt
>   		RO
> @@ -236,6 +247,17 @@ fan[1-*]_label	Suggested fan channel label.
>   		In all other cases, the label is provided by user-space.
>   		RO
>   
> +fan[1-*]_enable
> +		Enable or disable the sensor.
> +		When disabled the sensor read will return -ENODATA. For chips
> +		which do not have the capability to disable/enable single sensor
> +		but have support for sensor-group disable/enable, will only have
> +		the first attribute with write permission. In such cases write
> +		to the first attribute will affect all the sensors of this type.
> +		1: Enable
> +		0: Disable
> +		RW/RO
> +
>   Also see the Alarms section for status flags associated with fans.
>   
>   
> @@ -409,6 +431,17 @@ temp_reset_history
>   		Reset temp_lowest and temp_highest for all sensors
>   		WO
>   
> +temp[1-*]_enable
> +		Enable or disable the sensor.
> +		When disabled the sensor read will return -ENODATA. For chips
> +		which do not have the capability to disable/enable single sensor
> +		but have support for sensor-group disable/enable, will only have
> +		the first attribute with write permission. In such cases write
> +		to the first attribute will affect all the sensors of this type.
> +		1: Enable
> +		0: Disable
> +		RW/RO
> +
>   Some chips measure temperature using external thermistors and an ADC, and
>   report the temperature measurement as a voltage. Converting this voltage
>   back to a temperature (or the other way around for limits) requires
> @@ -468,6 +501,17 @@ curr_reset_history
>   		Reset currX_lowest and currX_highest for all sensors
>   		WO
>   
> +curr[1-*]_enable
> +		Enable or disable the sensor.
> +		When disabled the sensor read will return -ENODATA. For chips
> +		which do not have the capability to disable/enable single sensor
> +		but have support for sensor-group disable/enable, will only have
> +		the first attribute with write permission. In such cases write
> +		to the first attribute will affect all the sensors of this type.
> +		1: Enable
> +		0: Disable
> +		RW/RO
> +
>   Also see the Alarms section for status flags associated with currents.
>   
>   *********
> @@ -566,6 +610,19 @@ power[1-*]_crit			Critical maximum power.
>   				Unit: microWatt
>   				RW
>   
> +power[1-*]_enable		Enable or disable the sensor.
> +				When disabled the sensor read will return
> +				-ENODATA. For chips which do not have the
> +				capability to disable/enable single sensor but
> +				have support for sensor-group disable/enable,
> +				will only have the first attribute with write
> +				permission. In such cases write	to the first
> +				attribute will affect all the sensors of this
> +				type.
> +				1: Enable
> +				0: Disable
> +				RW/RO
> +
>   Also see the Alarms section for status flags associated with power readings.
>   
>   **********
> @@ -576,6 +633,18 @@ energy[1-*]_input		Cumulative energy use
>   				Unit: microJoule
>   				RO
>   
> +energy[1-*]_enable		Enable or disable the sensor.
> +				When disabled the sensor read will return
> +				-ENODATA. For chips which do not have the
> +				capability to disable/enable single sensor but
> +				have support for sensor-group disable/enable,
> +				will only have the first attribute with write
> +				permission. In such cases write	to the first
> +				attribute will affect all the sensors of this
> +				type.
> +				1: Enable
> +				0: Disable
> +				RW/RO
>   
>   ************
>   * Humidity *
> @@ -586,6 +655,19 @@ humidity[1-*]_input		Humidity
>   				RO
>   
>   
> +humidity[1-*]_enable		Enable or disable the sensor.
> +				When disabled the sensor read will return
> +				-ENODATA. For chips which do not have the
> +				capability to disable/enable single sensor but
> +				have support for sensor-group disable/enable,
> +				will only have the first attribute with write
> +				permission. In such cases write	to the first
> +				attribute will affect all the sensors of this
> +				type.
> +				1: Enable
> +				0: Disable
> +				RW/RO
> +
>   **********
>   * Alarms *
>   **********
> 

