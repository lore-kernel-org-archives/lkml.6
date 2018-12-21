Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C7BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F40121906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389939AbeLUKnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:43:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45310 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbeLUKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:43:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so4723136wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PaY6D5AxZFKBHi9C+xt5zlOnJi7qkpMTz/zEAfzHGXA=;
        b=QiR+Wuiit0p0dgPOMNxO2mj7Ckxx7bLtJYQEj2+0XZChwl4og/j9dQaqOqKPINO9iD
         JQFh7xY/wd9RCwxsBi+x3WaTvzbpmwAAbwRUI4pD7CwgLZHRnpiKtl4YeT8e63Yqf3if
         bh5dSCBnjsZOf59QpW6xwraO525yDH7ihY5CckBwV3rCyNWIoS5ODMIkNXtcQz0NfsNn
         wtOvoDrAw9lhLNpGSxyy/aMNgI9lDxslsxna1TdS9GmAo2oWIU/39h7WjJ4BXCg8I3pN
         lQ3xOLMazs7XIGv/XDz5Vj/imgvTAtNJXMTUaNWBhfMV/6KFQFwCofzBPPmAA2y3Fkso
         8Wvg==
X-Gm-Message-State: AJcUukf95mUNuU8MqgwJ4VyeVO4zeTybAsDQJkbtU7M1x6QhJDl8OEij
        l7Iz8lEs/I/4FjOBwFjqSnoMz5eQASc=
X-Google-Smtp-Source: ALg8bN7hbughlPeqdI0AY47i8WQKwPU516z2cGN32EPiI/L/zImY8rHSoCJ71BoTDAW1kTH46xCAGw==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr2091384wrx.298.1545388995457;
        Fri, 21 Dec 2018 02:43:15 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id q3sm16144405wrn.84.2018.12.21.02.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 02:43:14 -0800 (PST)
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Wolfram Sang <wsa@the-dreams.de>, Lukas Wunner <lukas@wunner.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219223341.GA998@kunai>
 <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
 <2368540.q2jLLRDsj0@aspire.rjw.lan>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6fb7d574-9648-2960-5724-8b02a3348012@redhat.com>
Date:   Fri, 21 Dec 2018 11:43:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <2368540.q2jLLRDsj0@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-12-18 22:09, Rafael J. Wysocki wrote:
> On Thursday, December 20, 2018 11:00:29 AM CET Hans de Goede wrote:
>> Hi,
>>
>> On 19-12-18 23:33, Wolfram Sang wrote:
>>> Hi Lukas, Hans,
>>>
>>> On Wed, Dec 19, 2018 at 07:36:54PM +0100, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 19-12-18 18:22, Lukas Wunner wrote:
>>>>> On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
>>>>>> +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
>>>>>> +{
>>>>>> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>>>>>> +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
>>>>>> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>>>>>> +}
>>>>>
>>>>> This looks like a duplication of the is_suspended flag in struct dev_pm_info.
>>>>> Any reason why you can't use that?  If so, it would be good to document the
>>>>> reason in the commit message.
>>>>
>>>> Oh, that is a very good point and that one only gets set on system suspend
>>>> and not on resume suspend, working around the problems with the i2c-designware
>>>
>>> Just to make it clear: you mean runtime suspend, not resume suspend, or?
>>
>> Yes I mean runtime-suspend, sorry.
> 
> The power.is_suspended flag is about system-wide suspend, however.

Right, which is why it is good for us to use, when runtime-suspend the
i2c-adapter drivers transfer function will do a runtime_pm_get and all
is well, we want to check for someone trying to do i2c-transfers on
the adapter while it is system-suspended, since then the runtime_pm_get
is a no-op and things fail.

So for this use case it is a good thing that power.is_suspended flag is about
system-wide suspend (which is what I was trying to say in the first place).

Regards,

Hans

