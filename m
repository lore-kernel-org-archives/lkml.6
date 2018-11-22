Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4AFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A9620824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVPGiIht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A9620824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406462AbeKWEWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:22:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41789 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406435AbeKWEWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 23:22:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so1993497pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SWzOB7lRQz3k1zhzqRIeHy8vGCWtDzwWyVzG97B337s=;
        b=QVPGiIhtEG2Zm4mFqurfbpybus54j32L1NYhtoP8VzaQY6Q++ZKxPk45y40QohvkqX
         DN/rShmF0kSMFKd4RURPROnCGv6IYdYkSkPmctbClyjQkAc4okugPbAmVHc45ApiZDwz
         L8TaUw3poaBHO+NXMNa5RC+CxQGZLp3FhUjuHpKXCRCYa3SqzcOXU/UCSvzRyzyZhlMo
         6Mgv15lzvyja/MXh2j8jSr0WLszBi9cT0Z8ugeq6vLdV2fUeYnWD5AjEdHge15xA8KLy
         9/NbuXUoqM8OlDtf0GHV4L/QDiC1v9gyeF2SLXL2UL1KBDFddfm/UqD1uLDWgveg+7wP
         0ALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SWzOB7lRQz3k1zhzqRIeHy8vGCWtDzwWyVzG97B337s=;
        b=OUqC9LxZJSBWWCL2+bEDFoJkIef86WtTuUeaTu+Vil4nVgxisA4tdrTAp0JsHMs22O
         GXKCwkdVMAe7lLIgouAbxkLq6Pv8Fb/7bfeaakzVmgZnSIauJFi5b5ttCJXESnCsQYrJ
         Mx14XDUOwEqhrjHbCXgBU9paggLkiBGuPNLpw97fku1r7tbbRAHFCWEegjycw465MQ4/
         bYwCkh4+2ezFLEXCNWcpDwpS4N1rBDXKhBfoFruGGbWnUSz3w814nNMNCTlnhtst/AWH
         7jUX6BhqXhbU1txnb6fBnhe2VgOVuDY3icEX0f6bUYVZB7+1UWxvIUo/WFZ7mEMl3mna
         JNWw==
X-Gm-Message-State: AA+aEWaodkZ3fAt+5VKKPpFhCwBBHRfcHZrNNX1dOS1aCzGhj7BjLEHV
        OpVd4aGZU+wy737+TRkp/lWgoZuw
X-Google-Smtp-Source: AFSGD/Wn3t7KhkfKsD/yvMhg8lPHByhlSNJuQ6nyLq2SY768ZEAZpZqUxshGeOhp30aWe0pDQtZtlQ==
X-Received: by 2002:a63:2b01:: with SMTP id r1mr10743990pgr.432.1542908513655;
        Thu, 22 Nov 2018 09:41:53 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a18sm58846743pgj.30.2018.11.22.09.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 09:41:52 -0800 (PST)
Date:   Thu, 22 Nov 2018 09:41:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     lee.jones@linaro.org, gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/7] mfd / platform: cros_ec: move lightbar attributes to
 its own driver.
Message-ID: <20181122174151.GA30386@roeck-us.net>
References: <20181122113356.23610-1-enric.balletbo@collabora.com>
 <20181122113356.23610-3-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122113356.23610-3-enric.balletbo@collabora.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Thu, Nov 22, 2018 at 12:33:51PM +0100, Enric Balletbo i Serra wrote:
> The entire way how cros sysfs attibutes are created is broken.
> cros_ec_lightbar should be its own driver and its attributes should be
> associated with a lightbar driver not the mfd driver. In order to retain
> the path, the lightbar attributes are attached to the cros_class.
> 
> The patch also adds the sysfs documentation.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
...
>  
> +int cros_ec_attach_attribute_group(struct cros_ec_dev *ec,
> +				   struct attribute_group *attrs)
> +{
> +	return sysfs_create_group(&ec->class_dev.kobj, attrs);
> +}
> +EXPORT_SYMBOL(cros_ec_attach_attribute_group);
> +
> +void cros_ec_detach_attribute_group(struct cros_ec_dev *ec,
> +				    struct attribute_group *attrs)
> +{
> +	sysfs_remove_group(&ec->class_dev.kobj, attrs);
> +}
> +EXPORT_SYMBOL(cros_ec_detach_attribute_group);
> +

Are those two functions necessary ? Why not just call sysfs_create_group
and sysfs_remove_group directly from the calling code ?

Thanks,
Guenter
