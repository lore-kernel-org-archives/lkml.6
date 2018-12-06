Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19FEC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F37021508
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3jJcPaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F37021508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbeLFGD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:03:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41263 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbeLFGD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:03:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so11258275plm.8;
        Wed, 05 Dec 2018 22:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=57oTXQ4VQufT9x0PRKi54O7D07V2teSLrtvD9DeC/4M=;
        b=H3jJcPaKlALulQiGKdvaS75THuYCnHOCZbF25Srd2fr5UHghecLBgX2WjcgMBNdK2J
         Ohw0tqB7sQnadWECzjaPxl7GHLNlAncLq3+oN06MEsuuF1F6515Yte1BbjrwphNE9isT
         WcnMoY/e2nb8CaZtaU0qEY1GUSYNthbQFS6hJgJ9NTYa9iBjpgPMtbKdddR2aAvFSrRR
         pMbP6zUxWgdb6dqikl55+FXIHJ0BtDsdc87dY7eI0J+WmapfEeDJBRd9msxW7cWHP5ql
         3DlKwj3YBqZvOtIrUNKQDnSup59l1xvn50bguV0jgxVV50hh7OIy69X2N9Z2FGG6vHn4
         qdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=57oTXQ4VQufT9x0PRKi54O7D07V2teSLrtvD9DeC/4M=;
        b=cRq6TOz63PA2lcC3BeS0O7FES/EB/sS3Dgkv110tnloeYJgWb/piz/+YoUUTvZ0+VT
         o6HKDUAzBagZtlBttx1wdHekjPpUdBmneQxubvic+JEsb0ePSoWsxwRGSTK1jcRjlsd1
         3d9VSmUCupvzB9ef4FmogfGZqRnfSB3igHc5eovk8Q942YRlhl0Q95pYEPZly5XICvap
         6xOWSEioZ7OE1GiQ63V+37v9qgkAc9Y3ARoqO4RX976POFp/DLR1896T6gsxF1Oco1rp
         nAsjAk/EhN8Ut//kaqQXpxAhbMkQ3/phxskobqbIOzuX68WkXyU8jHZQI5UMSGACR8vr
         6HKA==
X-Gm-Message-State: AA+aEWYfKygGTFdrEa5ekGOVKGCHUDLlT/NsinkaDHKgwL7B8igQqEjx
        n1FdsRswqJWrPMkWmjXuRNMgoKv3kPs=
X-Google-Smtp-Source: AFSGD/WdsKBeyU0gRCAsXEV0FF5HjseF6AA/PE2J7bHomaPhVI6YWsNyLwO3HWR9Mm+AEkrD+Mi9Ew==
X-Received: by 2002:a17:902:7c82:: with SMTP id y2mr26660287pll.33.1544076206261;
        Wed, 05 Dec 2018 22:03:26 -0800 (PST)
Received: from [0.0.0.0] (97.64.17.87.16clouds.com. [97.64.17.87])
        by smtp.gmail.com with ESMTPSA id h19sm27557451pfn.114.2018.12.05.22.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 22:03:25 -0800 (PST)
Subject: Re: usb: thoughts of adding more support for FT232H
To:     Anatolij Gustschin <agust@denx.de>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <48bc71bb-68e4-8b29-f609-940c9aedc0a9@gmail.com>
 <20181205161718.7451d98f@crub>
From:   Song Qiang <songqiang1304521@gmail.com>
Message-ID: <924d4ebb-5f9c-f863-c698-9f978e9bc337@gmail.com>
Date:   Thu, 6 Dec 2018 14:02:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205161718.7451d98f@crub>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/5/18 11:17 PM, Anatolij Gustschin wrote:
> Hi,
>
> On Wed, 5 Dec 2018 22:10:40 +0800
> Song Qiang songqiang1304521@gmail.com wrote:
> ...
>> I've been developing some iio device drivers and found that some people
>> would like to test their devices with a qemu system which requires an
>> i2c or spi port on our development hosts. Usually this is achieved with
>> a DLN-2 adapter, while this is a bit difficult for me because it costs
>> ~175$ in my country. Then I found that FTDI's FT232H supports both these
>> two modes and costs only less than 5$ but without full support in kernel.
>> The ftdi-sio driver supports FT232H only as a serial converter.
>> So I'm planning to write a mfd driver for it supports both these three
>> modes, here are my thoughts:
> There already has been a discussion [1] about adding an MFD driver for
> FT232H, since the operating modes are mutually exclusive (and bus pins
> shared between different modes), the MFD approach doesn't seem to be
> a good fit.
>
>>   - This device cannot support these three modes together because they
>>     share some common pins, so I'm planning to add a sysfs entry
>>     'current_mode' for selecting which mode the device should be working
>>     on.
>>   - This device is in uart mode on reset, so default mode would be reset,
>>     too. This also helps for people only want to use this as a serial
>>     converter feels nothing has happened (compatible).
>>   - I was trying to reuse the ftdi-sio driver but it seems like mfd can
>>     only register platform devices, while this is a usb driver. I may
>>     have to copy some functions from this driver.
>>
>> Would you share any ideas? I'd appreciate it.
> There is a patch series [2] adding an interface driver for FT232H-
> based adapter devices, it already supports adding custom MPSSE based
> SPI busses with SPI slaves for a custom USB PID. It already supports
> adding custom CBUS-/MPSSE-GPIO adapters for user-defined USB PID.
> Adding I2C driver/adapter support should be easy, too. Maybe you can
> re-use it.
>
> Thanks,
> Anatolij
>
> [1] https://patchwork.kernel.org/patch/9828985
> [2] https://patchwork.kernel.org/project/linux-usb/list/?series=48255

Hi Anatolij, Johan,


Great work you've done! While there still some thing confusing me.

Patch series [2] added new custom PIDs to distinguish the mode this device 
should be in when powered on, is this right? Since USB has a convention for all 
the VIDs and PIDs, is this really a good approach to use some us-defined PIDs?

In the discussion [1] #4, Johan said that mfd is not suitable for this situation 
because 'all drivers for these devices be able to retrieve the current mode 
during probe and only bind when the mode matches'.

I think this is saying that we can only register these devices(i2c, spi, gpio) 
when we plug it in, but FT232H's functions are surely mutually exclusive, so 
can't we dynamically register these devices in userspace? I mean through a sysfs 
interface, and through the implementation functions of this interface, we can 
try to use mfd_add_devices() and mfd_remove_devices() to unload one 
function(like uart) and load it as another device like a spi adapter. Is there 
any side effects of doing this in this way?

And also my English may be not very well so please correct me if I'm 
understanding anything wrong. :)


yours,

Song

