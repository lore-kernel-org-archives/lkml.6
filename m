Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9161AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DB126C24
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LSYgjFHY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mdZvF/su"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DB126C24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeFZQuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:50:03 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:46224 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeFZQuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:50:02 -0400
Received: by mail-yb0-f196.google.com with SMTP id s14-v6so6854254ybp.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LjiFNEY2CvYSq4UfWYvLVRPWNWqk3Lv9pTTT4k3DdRE=;
        b=LSYgjFHYGY8qOnVw+EnVeY5YMTZOlIaAU8x1rN4GI9F/7C9f4qUcphMdD69mepaFyP
         JCf3kALz9xpLRHMj6sDZY2Q+m7oqCnBfFFHgyt6p6H3cyahUjNdjh4LoteSjT0MEqxxN
         LwFvz78XWhL5j7sebm4xctN7dOdK+3Mr38NPoEjzZ3BDTp7Xx1TEl51fbw+VZhaNfn4j
         ZgEc6RxjHAGvlp39/R/ydgC+5uF9ihLOKxGVg2suz9Mn3Z/6K2Fiyxd05pEtrztXy+UO
         OXJuPNYNnXtR9c72TxwfwMTDOK1+QiJaL16V1s4imHDWtJdNfj2iwRB0s4CiGN0OBiDM
         eX5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LjiFNEY2CvYSq4UfWYvLVRPWNWqk3Lv9pTTT4k3DdRE=;
        b=mdZvF/suHE7pwMH5uxz8ygU5GD2B8lZRW1/YjasvDbV+w8CP41XSRIaPwvXdfNBzTY
         8MH7fKRgJSfuefhctPXLAHrJvgS6Q5b5973VVMY3pjnwp2APqFwsf7UrM1hcsF/M9rY6
         pQ+Tvc19mmEfVzdT2Ul5tsCfimpBZxIxYYfpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LjiFNEY2CvYSq4UfWYvLVRPWNWqk3Lv9pTTT4k3DdRE=;
        b=kAPR/7+YUXUllq0wd711x0dg17SFb6JMKCL05QJeTJ2yZPIdXY0M+kdXTBF/dIEdb2
         znwfXPjD+HUBFn14pZ7AFAGKIm/dskt0T7lTxU9DsRmmK+KeLgdxRT6Lb3KFQJ+JoJkz
         k7YzMzg4jHGrJuG2ex6k8NXZTMpUBBEcQmb74Qn6jsnbqOVd4Swf+HE6TaF35bHNpl5U
         qruePhDC7ba8OHqc/RNxJR0KRRB49GPAEDsLaL+JnaJhlTBpZ0HIRCSBkNI0Yf56xCC0
         cR/DVTx/T5hTrbkJXE3mZXn5u95kkVQ6tdik0oSjyz9kxJpxf08A8P2FNIKvFo8KD1DL
         fyDw==
X-Gm-Message-State: APt69E2iTWSvTZBRx5CZf4kN6b3C2n8SN0u5WT/XHTRn8DQIjN7dgLza
        fwyX2AODG6yg3WoQ5WO1V5tLaXlFA+L4OfdEDP3P/x3R
X-Google-Smtp-Source: ADUXVKJX4TDRS+MB0yYF4KdCri6mxsI7cT41EcaSzfjHokiv6ZfoqHnJsH4/6uFaxUzAMxd18n1iWPSxRFpLLqdcnbM=
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr1265903ybj.112.1530031801488;
 Tue, 26 Jun 2018 09:50:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 09:50:00
 -0700 (PDT)
In-Reply-To: <1ed829f4-ee39-2a46-e0d9-5c7ea584cfff@embeddedor.com>
References: <20180625211026.15819-1-keescook@chromium.org> <20180625211026.15819-2-keescook@chromium.org>
 <4d9f90abbf87539d3588f88117806f76c6826030.camel@perches.com>
 <CAGXu5j+PE9WpeO7eSX87uxrtwybBbX=J+F9d9H7sdoXAcWjUEw@mail.gmail.com> <1ed829f4-ee39-2a46-e0d9-5c7ea584cfff@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 26 Jun 2018 09:50:00 -0700
X-Google-Sender-Auth: RTT7danckmtGIoS7iZ-hmEYWJxw
Message-ID: <CAGXu5j+HNSMbORYEApw67MHX_0MNeEwO23=f_U3KE-9kAk16Fg@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] crypto: xcbc: Remove VLA usage
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 5:54 PM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
> On 06/25/2018 06:06 PM, Kees Cook wrote:
>> On Mon, Jun 25, 2018 at 2:23 PM, Joe Perches <joe@perches.com> wrote:
>>>  warning-3 += -Wswitch-default
>>
>> This reminds me, though. Should _this_ one get moved to warning-1?
>>
>> $ git log next-20180625 --no-merges --grep 'mark expected switch
>> fall-through' --oneline | wc -l
>> 129
>>
>> Gustavo, have you checked recently how many of these are left? Maybe
>> we can move this to default too?
>>
>
> I just built today's kernel and we have a total of 704 fall-through warnings with -Wimplicit-fallthrough=2

Wow; that's still a lot!

> I think we might be able to do that in this development cycle.

Do you think we could finish the rest of the unannotated ones this
cycle? If not, we could upgrade from W=3 to W=1 since it's a condition
we're actively trying to remove from the kernel...

-Kees

-- 
Kees Cook
Pixel Security
