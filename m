Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A48FC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 17:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82192085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 17:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbyzOekW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82192085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeJ1C03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 22:26:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38255 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728610AbeJ1C03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 22:26:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so1967237pgq.5;
        Sat, 27 Oct 2018 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5qHTLlwdAtHWG1LAdTKZGy8l7TuUw33q2Srd4xfK3aE=;
        b=LbyzOekWtnmtUVurIKryRLj9DK5MZIl1Ua85qrvrBeRpJyBpmTeDQrKqU5fcqFxvSR
         gyBP1lMHhHdmq+ME85UysSw7heJEgTiAiTWLhXZBLxuzLgBVCAlAc4YoxV75Gp7g7/zi
         6Pwgr+xDLiSCm/sbtmJ/LheH2zh6YxOhQIo1oR6FAbuRAMAGJyDula0oN72xIswOlPGo
         a2G/FAzaPUUC8zknyJGUw4w2cdxtmqfCxCxx+jdY5fHJDY1WGXQ4b0+AOt0TS9nNastD
         yLBkWio18JezcD9L8yi0ikJ5yLohZmC01fC+RqPQoDkdMMdymiMVrSXUDWRs/0/MHv7m
         dXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5qHTLlwdAtHWG1LAdTKZGy8l7TuUw33q2Srd4xfK3aE=;
        b=FNTeUqN/4nXpEEL1cuYOlVXZELn9dsAjJsWqqyyGX7c50kWFbXzJ/3Mcj+hi+BwjFv
         TESiDYuDBCa9imnlOlxFYIMUrs51tfTWJGUBU9Oiyt6DZQFg997zDw8FghCKmsTAWoBs
         AUYp1bAGZQPZSu8hDqCriNPukXXL9Q3oPDgH2A/8L8gH9S2iPWbWfHodiAhMB5zZUd6E
         tlQ6NqsoRydFgO9Zfc/a4I8zUS7ytZmufkp+xML/eaSqdwT6W+1dWZ/mmWl/mTS9pBd5
         50LumXsM8+eWYMXbzAGkQ16CkhUqqQxH2GwYLDpPKLJo1mR/cs1fIjo4643ILC75Nq51
         ACXA==
X-Gm-Message-State: AGRZ1gJ7ispEEv/RDenMOPU+Qry6US3TynUBwXEY/vQGd8gp6qBNteRh
        sOFZZYJHH+iHLZ8yj0jIByyHvRwP
X-Google-Smtp-Source: AJdET5f08XANU2S0a9Ik+MFdkL3JmcGiO4Vsmej0mw8Kad2++VGYuPXlBh1Ig/F9UHRfaVdgEOqblQ==
X-Received: by 2002:a62:5287:: with SMTP id g129-v6mr1980534pfb.17.1540662285470;
        Sat, 27 Oct 2018 10:44:45 -0700 (PDT)
Received: from localhost (99-61-165-247.lightspeed.sntcca.sbcglobal.net. [99.61.165.247])
        by smtp.gmail.com with ESMTPSA id w10-v6sm17889534pfg.1.2018.10.27.10.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 10:44:44 -0700 (PDT)
Date:   Sat, 27 Oct 2018 10:44:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] drivers: hwmon: add runtime format string
 checking
Message-ID: <20181027174443.GA31315@roeck-us.net>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-8-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181026232409.16100-8-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 27, 2018 at 01:24:09AM +0200, Rasmus Villemoes wrote:
> With -Wformat-nonliteral, gcc complains
> 
> drivers/hwmon/hwmon.c: In function ‘hwmon_genattr’:
> drivers/hwmon/hwmon.c:282:6: warning: format not a string literal, argument types not checked [-Wformat-nonliteral]
>       index + hwmon_attr_base(type));
> 
> Add a runtime check to ensure that the template indeed has a single %d
> printf specifier. Using fmtcheck() also makes gcc verify that the
> expression 'index + hwmon_attr_base(type)' is suitable for %d.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

I'll defer to others on this one; let me know if the series is otherwise
accepted. Personally I think that the compiler is at fault here
for not detecting that the format string can not be wrong (since it
is declared and used only in this file), and I find the fmtcheck()
confusing/obfuscating.

Guenter

> ---
>  drivers/hwmon/hwmon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index 33d51281272b..ec6f5f36b5fc 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -278,7 +278,8 @@ static struct attribute *hwmon_genattr(struct device *dev,
>  	if (type == hwmon_chip) {
>  		name = (char *)template;
>  	} else {
> -		scnprintf(hattr->name, sizeof(hattr->name), template,
> +		scnprintf(hattr->name, sizeof(hattr->name),
> +			  fmtcheck(template, "type%dwhat", 0),
>  			  index + hwmon_attr_base(type));
>  		name = hattr->name;
>  	}
