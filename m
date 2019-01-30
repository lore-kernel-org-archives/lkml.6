Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA7AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4122086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWExAgf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbfA3R2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:28:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34843 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfA3R2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:28:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so121746pgs.2;
        Wed, 30 Jan 2019 09:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jiK/5wEmnR1NSVX9k7yZPtVMnr7GbX57+YePuWAmpT4=;
        b=pWExAgf2bsu4mYTWbL1XKcDyAmnJ8+GyvWTIxY9hM2Erb7zRZMxk5ryEC65z7EsZOO
         OfqkzTxAHDYIzFef8eP4Oyb3vxwJRTinIfGRw468QEUwUc3Soc8SBc1SFZM8H2JqxoBr
         BJFrvfeLSJHZUW7HeJzIqIERJuFe98i7qp9+S1G1Qf0R7thqf4/HYMDiEtw2COe8ADS7
         27TiUbakMauNyBiuYS79TTu68gYaSJPDA1NqlEPTirxn5Q1gbFNwrD3NcjAv2slsT8Al
         ejtfTM0VhAvy4r3pkvR6RlR8ylQQHVdULXITfUbXJD9qMD7we3FtIjAWughYS/ap305l
         NM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jiK/5wEmnR1NSVX9k7yZPtVMnr7GbX57+YePuWAmpT4=;
        b=QdKCWkz/K4a1xnkLjSXLQXbRnJiczxJRPVK0Le3PpowZEIZBPkoRymMvV/wrYibkzN
         JmZhzlyDihb4hxbh2dkDO4xXhFA/ivoDFe6yB7p/TeQ3V+l1mdvVJoOasdNNavI4wi6U
         tTsRju2iOx8Nr3NtQE6/jghryQvCRZrTlc/jQlyC/daoi7CuS1vyU9iybgYk2RFP8p2c
         +k6bFe0xBVVms/7FzYkrPGdIIuBQHVOL4oWGTi1tTH5o6J6B3SdVeC4qUyEovbNUPdQA
         6izp2R4cS70BWvVMN1Y4GvAuYVsTyDPvq00n6uaTi37rNBFsgaP9UfsD+pLX6OrbVJpG
         wtAw==
X-Gm-Message-State: AJcUukfpVDEYSz8QIYGw28Q5XQnX5JA+NyA6NmF4G6uY09j4hYjaa0yh
        Nus0cjbh3skiehC+PMG34Es=
X-Google-Smtp-Source: ALg8bN6LCbDKN/XEI5GDmANFnNZg896xX3RR6Qre3qrKojKJq8RNLzP4Eo/RQmux96ewtUAFe0k0vA==
X-Received: by 2002:a62:b9a:: with SMTP id 26mr31651730pfl.196.1548869297276;
        Wed, 30 Jan 2019 09:28:17 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m20sm2940854pgv.93.2019.01.30.09.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 09:28:16 -0800 (PST)
Date:   Wed, 30 Jan 2019 09:28:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] dt-bindings: hwmon: Add tachometer interrupt to
 pwm-fan
Message-ID: <20190130172815.GC14781@roeck-us.net>
References: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
 <1548860827-29796-2-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548860827-29796-2-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 04:07:05PM +0100, Stefan Wahren wrote:
> This adds the tachometer interrupt to the pwm-fan binding, which is
> necessary for RPM support.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> index 49ca5d8..7f69b0b 100644
> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> @@ -8,6 +8,9 @@ Required properties:
>  
>  Optional properties:
>  - fan-supply    : phandle to the regulator that provides power to the fan
> +- interrupts    : contains a single interrupt specifier which describes the
> +                  tachometer pin output of a 2 pulse-per-revolution fan.
> +                  See interrupt-controller/interrupts.txt for the format.

So a hypothetical {1,4} pulse-per-revolution fan would explicitly not be
supported ? Why ?

Guenter
