Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66CCC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33FC217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enOPhhM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfAYJBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:01:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39137 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYJBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:01:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so4459646pfc.6;
        Fri, 25 Jan 2019 01:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lof1WbwTjGl75f5jNQ9eVMxww+CPak/791xsS0EsAC4=;
        b=enOPhhM05VgvWKUUi4rvUOTKX2cKuLR/DU0oGjWNeDQGGOuYwAgm8QNAA80FFI/IBH
         FqBHTkgWihM+kNqorMexR25h86ZnhAA1Buk1J5bRVSG3J0Y9oFmJkoarkZXmCFwe+5rR
         r1p7uAW1dMW9biSUdYMB2d+UZ5ne7/6o3bOFuQEiIE/q5YawGY9Pk7r2sYfyhcgZILzK
         UYx7OUZDNYpy6g8T/wP4SGKoecaBOk55gTfL/2NEA6jfJ38xiivA0M/qy/vPXSEye46V
         2AS3KFi2pE8iZmNNFr8eO7e094a/SFW3wX+wog3hut3jyRL5EKEIuocH6hrlhty4m2ND
         PQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lof1WbwTjGl75f5jNQ9eVMxww+CPak/791xsS0EsAC4=;
        b=blvrJyzlstOZjxGLFRitQi3LYY8m0btu12U1c+7O+9Xbn8/T2CHtCndp50VpFUw4cn
         9/qUbMDHkw0hAiodkJbhUqkHk3jPEznh2mE/IM3zJQLVom40EpRqv5OeLEoX5fgoUOXe
         3FhA0XaSprJTqrT5d27L7Mfn/UGBgyKgN5Q0eV8jnB11MVDjg0EWZG0LPN0tK0eBaMCj
         7EWMu1s1g04NeZKj9k/TPRD2Zhx7e07eftsZZjlrcigLazuhT3iU0kZnhVijfRdANntx
         XpPRF2l0sSBzJErj0lPBVozuyhv+BtRxwwrZlHQ6AkOT94W/l3T2f+IDiDbB59C028Rz
         ko0g==
X-Gm-Message-State: AJcUukfqh/xQV6R99aJzBMXybgh9TYtQp38XllFP9th99kH7JOASojnE
        My5nEPKQlymEbSZms+F2rORHIS2Y
X-Google-Smtp-Source: ALg8bN512fj1L7kbTn/XBsnCfaEAMVgM/ALF6sx3Cyya0LFfsxE89wD/+NuGcqyJta99NHbTvne2AQ==
X-Received: by 2002:a62:1d8f:: with SMTP id d137mr10011181pfd.11.1548406894406;
        Fri, 25 Jan 2019 01:01:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t3sm24667462pgv.31.2019.01.25.01.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 01:01:33 -0800 (PST)
Subject: Re: [PATCH] watchdog: dw: use devm_watchdog_register_device()
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190125154604.66801c6a@xhacker.debian>
 <b521625b-ffff-ba49-77d7-018ad363db36@roeck-us.net>
 <20190125161049.7884cda4@xhacker.debian>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4414c144-ebdd-2c16-7268-1e11d5a682cd@roeck-us.net>
Date:   Fri, 25 Jan 2019 01:01:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125161049.7884cda4@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/19 12:17 AM, Jisheng Zhang wrote:
> Hi,
> 
> On Fri, 25 Jan 2019 00:04:25 -0800 Guenter Roeck wrote:
> 
>> Hi,
>>
>> On 1/24/19 11:52 PM, Jisheng Zhang wrote:
>>> Use devm_watchdog_register_device() to simplify the code.
>>>
>>> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>>> ---
>>>    drivers/watchdog/dw_wdt.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
>>> index 501aebb5b81f..c053c2de5c2f 100644
>>> --- a/drivers/watchdog/dw_wdt.c
>>> +++ b/drivers/watchdog/dw_wdt.c
>>> @@ -303,7 +303,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
>>>    
>>>    	watchdog_set_restart_priority(wdd, 128);
>>>    
>>> -	ret = watchdog_register_device(wdd);
>>> +	ret = devm_watchdog_register_device(wdd);
>>>    	if (ret)
>>>    		goto out_disable_clk;
>>>    
>>> @@ -318,7 +318,6 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
>>>    {
>>>    	struct dw_wdt *dw_wdt = platform_get_drvdata(pdev);
>>>    
>>> -	watchdog_unregister_device(&dw_wdt->wdd);
>>>    	reset_control_assert(dw_wdt->rst);
>>>    	clk_disable_unprepare(dw_wdt->clk);
>>>    
>>>    
>> Unfortunately it isn't that easy. The other two calls have to be executed after
>> unregistering the watchdog, meaning you would have to add devm_add_action()
>> in the probe function to call them.
> 
> do you mean reset_control_asser() and the clk_disable_unprepare()? If yes,

Yes.

> does unregister the watchdog could trigger any register access? Per my
> understanding, there's no register access path in the unregister. Am I
> missing somthing?
> 

If the watchdog is unregistered last, it would be still accessible via its device
nodes, even though the clock has been reset, and even though the HW has been
put in reset. This would be racy.

Guenter
