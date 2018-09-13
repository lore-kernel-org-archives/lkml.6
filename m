Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EE4C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AE4213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 00:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="RG6z+Wrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85AE4213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbeIMF6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 01:58:07 -0400
Received: from vern.gendns.com ([206.190.152.46]:46447 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbeIMF6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 01:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2JfjiaZwDCyHr2071LwKYtbP5Ea6N5RM9k1W4ooGLqM=; b=RG6z+WrtRkAvm1DYXAEIHHBWjT
        /CR8OVeoyZuo+ZrGYFS5mHK2TQ0Fw041yMSxABasP+WpIzCd1SdsAfue+oSg6KfATjjxU2XgFDgFV
        17AmC+oARyTlFW8WAjZoIBTMyUaGD+mJlsURXcGa3dwGdrinJVKN7mxDWBev46TrPJzifp7LugfJe
        eH4FBG6LbLW+O9WDxC560xlUpJlkOTzDdBVmTAVqMC6fReketvsrSkq9X5xQ0JZInwSkl6WP7060S
        sKypbF8c1WqQdXbS46E3jdR4ZtT3MvN9J8gyMMr6iq4QvYPEvRx64+97usLIp4y8V31fqSmMjrNpy
        seAyl8Hw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:34326 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1g0FqY-00AIQi-Vh; Wed, 12 Sep 2018 20:51:03 -0400
Subject: Re: [PATCH] power_supply: sysfs: ratelimit property read error
 message
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20180913004830.1265-1-david@lechnology.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <fa60b825-cd9e-91d7-c422-ee3b147d68c1@lechnology.com>
Date:   Wed, 12 Sep 2018 19:51:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913004830.1265-1-david@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 07:48 PM, David Lechner wrote:
> This adds ratelimiting to the message that is printed when reading a
> power supply property via sysfs returns an error. This will prevent
> userspace applications from unintentionally dDOSing the system by
> continuosuly reading a property that returns an error.

s/continuosuly/continuously/

> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>   drivers/power/supply/power_supply_sysfs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 6170ed8b6854..dce24f596160 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -131,7 +131,8 @@ static ssize_t power_supply_show_property(struct device *dev,
>   				dev_dbg(dev, "driver has no data for `%s' property\n",
>   					attr->attr.name);
>   			else if (ret != -ENODEV && ret != -EAGAIN)
> -				dev_err(dev, "driver failed to report `%s' property: %zd\n",
> +				dev_err_ratelimited(dev,
> +					"driver failed to report `%s' property: %zd\n",
>   					attr->attr.name, ret);
>   			return ret;
>   		}
> 

