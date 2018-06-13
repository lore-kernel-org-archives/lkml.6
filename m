Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4AAFCC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0037E208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LeVH2p5g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0037E208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936036AbeFMO7f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:59:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39733 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935190AbeFMO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:59:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so6013003wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 07:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oMZWsnRKXXeQ+5GEcooKlwlJOUPr4xBZtKePEdz06AM=;
        b=LeVH2p5gLX6QR04e5gTNsR3ENtSkzuhLkyP3ByOJbjq1doYXl0XpPq9Hg7/e1U/Wrm
         IqU6eDXahLAuwSkxraeiKIGWqUVdFkziFRdnt+G+pflg5SqlQgxGh/KoswHK8zOvZGhZ
         ZJYpgQt/xEPdN77+m5bSl6bff14JIIGfupLPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oMZWsnRKXXeQ+5GEcooKlwlJOUPr4xBZtKePEdz06AM=;
        b=cfhDApd+rcQpnDXBRz2GKUUhf8Q5gNp+SMy1t888Va5Jci4Qfuk5aTxTvVguS3tc+x
         1i/NIVCZagi0P2Dbm7Fafj4Zxk0djlG70w1P/FBJptykYYOxQg+/R+ophUS7SuXyyZI1
         5NEeftZdh0eoJFoaL7zO2GssRWZPN4iigL+GywLXR8kJfX1RkT6MZukEvWGXeJdN1DNM
         d/lU2vvrw7YwkwSE76tw3d0hCM35AQYaR4msLC61vmobQWQpoJscSIYCUc2GHcIIMoNM
         7m9+r9PMmSKYKh9Syr6YvLiO5gJyErqq70aCY77Mb24kBOWcn/klJLk37M4gOVYqJz38
         z3Jw==
X-Gm-Message-State: APt69E3W1rJ8MXgcZep5uwPoHrkCtWwzqi/cxIr/jDU3eqazEAaaQoHT
        +OAdHV4pmhlczvH2OKIt3YBfG6Pdv/U=
X-Google-Smtp-Source: ADUXVKJ9FKOWbbsQsxlu/Bg6rp3z2hKOaTX9pk2ygUC7sdCVBqY19Dsae6p8JxcOXFDoGm+MS7wqig==
X-Received: by 2002:a1c:1286:: with SMTP id 128-v6mr3993527wms.9.1528901970023;
        Wed, 13 Jun 2018 07:59:30 -0700 (PDT)
Received: from [192.168.1.100] (aig34-1-88-167-228-121.fbx.proxad.net. [88.167.228.121])
        by smtp.gmail.com with ESMTPSA id u70-v6sm5027289wmd.3.2018.06.13.07.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 07:59:29 -0700 (PDT)
Subject: Re: [PATCH v2] lib/test_printf.c: call wait_for_random_bytes() before
 plain %p tests
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180613092919.24075-1-thierry.escande@linaro.org>
 <CAHp75VeXGT3KG9HXQstFJVyHFO8o64Dk0LSo43FzyR0SvPUONg@mail.gmail.com>
From:   Thierry Escande <thierry.escande@linaro.org>
Message-ID: <d663916f-ebbf-3177-cd03-8d1175912f53@linaro.org>
Date:   Wed, 13 Jun 2018 16:59:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeXGT3KG9HXQstFJVyHFO8o64Dk0LSo43FzyR0SvPUONg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2018 13:22, Andy Shevchenko wrote:
> On Wed, Jun 13, 2018 at 12:29 PM, Thierry Escande
> <thierry.escande@linaro.org> wrote:
>> If the test_printf module is loaded before the crng is initialized, the
>> plain 'p' tests will fail because the printed address will not be hashed
>> and the buffer will contain "(ptrval)" instead.
>> Since we cannot wait for the crng to be initialized for an undefined
>> time, both plain 'p' tests now accept the string "(ptrval)" as a valid
>> result and print a warning message.
> 
> There are two possibilities:
>   1. (ptrval) for 32-bit case
>   2. (____ptrval____) for 64-bit case.

 From lib/vsprintf.c, ptr_to_id() puts "(ptrval)" into the buffer, then 
it gets left-padded with spaces by widen_string().

Regards,
Thierry
