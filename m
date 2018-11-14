Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A245C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF602089F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuPgDU3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF602089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbeKODQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:16:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34763 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeKODQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:16:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so7386440pgg.1;
        Wed, 14 Nov 2018 09:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3cTohRAkiXXc1WScWgz2EjH+2ux+MlO1aP+F1hCh+Mw=;
        b=RuPgDU3o58OhNq/EwHCB/3t2TLXaPM9MqwKueHXP/1MTsU4Vyd82PpNLpB9nqJBncK
         P/ij+mzj1g9zsP2sO8I0IE1tO6+CEYlm+R8NEIKi3TedGzVi/YcsPsf0hRAj6Ube6tiH
         /H9Km1ZBvtfYeX6+K9cuKdDOS30xo1ecN8VXjb/RKF9sfD7dk2frcQBDboOFsxKXT2PU
         //o0SJblkX95w5x4dViTv+IA7wPjh0KSMM1BMnvXni1dBVWFAbgE7OnLVynn4Mc2HimQ
         WxAjD+mqvbHQ+gK8jQFiP9+WR8JQnvhvDRIal1WRHIM999q0q3sVay+vdBdlt0wZF13I
         ymdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=3cTohRAkiXXc1WScWgz2EjH+2ux+MlO1aP+F1hCh+Mw=;
        b=mssh+wauo5przNRyIw3J2iN4m7Z3UnL7S4EQsT3PZ05gBTuJRacyU11vrJ/3TtVo9l
         YZg4W5ekYyZ52OSe/n8nG8acXbqRfwmkdNeBM2ACBjWRcg/ER9hvaUR9cy2jsxnMJ5Ij
         +LEe1mPZ/Ea6QJHgTtS/ZiqA/HyNnaiFjal61zdZzvBP2fSVXl31+VC7G+NMLU+57OXG
         TZ9+wNewgRY7VEWoE0ncuswoHRloL2s7YEpjESU+KUjb1MAOlLdqlbth+wBLGPwvRiam
         JDRWliZ1LvM+lpxl2IPB+uIuIQUWInmLcTz9CTTARO+cQSwZwBmMEVuz1gstjMM+ldQ9
         pAkQ==
X-Gm-Message-State: AGRZ1gKAZ1INwUT+CJiYHlgrGYQbvaCYu5W1qGAOsmV6ZWMvUw/RUFZ8
        gQFPjsl4Rs422fpzdkC0jeQ=
X-Google-Smtp-Source: AJdET5fqH3XRljLuocB/MV9QP90Uxfr6dUkX4XPL89JKaNjSAJfiZTaYgtTfj+5VMGd3UlYOkzS0Gg==
X-Received: by 2002:a63:f65:: with SMTP id 37mr2493375pgp.238.1542215544795;
        Wed, 14 Nov 2018 09:12:24 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 186sm22575913pga.36.2018.11.14.09.12.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:12:23 -0800 (PST)
Date:   Wed, 14 Nov 2018 09:12:22 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ina2xx) Fix current value calculation
Message-ID: <20181114171222.GA25157@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 07:48:54PM -0800, Nicolin Chen wrote:
> The current register (04h) has a sign bit at MSB. The comments
> for this calculation also mention that it's a signed register.
> 
> However, the regval is unsigned type so result of calculation
> turns out to be an incorrect value when current is negative.
> 
> This patch simply fixes this by adding a casting to s16.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/ina2xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index c2252cf452f5..07ee19573b3f 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -274,7 +274,7 @@ static int ina2xx_get_value(struct ina2xx_data *data, u8 reg,
>  		break;
>  	case INA2XX_CURRENT:
>  		/* signed register, result in mA */
> -		val = regval * data->current_lsb_uA;
> +		val = (s16)regval * data->current_lsb_uA;
>  		val = DIV_ROUND_CLOSEST(val, 1000);
>  		break;
>  	case INA2XX_CALIBRATION:
> -- 
> 2.17.1
> 
