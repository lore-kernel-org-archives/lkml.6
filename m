Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F93ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AEF20869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MMCPgfMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34AEF20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbeKESwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:52:38 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46426 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeKESwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:52:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id x3-v6so7315114lji.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 01:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pm1RTPOzioeE8bB1/Pbs5+adQExShL3xEi+Kc1X/0GA=;
        b=MMCPgfMKOSfckZQhscqMLAqjVboBO4Fg59bvBBr1YT4N/cViI2YQKFJdEOlpaKC7hB
         85ECpfzSv8+P281Z660Z8JjwBFFa1AR1L1bCy7AZ9HOeTKUlqHE0GrjSgVsu8QgR4RFg
         CugBL6g+WBkDBrn1f5hD4Lpzab6rYzmrkqmPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pm1RTPOzioeE8bB1/Pbs5+adQExShL3xEi+Kc1X/0GA=;
        b=I9B+E0cT/zdpcLNc+9ZWnewc7qHJ2O5WQuCmVUsimm8ocne5AHYaaFNJFyh+hBvvWf
         jjgqtc+Gz1nzYeAKj3RbBGBU5kknFQ6GktedLvsvw3mqu7g9LLSpbR8unVQ7W0F2yf1B
         OJ+ISXrhLwn257MThKk8RTCPR++tM+oZVHG8HJsRPGS1nQuMmz6MgEYV2vflDkh2Lq/E
         Tt30ZRNbsm/xIu3kD7uiZc/pTMGtrqpDOVN8O87wrqBPbDDhuKr/+SarWii6XXGCvPXi
         1tmUu8pOmjLRTJ0kTjvBfhpg6BeZTuZXfwFwvqBfhyaX0M39w3rO0wAwyxTE8ButwfUY
         Svlw==
X-Gm-Message-State: AGRZ1gKBJVNclnbKFUhh6vamTBcAOlZzjFe5a/Rk9H46d1EgbbAy1BtK
        bo+JgT/Y/dlnsllVk0slilxJJmyccNAeZw==
X-Google-Smtp-Source: AJdET5cLsoSiyBNlCHFRGTIARrnWK+YsIj8J+oTRwhb5QlXhx50SMoIIGlQPpud9Rier4m3OEjEAZw==
X-Received: by 2002:a2e:8187:: with SMTP id e7-v6mr11291262ljg.50.1541410426702;
        Mon, 05 Nov 2018 01:33:46 -0800 (PST)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id b22sm5629992lfg.32.2018.11.05.01.33.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 01:33:46 -0800 (PST)
Subject: Re: [RFC PATCH 0/7] runtime format string checking
To:     Kees Cook <keescook@chromium.org>
References: <20171108223020.24487-1-linux@rasmusvillemoes.dk>
 <20181026232409.16100-1-linux@rasmusvillemoes.dk>
 <CAGXu5j+eGQ3oo_1qSwW-BEVSK=vcLmNLWH8E7fPiawobo=_fbQ@mail.gmail.com>
 <63e10688-5207-e8a4-dac2-d6c6094fbcc2@rasmusvillemoes.dk>
 <CAGXu5jL6RCL=WvCBJQytw=KnN74dp=1gd5wO-fO3i8tjAT=pvw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <2129af7f-9d01-32f5-771e-c1d4b52bbfad@rasmusvillemoes.dk>
Date:   Mon, 5 Nov 2018 10:33:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jL6RCL=WvCBJQytw=KnN74dp=1gd5wO-fO3i8tjAT=pvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-01 23:57, Kees Cook wrote:

>> Yes, gcc should be able to infer the constness of drv from the fact that
>> it's never assigned to elsewhere in the function... I think I saw that
>> on some gcc todo list at some point.
> 
> If you find that bug, I'll add it to my gcc bug tracking list. :P

I looked into doing it myself (just for the format checking case, not
for variables in general), but gave up after a few hours. So I created
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87879 . I tried adding you
to the cc list, but it seems you don't have a gcc bugzilla account (?).

Looking more into this, as you can see above, it's actually a little
worse than "false positive" -Wformat-nonliteral - see the f2() case.

[At https://godbolt.org/z/KC4ZRK I also included the const char[] case,
which works as the const char* const case wrt. format checking, but for
some reason gcc open-codes the strlen(). But that's a separate issue,
and not one we should care about, since the const char[] thing is wrong
regardless due to the bade code gen]

Rasmus
