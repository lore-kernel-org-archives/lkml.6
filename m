Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA756C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700C9206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYla5dqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700C9206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeI3Vf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 17:35:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47028 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeI3Vf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 17:35:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so7648831pga.13;
        Sun, 30 Sep 2018 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hxt7NXOduPh2Su7WZHwNqtDtuerGZMOFpJ1BPuIcglM=;
        b=hYla5dqCc7CdZqYhBtpiZy2QL/XA6enXE7ym6w4LAm2ipTpRlE8Whz4kRFU3SKmmOa
         BYVMJ+qiKrfTBvsPqNmF6c06RKwvw2Ye1eTY4NTSMa+XCCjZQFKHrWD3fFYuUI6gvgqs
         jpbaLBkFEbhgzoYcxSA9nCMdD1YflyPACcNzYG97X9yNxkweAgmtkFDp3SrJoQ58dUCt
         cnTFy/8pbs3G2nsdJnBtRRpBwwiZIfwsBDYIGA+i7A/i8IV+5JqFHaosAylDLhb+U9xx
         y+mq5VKbCPi94q2Hclmmam839kJncHUyxULqDr4Mny/sTEEeC52X1h0eVoZqyJfTpvd1
         dDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hxt7NXOduPh2Su7WZHwNqtDtuerGZMOFpJ1BPuIcglM=;
        b=Gbkp0UrC7O7NtzQOqc0ZfcIrKxTOxIE1sW9xiLM1Z817JLExQIPikeVQEi7p5M6+qv
         qxfml3t6Ylgg7stlvKhNNH9HfDbLi0Z4e9MycDp121W8M7hfUqqBMRhyPxzvpB1jrXni
         A4orq6XFu2DeRO0fR4lwtIr/Cst5P5XDbJs+lBIppYeAzt36oQVCuFW3SmOOhOfh1H6h
         j+1SbuJ99jsv8qHweiIXmYg7P22jXcL9MhoKI+bdR/1bd/7zOUO1dlCwEBzOjkxaN7Fe
         D5p06QfuvPGEGkir23rilV2Iaxj/cZjB9p4kbOHyzE3VZMvqudOlqwcCsDq+MhXwH5GW
         wgiQ==
X-Gm-Message-State: ABuFfohjTpOLWll2xejpGdtrfouqgFApEEY7qXJPgtmfZ478MRhJAOmE
        Q0OiE4s6MbhbspVdBGiy6Eg=
X-Google-Smtp-Source: ACcGV60r32Nm8HHDdtxxhARFHplx0ZK2Yo6b1vg9hvWhndxcgBOYvBatc6I5IxATupeS9SBz1lcgPA==
X-Received: by 2002:a17:902:a03:: with SMTP id 3-v6mr7621819plo.323.1538319727602;
        Sun, 30 Sep 2018 08:02:07 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s14-v6sm11953149pgv.29.2018.09.30.08.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 08:02:07 -0700 (PDT)
Date:   Sun, 30 Sep 2018 08:01:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] hwmon: ina3221: Fix INA3221_CONFIG_MODE macros
Message-ID: <20180930150159.GA13190@roeck-us.net>
References: <20180929214407.27208-1-nicoleotsuka@gmail.com>
 <20180929214407.27208-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929214407.27208-3-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 02:44:06PM -0700, Nicolin Chen wrote:
> The three INA3221_CONFIG_MODE macros are not correctly defined here.
> The MODE3-1 filed is loacted at BIT 2-0 according to the datasheet.
> 
located

> So this patch just fixes them by shifting all of them with a correct
> offset. However, this isn't a crital bug fix as the driver does not
> use any of them at this point.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

No need to resend; I fixed it up. Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/ina3221.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index cfe65ff01051..e0c4f4d83f4e 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -38,9 +38,9 @@
>  #define INA3221_WARN3			0x0c
>  #define INA3221_MASK_ENABLE		0x0f
>  
> -#define INA3221_CONFIG_MODE_SHUNT	BIT(1)
> -#define INA3221_CONFIG_MODE_BUS		BIT(2)
> -#define INA3221_CONFIG_MODE_CONTINUOUS	BIT(3)
> +#define INA3221_CONFIG_MODE_SHUNT	BIT(0)
> +#define INA3221_CONFIG_MODE_BUS		BIT(1)
> +#define INA3221_CONFIG_MODE_CONTINUOUS	BIT(2)
>  
>  #define INA3221_RSHUNT_DEFAULT		10000
>  
