Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D25C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAF52082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHRNoSP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAF52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeLAAaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:30:17 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36616 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeLAAaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:30:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id u3so5271029wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hii4n1E6S/MF9SivjoI8WUmkMeANsv0F7OC+UYYEM00=;
        b=SHRNoSP/ZGeICILnyHd+3j9nnwOfRsb9VHSqLUlXpUEpt8d+2EcTQXX111un46V5us
         OzfJMDspDZKry22bIEltdVa9Lcl/dyIER8H4DHGkWlzTmCBboVdS8uJ7VEIDqeY/BrEi
         cds0w9yPhwb68+nMWokw4kp0WcyFwdFGoP8pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hii4n1E6S/MF9SivjoI8WUmkMeANsv0F7OC+UYYEM00=;
        b=JPS4rFupnNKfUwyWcNj7z5C01Ey1nPUJyxO1lJ65rQSZyunTZwj9J1m0qMSa8BKvhQ
         NmK2QTFRsW4+RsB7JJNTPn7swh6dRKVDvqlSMpBDhJWb22OE0DVopPfRObdlTGc6onQE
         OWE147zuytH6bIUDDHQp3rFv8tUsnRfMEpE0+3csc+MwpjOV43HN0AabVEiUkptAAONQ
         0HUO0KBIvD2zTB7kDB0ojTpDXIOU9ou5WXifLab3TfUpdM7hrWp7osC7MHz7wbj4TKHs
         oWWmzqrcyxp0b283SswJSQAgDpXywc1m1cO0+3e4qhdVHAyXA5DkfCgJ6s6hPzeX/Q5X
         Lm1w==
X-Gm-Message-State: AA+aEWa0/J7VSgXF/tNeeFsstuONQqy+Eet3lr0YVvHJ7nCn85ms3nTV
        uRJNG7OfP2AdpgK3ZiN7RU+ZVw==
X-Google-Smtp-Source: AFSGD/V92aHUVMbBYp3fz6RcF2RoqyL9tHhVdRwno+8bU0bsJwNiF2CFBYYABZXrirCywpHW3BZBEg==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr5145011wrx.298.1543584058606;
        Fri, 30 Nov 2018 05:20:58 -0800 (PST)
Received: from ?IPv6:2a01:e35:8a7e:4790:488f:ca49:e154:1ce0? ([2a01:e35:8a7e:4790:488f:ca49:e154:1ce0])
        by smtp.gmail.com with ESMTPSA id q3sm4281843wrn.84.2018.11.30.05.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 05:20:57 -0800 (PST)
Subject: Re: [RFC PATCH 6/6] char: fastrpc: Add support for compat ioctls
To:     Arnd Bergmann <arnd@arndb.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
 <20181130104657.14875-7-srinivas.kandagatla@linaro.org>
 <CAK8P3a1XaGHu3NrAeLn0OEg0nL1uae_MyrP7EgadJpfeeXtR2Q@mail.gmail.com>
From:   Thierry Escande <thierry.escande@linaro.org>
Message-ID: <2dbd06c5-d094-6d16-2983-131d3ae24c8d@linaro.org>
Date:   Fri, 30 Nov 2018 14:20:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1XaGHu3NrAeLn0OEg0nL1uae_MyrP7EgadJpfeeXtR2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 30/11/2018 13:58, Arnd Bergmann wrote:
> On Fri, Nov 30, 2018 at 11:48 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> From: Thierry Escande <thierry.escande@linaro.org>
>>
>> This patch adds support for compat ioctl from 32 bits userland to
>> Qualcomm fastrpc driver.
>>
>> Supported ioctls in this change are INIT, INVOKE, and ALLOC/FREE_DMA.
>>
>> Most of the work is derived from various downstream Qualcomm kernels.
>> Credits to various Qualcomm authors who have contributed to this code.
>> Specially Tharun Kumar Merugu <mtharu@codeaurora.org>
>>
>> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Can't you just define the native ioctls so that you don't need this.

There are long time defined structures that are passed as argument to 
these ioctls and their sizes vary between 32 and 64 bits userlands, so 
the ioctl command values.

Unless I'm missing something here this also has the advantage not to be 
compiled if CONFIG_COMPAT is not set.

Regards,
Thierry
