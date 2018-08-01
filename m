Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413AFC46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99B7208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJmCFHyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99B7208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405572AbeHATkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:40:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39700 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405537AbeHATkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:40:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so8229422pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0yg9XFy5qhhUk0IDg1bCJxgjXEmfdIfGOMi25KRZiS4=;
        b=BJmCFHyAwqmRQAbmc8vEVB9SrH4Wiei873HAMVo4ZS5q7AydSM8q1DnzZoPS6c6uWA
         ZqI6CHO0/QMpjFRpbhu1ge9OCOTcJX5BfIF89aeN0wFLYTfBduwWZuTbQdLU8zUew5bD
         3cssIqboxnLUJJK+QIKURqbcDZLbYDDk0LQoZv4DryTlHvXkA1sMYWewe5gLKtELIV9G
         d7AdnCRwLI2b9ObJTyxZQ/6nipIqhuuvNA37G+VW+srO/23e+iXqJn18z91CQKTa5wVd
         w3yGRJH1QgKBxZpstFug/4bV1SNEDwb39SIrIxUrymUowC1bScNigukR6R4911wQaoSX
         PNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0yg9XFy5qhhUk0IDg1bCJxgjXEmfdIfGOMi25KRZiS4=;
        b=tZmdwvCFDHh5Rxf6JfSiVuA07YYpJnG1zdNqmmjUgAj4QAi4eXSwo1L+dRe1/Zx0CM
         PWTAEhcPULivde3w1cooySUxv1HU2OpOTw/whtub935Ev0ZBj63/sWsEsd9v2LE3Fujm
         UbreQJ/0yrBqDbY10AfJJIYSYu+/ockzlz11zE2B0CB978ifpPX+NmoJC33LSWr+pzY7
         KMms4FE0BGiabN/b/t26t85x+Skk2zGsCix0GYqc+HaefyJJtJfeg7xu3DHr266Y+oiO
         ZbyJL9yIFVS4qWDs5H7j9hDsDoDH5wuf2/k2wP9FIuYUQUZdI29d7V7KsZXeeYElsAk6
         oGmQ==
X-Gm-Message-State: AOUpUlHsnOPL/p88Vg3eE/xRQKa8RiISuVxyVYh9ReVDONH6NqSvjdA+
        kax1rrMWvZEin0ZKxZLftSdUJNZq5Zpb/hrR0zrHrQ==
X-Google-Smtp-Source: AAOMgpdYyI0OXiYjFSrhFngdKFL0WiKedUUDIl5Bd+Wv9ko+cLfyxkMa09Gsb+2t3YUvPG/rpEuzBCFdeAN7lv2sj10=
X-Received: by 2002:a63:743:: with SMTP id 64-v6mr26056249pgh.216.1533142067634;
 Wed, 01 Aug 2018 09:47:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Wed, 1 Aug 2018 09:47:26
 -0700 (PDT)
In-Reply-To: <bf435a04-b689-ec5a-f5df-f47807b43316@gmail.com>
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
 <30ee6c72-dc90-275a-8e23-54221f393cb0@virtuozzo.com> <c03fd1ca-0169-4492-7d6f-2df7a91bff5e@gmail.com>
 <CACT4Y+bLbDunoz+0qB=atbQXJ9Gu3N6+UXPwNnqMbq5RyZu1mQ@mail.gmail.com>
 <cf751136-c459-853a-0210-abf16f54ad17@gmail.com> <CACT4Y+b6aCHMTQD21fSf2AMZoH5g8p-FuCVHviMLF00uFV+zGg@mail.gmail.com>
 <01000164f60f3f12-b1253c6e-ee57-49fc-aed8-0944ab4fd7a2-000000@email.amazonses.com>
 <CANn89i+KtwtLvSw1c=Ux8okKP+XyMxzYbuKhYb2qhYeMw=NTzg@mail.gmail.com>
 <01000164f64bd525-be13e04f-18a9-4f7f-a44b-0c0fcec33b71-000000@email.amazonses.com>
 <bf435a04-b689-ec5a-f5df-f47807b43316@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Aug 2018 18:47:26 +0200
Message-ID: <CACT4Y+akncPCAZ2pUX3xEpUPELQAei1XzYByB8Dohfz-Ve0k5w@mail.gmail.com>
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Christopher Lameter <cl@linux.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org, netdev <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 6:25 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On 08/01/2018 09:22 AM, Christopher Lameter wrote:
>> On Wed, 1 Aug 2018, Eric Dumazet wrote:
>>
>>> The idea of having a ctor() would only be a win if all the fields that
>>> can be initialized in the ctor are contiguous and fill an integral
>>> number of cache lines.
>>
>> Ok. Its reducing code size and makes the object status more consistent.
>> Isn't that enough?
>>
>
> Prove it ;)
>
> I yet have to seen actual numbers.

Proving with numbers is required for a claimed performance improvement
at the cost of code degradation/increase. For a win-win change there
is really nothing to prove.
