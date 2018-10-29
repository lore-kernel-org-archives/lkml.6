Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDF7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1443020827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 10:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="aktZCO9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1443020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbeJ2TI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 15:08:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55620 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729457AbeJ2TI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 15:08:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id s10-v6so7584880wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 03:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j81lGX8F5EsMGr1X6zUYZqRoP0y/tqiHFoV2QCJc9FE=;
        b=aktZCO9YctIJORl6Qp63qatPjebuWTRJkhj0AMvN3uSC4NvaDrkkw7QB9LlhKxubhh
         XDm6eA+XoSn9flg7nPY6WzNEd4ouoFYSB9mcYHEk4+WhzindOu9fr/nDuBnNTxNeb34v
         uZuzb+in/N53D8twBNd0JckbzaYSrEkO2UbW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j81lGX8F5EsMGr1X6zUYZqRoP0y/tqiHFoV2QCJc9FE=;
        b=WXnUfEK/G4I9lBL78PWmfCnfkxbhLJVrUIZ4prvpQlgDrTUDFAGXWCLbBT5wxzo5KI
         YtCKGNNn9mtyZZEY++iQKWwlldBIMDFEkhwkp93etoLRQuHwGgvHMSl3JNIrrK4Fm9sH
         KizlaxtNokSSqlYBWNg2HNdHWP/yPiBJZq4fhUUHZkSjtIPJ2Iofac+PPUnqpHe0N7zk
         ALh/sOcVxLmA66Y5KQv+qrLxkgqcyTAorb/DWBevqH8FhYmzUCggx/+w2DFJPwWDfKoV
         It04N62iUl6K2RoLEC1Dr/58N+HQn4tkAZ87/wJuuLg084AnzUR1P4/Q6sRcOXXJQUXD
         sG+g==
X-Gm-Message-State: AGRZ1gLTu8Y4HS8WpCo6fqKJ5Hx6YeHTFqndXR9/1BFlftjjQ8uN9gwx
        u99R5Mry4+OzdJ/y7UQPHZMqcKq38gQ=
X-Google-Smtp-Source: AJdET5ddqimU6eYlovWhYjwVmf9a90zqRMvEDfOaeFH5EHQEtTpylol0PU9o6KpDs6HHljzKWl5y6Q==
X-Received: by 2002:a1c:9706:: with SMTP id z6-v6mr671677wmd.86.1540808422645;
        Mon, 29 Oct 2018 03:20:22 -0700 (PDT)
Received: from [172.26.255.55] ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id f67-v6sm3720112wme.22.2018.10.29.03.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 03:20:22 -0700 (PDT)
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
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <1b3ba24e-0180-8472-199c-07aa56451e4a@rasmusvillemoes.dk>
Date:   Mon, 29 Oct 2018 11:20:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANiq72kEdD3hoHaxukkdzEJt+e_nptyO1GdgfUqWnSAog3k=JQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-27 14:06, Miguel Ojeda wrote:
> Hi Rasmus,
> 
> On Sat, Oct 27, 2018 at 1:24 AM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> +/*
>> + * Optional
> 
> I did quick check and gcc >= 4.1, clang >= 3.0, icc >= 13 compilers
> seem to support it (or at least recognize it, even if they just ignore
> it), so we do not need to make it optional, no? Did I miss some case?

No idea. I think I didn't really know what was meant by
required/optional. E.g. something like __aligned must be supported and
honoured for correctness, while format_arg is just about getting some
diagnostics, and assume_aligned just allows for certain optimizations,
so it doesn't really matter whether every single compiler understands
them. It does seem that both icc and clang understand format_arg and
issues warnings when the template doesn't match the varargs, so in that
sense we can make it "required", though it seems a little backwards to
define required in terms of what the current range of compilers support.

Rasmus
