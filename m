Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14D0C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A414B2492B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUAdZZNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A414B2492B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933815AbeFVVuZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:50:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39370 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbeFVVuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:50:24 -0400
Received: by mail-wm0-f65.google.com with SMTP id p11-v6so4063640wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nb7gwKEi7wrpa7ryLvokYFq5D6MvbLRy1x109eWHhsY=;
        b=GUAdZZNJJRLY3aRrgJZQBky+6mpxd+7XWH3qzlaq33cpFIQofYQ89XBBuc2CHOMjIt
         tO4dCsYPy3A4vRSQaxIG5/X7pgEk5ytiMPjDR6Rgm3r2dk2nN8Z2SQjCMLFqX/Bu4p/h
         kGMPgFAPgCeiefIyA+4ti2yG9MCt8Hkbr6BpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nb7gwKEi7wrpa7ryLvokYFq5D6MvbLRy1x109eWHhsY=;
        b=HkUu2gOywBDVQFBJfAY8btkqkM38ZyMtdONRfIEduPctDrgbYjhyZHFqMra9mmajaN
         qE4ZQupq5psUlCXw0mlacT/8o9XRzQX1pcx7zucW8DyToyBc50soK5At3E7g4tqV//9R
         V9exFWwldbbSOdkWrC4lApjW4m8ArdpEnX+QNZVEOLktTHwvfiSiwycHjn8IanQtO7TH
         /+irxaP8MY3+Rpn3EyC9xaFZc26pfjaqdFFdYIjLOyEh3jZOn4Y1VvQdA7mtNqrdehw0
         5lIxMf3RVkwTULhB711OlLFMP3b5BFMPBv7bKQ7jVwEXnCbft66fi+8HQtr7KRueILMj
         wNRg==
X-Gm-Message-State: APt69E0xlo2ImO0VeaA+Hgq/64Ek73AAJ+ZiCuzE6VyB0Go5jwZaKueV
        hlMm0SLD3+PLBOEjP137NX8/jBKnNP8=
X-Google-Smtp-Source: ADUXVKLCZoT6MRtehVAv+j5u406tEICvI4Sni/3vlEXip+1tAnxsbv1teAKOfzg3zU7l8mAB+xE7ew==
X-Received: by 2002:a1c:e6d4:: with SMTP id e81-v6mr2684818wmi.152.1529704222779;
        Fri, 22 Jun 2018 14:50:22 -0700 (PDT)
Received: from [192.168.1.100] (aig34-1-88-167-228-121.fbx.proxad.net. [88.167.228.121])
        by smtp.gmail.com with ESMTPSA id b190-v6sm3387848wma.24.2018.06.22.14.50.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 14:50:21 -0700 (PDT)
Subject: Re: [PATCH RESEND] lib/test_printf.c: call wait_for_random_bytes()
 before plain %p tests
To:     Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20180604113708.11554-1-thierry.escande@linaro.org>
 <20180607122434.i4x7b5ij4p6dpx7w@pathway.suse.cz>
 <20180622205346.owyjk33wplzh7nhs@home.goodmis.org>
From:   Thierry Escande <thierry.escande@linaro.org>
Message-ID: <a2f0729c-593e-b747-a22f-6468ea88882e@linaro.org>
Date:   Fri, 22 Jun 2018 23:50:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622205346.owyjk33wplzh7nhs@home.goodmis.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2018 22:53, Steven Rostedt wrote:
> On Thu, Jun 07, 2018 at 02:24:34PM +0200, Petr Mladek wrote:
>> On Mon 2018-06-04 13:37:08, Thierry Escande wrote:
>>> If the test_printf module is loaded before the crng is initialized, the
>>> plain 'p' tests will fail because the printed address will not be hashed
>>> and the buffer will contain '(ptrval)' instead.
>>> This patch adds a call to wait_for_random_bytes() before plain 'p' tests
>>> to make sure the crng is initialized.
>>
>> Hmm, my system did not boot with this patch and
>> CONFIG_TEST_PRINTF=y
> 
> And neither does my test box. It killed my tests I was running, as one of the
> configs I test has this set.
> 
> It appears that Andrew pulled it in and sent it to Linus, as it is in
> 4.18-rc1, and I need to now revert this patch to make my tests work.

This patch has been superseded with a v2 and a v3 pushed into Petr 
printk.git tree 
(https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-4.19&id=ce041c43f22298485122bab15c14d062383fbc67). 
Sorry for the mess...

Regards,
Thierry

> 
> -- Steve
> 
> 
>>
>> I guess that there was not enough entropy. It is basically a deadlock.
>> The build-in module init calls are called when SMP is enabled but
>> there is no real activity and the init calls are called sequentially.
>> Therefore there is nothing that could produce some entropy, ...
>>
>> I suggest to skip the test when crng is not ready.
>>
>> Best Regards,
>> Petr
>>
>>> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
>>> Acked-by: Tobin C. Harding <me@tobin.cc>
>>> ---
>>>   lib/test_printf.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/lib/test_printf.c b/lib/test_printf.c
>>> index 71ebfa43ad05..839be9385a8a 100644
>>> --- a/lib/test_printf.c
>>> +++ b/lib/test_printf.c
>>> @@ -260,6 +260,13 @@ plain(void)
>>>   {
>>>   	int err;
>>>   
>>> +	/*
>>> +	 * Make sure crng is ready. Otherwise we get "(ptrval)" instead
>>> +	 * of a hashed address when printing '%p' in plain_hash() and
>>> +	 * plain_format().
>>> +	 */
>>> +	wait_for_random_bytes();
>>> +
>>>   	err = plain_hash();
>>>   	if (err) {
>>>   		pr_warn("plain 'p' does not appear to be hashed\n");
>>> -- 
>>> 2.14.1
>>>
