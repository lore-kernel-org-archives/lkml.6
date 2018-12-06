Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231B5C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCF520878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZEht12N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCF520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbeLFR5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:57:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46854 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLFR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:57:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so522897pfe.13;
        Thu, 06 Dec 2018 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5L8iuf/2rGPtBDYYmdAFTZds7U456isCJ+O2nxx3/OY=;
        b=iZEht12Nc90OwfHj4xmOTN0F0SgXNemppkPwTIZZCQ4BlXHgO/DkgX/qJGoE+3gbfY
         TfBOtms/QGQXYgihUVI1TSOiysA7QF169USknDC9PZ05j0l7euQ3ThJX9zfN3LwR7Iby
         ax9u7CF9FeEZdl6EKZgNSMU/1bhMqs3Pn2AT5zspx14IdijU/2zBjLT93YQdrm4SmOrU
         hEEASVCApeBjMqdrmiTo7Br5XRO1e3Kj446KruNBNIUlX0rfX2wiVgFGdyw8uq8GztVS
         mqbXvffaGImAhRttx9fC/STnT7z31REeMpJuXFF3Y/oJrX5cF3gkf8nEVvlnzVHctdh0
         29Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5L8iuf/2rGPtBDYYmdAFTZds7U456isCJ+O2nxx3/OY=;
        b=ZxJlymkf+eIewqpke9ROvLIVpgcsjmiT2myh0xmjutYC3ZHlB2UZW1dRyoEyRODBgj
         qOw51BLKqEx76rTio9HT4rBdlaWk5niQMJRqjf9Cf7jodYtAkBvTN7XeUjWD0kQAk+/j
         rFE6SttrbRp9u4N2jgJ7hMSPxB3NMnHmINAyBOm8An7f4H31EWhM5oVWRe3OsUWIZXPV
         +B3UgGYiviedEJM1qmVjF3CphZh42Xupy/XLpdI/B5X84+z4mbqxsTkiGcccO+qvFkMb
         zUfJMD1/4gSJeEG8UNK0gV77nQ7UQ1RwxQr38LACGpWjKz0C0RPiHSxqK1JQPXv437e7
         cvnw==
X-Gm-Message-State: AA+aEWaDXOvk2WT+qZlycBqTWfSp6vIt4JwmMIZpqdkgy1hVrYybJ3mH
        hxov5vDTHHBy9HTNXogXRsw=
X-Google-Smtp-Source: AFSGD/WUgvrdGgF+aV2/GNnIPKBb534yz7LC30ZuR8ohsxx3FCFpYf2NromB/UEGyj35tGxq6N5abQ==
X-Received: by 2002:a63:68c4:: with SMTP id d187mr24663527pgc.11.1544119069654;
        Thu, 06 Dec 2018 09:57:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j185sm1208745pge.72.2018.12.06.09.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:57:48 -0800 (PST)
Date:   Thu, 6 Dec 2018 09:57:47 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] watchdog/hpwdt: Update driver version.
Message-ID: <20181206175747.GD11808@roeck-us.net>
References: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
 <1544056943-79958-4-git-send-email-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544056943-79958-4-git-send-email-jerry.hoemann@hpe.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:42:23PM -0700, Jerry Hoemann wrote:
> Bump version number to reflect recent minor changes.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index c8e8055..ef30c7e 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -26,7 +26,7 @@
>  #include <linux/watchdog.h>
>  #include <asm/nmi.h>
>  
> -#define HPWDT_VERSION			"2.0.1"
> +#define HPWDT_VERSION			"2.0.2"
>  #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
>  #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
>  #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
> -- 
> 1.8.3.1
> 
