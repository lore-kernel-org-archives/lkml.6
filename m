Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5B9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8772075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhARRW6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8772075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbeKSHGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 02:06:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41397 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbeKSHGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 02:06:14 -0500
Received: by mail-qk1-f196.google.com with SMTP id 189so45636814qkj.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mfwWaMSXAnGvCyZhknK3dgKH0DCrI3zzR88U8BnZDvE=;
        b=EhARRW6ki4ocJ9XuCpNesbqQ2455skDLMYtuSIFRgXlFxk7z4xESfIUSGWBUmmtE65
         PEf7toCdY7aaTLgk+5WhqfQ/Muho/Vnoya4mq6MlCW1kjBQscmbTY6aB638jc/wMy3XE
         pE2WUHFCAoQ/DYUsyyzaozHeny5RJXSsgYBTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mfwWaMSXAnGvCyZhknK3dgKH0DCrI3zzR88U8BnZDvE=;
        b=H9nQGm3wKH7AS+Wxn6U3m5FjgNcjRdkdtTaa2TYcUWkEn7F0Q2YnbaKRxttJ2iUhcq
         CrTM+AEJZRUA9RNBb6tHacd0RrZxjb2mtSt0odrKbSJK7mRq2RdW3kFRREbDRr0eRz/R
         eYWG0n0AfHDwEBb/s0jMDj6gs9FHTbFpqGfBc3jaclboJHquSGeBAu0VYrVI01pg4DS/
         AqhD9X2zcQ0lytPmt5OJ0PKBz4n2R55cXSMkvHf+sFnIDJoWVQjgd+Z0GPol3YPyDp1J
         gO8MgAnAEGqS1++1sIXEWkGWz5CUwFa6snDxLAiwnCZ0xUCcVz6kwmRj9SwxaEqPohru
         yhzg==
X-Gm-Message-State: AGRZ1gJVhGYCrsIb3qeoSR0Kn/pPegHIJoBX/IuEbPSjuflJupZtVWaV
        7g4KaeWluzqJg22A3sRUUeneoA==
X-Google-Smtp-Source: AJdET5dl4toEfDqxXDAmTnNRP+VTvUwGglHXH1pzpRXksd65aKJsae8rqPJtUFr8rBUBjm96QJ6zYA==
X-Received: by 2002:ac8:35eb:: with SMTP id l40mr19014369qtb.165.1542573895426;
        Sun, 18 Nov 2018 12:44:55 -0800 (PST)
Received: from [192.168.48.13] ([168.194.160.89])
        by smtp.gmail.com with ESMTPSA id b20sm18313777qkb.17.2018.11.18.12.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 12:44:54 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v5] selftests: membarrier: re-organize test
To:     shuah@kernel.org
References: <dcc20b51-3069-6854-3190-b8958e2f9b96@kernel.org>
 <20181109154911.24464-1-rafael.tinoco@linaro.org>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <4b31ee44-6463-6f6b-ca43-f03af8b06e35@linaro.org>
Date:   Sun, 18 Nov 2018 18:44:50 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181109154911.24464-1-rafael.tinoco@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why do we need to add new routines for these conditions. Why can't handle these strings in array. For example you can define an array of strings for passed unexpectedly etc. and the pass the string to appropriate ksft_* interface instead of adding of these routines. Also it is hard to review the code this way.

I was able to fit all the logic in the 80 char limit and, still, give a 
notion what was being called on each condition (instead of using an 
array number or equivalent). Considering this is not the core code, and 
the this has been already accepted and reviewed in LTP project, would 
you mind accepting it so both can be maintained together ? It is much 
better than the existing one, anyway...

Note: I have removed the part where we test for older return codes, 
since kselftest is not focusing in those (but LTP does).

>> I do like the direction though. Also please run get_maintainer.pl and cc everybody it suggests.

Done in v5.

Thanks a lot.

>> 
>> thanks,
>> -- Shuah


> This commit re-organizes membarrier test, solving issues when testing
> LTS kernels. Now, the code:
> 
>   - always run the same amount of tests (even on older kernels).
>   - allows each test to succeed, fail or be skipped independently.
>   - allows testing features even when explicitly unsupported (force=1).
>   - checks false positive/negative by checking ret code and errno.
>   - can be extended easily: to expand an array with commands.
> 
> Note: like this, the test is pretty close to the LTP membarrier basic
> tests, and both can be maintained together.
> 
> Link: https://bugs.linaro.org/show_bug.cgi?id=3771
> Link: http://lists.linux.it/pipermail/ltp/2018-October/009578.html
> Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
> ---
-- 
Rafael D. Tinoco
Linaro Kernel Validation
