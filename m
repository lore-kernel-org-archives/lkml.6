Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC89CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83048208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1PS3W1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83048208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeKPK3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:29:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42453 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeKPK3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:29:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id x21-v6so7527626pln.9;
        Thu, 15 Nov 2018 16:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D4ec80u+BNIi7PJtY//hky+X61mrrrkMKiO81xuskZo=;
        b=p1PS3W1P5LBam6Lt0h6QSyB0CGxMUucNElUWKzEgcxjdZ3EBgrI4ar2m5zKgGfmknj
         Zv45+ehoCwKEVrF+slJG82KotMH93N8/EblUNY55msqro+igQgu60k+DHX+/iYHwLLqp
         udXZR0vknSUlwrdWTKCXe9WBIbBz3Yxq5uPgmHUj/c76dTk/uVyvXhqzgw9Nr/bQcAZp
         bxID15rKgEb1d5uT4C0VlBrtT1F68PgUbdGF9u2k+ePMF3x7Ak8ENGDTPXQ1SRqzFNi4
         klucCB1fXfx+zZDJ0TPEENtTP1/XqeN9oxLq4TlzeOKPRf4UmiNFzmry8wbSv4mZNRq/
         uiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D4ec80u+BNIi7PJtY//hky+X61mrrrkMKiO81xuskZo=;
        b=VVA/YqYD93Gke3rk9jCVWAUCFwjgSSoGYYLAGmcgWGAgg/XLkWAUjjNB7J8/AKGj+t
         0YAHMycOtHO2U3kKZ6Xtnb0cNlgV9dKNClR0Jmm5Z9+PYU1c+UN3o00AzRUVd1vh/Xnc
         KunfHx9+iiLNPPb9v9TdPbrbazxUgUeOJgznFbJaPwcnyan77rNCqM8Ww9miwPYmXWIS
         z5YdHK2gTRpfCKt2hj4aHz13G01asmAO8PVBvePXEDmRW36MYK12MNyJD7dcRRpKxoWM
         zP2IZktHf+J8VaZk7MWFX+M96Bsci7Iu6roUqJ6Mhg69uEwemewFxH9nbmbWeZAxf56B
         sc6w==
X-Gm-Message-State: AGRZ1gL5rQk5Z23v+MiA36fknMvb+aDRL76l+5s54LHnr6aArDkLtLx2
        mumz7rEZz7xrmbXrF0UXjMA=
X-Google-Smtp-Source: AJdET5e9WTZAYFyAVmC4n2gSNsDxfy5ZqWR+RmZFcZ0ET8v3Pzl/rQI1dBWIPHbIe0pOEJazRLdILQ==
X-Received: by 2002:a17:902:650a:: with SMTP id b10-v6mr8429095plk.36.1542327580424;
        Thu, 15 Nov 2018 16:19:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k24sm16636321pfj.13.2018.11.15.16.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 16:19:39 -0800 (PST)
Date:   Thu, 15 Nov 2018 16:19:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tao Ren <taoren@fb.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH] watchdog: core: suppress "watchdog did not stop" message
Message-ID: <20181116001938.GA16009@roeck-us.net>
References: <20181115234413.27009-1-taoren@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115234413.27009-1-taoren@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 11:44:26PM +0000, Tao Ren wrote:
> Currently "watchdog did not stop!" message is printed when the watchdog
> timer is not stopped at close. For example, people may see the message
> when rebooting the system, or the message will be logged to console
> periodically if watchdog is kicked by a scirpt which runs "echo k >
> /dev/watchdog" command.
> 
> Given a critical message usually indicates a serious hardware/software
> failure, this message could easily lead to confusion, so it's better to
> just delete the message.
> 
> Signed-off-by: Tao Ren <taoren@fb.com>

NACK. This message is displayed if/when the watchdog application
exits without stopping the watchdog and/or without closing properly.
This _is_ critical since it will reboot the system after the next
timeout period.

If userspace triggers this message on purpose (eg by the mentioned
script, which does not exit properly), userspace is at fault,
not the kernel.

Guenter

> ---
>  drivers/watchdog/watchdog_dev.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index f6c24b22b37c..65e9ebbd8759 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -879,7 +879,6 @@ static int watchdog_release(struct inode *inode, struct file *file)
>  
>  	/* If the watchdog was not stopped, send a keepalive ping */
>  	if (err < 0) {
> -		pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
>  		watchdog_ping(wdd);
>  	}
>  
> -- 
> 2.17.1
> 
