Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55499C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 17:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F18E02085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 17:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKyRD1Rc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F18E02085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeJ1COU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 22:14:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42989 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeJ1COU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 22:14:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so1952431pgq.9;
        Sat, 27 Oct 2018 10:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H/1OqAdttXK0U67yzUyL1vtOHPem0NZuPBvQjEKM7bQ=;
        b=nKyRD1Rc6gT2wTj497jhftcESJLPPxUgrs9iamaGJGIwAUL1uLT5yCJPQowsMvQW6y
         byM4nkD0BaCsAK47L+QnlZO0002TncBmaXmoma2dSweS5UcuDyErRTTv1m5Sq5RD66vQ
         A1OZTscGlabvILxa+NtfzYpHfUHC4BvJLf+FUnwLVvFVxwgHGLWe4MLTRCMqSolpCSpH
         NThwLf/D2her4eQoqm2BxE1BfF+EdD/BE2nULYWpWgxtBL2rFVZuXcFcVkZZUHR0xrCF
         /g5gdwG1MCRe6b2XlU0V3oszi0149PxD+RG1EEOO5bAb5dfHASl9idcb12+tc/Rp0BFQ
         gcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=H/1OqAdttXK0U67yzUyL1vtOHPem0NZuPBvQjEKM7bQ=;
        b=ZkqLhHk4ZZMGYDKEdXF0E9oM93thlFHsx1BD+FhrSInk/IMBA+RwYe53iEwRQuSt1c
         SUd7WzHEdqU3XFjWbG2dWmhWhETf9d+feLEo9qKlpwH0ud9ooNZHnDw+/Oq8x0dxxAID
         MXV6Kj3yK0kE4uuZMMhduTcazevOQGaM+kqnZo7khcL+7mWMgE9xrXkjQs9GBJAifks5
         Qjjf7/mWFuFUz7M8rOqSu2cCj2OI7EeyU2Mjp3yeycir7mVa/dokQ7O9b+hiuwTV7vfv
         hiVRyBcfBGkKycQ6hzSEZQt+K+ES12ceDYTT5uPlIgN9BVrYZRggrN9AKC599NUctXzY
         dRiw==
X-Gm-Message-State: AGRZ1gLoU41BUVX9qckciN4d4VtrpyjTMD/9/hSaqESnorD69HjAXbCZ
        /YteTYlqTF67HfLOV/36/zTAFwZy
X-Google-Smtp-Source: AJdET5dsz8rrlY9pAuV7EMqEkA1Azr4P7Y6Kak64dGa3ZVBaQk1eor20fMMYKARGlJNgfvUBJccY0g==
X-Received: by 2002:aa7:814f:: with SMTP id d15-v6mr8512361pfn.78.1540661558365;
        Sat, 27 Oct 2018 10:32:38 -0700 (PDT)
Received: from localhost (99-61-165-247.lightspeed.sntcca.sbcglobal.net. [99.61.165.247])
        by smtp.gmail.com with ESMTPSA id l1-v6sm16441616pgm.8.2018.10.27.10.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 10:32:37 -0700 (PDT)
Date:   Sat, 27 Oct 2018 10:32:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: hwmon: remove redundant cast
Message-ID: <20181027173236.GA26153@roeck-us.net>
References: <20181026223059.17652-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026223059.17652-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 12:30:59AM +0200, Rasmus Villemoes wrote:
> struct attribute::name which this local variable name is eventually
> assigned to is "const char*", and so is the template parameter. We might
> as well preserve the constness all the way through.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Applied to hwmon-next.

Note that the "drivers:" tag is unnecessary; I removed it when applying
the patch.

Guenter

> ---
>  drivers/hwmon/hwmon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 975c95169884..ea42c5ec40d9 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -267,7 +267,7 @@ static struct attribute *hwmon_genattr(struct device *dev,
>  	struct device_attribute *dattr;
>  	struct attribute *a;
>  	umode_t mode;
> -	char *name;
> +	const char *name;
>  	bool is_string = is_string_attr(type, attr);
>  
>  	/* The attribute is invisible if there is no template string */
> @@ -289,7 +289,7 @@ static struct attribute *hwmon_genattr(struct device *dev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	if (type == hwmon_chip) {
> -		name = (char *)template;
> +		name = template;
>  	} else {
>  		scnprintf(hattr->name, sizeof(hattr->name), template,
>  			  index + hwmon_attr_base(type));
