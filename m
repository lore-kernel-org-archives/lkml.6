Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E308C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED212241A3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvbhksY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED212241A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeGDVnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:43:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44010 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752667AbeGDVm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:42:59 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so3526174pfm.10;
        Wed, 04 Jul 2018 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dd7w7zv7rxbUrPItcb7ZsHf8AJRO2FiCdGVNCoV5qCs=;
        b=LvbhksY8m0adBqD9U3w8xdsYEMmX/BmtEQknzS1El25mFFlcFOe8fAdrcBOrkE/SmF
         trUgZ0XYFnauZMOQWZ3I+WtJ2AalXTv56vIO97kZFAV2wFxrSIQ4/louiEyORM3KdW9c
         7nptZTL2uVnqjveHDZN+ZjI5H9pxuSXlY66Sfix7bgXp+jYYWEH7y/hggZXmqwFxo3Uc
         8Jpis85Pi5P8EiRjixcfGPKc2CifnI57tD5VvmmL7uxSWsVQDCfMPRfblPANOW8wV/63
         CudE5g1gVD15NP8dr/J/YfaI3YPf1BQQPX0E5l48OTVv5e7ujpCUiUjNIy4OR3To8R+F
         czgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dd7w7zv7rxbUrPItcb7ZsHf8AJRO2FiCdGVNCoV5qCs=;
        b=IdzK1g5V7oaiuBIxozNddVg8b3N+IsI/3DYsk0CnLHP2feSEgw0KifCOhtZY1olRTb
         06tbp0grK83dD5f03VZMxMCLgl0zxtBo18xUZGdiACv14rbhGEAcXZF+x6d+kDdOJFNN
         tiXDxWTNqnaa9zGt0LRQQRMDH6fPDTd1iEXFRkrND8+sJcIH54axuDUhoc6i/OnSoWm1
         araZIKdf1S7PjEqbGqT0jvseqAI9xFSE/dXMjJQSlWXlru70RJvsSaZCHmLUT6DZFv54
         pyuCAUGaVubVyIb6esKW4NhAnFB6f17g48U1xDXnJpuyum3LzFTx/qIVxt3RT5CfGqLh
         wxWQ==
X-Gm-Message-State: APt69E1lfrcbIr0b0GZN/b+hU+PPMKH/+hhKMgLP3ev7AZy/F7y7J9Hc
        BB/slfbrrJooJoceZRXev5Oy3Q==
X-Google-Smtp-Source: AAOMgpfpHcX/D0vpNJTsnt56wLTVAtQMewCDv49azQxvh7USwIdPQUKsLiW/RmrTzNO0CHUXsjTp3Q==
X-Received: by 2002:a63:c44a:: with SMTP id m10-v6mr3256092pgg.416.1530740579239;
        Wed, 04 Jul 2018 14:42:59 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e17-v6sm6342431pgo.70.2018.07.04.14.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 14:42:58 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] hwmon: ibmpowernv: Add attributes to
 enable/disable sensor groups
To:     Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
References: <1530695793-4584-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1530695793-4584-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <e3a013fb-eaf0-8d45-2f23-3be8b3e5640b@roeck-us.net>
 <c7e1272a-c9c8-a120-632f-7693cef3fd22@linux.vnet.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f0b3384f-02fb-f4f2-0f89-378183a1fad9@roeck-us.net>
Date:   Wed, 4 Jul 2018 14:42:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <c7e1272a-c9c8-a120-632f-7693cef3fd22@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2018 09:53 AM, Shilpasri G Bhat wrote:
> Hi Guenter,
> 
> Thanks for reviewing the patch.
> On 07/04/2018 08:16 PM, Guenter Roeck wrote:
>>> +        /* Disable if last sensor in the group */
>>> +        send_command = true;
>>> +        for (i = 0; i < sg->nr_sensor; i++) {
>>> +            struct sensor_data *sd = sg->sensors[i];
>>> +
>>> +            if (sd->enable) {
>>> +                send_command = false;
>>> +                break;
>>> +            }
>>
>> This is weird. So there are situations where a request to disable
>> a sensor is accepted, but effectively ignored ? Shouldn't that
>> return, say, -EBUSY ?
> 
> This is because we do not support per-sensor enable/disable. We can only
> enable/disable at a sensor-group level.
> 
> This patch follows the semantic to disable a sensor group iff all the sensors
> belonging to that group have been disabled. Otherwise the sensor alone is marked
> to be disabled and returns -ENODATA on reading it.
> 
> And a sensor group will be enabled if any of the sensor in that group is enabled.
> 

In similar situations, where setting one attribute affects others, a common solution
is to make only the first attribute writable and have it affect all the others.
I think that would make sense here as well, and it would be much simpler to implement.

Guenter

> I will make changes to the remaining code according to your suggestion.
> 
> Thanks and Regards,
> Shilpa
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

