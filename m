Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 67285C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C94A208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gt6S2zFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C94A208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935326AbeFMQmn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:42:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44690 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934941AbeFMQmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:42:40 -0400
Received: by mail-wr0-f194.google.com with SMTP id x4-v6so3444644wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PRh79OU+UfGR0hbYKBymvBE8KyXMEFfAYLCiMgN0cvo=;
        b=gt6S2zFoOatb5TwybcTH8vARw1hso4llztnkQhgpbZndK7fGmIaIh4NEAH0oNIRG9q
         X+nZ9etCijB5PV2Py2WFTFKfcixsQCwcsAbGM4btpGw8RSdmA1kEYBUTPnuVEHKEiLyl
         clysDjK72ZqWrPPzDk0iptOyBcqgFv+Vz+mU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PRh79OU+UfGR0hbYKBymvBE8KyXMEFfAYLCiMgN0cvo=;
        b=K/JsRKLkqgugzjOZlsqYSqZ1D3Lnn6JsazTEGw15/iYQjh1uMdfcoR8nrV49RUuuvz
         WzRQss9zZFK5k7IaAsKhwcXfG5i0xgoYBu2yHUuROWk7CUUOw2cE/KVNshkSKBp/ggPW
         D78DXn5ayaUMtUf7jnXaUcWvbOjkS7EZis61PbBLCUNMFJdZ9qhFyY8V10F86jxvRlm5
         eDYzSksZyhyQ4LBezuj3lR8lkshQcbbFsvKQFLrPgQ/Qnv/YKy0naEj5xoJa0IE2Ooe6
         GcJ1MqUM2BkRh3mTEXty8uKR5Wg7ARh2Gh+K6rbbXaN0GOz3JU90rwhxx+Xl4zQoKeQp
         HOLg==
X-Gm-Message-State: APt69E1H8R3YRxZmfyzBWcVIQDgRS8DhKKdfcdSBVzZssC+tKlIeqF7P
        pfb+CsunnmF0NY9tUoFEH/5OricbAP8=
X-Google-Smtp-Source: ADUXVKJbvyeZwiH8Rv5uDcJwV72xKPsRNDf7i+4LJ5y1X4ZzSH1fYHY6nH9Y9rEgY5LN3N/Y4+O49A==
X-Received: by 2002:adf:8e89:: with SMTP id q9-v6mr4786023wrb.269.1528908158678;
        Wed, 13 Jun 2018 09:42:38 -0700 (PDT)
Received: from [192.168.1.100] (aig34-1-88-167-228-121.fbx.proxad.net. [88.167.228.121])
        by smtp.gmail.com with ESMTPSA id t17-v6sm4133599wrr.82.2018.06.13.09.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 09:42:37 -0700 (PDT)
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
 <d663916f-ebbf-3177-cd03-8d1175912f53@linaro.org>
 <CAHp75VeiH+FvT7pbCpx75kxxeC5huxKRtXQvzfVjX4OyCaLLrw@mail.gmail.com>
From:   Thierry Escande <thierry.escande@linaro.org>
Message-ID: <7c23d47c-3380-f28f-bab9-fa5dcc1a93f4@linaro.org>
Date:   Wed, 13 Jun 2018 18:42:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeiH+FvT7pbCpx75kxxeC5huxKRtXQvzfVjX4OyCaLLrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/06/2018 18:30, Andy Shevchenko wrote:
> On Wed, Jun 13, 2018 at 5:59 PM, Thierry Escande
> <thierry.escande@linaro.org> wrote:
>> On 13/06/2018 13:22, Andy Shevchenko wrote:
>>>
>>> On Wed, Jun 13, 2018 at 12:29 PM, Thierry Escande
>>> <thierry.escande@linaro.org> wrote:
>>>>
>>>> If the test_printf module is loaded before the crng is initialized, the
>>>> plain 'p' tests will fail because the printed address will not be hashed
>>>> and the buffer will contain "(ptrval)" instead.
>>>> Since we cannot wait for the crng to be initialized for an undefined
>>>> time, both plain 'p' tests now accept the string "(ptrval)" as a valid
>>>> result and print a warning message.
>>>
>>>
>>> There are two possibilities:
>>>    1. (ptrval) for 32-bit case
>>>    2. (____ptrval____) for 64-bit case.
>>
>>
>>  From lib/vsprintf.c, ptr_to_id() puts "(ptrval)" into the buffer, then it
>> gets left-padded with spaces by widen_string().
> 
> Which kernel version you are trying to fix?
> 
> What I see for a long time in linux-next:
> 
> static char *ptr_to_id(char *buf, char *end, void *ptr, struct printf_spec spec)
> {
>          const char *str = sizeof(ptr) == 8 ? "(____ptrval____)" : "(ptrval)";
> ...
> 
> brought by the commit 91efafb1dd8f ("lib/vsprintf: Replace space with
> '_' before crng is ready").

I missed that one as it's not in v4.17. My bad.

Regards,
Thierry
