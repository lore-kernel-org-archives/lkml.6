Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39508C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26FD21F41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="iAkQ46r/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26FD21F41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbeGCT7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:59:10 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:36661 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbeGCT7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3STpEE75dlN2mr+SpZXW8y32SxF68tcmaWleQEC7Uu0=; b=iAkQ46r/y5hDZTuDul0pie16Rp
        ahFtd0ISylzZQIiI6G+u0JgscJXqE1sAK9pdfXY0zOjvwXIf3OaelXeAMv0Ld9GsX6HpvDR58By9T
        eJfcLj7W34EQ+1SQhZ9VHnJSUSetjGIQTWwLabDqreV+3mBO+HQp7WIelFUo0eHqJIZMqPfs9IbVK
        PXh833FuNLt4ROCsv7NV0d8lrRuiKl5vXBege6PFOM1dvjErLjhnodHAs5AF1W+JvzHCJY2E7QOQJ
        jaDSJm3aXtF0cAooQ4aXSIAChWUXITuaR2wQU2orkJu2KSdV+jH3Pnui+iq/FJ5vb7Z9h1PV4pE2o
        ogA+eMuw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:39612 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1faRS6-008EiQ-Nz; Tue, 03 Jul 2018 19:59:07 +0000
Date:   Tue, 3 Jul 2018 12:59:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksei Mamlin <mamlinav@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: w83795: Convert to
 hwmon_device_register_with_info()
Message-ID: <20180703195905.GA14558@roeck-us.net>
References: <20180703193515.4379-1-mamlinav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703193515.4379-1-mamlinav@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 10:35:15PM +0300, Aleksei Mamlin wrote:
> This patch replaces deprecated call to hwmon_device_register() with the new
> hwmon_device_register_with_info().
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>

NACK. This doesn't really convert anything, it just exploits a loophole
that was necessary because some drivers can not be converted cleanly.

Guenter

> ---
>  drivers/hwmon/w83795.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/w83795.c b/drivers/hwmon/w83795.c
> index 49276bbdac3d..25bcf988ef1c 100644
> --- a/drivers/hwmon/w83795.c
> +++ b/drivers/hwmon/w83795.c
> @@ -2234,7 +2234,8 @@ static int w83795_probe(struct i2c_client *client,
>  	if (data->chip_type == w83795g)
>  		w83795_check_dynamic_in_limits(client);
>  
> -	data->hwmon_dev = hwmon_device_register(dev);
> +	data->hwmon_dev = hwmon_device_register_with_info(dev, client->name,
> +							  data, NULL, NULL);
>  	if (IS_ERR(data->hwmon_dev)) {
>  		err = PTR_ERR(data->hwmon_dev);
>  		goto exit_remove;
> -- 
> 2.16.4
> 
