Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3637FC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D90620874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H04BMkYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfAJSbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 13:31:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33622 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfAJSbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 13:31:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so5703321pfb.0;
        Thu, 10 Jan 2019 10:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EOncnPHWdA2GYIole6MY3FQfttAqfUYxz/TSYuNxSrE=;
        b=H04BMkYFfGksBapV+T89qQxBmB0OIq/SExAiCAwv5/vTxrGcjqIz1AWY35nOzZutZ6
         M0r3pz5PkZnxbJanMkn4Rl8FpiWujdU5KXEqdg+3Sz2P3kTghYgRlWU+o9Q2BTqZOY5T
         iDgQdi2fhSvxJ4oiJckxZqNhAGSoYCfIBUTOC5iT/fGcp9JYydihS4vV47IaElsPXVYt
         HlBOOexHIbJE53bFffKyI8xblV1ycbFKxMtGXG1H6fXVoVbtl/hGwZlYha/VJ2lJY+UT
         tREwwn9FUELrqXx8G0PGDZ3KmG8cNEqbb/auQ16oBDaJ54omAl3DyVpyi+dHHGM/l6O7
         25NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EOncnPHWdA2GYIole6MY3FQfttAqfUYxz/TSYuNxSrE=;
        b=BkO4Usf7jKygrkImfACn4dcWa8gZm4uORrJzlFPJbfDN6B/X1DB+0ujuoKks1WdPlg
         9HYlaUngAvpY0NMyFTo/p0radYTCIK3a9onDouUwTIP1S5b9pKWbrVWPbUxlVeLexVeK
         5irYwlFX5/w7RdsxlH8KJzW7fQ221X+8l2kOfgTyYdFEGMjbFMkeG+/R2N3JWFjpC1zx
         yO1nPhg2E3K/c9F5pv/cM6m3JmHxdUvqwuGg0oSvhjYjUcHym0pYXbWxs67jnNIg0XRF
         M5g/bj92KFhdSkds1yQMezFxJc6I4WaTEGZLy98YqvNUh+ryGAuwCCAOq+i71DRxQc1a
         14tw==
X-Gm-Message-State: AJcUukfS7MrHZvItZrtKrlehHWSjPusrv68rbHJPLacMf6NdOc4tyEY3
        YR93og7oOZPod1emTuOI7WQ=
X-Google-Smtp-Source: ALg8bN4Vcnd0++5XDaa49TfsfiVMN5fZMPT4Kb4RJCImJO0WvpLNohks7nphZlerwzgoTU8+/gMnVw==
X-Received: by 2002:a63:658:: with SMTP id 85mr10291877pgg.373.1547145111769;
        Thu, 10 Jan 2019 10:31:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r8sm157973209pgu.38.2019.01.10.10.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 10:31:50 -0800 (PST)
Date:   Thu, 10 Jan 2019 10:31:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (adt7462) Mark expected switch fall-throughs
Message-ID: <20190110183149.GA4179@roeck-us.net>
References: <20190110162429.GA15908@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110162429.GA15908@embeddedor>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:24:29AM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/adt7462.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
> index b0211f731251..030f5d49c061 100644
> --- a/drivers/hwmon/adt7462.c
> +++ b/drivers/hwmon/adt7462.c
> @@ -448,6 +448,7 @@ static const char *voltage_label(struct adt7462_data *data, int which)
>  		case 3:
>  			return "+1.5V";
>  		}
> +		/* fall through */
>  	case 2:
>  		if (!(data->pin_cfg[1] & ADT7462_PIN22_INPUT))
>  			return "+12V3";
> @@ -505,6 +506,7 @@ static const char *voltage_label(struct adt7462_data *data, int which)
>  		case 3:
>  			return "+1.5";
>  		}
> +		/* fall through */
>  	case 11:
>  		if (data->pin_cfg[3] >> ADT7462_PIN28_SHIFT ==
>  					ADT7462_PIN28_VOLT &&
> @@ -542,6 +544,7 @@ static int voltage_multiplier(struct adt7462_data *data, int which)
>  		case 3:
>  			return 7800;
>  		}
> +		/* fall through */
>  	case 2:
>  		if (!(data->pin_cfg[1] & ADT7462_PIN22_INPUT))
>  			return 62500;
> @@ -599,6 +602,7 @@ static int voltage_multiplier(struct adt7462_data *data, int which)
>  		case 3:
>  			return 7800;
>  		}
> +		/* fall through */
>  	case 11:
>  	case 12:
>  		if (data->pin_cfg[3] >> ADT7462_PIN28_SHIFT ==
