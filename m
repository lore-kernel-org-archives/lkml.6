Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B877BC18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E95206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWPaFLDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E95206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbeKUBE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:04:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41341 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeKUBEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:04:25 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so1083080pfi.8;
        Tue, 20 Nov 2018 06:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9RL4t5TyE+hL/OxCs1olaiD9t2q/9+1+CLGPVCwlmTU=;
        b=VWPaFLDj9cRNe2Cedy8AJtGBypZbIlO201Cnq0T7v82nhIDA5TNn5nrXwxnysTfSQx
         UXNppnt/t4I+u49QV5OIIqacE0EvGosL+H2IeXXXfn3e7eOhBlMRflNY28vOIRAYV7tk
         z0FMMuh4nN8TWJUegKqI8ljaCnr524XaJd3DrhCZWkegAmlw4Yd3g815+hkkL60z37jp
         NY+z8xvs2VXjLPLlfllJyn3lgGR7w/H5MZ3dHcURK8SyjxV4DUxeMwDBPX+D19Ay/JoV
         FnbQ4G0qTxk+BE+qkFAJnMDT2B/CQ38mEueE0PMBrUsjiZEN6iORvZ02QlkjkH+bUmAk
         iXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9RL4t5TyE+hL/OxCs1olaiD9t2q/9+1+CLGPVCwlmTU=;
        b=Ag9j9qRe5ajLz3oZBAzXFBQWCe6YVVr9V/o0MP8SjhJZZ+qlm9RHNQmMtyIX5iIAQS
         dOAB8RlIJWMSmsI6czdkKZJfB2YlPhr5ABg1dhEFT7k/8Yt2hzxfyhBi8Iaj/3ETrWBJ
         VheAu8oy853H+ygtbnnqXbsDbad7q7i0jbP1yMqgMw71ROvkwyui1PFFSfqr7VSGll10
         Bkz182H23oe9HUqS81bUtE3gFU9U0qePAxo/U2Rt0sTsfCCGjqm9RAcLkSrgtPwhvPJh
         7v/2pkcon+raiP2B/lBAbjDb262sGyLQCp5HiMxinVtUllaN0m+51djD/SUtJGEaR27w
         T0dg==
X-Gm-Message-State: AGRZ1gJ06QWrSz88/R7Mw63F6R/c6dOQn1Amu/BBuHJKWDj9O8xiPG1h
        MbTsWKxzoPp/1GdYv/aULGsuC7q/
X-Google-Smtp-Source: AJdET5e0srY9kp4/Dq/ey5Nvxul/jsmTiT4ZqIHlSHvBnmqXMtlMn8Y1Ao66J//uL44/iZNFxZv2Iw==
X-Received: by 2002:a62:81c1:: with SMTP id t184mr2434251pfd.246.1542724498672;
        Tue, 20 Nov 2018 06:34:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f193-v6sm62514131pfc.74.2018.11.20.06.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 06:34:57 -0800 (PST)
Subject: Re: [PATCH] watchdog: cpwd: add of_node_put()
To:     Yangtao Li <tiny.windzz@gmail.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181120132359.19799-1-tiny.windzz@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8abef7ab-1d77-cf88-748c-11e54c760f34@roeck-us.net>
Date:   Tue, 20 Nov 2018 06:34:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181120132359.19799-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/18 5:23 AM, Yangtao Li wrote:
> use of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>   drivers/watchdog/cpwd.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
> index aee0b25cf10d..d3a81642ada5 100644
> --- a/drivers/watchdog/cpwd.c
> +++ b/drivers/watchdog/cpwd.c
> @@ -617,6 +617,7 @@ static int cpwd_probe(struct platform_device *op)
>   
>   	platform_set_drvdata(op, p);
>   	cpwd_device = p;
> +	of_node_put(options);

It would be better to do that right after its last use to also cover
error handling.

Guenter

>   	return 0;
>   
>   out_unregister:
> 

