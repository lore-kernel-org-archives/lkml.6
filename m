Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212CDC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F3720880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPwSUE02"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F3720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeILVHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:07:42 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33208 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeILVHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:07:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id s7-v6so1305707pgc.0;
        Wed, 12 Sep 2018 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3EKTlf27jyQZ8s4nntev35+YoNxNHI6V2pv6fmn4nIs=;
        b=dPwSUE02h6pFvcjHFYfMClSRBtNGHFG5GUOSXT/VlDtyk/HnicioJ9yWTjxyjOfuW5
         Il+VyP3bZKsAZdZsf3KYOFv+7a3BAwHXQFAUETDXkaIqRVttoNlflumJOXDryzX51kPp
         gEvNf5W42liQ/8dT6ShgxqHC0a8EWFr5t6SXvmZk5qatge9bQ/8WgWSiu00hIi2ObMac
         I/I/Tu6ulAk1EGC3Ucw3cXa0WbyOdTBJ/Np057Z/Hk5f2uNP3qJQiTIT5jtP0mgq/a0b
         3lPUwP0LP0xXVC08lJdFlnMjH3u/x3VqaJ3Zsjf1NXnmPnJ8DrkSHWTnDNg6g80k9jOb
         0M3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3EKTlf27jyQZ8s4nntev35+YoNxNHI6V2pv6fmn4nIs=;
        b=XyXx3RWb90y0aEYW3HNKyQDbVZMEqHJhvTbUFoTfAzRD6sf2zuzi9GvYSMnYjezots
         P5ySDQzNPL1haorjatpkEgBT0OJAkk4/jCS4goy4sAaIoHcpwnPexJaonXj1j3IMqKVX
         0M8EbQBFLaahTA/3BaEw5G9Aan3kpI68N2c3m22aBzpwUcGUuC/8XgHNgV4e/GFR1PdK
         FP+gKb2fIxuIbx8rljuBTstM+Nq3nn73HyHpQ0Jx9aEpLpWTXp8vbwsWj8YBhwFDSsw2
         8rsJ8UrvrM6zBjkcd049UhdtV7TNV/CKg173QtQDIhvOgquGpSyWY7ny7eR9i3xd+Zb0
         hGTA==
X-Gm-Message-State: APzg51B1lhGBT/hGy+8V4QSNs9u75rgDbZSUjOFpj7HB7bPxCvVdTkwV
        0+guz32QDNuvB5A4p2b2XDE=
X-Google-Smtp-Source: ANB0Vdb3ahCBughx6uSa79JERcIVZDeS65ChYjx/LzcU4ViFCfKddoocY6VVf0XVa/sRi1pUoXwuuw==
X-Received: by 2002:a63:fc07:: with SMTP id j7-v6mr3061541pgi.1.1536768152024;
        Wed, 12 Sep 2018 09:02:32 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r205-v6sm4472696pgr.11.2018.09.12.09.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 09:02:30 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:02:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jagdish Tirumala <t.jag587@gmail.com>
Cc:     wim@linux-watchdog.org, yamada.masahiro@socionext.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WATCHDOG: uniphier_wdt.c: Fixed error do not initialise
 statics to 0
Message-ID: <20180912160229.GA3300@roeck-us.net>
References: <20180912153354.4658-1-t.jag587@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912153354.4658-1-t.jag587@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 08:33:54AM -0700, Jagdish Tirumala wrote:
> Fixed error do not initialise statics to 0
> in file drivers/watchdog/uniphier_wdt.c
> 

I don't mind the patch, but I do mind both subject and description
as misleading. This is not an error, except for checkpatch.

A subject such as "watchdog: uniphier_wdt: Do not initialize static
variables to 0" and a description along the line of

Fix the following checkpatch error:

ERROR: do not initialise statics to 0
#44: FILE: drivers/watchdog/uniphier_wdt.c:44:
+static unsigned int timeout = 0;

would be more appropriate.

Please also note that the watchdog subsystem does not use capital
letters to describe the subsystem name, and the driver tag should not
include ".c". As a general note, I would suggest to do a quick browse
through commits in a subsystem to get an idea about its conventions.

Thanks,
Guenter

> Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
> ---
>  drivers/watchdog/uniphier_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
> index e20a7a459d69..2c62ad7250fb 100644
> --- a/drivers/watchdog/uniphier_wdt.c
> +++ b/drivers/watchdog/uniphier_wdt.c
> @@ -41,7 +41,7 @@
>  #define WDT_PERIOD_MIN			1
>  #define WDT_PERIOD_MAX			128
>  
> -static unsigned int timeout = 0;
> +static unsigned int timeout;
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  
>  struct uniphier_wdt_dev {
> -- 
> 2.17.1
> 
