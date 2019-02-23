Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFBAC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E561220657
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 17:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6CjLL5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfBWRCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 12:02:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41975 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBWRCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 12:02:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so2532126pgq.8;
        Sat, 23 Feb 2019 09:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bFcCp2bDfNaCTD1wnVh+0XE/83DbDwWz8ibwUgPXo6g=;
        b=t6CjLL5RY9xomMUhvExaDVVW/U/KCDhPD5laiPiNadQsZdaWdoxiWOkI47ObIx3Pv/
         2o30jvXPK23my1fYitJtSt7wlihOazz+aE1/1nIdNy4fQTIB0CJHS3KcRWJfwav7vxZY
         db0zcD1JXiIW08HOz5ZMh0ITzU8EvqnxM7bEVI2i9A+qitRZtHrtOmM2+EVn55rdoxQu
         bthlwmOK9UMq5RAyPV6feP6FrZPm8sdTKsOns/S5j00+g3mPcQbzXKnq4FQ+wIjiecHz
         vqp5gJgISbeM1i8wPn2LUbzSjwmfCvLzmgXUgX8GK8pAoyYiFnJETTCESxhuHW9bReYF
         wR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bFcCp2bDfNaCTD1wnVh+0XE/83DbDwWz8ibwUgPXo6g=;
        b=SML/YNJaV/iqmXzkk7uv1A11vyqMFXv1AhdZBgqs4wdP4JubLHprCDTm/mH2sbgjgC
         XRgo6kd2HOeL8XgMzPqWpFtWvN/6ZjleHzKy2hTBVUwUKsIQJZh6+BVQjEao/06t5okW
         fQO4ds9IKylkYT3ApWs9svuPoWG4kadFlH1d3w8lVl1inhT19rM+gDFNAZbPPyHHkwjK
         TsgUB+4ECXWa4gAoEJZb6V3C7tE358zxWvUxu6WzaoquN4tlE348UeV09+LfXC9qZjB/
         ZAQ3N4GVhEtMiOUDc88eNkyhGc211Ce+Gfmqf3bt7dDm5CPgqUVzxLJU/uvAu5w0A4sQ
         0EFQ==
X-Gm-Message-State: AHQUAubghLHHMVfvUaGkWQ9tT4+8YgR0ovJOIeV+YDzugG7oLk3S5Io0
        Eu6YlHm59/KPaKJ7IKNvnJY=
X-Google-Smtp-Source: AHgI3IbcB7zF+MHHb7PSfWx7100jtSCZUipC+cP1/s6BsY0xJci1YcaklntBVI/ZUHQLDs1yZojDDQ==
X-Received: by 2002:a62:d10b:: with SMTP id z11mr10215282pfg.84.1550941368660;
        Sat, 23 Feb 2019 09:02:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2sm6297597pgj.64.2019.02.23.09.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 09:02:48 -0800 (PST)
Date:   Sat, 23 Feb 2019 09:02:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] dt-bindings: hwmon: Add optional regulator
 support to pwm-fan
Message-ID: <20190223170247.GA7739@roeck-us.net>
References: <1550843124-10992-1-git-send-email-stefan.wahren@i2se.com>
 <1550843124-10992-2-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550843124-10992-2-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 02:45:23PM +0100, Stefan Wahren wrote:
> This adds an optional regulator support (e.g. switchable supply) to the
> pwm fan binding.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> index c6d5332..49ca5d8 100644
> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> @@ -6,6 +6,9 @@ Required properties:
>  - cooling-levels      : PWM duty cycle values in a range from 0 to 255
>  			which correspond to thermal cooling states
>  
> +Optional properties:
> +- fan-supply    : phandle to the regulator that provides power to the fan
> +
>  Example:
>  	fan0: pwm-fan {
>  		compatible = "pwm-fan";
