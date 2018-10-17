Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24429ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C647D2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fejLbzAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C647D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJRAwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:52:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38537 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeJRAwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:52:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id f29-v6so13494392pff.5;
        Wed, 17 Oct 2018 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H0tzBNjen/HAYn5aeJtcuh3AEsMohdmkQq6MPW3YzHs=;
        b=fejLbzAP01ysmWhnDkK2hmEG0dk4YVME/3KQd8Jw8aUtJufDJvefRakpNAMea596Yz
         Qzt4SIcNv5pIDY7lAjgqB6dbrL8GiGk3zQyxhvMA+RrgH4DDnpVX5gtjrhVs6biNupCf
         kftJuNZE0FsOndS0+3Eoi+MGq+WWaU1YT3OZICM+9NwG1SK0AFt3YmMEDXRytnUKbs3s
         /DJD+nCCE75NEVRRnrd0MJS3kzT5ERrN4nVMzInpwSqNSVHrRM3HcWDHuauy4s0EQYyn
         Gnm8n+Q4RfZX9RTy7RkYxCfuCV11Y4tZq8rDZJXSUpsUIZ4wzLLK+TOgN+rCuqGK/xMU
         ZokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H0tzBNjen/HAYn5aeJtcuh3AEsMohdmkQq6MPW3YzHs=;
        b=OnlHa73/1atalzIUcwklsqDqEyCikIuC0Y4XJ6Kmybb8F9UPaxc1Lo46XFq2X2UigJ
         oGsCKitRsqTb/MFtin08ehSIC8YB15uUg5aycCuvPpJoDUXNChVUFpHIrRBBs0OxQH5W
         tdZ+6N/plvDVk82MFWP+IJrbPJ907eMGUZ+ZfM3PozDxfcCE6H5sjPbwFZUZuBgMw95s
         L36AclGflZqqM8cK0SetoxfDAUiqg2lEigxOusDP0JW03f7sriGFiS6/ZTv1CHjDNib1
         5v7lXUVR99xn7E+OIIMVZFbMuysj+anAWzE2i39l6+d7uz8Ym7FFa4JcD2g30IfRYN/W
         E0oQ==
X-Gm-Message-State: ABuFfojZGjvPBO5DhH9jheSo713a1XuN7NLErgjwM7fzXf42oUetDz74
        W4Lx/DFRwXUWRFc1r+3cTwgZ/A+p
X-Google-Smtp-Source: ACcGV612HQXEonRg2f1xxJ/aHd9fkCLFAh5Dr0t24oZNB8d8TjzQicCAnOTCo7wRXjs20UXPG/ZFAA==
X-Received: by 2002:a63:2807:: with SMTP id o7-v6mr24808559pgo.155.1539795345821;
        Wed, 17 Oct 2018 09:55:45 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x23-v6sm21102794pfm.113.2018.10.17.09.55.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 09:55:44 -0700 (PDT)
Date:   Wed, 17 Oct 2018 09:55:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] hwmon: (ina3221) Make sure data is ready after
 channel enabling
Message-ID: <20181017165543.GA22822@roeck-us.net>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
 <20181017012426.26958-5-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017012426.26958-5-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 06:24:25PM -0700, Nicolin Chen wrote:
> The data might need some time to get ready after channel enabling,
> although the data register is readable without CVRF being set. So
> this patch adds a CVRF polling to make sure that data register is
> updated with the new data.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/hwmon/ina3221.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index 5fc375bf6635..160ddc404d73 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -45,6 +45,7 @@
>  #define INA3221_CONFIG_MODE_BUS		BIT(1)
>  #define INA3221_CONFIG_MODE_CONTINUOUS	BIT(2)
>  #define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
> +#define INA3221_CONFIG_CHs_EN_MASK	GENMASK(14, 12)
>  
>  #define INA3221_RSHUNT_DEFAULT		10000
>  
> @@ -52,6 +53,9 @@ enum ina3221_fields {
>  	/* Configuration */
>  	F_RST,
>  
> +	/* Status Flags */
> +	F_CVRF,
> +
>  	/* Alert Flags */
>  	F_WF3, F_WF2, F_WF1,
>  	F_CF3, F_CF2, F_CF1,
> @@ -63,6 +67,7 @@ enum ina3221_fields {
>  static const struct reg_field ina3221_reg_fields[] = {
>  	[F_RST] = REG_FIELD(INA3221_CONFIG, 15, 15),
>  
> +	[F_CVRF] = REG_FIELD(INA3221_MASK_ENABLE, 0, 0),
>  	[F_WF3] = REG_FIELD(INA3221_MASK_ENABLE, 3, 3),
>  	[F_WF2] = REG_FIELD(INA3221_MASK_ENABLE, 4, 4),
>  	[F_WF1] = REG_FIELD(INA3221_MASK_ENABLE, 5, 5),
> @@ -111,6 +116,19 @@ static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
>  	return ina->reg_config & INA3221_CONFIG_CHx_EN(channel);
>  }
>  
> +static inline int ina3221_wait_for_data_if_active(struct ina3221_data *ina)
> +{
> +	u32 cvrf;
> +
> +	/* No need to wait if all channels are disabled */
> +	if ((ina->reg_config & INA3221_CONFIG_CHs_EN_MASK) == 0)
> +		return 0;
> +
> +	/* Polling the CVRF bit to make sure read data is ready */
> +	return regmap_field_read_poll_timeout(ina->fields[F_CVRF],
> +					      cvrf, cvrf, 100, 100000);
> +}
> +
>  static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
>  			      int *val)
>  {
> @@ -258,6 +276,13 @@ static int ina3221_write_enable(struct device *dev, int channel, bool enable)
>  	if (ret)
>  		return ret;
>  
> +	/* Make sure data conversion is finished */
> +	ret = ina3221_wait_for_data_if_active(ina);
> +	if (ret) {
> +		dev_err(dev, "Timed out at waiting for CVRF bit\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -676,6 +701,13 @@ static int __maybe_unused ina3221_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> +	/* Make sure data conversion is finished */
> +	ret = ina3221_wait_for_data_if_active(ina);

This is quite expensive and would delay resume (and enable, for that matter).
A less expensive solution would be to save the enable time here and in
ina3221_write_enable(). ina3221_wait_for_data_if_active() can then be called
from read functions and would wait if not enough time has expired.

	if (time_before(...))
		usleep_range(missing wait time, missing_wait_time * 2);

or something like that. This could be done per channel or, to keep
things simple, just using a single time for all channels.

Thanks,
Guenter

> +	if (ret) {
> +		dev_err(dev, "Timed out at waiting for CVRF bit\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.17.1
> 
