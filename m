Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C63C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242F521742
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iTIadHCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242F521742
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbeHNQWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:22:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35092 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732782AbeHNQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:22:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id g1-v6so17257895wru.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=K91FeSVm8izC4kRbjHtoyfX7pL61Br0otU3riF2ndyo=;
        b=iTIadHCoFMnKJQZQpS620tRWXKIYq6M0/5lqXnqLcYOu93TtbNBcDgMfXhXDf/Mzls
         usgIa8xlF3GWICqE3bF3uoxEF5C98A3xUMIKtbxXwega/guTEoViPHqfTY5rUC2ZRQU3
         7xlRuhTni3CFZCD0rxyRDvUPCV7HqHHQ72Vyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=K91FeSVm8izC4kRbjHtoyfX7pL61Br0otU3riF2ndyo=;
        b=BULpHI3NfR7Sz03IGF8qiPOq5mDN376B7qqVmjQpEqazrvhkNfP7/DSi9W1on0uYKF
         ttjLAl1CFS1pXOhzv1p1Yq8VAQjn8osN19C1SvsjyUGfvZGm7hKnlMkNPj0WWBVi4T/P
         2I5vNbQmgE2ad1kMKNDj6jcG98RXDISSUQXyajdwzfKUdtPQE5oqDu06WWQOSHrfEh7V
         FIoXjqqrUGAA88JI7rYNNiKAvfQZ7DtX0z0iiAQlumMWpc3Ewk8oQ4cK0mtXb2uCpEEN
         RICW56rVb07lyojl+S5f3+Mfc8RHeOLAULD7fGDtLMnOoJ4qVx0XxJxbZsR5oDH0jGyC
         VDqA==
X-Gm-Message-State: AOUpUlEa542O2MWbf1ydpwXUAhbdxqli/3QqD7L1DC4FWcrEFyGwlje+
        huMYH1tpQflTve4WaB1X/WWWGw==
X-Google-Smtp-Source: AA+uWPyWiXITI05asyduaL07FJvYGlRAVdkKI1sGcLcv9KSGrOi3OWUN9i+2QWdBm3jPO7pceSyeTQ==
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr13010134wre.12.1534253739018;
        Tue, 14 Aug 2018 06:35:39 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j133-v6sm27944849wmd.12.2018.08.14.06.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 06:35:38 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:35:36 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     zhe.he@windriver.com
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, kgdb-bugreport@lists.sourceforge.net,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kgdboc: Change printk to the right fashion
Message-ID: <20180814133536.bfpygzwnmlqfsee5@holly.lan>
References: <1534250761-824-1-git-send-email-zhe.he@windriver.com>
 <1534250761-824-2-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1534250761-824-2-git-send-email-zhe.he@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 08:46:01PM +0800, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> pr_* is preferred according to scripts/checkpatch.pl.
> 
> Cc: stable@vger.kernel.org

This change does not "fix a problem that causes a build error
(but not for things marked CONFIG_BROKEN), an oops, a hang, data
corruption, a real security issue, or some “oh, that’s not good” issue.
In short, something critical.". Only the first patch meets this criteria
and only that patch should be Cc:ed to stable@ .

Please remove from this patch.


> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> v2:
> - Split printk cleanups into a single patch
> - Add cc to stable@vger.kernel.org
> 
>  drivers/tty/serial/kgdboc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 206f8c2..0003d6c 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -136,7 +136,7 @@ static int kgdboc_option_setup(char *opt)
>  	}
>  
>  	if (strlen(opt) >= MAX_CONFIG_LEN) {
> -		printk(KERN_ERR "kgdboc: config string too long\n");
> +		pr_err("kgdboc: config string too long\n");

Looks like you should remove the tags from pr_err and use pr_fmt(fmt) to
put tags on the messages:

#define pr_fmt(fmt) "kgdboc: " fmt


Daniel.

>  		return -ENOSPC;
>  	}
>  	strcpy(config, opt);
> @@ -253,7 +253,7 @@ static int param_set_kgdboc_var(const char *kmessage,
>  	int len = strlen(kmessage);
>  
>  	if (len >= MAX_CONFIG_LEN) {
> -		printk(KERN_ERR "kgdboc: config string too long\n");
> +		pr_err("kgdboc: config string too long\n");
>  		return -ENOSPC;
>  	}
>  
> @@ -264,8 +264,7 @@ static int param_set_kgdboc_var(const char *kmessage,
>  	}
>  
>  	if (kgdb_connected) {
> -		printk(KERN_ERR
> -		       "kgdboc: Cannot reconfigure while KGDB is connected.\n");
> +		pr_err("kgdboc: Cannot reconfigure while KGDB is connected.\n");
>  
>  		return -EBUSY;
>  	}
> -- 
> 2.7.4
> 
