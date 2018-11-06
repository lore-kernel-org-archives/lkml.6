Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0C2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40E52081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 09:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hdby4e6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40E52081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbeKFSaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:30:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45427 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730210AbeKFSaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:30:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id k15-v6so9560939wre.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 01:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Nuqea1ZVQ9Xu58OXI7ntI655PFs/NbWNhOdcc8XoK8=;
        b=Hdby4e6g6XXAueGv6fe49a+kjZEIc1K5q0kOlQbH9pgT4bERKlelpGd6gH10UYgoUC
         QunaoiRELHIunQFkRnqKfZxDoFOQmeX2qxeYnLF1LooVWo/lVXwUad0xEreDwgl+LJ9d
         /Q9x4zeOCaHvmC8uygpdP6YeZxxJE8yxBgZhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Nuqea1ZVQ9Xu58OXI7ntI655PFs/NbWNhOdcc8XoK8=;
        b=FChCYJfQQAaY6zlkJChuy2m0Dj4EG6j0ipeT5x+2EByDVpTB5kDJY2N+5atB18sWk0
         6vyCEuBskM2qVmMRPYXHurlnAD6rD2/CPPybibB7HuE8w7J+DeH59WX4JCHM4DrnGHgu
         SnEhFZdkvujQCMzNlJt5PjwLd6ULmhsuMcMSIaW+Fy5ppZjyHSqAERsQOT0VgbKVtalG
         rTDVn+6xEA0D1Lv+K5X7H2ctWQEXj/yxvnAm63+7mdBx6aNXPx5pfGhynxGCmPhN+EWK
         zwwJCGdb510h62TxTVXQMYS6YWsv3hX+vWHuKk+OzXzbfiZVWmFJHGz8GLOy9SvglBYL
         Aj6Q==
X-Gm-Message-State: AGRZ1gKb6R93FxRGA0JXDGdo5vJhPB8swhp42hgEvqqayVMRMjbaHZRz
        bCP0sJZ08s+YSk8/H/njV61mDQ==
X-Google-Smtp-Source: AJdET5f1lZLRf1VQtE9SwiJPzK3dt5GMWT41NEcWldj51wKQtDk+aD/Bb2Z5v+pKzqiKfed7cNzDhA==
X-Received: by 2002:a5d:4450:: with SMTP id x16-v6mr22612367wrr.308.1541495165361;
        Tue, 06 Nov 2018 01:06:05 -0800 (PST)
Received: from [192.168.0.40] (119.151.136.77.rev.sfr.net. [77.136.151.119])
        by smtp.googlemail.com with ESMTPSA id v1-v6sm62574922wrd.24.2018.11.06.01.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 01:06:04 -0800 (PST)
Subject: Re: [PATCH V2 2/2] clocksource: imx-gpt: add necessary kfree to avoid
 resource leak
To:     Anson Huang <anson.huang@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1541379930-14538-1-git-send-email-Anson.Huang@nxp.com>
 <1541379930-14538-2-git-send-email-Anson.Huang@nxp.com>
 <dea51d27-0957-f762-773f-e0e0e001045c@linaro.org>
 <DB3PR0402MB39161E47E47937FDB8046B6EF5CB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d811ef14-ec53-3422-b747-7df0c1ce360d@linaro.org>
Date:   Tue, 6 Nov 2018 10:06:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB39161E47E47937FDB8046B6EF5CB0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Anson,

On 06/11/2018 02:38, Anson Huang wrote:
> Hi, Daniel
> 
> Best Regards!
> Anson Huang
> 
>> -----Original Message-----
>> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
>> Sent: 2018年11月5日 21:35
>> To: Anson Huang <anson.huang@nxp.com>; tglx@linutronix.de;
>> linux-kernel@vger.kernel.org
>> Cc: dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH V2 2/2] clocksource: imx-gpt: add necessary kfree to avoid
>> resource leak
>>
>> Hi Anson,
>>
>> On 05/11/2018 02:10, Anson Huang wrote:
>>> kfree should be called to free resource in error path before return.
>>>
>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>> ---
>>>  drivers/clocksource/timer-imx-gpt.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/timer-imx-gpt.c
>>> b/drivers/clocksource/timer-imx-gpt.c
>>> index a3d6ccb..0f78b30 100644
>>> --- a/drivers/clocksource/timer-imx-gpt.c
>>> +++ b/drivers/clocksource/timer-imx-gpt.c
>>> @@ -477,12 +477,16 @@ static int __init mxc_timer_init_dt(struct
>> device_node *np,  enum imx_gpt_type t
>>>  		return -ENOMEM;
>>>
>>>  	imxtm->base = of_iomap(np, 0);
>>> -	if (!imxtm->base)
>>> +	if (!imxtm->base) {
>>> +		kfree(imxtm);
>>>  		return -ENXIO;
>>> +	}
>>>
>>>  	imxtm->irq = irq_of_parse_and_map(np, 0);
>>> -	if (imxtm->irq <= 0)
>>> +	if (imxtm->irq <= 0) {
>>> +		kfree(imxtm);
>>>  		return -EINVAL;
>>> +	}
>>>
>>>  	imxtm->clk_ipg = of_clk_get_by_name(np, "ipg");
>>
>> Please convert to timer-of API.
> 
> This patch mainly to fix the potential resource leak issue, for converting
> to timer-of API, should I add another patch for it? Since it is a different
> subject.

Actually I was unclear. The patch is duplicating the kfree in the error
path, usually a rollback routine should be provided.

So instead of creating this rollback path, you can directly use the
timer-of which contains the error check and rollback.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

