Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B67C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307F62081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="L/wwtFos"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307F62081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeKBTtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:49:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36270 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKBTtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:49:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id h192so1016025lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 03:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x3S7Dc3i+1ER3jsEvnMSLrTNDgnTJWknmxggfFSJ2ZI=;
        b=L/wwtFos01nHILF7L1piX4RE4p0R3VEuUv/ynzWfzZ3+uDEfAYanO5ehb/vTbV4lha
         E3N82dJkBXtK2eGQ04gQQaOOMlOUD/UDohXTGE4ZCgf/NjE8RlSSHGTpWbUSnIRN8VII
         uzHQN+laJ/qPrwB2B0tlXSqpvEfavfBTYbHag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x3S7Dc3i+1ER3jsEvnMSLrTNDgnTJWknmxggfFSJ2ZI=;
        b=TXEE2tNCD/5mVx9ANRdNLUknj3mbJPp2UmKPT/sEbsOaLH9yr8QSy1hXyW1dZk/eDe
         f1B+2bMrInhYklu1UIPUKJ1wxlW9PfJyQiEs7MTaCcNJaqlTxOfsIV02nhlIazqr1yRP
         jOTrwIleSiMYgmoerikKGtc0VOAXtSI5g8bNQnpdDwiG+/i5GXey5Y9Kt9tajykXMyN6
         OuDyqBPxGO/g45par1oCdYiYdFIe3rLBLTdmAU/il4Dk/q+UDLXKpMAHFW3YpjUAloUX
         E+V2NhHA1IUQfv+806lU289l2iL4/w9bCd287CWT3x8BrPL+STQR0yZ6hPylk0HIEyq8
         AORw==
X-Gm-Message-State: AGRZ1gLTk0Vye9JXvuUUJpxXjFU3ydYzO80ly1IkH0qDAvBWbwmQtAZn
        ONpvxdMaTqqUxTs7JBjjzbHcl63PnuolMw==
X-Google-Smtp-Source: AJdET5e92L2JMOSyYIUlQMNTNW7L2ModtyPd0wDHbWqYFnAdyV1nRv9tvOCyC1Cy5M2+EP/0EoUiIQ==
X-Received: by 2002:a19:4948:: with SMTP id l8-v6mr6153766lfj.16.1541155388561;
        Fri, 02 Nov 2018 03:43:08 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s191-v6sm194589lfe.17.2018.11.02.03.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 03:43:08 -0700 (PDT)
Subject: Re: [RFC PATCH 1/7] compiler_attributes.h: add
 __attribute__((format_arg)) shorthand
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-2-linux@rasmusvillemoes.dk>
 <CANiq72kEdD3hoHaxukkdzEJt+e_nptyO1GdgfUqWnSAog3k=JQ@mail.gmail.com>
 <CANiq72=-2mrvBWHUcFCNsoQ_EbXQm4RmtOp061ngnGJx_Fyp0g@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <72ac8661-312c-8df9-358a-22ddb0a81f54@rasmusvillemoes.dk>
Date:   Fri, 2 Nov 2018 11:43:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANiq72=-2mrvBWHUcFCNsoQ_EbXQm4RmtOp061ngnGJx_Fyp0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-02 11:36, Miguel Ojeda wrote:
> Hi Rasmus,
> 
> On Sat, Oct 27, 2018 at 2:06 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
>>
>> I did quick check and gcc >= 4.1, clang >= 3.0, icc >= 13 compilers
>> seem to support it (or at least recognize it, even if they just ignore
>> it), so we do not need to make it optional, no? Did I miss some case?
> 
> compiler-attributes landed -- do you want to do the v2 of this (i.e.
> #defining it unconditionally) or you prefer I simply fix up the patch?

I'll wait a few more days for comments on fmtcheck(), and allow you to
do the 'optional'/'required' clarification in the meantime. I hope to
get fmtcheck() picked up for -next around -rc3 or so.

Rasmus
