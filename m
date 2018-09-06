Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BC9C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CBD20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gHvdcBo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CBD20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbeIFEpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:45:45 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40318 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeIFEpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:45:45 -0400
Received: by mail-yw1-f67.google.com with SMTP id z143-v6so3389466ywa.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 17:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=24pYI4KddXJnrAcu6s0pb76+kLW85+ssqvzp2xeeESI=;
        b=gHvdcBo5VWqbBoKG1aDZRFdvL3zV+mHuWdANPt1IcU+DeNl19BwIf+tqL5oAC9WT+m
         BmVCv3tqPBH3nCvoT6TmDaIAUtxOnA3l08cHF/zA6IdH+w9ebusP0o1avwH5MpMAlwDK
         LV7y4NeaImbONd/GOa35KAVHk+gyd5wnHYyxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=24pYI4KddXJnrAcu6s0pb76+kLW85+ssqvzp2xeeESI=;
        b=R97YPJXHFZ3M/eJK1s0THcZg3meFd3uZFK1D7X8DvOsgqRlA8DKe67B9X/IqigSF1B
         e7X/DLJkA0b2PYgK4+e2OJvMZsJWJZr6OFpMh4qNpF6UKOhzi/+8J2g1VhFLhYO21i6x
         cjZWN61sXbpvO8zNB0UHu/R8OT1ffV2nHf+zuarborvPYEQbYlEBreSdzo72/oeJxCMk
         hQ4ARJVkP0m/X0e2zOCCbt/W9EXwOMGZQlG6u91Ue7jFdllOyNrDwrIxHDerCuBtNeSv
         n2KP/4fPEQ2RZlyKHbMEZ9sKKmNgHQdtessypGQ5OsLPrJsWzLY869dfdzafZ/J5Hhei
         Cmcg==
X-Gm-Message-State: APzg51AX7XKDKsQ6ZIb2TCHJ17Qt3h2dMtB3GbXpZyHameV+7QEK4BM/
        4/zEFfbbRVR2fuM1NpfSVPDRgXHFjfA=
X-Google-Smtp-Source: ANB0VdaSxDYtNYvw8gqk/7G9G7hMjJ0j5CA0HUquozC3TpgSjifv1SWR1ndVurwzNc7y38jEYK3c1g==
X-Received: by 2002:a81:b65f:: with SMTP id h31-v6mr96995ywk.144.1536192788104;
        Wed, 05 Sep 2018 17:13:08 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id n187-v6sm2492933ywn.76.2018.09.05.17.13.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 17:13:06 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id x83-v6so3398071ywd.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 17:13:06 -0700 (PDT)
X-Received: by 2002:a81:4418:: with SMTP id r24-v6mr76623ywa.407.1536192786105;
 Wed, 05 Sep 2018 17:13:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 17:13:05 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.21.1809061008210.23269@namei.org>
References: <20180905203443.32289-1-igor.stoppa@huawei.com>
 <CAGXu5j+e2n6pUW+40ZNm5qifd8dVEEryN-Qfqe7ok-KZHP1Hyw@mail.gmail.com>
 <2192189d-b8bb-3233-c9f3-14cbeeddaf34@gmail.com> <CAGXu5jKoKsj=qbKrcYGiQWJnSrLwfoBHL40RK37qZyLgXWk=DQ@mail.gmail.com>
 <alpine.LRH.2.21.1809061008210.23269@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 5 Sep 2018 17:13:05 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJKovNX9SMEPrawx=BqzkPHXay-WSfidQF830hqAGZ-eg@mail.gmail.com>
Message-ID: <CAGXu5jJKovNX9SMEPrawx=BqzkPHXay-WSfidQF830hqAGZ-eg@mail.gmail.com>
Subject: Re: [PATCH] seccomp: remove unnecessary unlikely()
To:     James Morris <jmorris@namei.org>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 5:08 PM, James Morris <jmorris@namei.org> wrote:
> On Wed, 5 Sep 2018, Kees Cook wrote:
>
>> On Wed, Sep 5, 2018 at 3:49 PM, Igor Stoppa <igor.stoppa@gmail.com> wrote:
>> >
>> >
>> > On 06/09/18 01:23, Kees Cook wrote:
>> >
>> >> Should I take this, or is it part of your series going somewhere else?
>> >
>> >
>> > It turned out it doesn't really work to have a generic series against 20
>> > trees :-/
>>
>> I know that pain very well!
>>
>> > I'm submitting them individually to each subsystem.
>> > So this one is just for security.
>>
>> Sounds good.
>>
>> James, can you take this directly, or would you prefer a pull request from me?
>
> I'll take it with your ack.

Already included! :) (This was a v2, split from a separate series, so
Igor already included my Ack from the other thread.)

But, for completeness:

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
