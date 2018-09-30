Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A690C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2703206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfuSYd54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2703206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbeI3VdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 17:33:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35178 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeI3VdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 17:33:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id v133-v6so7690876pgb.2;
        Sun, 30 Sep 2018 08:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=THX5eFZJkQcsuivBldIGI0ag3X3sE2iZ3+bI6UqMf1I=;
        b=ZfuSYd54J3h+FvDK7BzEIgrlqmyHOhwAt3VY4N9weVU/rJmOxYBeMfyfGYW2ZkHA2i
         BZORXkWquAD93kU//TaCEUphqe9LIqDmX+XuBHTZS2JmbIm9foQAFZeYLQGFd5qBhtRh
         a1rkXI9La/T8baq93ZvsLowRnOTB02jBGFSt3aM/kAZbfJpvA/X4FxgQK0duuQzsTrmZ
         4E54cAzusWSoPdNoGX8CpQvCbx5EhkgJzNzSY4N8DBv3dN5F85N6gA6acLRP7n85aRa9
         GtDMPrW7fHinoElU/DtX7r4sW4lHey3a7sMwoyq4FTe/v5CcFYqtyLi3m19WL4tAeB8A
         axQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=THX5eFZJkQcsuivBldIGI0ag3X3sE2iZ3+bI6UqMf1I=;
        b=GY5y06ka6zT80l25QdnSEyWcRz0sh9XttN/9bdSlKRexJTvewWHJCefGuoWsSunTYg
         x3V0DO77w/0KBkNSg2/eAEY6ctlRt+4kxsceydbDQT1vzGwll9nXeY3+AnSYZg8QIB/g
         +CQHKUO5qg+WjeFDlm+hqZ7ZFWHEidB3soAUAfxH5NSGxt/tm88qFZ+nbdxswrLEK1zi
         jhE/rTG2lx99scVrYUn80o+3WtzocfS1PVb/arLHIuSpVwid5XqAU46E83SwcdSF0BRd
         10Ys3XdXfsqzLpydW8OnP2Xfr5mDArW5XYmQvfl0t6M2kAPia1SAgNhXX+9rEWlD1vsm
         +RRg==
X-Gm-Message-State: ABuFfohNj8sE3+kVJ0dy8dXf+wnfHs368GZHsUnFlYZMrOSmuzYSSLXb
        dVlk8Q7Nx8Xpt45P6SzBv0A=
X-Google-Smtp-Source: ACcGV61xPEqlTUo7IK/xSVo0CtnqisauGesOvejMaBh6hbyjnLXe2EIPcO+CltUoEGIoKVXH84+dig==
X-Received: by 2002:a63:d44:: with SMTP id 4-v6mr6784514pgn.107.1538319604180;
        Sun, 30 Sep 2018 08:00:04 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q2-v6sm25337177pfc.17.2018.09.30.08.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 08:00:03 -0700 (PDT)
Date:   Sun, 30 Sep 2018 08:00:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: ina3221: Add INA3221_CONFIG to
 volatile_table
Message-ID: <20180930150001.GA13042@roeck-us.net>
References: <20180929214407.27208-1-nicoleotsuka@gmail.com>
 <20180929214407.27208-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929214407.27208-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 02:44:05PM -0700, Nicolin Chen wrote:
> The MSB (15th bit) of INA3221_CONFIG is a self-clear reset bit.
> So this register should be added to the volatile_table of the
> regmap_config. Otherwise, we will see this bit is sticky in the
> regcache which might accidentally reset the chip when an actual
> write happens to the register.
> 
> This might not be a severe bug for the current code line since
> there's no second place touching the INA3221_CONFIG except the
> reset routine in the probe().
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/ina3221.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
> index e6b49500c52a..cfe65ff01051 100644
> --- a/drivers/hwmon/ina3221.c
> +++ b/drivers/hwmon/ina3221.c
> @@ -353,7 +353,7 @@ static struct attribute *ina3221_attrs[] = {
>  ATTRIBUTE_GROUPS(ina3221);
>  
>  static const struct regmap_range ina3221_yes_ranges[] = {
> -	regmap_reg_range(INA3221_SHUNT1, INA3221_BUS3),
> +	regmap_reg_range(INA3221_CONFIG, INA3221_BUS3),
>  	regmap_reg_range(INA3221_MASK_ENABLE, INA3221_MASK_ENABLE),
>  };
>  
