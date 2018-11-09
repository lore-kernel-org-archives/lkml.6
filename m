Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4219C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F2A2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlUjyE6K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F2A2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeKJIjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:39:46 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36843 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbeKJIjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:39:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id d13-v6so1577185pfo.3;
        Fri, 09 Nov 2018 14:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EFmz1lyHcqVpGgu7Fzp6Tsu53nwAEJemJDViA2rLru8=;
        b=WlUjyE6KxYbXvgXxtOUYXwe3cGu0Vuc20x4fVd+9wuI1XZTG7Lm8xM4w0pasiejLH3
         w5c00mNnWDSI9pkJT/NajYSk0TibppCCTdgsMg9xDAFq9+YcfnSgkC7Y06uYrhhYgl8R
         dynXiUUwYf7/S3L+mBmDDITPC2JsTIEu0qzXFKt+YvCDQibcj6I1cPfIxHt2nILwt2PC
         IMQUZumxHusLmRMusUggRW5XI4DN1VnF7oIjDDeffXAa3wSFbVlR4gCGCjkK9HCagy+5
         IBCW8hu5Rzr0h4ErwrtKbm8s74iOz+4/+ue8GOFm26kSRAzss9OP7o/YQRW/caRTl/7N
         Olnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EFmz1lyHcqVpGgu7Fzp6Tsu53nwAEJemJDViA2rLru8=;
        b=J44aVZdvYG0Xx7bq9qBeCUtyo/EPwz4+mQKOUK/KjgYnZFpU8Ec6IcxANoxpELs3CE
         Z/Ma7Nz+DtOMSUvZscscoiCgSKCdZYcekbhJJl8cr69koJQeSqLzExTVHG3gSHGgbXTx
         sbT3PzThp/QcNhtsArNS4J9gH3GtPYihTs2u5TfsJRNUodE2yzTynw5VM9pG4JsMC0X7
         c3KQsEB9yj6NKW6h7110qJ0sR6Zs1le6jSgYa1tEeDfs8NEeVxBcRSLR4rDi2lN7VQ2h
         6Et002vMrX1RlEma1t+w7ozFuYnLc7boDD3W5HKWfIty6ogANVOE/P58zhvz9QXSiomc
         6MXg==
X-Gm-Message-State: AGRZ1gLeWign7tOy+LEOsJcGd70PaovwKqI8d34omNTPikoSStC3FYQA
        hNTefZfjCU9uGRv8vZ0bRKGYxyIH
X-Google-Smtp-Source: AJdET5cMei8Z2avDIWmjsB16uAjQd3zwigxAJRlzA+CdSjGkndRuJ9wZ5a68CsfcO46vmzq6gtgDLw==
X-Received: by 2002:a63:ef47:: with SMTP id c7mr9247917pgk.386.1541804223602;
        Fri, 09 Nov 2018 14:57:03 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g5sm862013pgu.57.2018.11.09.14.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 14:57:02 -0800 (PST)
Date:   Fri, 9 Nov 2018 14:57:00 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] hwmon: (ina3221) Implement PM runtime to save
 power
Message-ID: <20181109225700.GA30816@roeck-us.net>
References: <20181105204843.4081-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105204843.4081-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 12:48:39PM -0800, Nicolin Chen wrote:
> This series patches implement PM runtime feature in the ina3221 hwmon
> driver (PATCH-4). However, PATCH-[1:3] are required to make sure that
> the PM runtime feature would be functional and safe.
> 

Series applied to hwmon-next.

Thanks,
Guenter

> Changelog
> v4->v5:
>  * Dropped the change for hwmon core; Shifted all the patch indexes
>  * Used i2c_client dev pointer for pm runtime callbacks (PATCH-4)
> v3->v4:
>  * Added generic pm runtime functions to hwmon class (PATCH-1)
>  * Updated to pass pm pointer via _with_info API (PATCH-5)
> v2->v3:
>  * Dropped timeout dev_err messages as it's indicated in errno (PATCH-4)
>  * Improved a dev_err message and comments (PATCH-5)
> v1->v2:
>  * Added device pointer check (PATCH-1)
>  * Returned 0 for alert flags (PATCH-2)
>  * Moved CVRF polling to data read routine (PATCH-4)
>  * Bypassed i2c_client->dev in suspend/resume() (PATCH-5)
> 
> Nicolin Chen (4):
>   hwmon: (ina3221) Check channel status for alarms attribute read
>   hwmon: (ina3221) Serialize sysfs ABI accesses
>   hwmon: (ina3221) Make sure data is ready before reading
>   hwmon: (ina3221) Add PM runtime support
> 
>  drivers/hwmon/ina3221.c | 190 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 166 insertions(+), 24 deletions(-)
> 
> -- 
> 2.17.1
> 
