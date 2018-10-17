Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88647ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFAC21479
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDBJ5ype"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFAC21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeJRDnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:43:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40249 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJRDnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:43:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id g21-v6so6689929pfi.7;
        Wed, 17 Oct 2018 12:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1xT8g/zixAXHql8bh/cCrp766K5il4K3i71D0+xX3ZU=;
        b=NDBJ5ypeuoaGEy6256oqA/eHaQ2U5n6YdmtNTbxOBBnpMbfP4rslCBQaIO+B6mUaeb
         lkRKPfYfUq7TMO9BANC/glQV3JY3nyP6k8N8DQjpw7uMq4m6roXq9BfN5Vm9j4yuI8tU
         V1HMMa8BOa1d8iP9ApGpbw+bOa7eWA8p8qEW0PuABaKiDzeWeDl2Q6QXDaDW/v5Db7D8
         bFXHbXlx4w/m90x6zs6mkRJhBVEncX48BgoRVjmKQBGDExSt1hsAAacK4CcWrHovVWGE
         tOlYxwD/2v7oXfy2VxG+Oj04EC83g4VTisfC70r+K5XN/f3slUnD+0gwfkiuZERzHjFX
         jyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1xT8g/zixAXHql8bh/cCrp766K5il4K3i71D0+xX3ZU=;
        b=rz9dKNrOimE2aSrW8mv7wRfKP7I54iIk3sUslpjFNStdV345WOZGDaF0Q0nFsTan+A
         YoDrHz0pPJoxbTBomKExSGkhrPTXe1fqYpcdtimYfnCGATlAdS8aLcM3CjjVID0akFXs
         B09LwYHzL6Cn8/6Lh1gyP2HBWphBJbOgAYZ1vo9PKzNwU2Zl043cdt86gGbiANc5aI/s
         1CIwfBFc6koLEwyPFpXtNVsYSR4ZUb8u4F7JuDxPI0mds03aTcXtm7yKtUmj1pNFodaF
         hHK686zPAJXr0D5mzZn3SV9JHw0X37kwlwjKdstM9DjitSJa04ipqAk7sEVQgnRYGJIP
         fO/A==
X-Gm-Message-State: ABuFfog8+v0CfDeL26s6PSNOda+r2mh0GHr0UNQBFelqSA0CC+nX7t7k
        zkighU+8NVe4SPvJ7f/MYKo=
X-Google-Smtp-Source: ACcGV60AHa1ygwsvb+Q0CfXalBCMtXtjaD/MIjtPre9k4/14HVoivzrqWxWJDvjnlenw3PR721hpFg==
X-Received: by 2002:a63:6286:: with SMTP id w128-v6mr2253339pgb.346.1539805567002;
        Wed, 17 Oct 2018 12:46:07 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i2-v6sm17878390pgq.35.2018.10.17.12.46.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 12:46:06 -0700 (PDT)
Date:   Wed, 17 Oct 2018 12:46:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] hwmon: (ina3221) Return -ENODATA for two alarms
 attributes
Message-ID: <20181017194605.GB6812@roeck-us.net>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
 <20181017012426.26958-3-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017012426.26958-3-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 06:24:23PM -0700, Nicolin Chen wrote:
> There is nothing critically wrong to read these two attributes
> without having a is_enabled() check at this point. But reading
> the MASK_ENABLE register would clear the CVRF bit according to
> the datasheet. So it'd be safer to fence for disabled channels
> in order to add pm runtime feature.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/hwmon/ina3221.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index d61688f04594..3e98b59108ee 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -200,6 +200,8 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
>  		return 0;
>  	case hwmon_curr_crit_alarm:
>  	case hwmon_curr_max_alarm:
> +		if (!ina3221_is_enabled(ina, channel))
> +			return -ENODATA;

Makes sense, but can you check what the sensors command does with this ?
If it bails out I'd rather have the code return 0 and no error (after all,
the sensor is disabled, so any alarm would be bogus).

Thanks,
Guenter

>  		ret = regmap_field_read(ina->fields[reg], &regval);
>  		if (ret)
>  			return ret;
> -- 
> 2.17.1
> 
