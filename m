Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C1AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249BD2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZP+CoFLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249BD2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbeJaE0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:26:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51932 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeJaE0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:26:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id w7-v6so1908660wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UxxBfovwvy+MnmVApVKLnMfUZJTGrFZeukHnYtlf49g=;
        b=ZP+CoFLV/7AkneiLvmxO6UQn6Uvz8WwrH31esF7snZiDS+TCO1bE6k/qhhjfZQQiTp
         u0j0UZqhal+TmL8wmPWVDjJ8xMvLj5LbUAhooEk6jeGjrZrfmpe1sjx4UjuBLZBeEFME
         Gq0Z8u1VpUfWGD9NRILBksUCXanXnEN/Bn9Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UxxBfovwvy+MnmVApVKLnMfUZJTGrFZeukHnYtlf49g=;
        b=lpAq0kiWyKM+sM620OI21oOIRncRWOj+AguVM8GkJpiJ65WuGjjU/oipW5AH7JKZjS
         y7SqVquo0ZhIeMXiaXOfYoV8iy3S0yx/KHxZuHnOQadhhY0HUU2u91LeJhTCMPc76K17
         BozK4D+vVwT0nFtXprMpAf8VH1VL561U6Rjnj/cyaqEW8bM9zXmjqrwQoLvLsG/79vEp
         jh20EfBpVtH2n5EfTY9ag9wnCkWsORugTJJwSFX8AVvYKCkurdlY/bcnaUE525blGSF+
         F+qoMuMokIHx9Pbv+wS3yKK2Q4EUhPd7hT50IGMnc3h4jkhhhbqZNIrFNEXDSppMrizU
         wJUw==
X-Gm-Message-State: AGRZ1gLRESqymOkXOWq2GPhRLNTSlz0zde3aCub7pOb5WpLPMAqKkda/
        mEdqOkrR8InXRgD5ydQs1E0d+lNoiRrHtZvgGWt2jA==
X-Google-Smtp-Source: AJdET5fYSnNcoHTEz6uV3emWeL6MxHJfZr7O99kPI3YL4/oyVQTjpDbCnjvzAu0dncxv87TUoUL3LJ1ae/uiBxz4jZg=
X-Received: by 2002:a1c:8c8c:: with SMTP id o134-v6mr17296wmd.35.1540927880356;
 Tue, 30 Oct 2018 12:31:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9f03:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 12:31:19
 -0700 (PDT)
In-Reply-To: <CAHp75Vd7XpPgx+RuOon6HD0U7LcKrqJLgukEk0wfYFrii=2DJg@mail.gmail.com>
References: <20181029200920.28901-1-semen.protsenko@linaro.org> <CAHp75Vd7XpPgx+RuOon6HD0U7LcKrqJLgukEk0wfYFrii=2DJg@mail.gmail.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Tue, 30 Oct 2018 21:31:19 +0200
Message-ID: <CAKaJLVvEram7BLCi_4EcXcBTdDFdwDrLfrihtq2i7z4Ya9NKUA@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/SRCU: Fix ctags
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:11 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Oct 29, 2018 at 10:09 PM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
>>
>> ctags indexing ("make tags" command) throws this warning:
>>
>>     ctags: Warning: include/linux/notifier.h:125:
>>     null expansion of name pattern "\1"
>>
>> This is the result of DEFINE_PER_CPU() macro exapansion. Fix that by
>> getting rid of line break.
>>
>> Similar fix was already done in commit 25528213fe9f ("tags: Fix
>> DEFINE_PER_CPU expansions"), but this one probably wasn't noticed.
>
> Why not to add Fixes tag here as well?
>

Will do, thanks, Andy!

>>
>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>> ---
>>  include/linux/notifier.h | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/linux/notifier.h b/include/linux/notifier.h
>> index f35c7bf76143..0096a05395e3 100644
>> --- a/include/linux/notifier.h
>> +++ b/include/linux/notifier.h
>> @@ -122,8 +122,7 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
>>
>>  #ifdef CONFIG_TREE_SRCU
>>  #define _SRCU_NOTIFIER_HEAD(name, mod)                         \
>> -       static DEFINE_PER_CPU(struct srcu_data,                 \
>> -                       name##_head_srcu_data);                 \
>> +       static DEFINE_PER_CPU(struct srcu_data, name##_head_srcu_data); \
>>         mod struct srcu_notifier_head name =                    \
>>                         SRCU_NOTIFIER_INIT(name, name##_head_srcu_data)
>>
>> --
>> 2.19.1
>>
>
>
> --
> With Best Regards,
> Andy Shevchenko
