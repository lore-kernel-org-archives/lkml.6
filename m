Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57756C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F1F20831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkEoA5th"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F1F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbeLIOOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 09:14:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39947 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbeLIOOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 09:14:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so3973854plq.7;
        Sun, 09 Dec 2018 06:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6MaKgahVa6qEuLgFsB+JPNTIpF5/GVHshk4v8l6kes0=;
        b=kkEoA5thCOwzbEv7EouDynEKUje6KDOitY2f0ESHp5746XWddgC2/iWYp+32UQGO0l
         dZQZdMuVjDeIptcoX7ofI5NqCs0ipIqfJ/lrEVRYxV5gs/eWICJVhIMIiENj/6pXZ8oU
         0jwBAZReKBllotRPdn1RF9P0cyGU6yw+Pmv6mBFbnjWiDaHbdMMr2h4GjCFxQTZNi1CY
         Df/iDEevcKWeEEADy5Hfn8F6Zil0t4G7FwWDcScDc3egr0EpTKZ/FeeQSWIHhYgCsnrI
         qQJSMY2UlxNqjzsduP8yFSJh/lNqhdCON+sSST+PZnRCMlslnYYKrzZ8tHCEnRBvsSEq
         9Knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6MaKgahVa6qEuLgFsB+JPNTIpF5/GVHshk4v8l6kes0=;
        b=rozlfMQWegWc2Ngp0yo13HkCwCdTjUNRxRrgBIS0Ac87hu0UKcrbEQUaffW2H1Lw0a
         5K15L5CX+ekOkLIIQAK00KIxjsaRD+P6mLuz7O2rY8exsp6zTTfEidwkG3nLsEE6g4v5
         tuSSkaDHaFeMxxQxYoA4A+X0sZiJSHZlxliKGYCUwa8W29vYRw9CApzv8VuSMFm0SvLk
         Wj8ai/vO5Y5MX6tc1/EAdQr9OvnDe5vryLwIZ0/4G+Ne/9bn2jkW44ty3v5u+z5r+1cC
         LX9YISv+5rgsi4Um4OdUxXZRJgy89InCgA32UzCpR2yB8Sk1w3xwYnRPWixkhk7GuDLu
         5CRA==
X-Gm-Message-State: AA+aEWbX6k1OwYAEMcHcLzzwiqbpxz9sQAiocqwub/4qwN3IT0ENtz6V
        VOcfPyq3JKLc4d1f/8XAVtdmaEVY
X-Google-Smtp-Source: AFSGD/X0Y4p5wHzOijyD76a/dERW9SoP/F9HWrs7A9PG3g4jRC5wh/xO0Q1gcwENj1ZmXpoJnQJs1g==
X-Received: by 2002:a17:902:7443:: with SMTP id e3mr8777673plt.304.1544364841944;
        Sun, 09 Dec 2018 06:14:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k63sm13565073pfc.76.2018.12.09.06.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 06:14:01 -0800 (PST)
Subject: Re: [PATCH] Watchdog: remove outdated comment
To:     Hardik Singh Rathore <hardiksingh.k@gmail.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181209104726.15610-1-hardiksingh.k@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <18f7e9ee-0d8f-7c73-cdc0-7826e912d33a@roeck-us.net>
Date:   Sun, 9 Dec 2018 06:13:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181209104726.15610-1-hardiksingh.k@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/18 2:47 AM, Hardik Singh Rathore wrote:
> The lock field doesn't exist in watchdog_device structure.
> It was added by commit f4e9c82f64b5 ("watchdog: Add Locking support")
> and removed by commit b4ffb1909843
> ("watchdog: Separate and maintain variables based on variable lifetime")
> 
> Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   include/linux/watchdog.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 44985c4a1e86..417d9f37077a 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -90,9 +90,6 @@ struct watchdog_ops {
>    *
>    * The driver-data field may not be accessed directly. It must be accessed
>    * via the watchdog_set_drvdata and watchdog_get_drvdata helpers.
> - *
> - * The lock field is for watchdog core internal use only and should not be
> - * touched.
>    */
>   struct watchdog_device {
>   	int id;
> 

