Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA61C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A1E2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu2HxyDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfBTPg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:36:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37507 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfBTPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:36:26 -0500
Received: by mail-pg1-f195.google.com with SMTP id q206so12052675pgq.4;
        Wed, 20 Feb 2019 07:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4XRMCSi0LdzN7adsNjimSKKZZBAP1rV9ioFDU46+zRA=;
        b=Iu2HxyDbS+NZCUPuNRzhT5m7pBT2y9XBoytp47BCOZRNmY9gOTjsqwzH3aXCqDIiKp
         VN67ziAfi5BIyQjyDzUrYe0bi0bm86Dffdg+N2k1Kzm4hcrzw8QANdMydNnlN9zRF7Y9
         VCIdyemIdbfGAo3ZJGd2R6RtOqhl/WPDrytg2NSTkktNEKh1f69Yo5DD0bijbP2fgmDQ
         B23BSsHuoeiJ5t7iz65ESpVmscUAXTcsT417LX7qtQPZP11EUF/thcul8U21Y/GhYpyz
         Nn36i9sHITdKMzcGqy+6o6HaU69nx1mRTodLD0Or9K+gVcpOsGJqdpn7v5jnd/qrCR6u
         /chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4XRMCSi0LdzN7adsNjimSKKZZBAP1rV9ioFDU46+zRA=;
        b=AYPF9iXE7WD+6gUMDtfqiP6IhYXNtjl7un4FnP3DCiX4Z9oZIRbc/Nfu2pALFgthD7
         eVxbZOzTesHo6bXU/URSizMJBDvw0/KheH/LdL5LCYDfinhuOjgQCx9WVa2QqwP89Ci0
         MqDBDpS+J116OESdobx/TAPkA0ibQBVqteeR2qFpSlshq0ZhYslILcPSOP4IVnQyKDuZ
         Jjaa9Dr/4LPO7oPe/z4mLOH3dVbqDZiZz/MN4kJyC4NalSwKwAPq1RZuQ3ARyKqaPCuF
         XvR8rUGJXlAZWrqt5UZsvzhqB6LfviB5Em5+JttyqGZDPTYnTZ4RZiOI9hiuGEbtMxyS
         tLLw==
X-Gm-Message-State: AHQUAubh5nqIJlWTU2/jTN3HQcRuN0QTo755P+SYPYF0jOCeblLvg10a
        91BB+JyVpqc8ddw4UMWeSawiA0/0
X-Google-Smtp-Source: AHgI3IaCMMH7/TTEQyp3jtXtrp5pJqmkiaD8dzTAL8C58FlVPzsYrDLrzBcrij9QkXhLQWklLy4AlA==
X-Received: by 2002:a63:c503:: with SMTP id f3mr29177919pgd.431.1550676985646;
        Wed, 20 Feb 2019 07:36:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l12sm21625830pgp.54.2019.02.20.07.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 07:36:25 -0800 (PST)
Subject: Re: [PATCHv3] usb: typec: tps6598x: handle block writes separately
 with plain-I2C adapters
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nikolaus Voss <nv@vosn.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
References: <20190220110017.BFA344CE86@mail.steuer-voss.de>
 <20190220151138.12332-1-nv@vosn.de>
 <8dc1a931-c9f7-a46a-42dc-fdcd2274343b@roeck-us.net>
Message-ID: <d4d0f4c7-bcea-2d4e-51d9-97be6f9a48bc@roeck-us.net>
Date:   Wed, 20 Feb 2019 07:36:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8dc1a931-c9f7-a46a-42dc-fdcd2274343b@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 7:35 AM, Guenter Roeck wrote:
> On 2/20/19 7:11 AM, Nikolaus Voss wrote:
>> From: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>>
>> Commit 1a2f474d328f handles block _reads_ separately with plain-I2C
>> adapters, but the problem described with regmap-i2c not handling
>> SMBus block transfers (i.e. read and writes) correctly also exists
>> with writes.
>>
>> As workaround, this patch adds a block write function the same way
>> 1a2f474d328f adds a block read function.
>>
>> Fixes: 1a2f474d328f ("usb: typec: tps6598x: handle block reads separately with plain-I2C adapters")
>> Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Note that tps6598x_exec_cmd() is only called with in_len == out_len == 0
> and NULL data pointers. It might make sense to simplify the function and
> drop the unused parameters as well as the associated code.
> 
Clarification: That would be a separate patch.

Guenter

> Guenter
> 
>> ---
>> v2: fix tps6598x_exec_cmd also
>> v3: use fixed length for stack buffer
>> ---
>>   drivers/usb/typec/tps6598x.c | 26 ++++++++++++++++++++------
>>   1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
>> index c84c8c189e90..eb8046f87a54 100644
>> --- a/drivers/usb/typec/tps6598x.c
>> +++ b/drivers/usb/typec/tps6598x.c
>> @@ -110,6 +110,20 @@ tps6598x_block_read(struct tps6598x *tps, u8 reg, void *val, size_t len)
>>       return 0;
>>   }
>> +static int tps6598x_block_write(struct tps6598x *tps, u8 reg,
>> +                void *val, size_t len)
>> +{
>> +    u8 data[TPS_MAX_LEN + 1];
>> +
>> +    if (!tps->i2c_protocol)
>> +        return regmap_raw_write(tps->regmap, reg, val, len);
>> +
>> +    data[0] = len;
>> +    memcpy(&data[1], val, len);
>> +
>> +    return regmap_raw_write(tps->regmap, reg, data, sizeof(data));
>> +}
>> +
>>   static inline int tps6598x_read16(struct tps6598x *tps, u8 reg, u16 *val)
>>   {
>>       return tps6598x_block_read(tps, reg, val, sizeof(u16));
>> @@ -127,23 +141,23 @@ static inline int tps6598x_read64(struct tps6598x *tps, u8 reg, u64 *val)
>>   static inline int tps6598x_write16(struct tps6598x *tps, u8 reg, u16 val)
>>   {
>> -    return regmap_raw_write(tps->regmap, reg, &val, sizeof(u16));
>> +    return tps6598x_block_write(tps, reg, &val, sizeof(u16));
>>   }
>>   static inline int tps6598x_write32(struct tps6598x *tps, u8 reg, u32 val)
>>   {
>> -    return regmap_raw_write(tps->regmap, reg, &val, sizeof(u32));
>> +    return tps6598x_block_write(tps, reg, &val, sizeof(u32));
>>   }
>>   static inline int tps6598x_write64(struct tps6598x *tps, u8 reg, u64 val)
>>   {
>> -    return regmap_raw_write(tps->regmap, reg, &val, sizeof(u64));
>> +    return tps6598x_block_write(tps, reg, &val, sizeof(u64));
>>   }
>>   static inline int
>>   tps6598x_write_4cc(struct tps6598x *tps, u8 reg, const char *val)
>>   {
>> -    return regmap_raw_write(tps->regmap, reg, &val, sizeof(u32));
>> +    return tps6598x_block_write(tps, reg, &val, sizeof(u32));
>>   }
>>   static int tps6598x_read_partner_identity(struct tps6598x *tps)
>> @@ -229,8 +243,8 @@ static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
>>           return -EBUSY;
>>       if (in_len) {
>> -        ret = regmap_raw_write(tps->regmap, TPS_REG_DATA1,
>> -                       in_data, in_len);
>> +        ret = tps6598x_block_write(tps, TPS_REG_DATA1,
>> +                       in_data, in_len);
>>           if (ret)
>>               return ret;
>>       }
>>
> 

