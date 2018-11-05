Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951CDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A2F2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="amU7KVp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A2F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbeKFELg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:11:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36224 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeKFELg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:11:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id z13-v6so8318738wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 10:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eQ0yEPremo8B52k/FyqcK25od7JQpyHMXbzuF9gsdN0=;
        b=amU7KVp8WunULXUkJET7bYtA0r71du004Q+APnUm5VVoHPsP0O/X1TSNXFEYSnHjuP
         Tdt6qrnyRs3w8LeBShQqy+fk7Ph6X9hBbARhDuF09Kkei6MvRz8yQL9rKW6Dq2Dy1p52
         aLTeLqQb22iSa0t37n64XAIthPGG7Bhazu1D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eQ0yEPremo8B52k/FyqcK25od7JQpyHMXbzuF9gsdN0=;
        b=FUI7TNVzr0gbvMRWVkc+rqye3XLLji0k8Pl+/p39kZjK0EmLQWg0dw7l0bJHUf2TLg
         7VZaF3hZqn49rUcpKXAI2swHDj0ojm+D0attmMmbs1DEnffpVLFQbNSVGDAQTnFIOmoy
         lr5WYC9/Z7ssRPXKTwLSqzJgLJ0wXcSsL8jJ78K1p6A+4ztb8ZrewJ+Jzw0GK1p13od8
         T2c+TDoUsEgNHxcBTr7Gkp3ZYpIYYd0P6xZx0QbslnCvLIQY3AxtSDQ2mIFNm847Xgax
         ZTywqM8PMWQ38jN3eRD/LhZ7uVaGJjl+OuAQDlF3j5vnMKLxSgoStV7qypkDCcZtAJzt
         HSkQ==
X-Gm-Message-State: AGRZ1gIzR9WzLyM69ON73VtxDU9MCGB9anC4pmW/44pLysSkN0IPbaZh
        d/6Qnqw8eripbfsrTPVQcNCHdA==
X-Google-Smtp-Source: AJdET5c6/zsiaTNeJiuVzvDeSvk/ILcuSVSHmbUJNrjV8i8PXef9QzY5AV98N9gAVB5SIWsQTvAE4A==
X-Received: by 2002:adf:9403:: with SMTP id 3-v6mr20449968wrq.54.1541443834122;
        Mon, 05 Nov 2018 10:50:34 -0800 (PST)
Received: from [192.168.0.40] (119.151.136.77.rev.sfr.net. [77.136.151.119])
        by smtp.googlemail.com with ESMTPSA id y21-v6sm19345969wma.36.2018.11.05.10.50.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 10:50:33 -0800 (PST)
Subject: Re: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
To:     Tao Ren <taoren@fb.com>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Yu Lei <mine260309@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20181003215350.3550926-1-taoren@fb.com>
 <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
 <BC1ADE3F-F31F-4E1E-A6EE-3BD83C5F2634@fb.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <279e6a06-3f2f-e736-f28e-4d099729a517@linaro.org>
Date:   Mon, 5 Nov 2018 19:50:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BC1ADE3F-F31F-4E1E-A6EE-3BD83C5F2634@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 19:43, Tao Ren wrote:
> On 10/7/18, 2:03 PM, "Linus Walleij" <linus.walleij@linaro.org> wrote:
>>
>> On Wed, Oct 3, 2018 at 11:54 PM Tao Ren <taoren@fb.com> wrote:
>>
>>> TIMER_INTR_MASK register (Base Address of Timer + 0x38) is not designed
>>> for masking interrupts on ast2500 chips, and it's not even listed in
>>> ast2400 datasheet, so it's not safe to access TIMER_INTR_MASK on aspeed
>>> chips.
>>>
>>> Similarly, TIMER_INTR_STATE register (Base Address of Timer + 0x34) is
>>> not interrupt status register on ast2400 and ast2500 chips. Although
>>> there is no side effect to reset the register in fttmr010_common_init(),
>>> it's just misleading to do so.
>>>
>>> Besides, "count_down" is renamed to "is_aspeed" in "fttmr010" structure,
>>> and more comments are added so the code is more readble.
>>>
>>> Signed-off-by: Tao Ren <taoren@fb.com>
>>> ---
>>> Changes in v2:
>>>   - "count_down" is renamed to "is_aspeed" in "fttmr010" structure.
>>>   - more comments are added to make the code more readable.
>>  
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Hi Daniel / Thomas,
> 
> Any further comments on the patch? Or is there anything needed from my side?

Oh right, sorry. Should it go to stable also ? Is there a Fixes tag it
can apply ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

