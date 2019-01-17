Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63D8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75822086D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 23:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFrX1p9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfAQXg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 18:36:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36143 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfAQXgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 18:36:55 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so5143400pgm.3;
        Thu, 17 Jan 2019 15:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mUOUrhc55hYKZLuJ30VUbIjoTyKBilkmeOoNQ0KpoIA=;
        b=oFrX1p9cYbZb3NNGnfhPTz6vzRW6HAGja1V+ISfB9ZhzJnkjxAR6vVVACWL7q7MdDI
         2Z+MPxMGgAXlqF2KQb1hbB5J4GP/6S/VwAyDlWG3TqQRHMrhH56WqLuZtZB0vFwc6eM2
         4Iee2xEl5Geq+LMWQqSw24yoXc089vBoOJ4WoBFO+SoRZikbtU1D2T8UgcSQctqDxw4h
         3TRK2DP08kPxjm59uaREy+28qEFLr9zRoPjVvAi5nDnGyiM4OUSWHOcAfKF21AlBo6NZ
         qITVp9UpIlg0a3SSa/ZB1mJFFg4x1Vlj1yCzANyToHhgHkIlXFlvscUshsbf87Rrnqqt
         cM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUOUrhc55hYKZLuJ30VUbIjoTyKBilkmeOoNQ0KpoIA=;
        b=t+1iN8noVHYIx0Fz8tJVDeAAUqExyF7KLq+JO25yPpsvSQD/9UpsnWXjbjo4H1lXzW
         ebqtcldIrKqoOHQb4oPMVgqJnBq7R/VkW+9u5nUI8LyMB15a9SzmsV1e6MMXyti4fSrM
         dgFh4iCIXlnkiwqh350PYMtMkknSUjAPnxKH6jUdE9EdeMDz/lDy2Fxu5XC+rFe+ecvT
         MAzBfMdwp0sFqiU7/iY1JRVW2k5lk6nx6PgKWfVcD2yChdt3w3BqyxIHVRybxOpyqcYu
         KozIL4Wad54glck9Qp8pdeLgy6cCeDYX8NiwpARL91VfrNFLZJen8q8IQKEoaTa6YqCc
         VkTg==
X-Gm-Message-State: AJcUukcDj/9BCYBFZnnJVn3UMMW3xY2qG4pm5aYaptzXNx72VImbKEOE
        4+L4PfQxwtRdwEr60uz13Pc=
X-Google-Smtp-Source: ALg8bN4UNGClMMrUXo0UgnHyDTYl+AzOh+BjrOUm2AA/WXlz4OwdHpuH+aShJBkkgK0nce/czKjW8Q==
X-Received: by 2002:a62:9fcf:: with SMTP id v76mr11383617pfk.144.1547768214134;
        Thu, 17 Jan 2019 15:36:54 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9sm8682114pfd.99.2019.01.17.15.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 15:36:53 -0800 (PST)
Date:   Thu, 17 Jan 2019 15:36:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] hwmon (ina3221) Add single-shot mode support
Message-ID: <20190117233651.GA24862@roeck-us.net>
References: <20190117231253.8828-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117231253.8828-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 03:12:51PM -0800, Nicolin Chen wrote:
> By default, ina3221, as a hardware monitor, continuously measures
> the inputs and generates corresponding data. However, for battery
> powered devices, this mode might be power consuming.
> 
> This series of patches add a feature of changing default operating
> mode to its single-shot mode via DT.
> 
> Changelog
> v2->v3:
>  * Added "Reviewed-by" from Rob to PATCH-1
>  * Cleaned-up PATCH-2
> v1->v2:
>  * Cleaned-up PATCH-2
> 
> Nicolin Chen (2):
>   dt-bindings: hwmon: ina3221: Add ti,single-shot property
>   hwmon: (ina3221) Implement ti,single-shot DT property
> 
>  .../devicetree/bindings/hwmon/ina3221.txt     | 10 ++++++++++
>  drivers/hwmon/ina3221.c                       | 19 +++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
Series applied to hwmon-next.

Thanks,
Guenter
