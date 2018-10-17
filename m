Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC44ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78EB2086E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uu2SD2Nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78EB2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeJRDlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:41:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32946 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJRDlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:41:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so13030688pge.0;
        Wed, 17 Oct 2018 12:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kukxStogY+V0lP6DbEYT9+l0ErtioerpPouiREFUNcY=;
        b=uu2SD2NcfW2R6h4L+tq8HkdugWo+u4Umh8dTthUY0QJfaCl9Bmqfw/xlOfQMZV41Vf
         JbQwXROYVe1cYH3WOAl3xf/i+2gqCd5GHp4t947UIfH1kEgfCXtQ5vN02j7uwP7wGHSv
         7Olt2RSpo4HEr2HP1/Gd3jlE/WZ7IBxsRuCJJEkk81tMpOR2kK4VgM2PDxMC7F6vzXD1
         GUKS+/6lx7qdZO6/FfTvxBESjh5KekY2GlAGVuK/dPo5cPm3u9ieboHLX93FXvou52Jr
         I3ZwJVjhasyDhRkaQvL8LE7F2H5d5HZp6i7rGBOc23PYEjreivwhuDzUzI2W6vEPgV/Z
         gTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kukxStogY+V0lP6DbEYT9+l0ErtioerpPouiREFUNcY=;
        b=JVj2c+aswAnUjILWCqzLYMX1pokxQLApwctVlybfz5RrtI/Q/i+BE1Ni3/2Vv3agp4
         PoSlikBQuMX6ZbiAfW60D3gGP7AVn9eqgwOHfh2TCKb5mjsE0KxtTELDoGrk55IaFFng
         vnVMl45c59qyIMDynUHK9P+pQar44pzAAVciFQ++FCzxIWOUbhcLNFCvpoRajnXF7xqj
         u1qOivh/CC7eJj1lHRgSW6mAfjIrMGPatpMHgKiQez1QcT7F0YXtXB+zP2nfYi6qHyJ7
         rw7mCrzHouJhuT46kK7fRw49FS2vWLQOLWY9h1/quK2xSqMai3bklo8Nh0PsyJcYGPCQ
         aKoA==
X-Gm-Message-State: ABuFfogpu+97g9h403L0lbt7fx8zpG4CNs1f3RvgimJCYdBsmLY7e2XJ
        Fgbi4KWJu/pV+okKCQCibIQ=
X-Google-Smtp-Source: ACcGV60VeWAYvig8AVZ0trPX/rhenrmz2XzZ+DDZmXTjq7SQrTrBvvuK3q9ory1MAX0vMicT5Dbpvw==
X-Received: by 2002:a62:aa17:: with SMTP id e23-v6mr27793245pff.211.1539805472374;
        Wed, 17 Oct 2018 12:44:32 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id w127-v6sm25637729pfd.112.2018.10.17.12.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 12:44:31 -0700 (PDT)
Date:   Wed, 17 Oct 2018 12:44:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] hwmon: (core) Inherit power properties to hdev
Message-ID: <20181017194430.GA6812@roeck-us.net>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
 <20181017012426.26958-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017012426.26958-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 06:24:22PM -0700, Nicolin Chen wrote:
> The new hdev is a child device related to the original parent
> hwmon driver and its device. However, it doesn't support the
> power features, typically being defined in the parent driver.
> 
> So this patch inherits three necessary power properties from
> the parent dev to hdev: power, pm_domain and driver pointers.
> 
> Note that the dev->driver pointer is the place that contains
> a dev_pm_ops pointer defined in the parent device driver and
> the pm runtime core also checks this pointer:
>        if (!cb && dev->driver && dev->driver->pm)
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/hwmon/hwmon.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 975c95169884..7c064e1218ba 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -625,6 +625,9 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
>  	hwdev->name = name;
>  	hdev->class = &hwmon_class;
>  	hdev->parent = dev;
> +	hdev->driver = dev->driver;
> +	hdev->power = dev->power;
> +	hdev->pm_domain = dev->pm_domain;

dev can, unfortunately, be NULL

>  	hdev->of_node = dev ? dev->of_node : NULL;

... as you can see here.

Guenter

>  	hwdev->chip = chip;
>  	dev_set_drvdata(hdev, drvdata);
> -- 
> 2.17.1
> 
