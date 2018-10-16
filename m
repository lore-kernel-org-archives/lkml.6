Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215F1C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81482148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YRf3d2BS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81482148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbeJQGeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:34:01 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41281 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJQGeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:34:01 -0400
Received: by mail-yw1-f67.google.com with SMTP id 135-v6so9580455ywo.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T8CxYADkKTTOTmBYbAGVXU1YKmiIKH184LC05Mu8yIg=;
        b=YRf3d2BSY22FPSAxkOZg6jB+Zb8udoszkat49lrZ2OB8CJeP/SiiNxIuFzvoIfSRsz
         jbD3/WZLGked3th3bCiwOhYZSK5lzbuJeoflbgXxzr/XjfXNs8ylFpa64P24q5HMR2EQ
         4QXkIAgjXmUVORViwCA5FfguW9jvRbhsWWVXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T8CxYADkKTTOTmBYbAGVXU1YKmiIKH184LC05Mu8yIg=;
        b=rfnJCwFcuOikqkZ8lsNtL9Q3HsjQitOek1iwSMCUgpRYiqDXhJH+COL8GDfk3d9y08
         hvx8mDoqjpCxo+mUTDBN11kNW5PDYzlVhsbhUMBD9zEfg7463Xw+uwFqPoYO0PsRl+Hm
         wJOFXCAKKRHD+E9CX1uAK1WdUoOKPa14jSzHAl2NRJyzLaZi+NFSCopPVhAmJX238APq
         3SlkKFZYHrQhLSotungR3rC5Gp6/yV0dEdlTD0RL8LDtOX9xufcOqG51BkYk9v87ff3W
         f2fUIlCjIvwxgZS31sT5BQvtB9ucSLRIVUsK6Ol0Q+NYsLWxENDjaoLO/DuwCaFNOQ1E
         3P9w==
X-Gm-Message-State: ABuFfog4z3L+3nK3B0Oa56e5Ih12AcudFmt132z9p8kUJdjFw1WbSg1J
        YI199KxLGDf8Fwqkvp7v4Ts0pebNs40=
X-Google-Smtp-Source: ACcGV63UdQ3PBafrEqxWaK/FZAzNj7tN8xrkrtT09liIwVvsOY3UkW0/8gzNyQXyAAP5oVpdWUDj2Q==
X-Received: by 2002:a81:85c6:: with SMTP id v189-v6mr13554779ywf.295.1539729686865;
        Tue, 16 Oct 2018 15:41:26 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id g14-v6sm3756725ywk.94.2018.10.16.15.41.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 15:41:25 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id l79-v6so9587114ywc.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:41:25 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr12756806ywg.47.1539729685069;
 Tue, 16 Oct 2018 15:41:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Tue, 16 Oct 2018 15:41:24
 -0700 (PDT)
In-Reply-To: <CAGXu5j+rLGyGCozaSMqFV0p+cHoJFmJBXWXHz5WfYEaDkHJdGw@mail.gmail.com>
References: <20181013115646.GA3516@embeddedor.com> <CAGXu5j+rLGyGCozaSMqFV0p+cHoJFmJBXWXHz5WfYEaDkHJdGw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Oct 2018 15:41:24 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+Bv5LMBJw_W0w5VHk-zWNzWb=1cev0G+TrX_65YPy1XA@mail.gmail.com>
Message-ID: <CAGXu5j+Bv5LMBJw_W0w5VHk-zWNzWb=1cev0G+TrX_65YPy1XA@mail.gmail.com>
Subject: Re: [PATCH] skbuff: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 2:30 PM, Kees Cook <keescook@chromium.org> wrote:
> On Sat, Oct 13, 2018 at 4:56 AM, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Acked-by: Kees Cook <keescook@chromium.org>

Actually, since this is skbuff, can you resend this to netdev instead?
Andrew took the other two, but this one seems like it should go via
David Miller.

Thanks!

-Kees

>
> -Kees
>
>> ---
>>  include/linux/skbuff.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>> index 119d092..92ec346 100644
>> --- a/include/linux/skbuff.h
>> +++ b/include/linux/skbuff.h
>> @@ -3505,13 +3505,19 @@ static inline bool __skb_metadata_differs(const struct sk_buff *skb_a,
>>  #define __it(x, op) (x -= sizeof(u##op))
>>  #define __it_diff(a, b, op) (*(u##op *)__it(a, op)) ^ (*(u##op *)__it(b, op))
>>         case 32: diffs |= __it_diff(a, b, 64);
>> +               /* fall through */
>>         case 24: diffs |= __it_diff(a, b, 64);
>> +               /* fall through */
>>         case 16: diffs |= __it_diff(a, b, 64);
>> +               /* fall through */
>>         case  8: diffs |= __it_diff(a, b, 64);
>>                 break;
>>         case 28: diffs |= __it_diff(a, b, 64);
>> +               /* fall through */
>>         case 20: diffs |= __it_diff(a, b, 64);
>> +               /* fall through */
>>         case 12: diffs |= __it_diff(a, b, 64);
>> +               /* fall through */
>>         case  4: diffs |= __it_diff(a, b, 32);
>>                 break;
>>         }
>> --
>> 2.7.4
>>
>
>
>
> --
> Kees Cook
> Pixel Security



-- 
Kees Cook
Pixel Security
