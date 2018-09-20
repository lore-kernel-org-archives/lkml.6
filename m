Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCD6ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2D42087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl4QdBgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2D42087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbeITXPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:15:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44370 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeITXPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:15:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so4685207pff.11;
        Thu, 20 Sep 2018 10:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dIOyyyyoiuNeg4o0XmSQB5T/tVW51+2s2SifPkFVg6w=;
        b=Tl4QdBgg2wWfh8TejpGFSe/q26Xir32TS73QuLFxTXZeRrdzK5QOIJdt85j0cRMbzz
         zv9fljbQyk0dJnfeknNSh3QaQKcPQYNsgufZXSeSQlEVIIfTJ3yeUNN62g6MbWFiODtj
         VclIaohLN6u95rx3qzLu7+G5p4WJ9PvaCcne67mHJ7Z5i9EDFyMS1a0eZziSOJ9ffu5M
         XRKIrSRhNLneJIe3ngKdWRSF86KFZugNAD84oatzOrCR3MFyzAklQSpcrp1/nJEA0ZN+
         3ad6bFxMJ2f1hB7vsKbVJKxqVfCc1r2TYlvDNWuZDqZxnGK0SZv/Z3T9igEQ984ycDLN
         fx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dIOyyyyoiuNeg4o0XmSQB5T/tVW51+2s2SifPkFVg6w=;
        b=fMVA8kqZzn7ud6UxGsnTFB8lAsnV+2WU6YlBRE1hTCvy30TGrQx3Ya0U/zB9qxvmgl
         roFnptReClGjms74B1QFzwsEP8SLV+TbFfmtnK1j7eBn9CDn9QNg6d8euJCt0oSvUps5
         zJc4aFoLmIAMAXpqarL4DziokkP9eg7WEoRlTUwGgY2VHYT8itLgisaoRXt9OKsZ/v1C
         wd6nriQLx6FxE+Pky2NyHliKkvPyZGCx4G0wQPQN2CYrMUbPMprp79CN8Be51OQ8ANto
         71HFD/8smqTvlZSCkS56HL3iX0dP4ATpctPL1KQVuD4iqLQ1ItvBpY7nXROe4I58dY7v
         pYXQ==
X-Gm-Message-State: APzg51AS+QVStu3YYxssLwz1OSi2UnFn+EU95vGNAXD/f+4achhiDH6z
        e2J2tbHzrRSMe6UmDKl56t0=
X-Google-Smtp-Source: ANB0VdbRyzHKjXCJ7B3BhiKOHSg3pa5ERYB03kzOWxgZLsUAnRrg8pb94uyeQT0xOYqqt2TlfiHKjg==
X-Received: by 2002:a62:ce82:: with SMTP id y124-v6mr9982239pfg.140.1537464647849;
        Thu, 20 Sep 2018 10:30:47 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u11-v6sm11771291pgj.71.2018.09.20.10.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:30:46 -0700 (PDT)
Date:   Thu, 20 Sep 2018 10:30:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: remove redundant continue
Message-ID: <20180920173045.GA15272@roeck-us.net>
References: <1537431070-38261-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537431070-38261-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 04:11:10PM +0800, zhong jiang wrote:
> The continue will not truely skip any code. hence it is safe to
> remove it.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

The proper subject line would be

hwmon: (scpi-hwmon) <summary>

Since it now happened several times that I got a patch without proper
subject (ie where the subject does not even mention the affected driver),
I am no longer going to accept patches if the affected driver is missing,
sorry.

Guenter

> ---
>  drivers/hwmon/scpi-hwmon.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 7e49da5..111d521 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -286,10 +286,8 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
>  		 * any thermal zones or if the thermal subsystem is
>  		 * not configured.
>  		 */
> -		if (IS_ERR(z)) {
> +		if (IS_ERR(z))
>  			devm_kfree(dev, zone);
> -			continue;
> -		}
>  	}
>  
>  	return 0;
> -- 
> 1.7.12.4
> 
