Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AFDC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411D020866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 02:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qg2D3UYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbfAPCwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 21:52:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38529 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729698AbfAPCwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 21:52:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id q1so2290822pfi.5;
        Tue, 15 Jan 2019 18:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rvskhnH1HdI6/Ux5FN/lBQ4hWy2vZlVwBSH6mr0AhDo=;
        b=qg2D3UYuS74kiL54zu9ReII1VYiNBYfpVSJrFxIOPd7r1LoZkrMNV7Zt7j6nUfkI3M
         YxfhYMZDfb/bCmIvBREkxH0N1BSv8sIGMkPp94rXyFpK9LSwSSHPr8w3tok+ElK39h+2
         YtMQCRRQmBfU/QgeT/zQxM1zgupPetVV85xAlmO0ASkY73X3jnRFwXuV/2RvpvY7tMNK
         6SgiedeJYhojFachAEt7s73IofJPspnzuhoIrgY21hCSzFkuTzpiBi7ypIlW2TjfhWY6
         r+MLkEJ4jqMNVoyHiyCba6oNOmdMLhRA5AUoRsSxUYHU7acEQkmyrG0H+/fXy5cQ8LzC
         IVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rvskhnH1HdI6/Ux5FN/lBQ4hWy2vZlVwBSH6mr0AhDo=;
        b=rvGdDNSd34JTZsFgpZx2Ib0ylL5hwNBKJ5IlQCmRgHOeWsSmXytsGrB5vkMeqHfAPg
         Z/L9vZM4MUdyKg+Dmr/7O2nlMsRlX4gzkBHURAZg2g7TtyEL0tkeSEbTZmCUBzFD4k+u
         KwMxjOvYx3LXsR5d5iRq6t7aB182BxI/Nm35NXGPKtMlzhOwx9yWhCud8Fw2O9Gyuspi
         IdOIBfp653EdAhPcDp2IXWK4YqBbaNJDIwhN+QgYMI+IY61aGqLZuTn+vt6DrCtl9LnQ
         JoWTzHMvhplbKOLmAJTTa9BdBHHZs3fNRnzTZArJlqxyci/uF+vm+HPP9GIkHDlLgT66
         0SjQ==
X-Gm-Message-State: AJcUukdIV9VU66yIPOGcUV1BfdYmAAwPGVhCpRXr9TSDUtpMzS0woaB/
        wopxD+jZgu913odYeDDm414=
X-Google-Smtp-Source: ALg8bN71j3U/SvbXlBfSqmkXvSnLsv/cV1XuF0RkmgqgS1sLf0f0zOpXADvooqDM6wz3vRDZlEZz5Q==
X-Received: by 2002:a62:b24a:: with SMTP id x71mr7511937pfe.148.1547607124787;
        Tue, 15 Jan 2019 18:52:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 134sm4916267pgb.78.2019.01.15.18.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 18:52:03 -0800 (PST)
Subject: Re: [RFC PATCH 1/4] watchdog: hpwdt: Don't disable watchdog on NMI
To:     Jerry.Hoemann@hpe.com, Ivan Mironov <mironov.ivan@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
 <20190114023617.10656-2-mironov.ivan@gmail.com>
 <20190116022731.GD18342@anatevka>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <24e18efa-441b-8e62-7cb8-363afacfe05d@roeck-us.net>
Date:   Tue, 15 Jan 2019 18:52:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190116022731.GD18342@anatevka>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 6:27 PM, Jerry Hoemann wrote:
> On Mon, Jan 14, 2019 at 07:36:14AM +0500, Ivan Mironov wrote:
>> Existing code disables watchdog on NMI right before completely hanging
>> the system.
>>
>> There are two problems here:
>>
>>   * First, watchdog is expected to reset the system in a case of such
>>     failure, no matter what.
> 
> Documentation/watchdog/watchdog-api.txt
> 
> explicitly allows for pretimeout NMI and generation of kernel crash dumps.
> 
> By removing hpwdt_stop the system will likely fail to crash dump
> as there is only 9 seconds between receipt of a NMI and the iLO
> resetting the system.
> 
> Unfortunately, kdump is not without issues and can also be difficult
> to properly configure either of which can result in failure to dump
> and reset.
> 
> Customers who value availability over kdump collection, the pretimeout
> NMI can be disabled and hardware will not issue the pretimeout NMI
> and will only do reset.
> 
> A middle ground for those who want tombstones but not kdump, would
> be to leave the pretimeout NMI enabled and add "panic=N" to the
> Linux command line.  That way after the panic, the tombstone is
> printed and the system resets after N seconds.
> 
> 
> 
>>   * Second, this code has no effect if there are more than one watchdog.
> 
> That is correct.  Hpwdt will not turn off any other WDT.
> 
> I don't see a current method of notifying other watchdogs
> that a given watchdog is going to take the system down.
> 
And there should not be.

> The closest I hook see is watchdog_notify_pretimeout, but I don't
> see that notifying other WDT.  Its not clear to me that it should.
> (e.g. the second WDT could be of longer duration and protect against
> kdump hanging. This would need to be thought through.)
> 

Watchdogs are independent of each other. If there is more than one,
they need to be configured carefully (just like pretimeout vs. timeout).
It is not up to the kernel to let watchdogs interfere with each other.

Guenter

> 
> 
>>
>> Signed-off-by: Ivan Mironov <mironov.ivan@gmail.com>
>> ---
>>   drivers/watchdog/hpwdt.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
>> index ef30c7e9728d..2467e6bc25c2 100644
>> --- a/drivers/watchdog/hpwdt.c
>> +++ b/drivers/watchdog/hpwdt.c
>> @@ -170,8 +170,6 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>>   	if (ilo5 && !pretimeout && !mynmi)
>>   		return NMI_DONE;
>>   
>> -	hpwdt_stop();
>> -
>>   	hex_byte_pack(panic_msg, mynmi);
>>   	nmi_panic(regs, panic_msg);
>>   
>> -- 
>> 2.20.1
> 

