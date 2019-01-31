Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8CFC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF4C20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 17:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXfqnpiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfAaR6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 12:58:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33306 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfAaR6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 12:58:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so1826382plo.0;
        Thu, 31 Jan 2019 09:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7myhdk7E3+TT6ebRJum3PKNz1A/U8y95id46q85qWFA=;
        b=UXfqnpiLb0sYTMfuyEsUT0NBpBdE06FJHLeRZ7haUPKD65qD77qsiiANhtRkh5WiS6
         7xI3PqooWpkAow5y57Alo6FSQg1m6OdCLx0YsIUAHQhlzOR3Ivq2eR2Rp7+2Nvo7CAll
         pVmTVVrYeoU5p7ZXstHUDoSOMT1BqY/AUDCI1xzRJcKRVY9jZTC1Ud1BrmCRkGG/apjf
         8uM9oZaVNM/kFRbxMhkFaO26x44GhdldnfiwEgtyhsd3MJ04tm/1xh1NgpbnELjJ3ZTt
         pVEeHmfghISK1/hH2PPvyH3ZcuI8szfYnBqNPDIE5v811hWtBfyaG+ZZ2r/mOOKITwlw
         x8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7myhdk7E3+TT6ebRJum3PKNz1A/U8y95id46q85qWFA=;
        b=A7/yq/bIS4dpgC1NGlKnwxjZ7IPXtLvJK6NZ2LhEeQoFXDuYOB5tbie8RNZRCANcnN
         ILzIOlXS67mfe3+n8DTXTs1nEyz/BL8GyG3nhnoXzeUJUBi3A6RXuWnRj7WVJlurdlTr
         Pb5nyDW8gcyOkuWXhjkydAcDINZlgi5tx0Ov0TVbnxa1ljUI2ycYYGJyUBZRfpTRqJty
         muv6qBKPpLbdZ2uWgnKjOO85s0/zmnT7zyV4QtgU79ill1g9sdJhkfFXVG8iBIgu9b8n
         +PiOELrCma9ZNXjfW3uUOiPfDzEkDKnAc7QEPVSSqzS+el2ZF69ELN3WIVHaqWaAzTtm
         Vt+g==
X-Gm-Message-State: AJcUukdQAdHJxeTucHSSIjMImSK4QUWY7Ai1+TUoA0bC9EfNeulSU5ne
        kPkzXGmiyDt9h93GWTYidllb9hmv
X-Google-Smtp-Source: ALg8bN4KJvqqw2eCRobOJkD02z7VPnFh1yRzToU/Qcr6F19L33adkSsHJMwQDTmOU3MkDQZ2MFtj4g==
X-Received: by 2002:a17:902:5ac2:: with SMTP id g2mr35884774plm.313.1548957523423;
        Thu, 31 Jan 2019 09:58:43 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c9sm9396278pfc.92.2019.01.31.09.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 09:58:42 -0800 (PST)
Date:   Thu, 31 Jan 2019 09:58:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        joel@jms.id.au, jdelvare@suse.com, tglx@linutronix.de
Subject: Re: [PATCH v2 1/2] hwmon (occ): Fix license headers
Message-ID: <20190131175842.GA16851@roeck-us.net>
References: <1548692604-9899-1-git-send-email-eajames@linux.ibm.com>
 <1548692604-9899-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548692604-9899-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:23:23AM -0600, Eddie James wrote:
> Files have inconsistent license information.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/occ/common.c |  3 ++-
>  drivers/hwmon/occ/common.h |  3 ++-
>  drivers/hwmon/occ/p8_i2c.c |  3 ++-
>  drivers/hwmon/occ/p9_sbe.c |  3 ++-
>  drivers/hwmon/occ/sysfs.c  | 13 ++-----------
>  5 files changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
> index 391118c..b91a80a 100644
> --- a/drivers/hwmon/occ/common.c
> +++ b/drivers/hwmon/occ/common.c
> @@ -1,4 +1,5 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright IBM Corp 2019
>  
>  #include <linux/device.h>
>  #include <linux/hwmon.h>
> diff --git a/drivers/hwmon/occ/common.h b/drivers/hwmon/occ/common.h
> index 7c44df3..ed2cf42 100644
> --- a/drivers/hwmon/occ/common.h
> +++ b/drivers/hwmon/occ/common.h
> @@ -1,4 +1,5 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright IBM Corp 2019 */
>  
>  #ifndef OCC_COMMON_H
>  #define OCC_COMMON_H
> diff --git a/drivers/hwmon/occ/p8_i2c.c b/drivers/hwmon/occ/p8_i2c.c
> index b59efc9..76fb787 100644
> --- a/drivers/hwmon/occ/p8_i2c.c
> +++ b/drivers/hwmon/occ/p8_i2c.c
> @@ -1,4 +1,5 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright IBM Corp 2019
>  
>  #include <linux/device.h>
>  #include <linux/errno.h>
> diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
> index b65c1d1..f6387cc 100644
> --- a/drivers/hwmon/occ/p9_sbe.c
> +++ b/drivers/hwmon/occ/p9_sbe.c
> @@ -1,4 +1,5 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright IBM Corp 2019
>  
>  #include <linux/device.h>
>  #include <linux/errno.h>
> diff --git a/drivers/hwmon/occ/sysfs.c b/drivers/hwmon/occ/sysfs.c
> index 743b26ec..fe3d15e 100644
> --- a/drivers/hwmon/occ/sysfs.c
> +++ b/drivers/hwmon/occ/sysfs.c
> @@ -1,14 +1,5 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * OCC hwmon driver sysfs interface
> - *
> - * Copyright (C) IBM Corporation 2018
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright IBM Corp 2019
>  
>  #include <linux/bitops.h>
>  #include <linux/device.h>
