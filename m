Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6297FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222EE20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dX215uVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 222EE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeLAA75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:59:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35277 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeLAA75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:59:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id c126so5781140wmh.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 05:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n3sAUM3ZXV+uBWTxeruxfPgRuVdikWgC6Q4vCJn4PRo=;
        b=dX215uVVo95HfXo38o+feJyGt2oLNkuQttt1mIMF5/AB14OGVdHOJM9qBP6MQmMagn
         rUbLF7ybQDUukO0B/rmqwauXjDUnEll2hZVAJggCQ0QNOuyrV1NIHr608bv3Jnt8X1Zs
         CG3HC1/oXQAiLUJ2hlECAIbHQAy3IPecsdroU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n3sAUM3ZXV+uBWTxeruxfPgRuVdikWgC6Q4vCJn4PRo=;
        b=tewCpPSA6wNP0aDGUL2fgUm9sbS8IU+8LgD2CGcRIWNDQduNBr9y69wX+VXF/JZu8+
         UzleWrqw20TUfRPTMr45UdCThngx/Tl+tmUp3wADc/WtZxlaABu0orWW8JEVkJmUSxcG
         3NpiIRZMgu0KybZslhsqdzD2CmrjM+svXkzF0M1iRfRiWNwc2M+807fD6QJcOpjxXfyW
         zFHX5/ItsS3WBpS6Ep6qjhOwwf/U/dhx5/EBQEOBQxU7sLDdBIg8ZqkccJeUlyC4ykdm
         8Qlr5UpAlhd4bpJ6Yk/NG8FGyCcrcYmPEnaUVXfJ1v/+IwQos2cnoQ5ChvBegaR2tzHG
         JuGw==
X-Gm-Message-State: AA+aEWbesiauVrN0X4bMPaHPCOfn35vyeU+OlK+6WWxAlQLnH0gQNav/
        DE5PT6psdRPUTgakXhaF9ZS2fA==
X-Google-Smtp-Source: AFSGD/WhtmzWGJwJ3+gWAsQL02j7vASHS0sCsu524+Z6zbA5sqKn4REfe0LR8jd276qgzD5jvxPELg==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr5946208wmg.42.1543585833712;
        Fri, 30 Nov 2018 05:50:33 -0800 (PST)
Received: from ?IPv6:2a01:e35:8a7e:4790:488f:ca49:e154:1ce0? ([2a01:e35:8a7e:4790:488f:ca49:e154:1ce0])
        by smtp.gmail.com with ESMTPSA id j8sm6619557wmd.0.2018.11.30.05.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 05:50:33 -0800 (PST)
Subject: Re: [RFC PATCH 6/6] char: fastrpc: Add support for compat ioctls
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, bkumar@qti.qualcomm.com
References: <20181130104657.14875-1-srinivas.kandagatla@linaro.org>
 <20181130104657.14875-7-srinivas.kandagatla@linaro.org>
 <CAK8P3a1XaGHu3NrAeLn0OEg0nL1uae_MyrP7EgadJpfeeXtR2Q@mail.gmail.com>
 <2dbd06c5-d094-6d16-2983-131d3ae24c8d@linaro.org>
 <CAK8P3a3DsADgQo7b1B5vWV2Ws8mOpB1ixbi5tR=Z6cfvp+eZpA@mail.gmail.com>
From:   Thierry Escande <thierry.escande@linaro.org>
Message-ID: <ff3caa6c-6df1-b83f-5237-25fc024b0143@linaro.org>
Date:   Fri, 30 Nov 2018 14:50:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3DsADgQo7b1B5vWV2Ws8mOpB1ixbi5tR=Z6cfvp+eZpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2018 14:46, Arnd Bergmann wrote:
> On Fri, Nov 30, 2018 at 2:20 PM Thierry Escande
> <thierry.escande@linaro.org> wrote:
>> On 30/11/2018 13:58, Arnd Bergmann wrote:
>>> On Fri, Nov 30, 2018 at 11:48 AM Srinivas Kandagatla
>>> <srinivas.kandagatla@linaro.org> wrote:
>>>>
>>>> From: Thierry Escande <thierry.escande@linaro.org>
>>>>
>>>> This patch adds support for compat ioctl from 32 bits userland to
>>>> Qualcomm fastrpc driver.
>>>>
>>>> Supported ioctls in this change are INIT, INVOKE, and ALLOC/FREE_DMA.
>>>>
>>>> Most of the work is derived from various downstream Qualcomm kernels.
>>>> Credits to various Qualcomm authors who have contributed to this code.
>>>> Specially Tharun Kumar Merugu <mtharu@codeaurora.org>
>>>>
>>>> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
>>>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>>
>>> Can't you just define the native ioctls so that you don't need this.
>>
>> There are long time defined structures that are passed as argument to
>> these ioctls and their sizes vary between 32 and 64 bits userlands, so
>> the ioctl command values.
> 
> Where? I don't see them in linux-4.19.
> 
>> Unless I'm missing something here this also has the advantage not to be
>> compiled if CONFIG_COMPAT is not set.
> 
> You can normally just set .compat_ioctl() to the same function as
> .unlocked_ioctl(), and get no overhead either way.

As you suggested for the other patches in this series, we will rework 
these ioctl data structures and then use the same function.

Regards,
Thierry
