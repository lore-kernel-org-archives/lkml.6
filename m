Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A8AC282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 23:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E8720857
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 23:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3K0apwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfA0Xxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 18:53:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36400 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0Xxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 18:53:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so7173665pfc.3;
        Sun, 27 Jan 2019 15:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a8qdXhyWgTXnWPhZIODPClZCfoEAHYrzyBhZ6a3KE7g=;
        b=Y3K0apwS28qIk6OhXvQtQmEdHar2ZD3/tVdMbtTcvsEWL1wVFTLxwDuBwM0wOMXTMu
         q1tozQ2QCe4McztuyOgmDkAEwjplaaSnpUl7s9TBkAZbBkvqY8iBFEQT3cwtkvIsGPCQ
         K+bkKlr1rCqhfO5AesuBI7C6SFg2YbYo0ClaFFHhK2pNEbtJuL1CzaZCd7T3t0C9oLzv
         Esus130H2DYFXsA5sZV6ifX3c1o4aBpIUrlQaO69SoeoNgvvozk7Fr/EcD92lXlfuNH8
         07hpOACsc3t+s4Dz6a8NWi6vI57RxhyGXN4xezFWHh0FAHIV/nTpY+ejUWUOnG6SlxRv
         RlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a8qdXhyWgTXnWPhZIODPClZCfoEAHYrzyBhZ6a3KE7g=;
        b=b+MtfR2E/nnM8Hq07Dgy7L4e1n3L8NoSOR4jkYvigFXRopkM2GXwi4IeIa7h+MKG3m
         k5Fh2Z6BOXnlbMLxyzb5hwJZ5/UI1x/UteltEuGSRE6hDQuZp75MLPQcuiiMZV0LjpSZ
         HgDFtLn2iYzSr6FXgHnB1etb5TjjneqP1uBUnrbU3/02K9WyhtomfvSAlbstfwmFZZvt
         LBlJAgKyf/wWWEshecR0+FNFX5nUWv5S9ATifDl25BW1WoorOoLgH7BFbLEGqhGrLxW6
         axNdJrhfyyPj41BQ52d80m7Cwoa8VAYCz5IwvRS76f7vAkIH7Tl0/96KvjvN6mnO+cXt
         zRpA==
X-Gm-Message-State: AJcUukdSzqg+197HEuWoIVE3+ACDJma9rD7A8IRyQde2lxON/kaf91nC
        U9US+msRO/ttlZcqMhQfAFj5UIC7
X-Google-Smtp-Source: ALg8bN64XSA7MDEa+FQhLCb0UOIXs7r++JtwIkYdjDdgZZbjvTCiNTMEECoPGUoTW3WQCbHCFHcyVA==
X-Received: by 2002:a63:4c04:: with SMTP id z4mr17958042pga.312.1548633217245;
        Sun, 27 Jan 2019 15:53:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i184sm40256361pfc.41.2019.01.27.15.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:53:36 -0800 (PST)
Subject: Re: [PATCH] selftests/seccomp: Actually sleep for 1/10th second
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20190127094357.GA9436@beast>
 <CAKwvOdnUzTXSBPayebsy8pJGjJjPS3oi3qE8nRPtAhtv_PJ4xw@mail.gmail.com>
 <CAGXu5jKDdutht_+hVhKan6cNZ+bS7e0gom5yXmcMgKE9KuZwYg@mail.gmail.com>
 <CAKwvOdkvV+1qVUTz7G+nfftdzUfTGL+RnQ_8rA_RAhRrpvRLBA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e571e536-3c27-fb47-32d0-c9e72417f888@roeck-us.net>
Date:   Sun, 27 Jan 2019 15:53:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkvV+1qVUTz7G+nfftdzUfTGL+RnQ_8rA_RAhRrpvRLBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/19 11:36 AM, Nick Desaulniers wrote:
> On Sun, Jan 27, 2019 at 11:13 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Sun, Jan 27, 2019 at 11:25 PM Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>>>
>>> On Sun, Jan 27, 2019 at 1:44 AM Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>> Clang noticed that some none-zero sleep()s were actually using zero
>>>> anyway. This switches to nanosleep() to gain sub-second granularity.
>>>>
>>>> seccomp_bpf.c:2625:9: warning: implicit conversion from 'double' to
>>>>        'unsigned int' changes value from 0.1 to 0 [-Wliteral-conversion]
>>>>                  sleep(0.1);
>>>>                  ~~~~~ ^~~
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>> ---
>>>>   tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
>>>> index 067cb4607d6c..a9f278c13f13 100644
>>>> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
>>>> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
>>>> @@ -2569,6 +2569,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
>>>>   {
>>>>          long ret, sib;
>>>>          void *status;
>>>> +       struct timespec delay = { .tv_nsec = 100000000 };
>>>
>>> "Omitted fields are implicitly initialized the same as for objects
>>> that have static storage duration."
>>> https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
>>> https://godbolt.org/z/cuGqxM
>>> (So this wont sleep an arbitrary amount of seconds, phew)
>>
>> Yup. :) Even an empty initializer works ... = { };
>> (Except that padding bytes aren't always included in the zeroing...)
>>
>>>
>>>>
>>>>          ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
>>>>                  TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
>>>> @@ -2622,7 +2623,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
>>>>          EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
>>>>          /* Poll for actual task death. pthread_join doesn't guarantee it. */
>>>>          while (!kill(self->sibling[sib].system_tid, 0))
>>>> -               sleep(0.1);
>>>> +               nanosleep(&delay, NULL);
>>>>          /* Switch to the remaining sibling */
>>>>          sib = !sib;
>>>>
>>>> @@ -2647,7 +2648,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
>>>>          EXPECT_EQ(0, (long)status);
>>>>          /* Poll for actual task death. pthread_join doesn't guarantee it. */
>>>>          while (!kill(self->sibling[sib].system_tid, 0))
>>>> -               sleep(0.1);
>>>> +               nanosleep(&delay, NULL);
>>>
>>> Interesting bug.  If the sleeps weren't doing anything, are they even
>>> needed? Does adding the tests cause them to continue to pass, or start
>>> to fail?  If they weren't doing anything, and the tests were passing,
>>> maybe it's just better to remove them?
>>
>> It was just spinning.
> 
> So this test has been broken? If so, do you know for how long? Or
> who's monitoring them?  Either way, thanks for noticing and fixing.
> 
> +Guenter; did you notice if this test was failing? Are your boot tests
> running kselftests?
> 

No, I don't run kselftests at this time.

Guenter

>> This restores the intention of not being so
>> aggressive in the wait loop. While the sleep could be removed, that
>> wasn't the intention.
> 
> Oh, yeah I guess the comment above it about pthread_join is relevant.
> I just get highly highly suspicious whenever I see sleeps added to any
> code.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 

