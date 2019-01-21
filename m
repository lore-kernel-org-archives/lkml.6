Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF384C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEFC20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GIlNGDnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfAUHZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:25:00 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:43079 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbfAUHZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:25:00 -0500
Received: by mail-lf1-f47.google.com with SMTP id u18so14693349lff.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uQDXfJo7O5/gGYsKedHfd/nh8URHDQGpNW0T5zwmORk=;
        b=GIlNGDnwwUVWobI/4+XIOJWuys3rT2e4nwv6+epSQbLR6ou/krTEHjcLw1yBQxOTTY
         IL3bEexmAlXVEGQciXJ9/uvKwx6asT3RK7SXsljF9HomNvcFTOTE3OwFbIQtbpeciiAI
         zsbyI7BiXGP1+SD75edqoCS38WUX9hyeaqXCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uQDXfJo7O5/gGYsKedHfd/nh8URHDQGpNW0T5zwmORk=;
        b=esPdQv4ct0m7+u8Kp21nSuB7DfS1CwyNwJTp0EDQdS6gCwv3hCb6RRwgjwFkU3CS/V
         j9FaPBpfo8CdetIZDyYX5FK5bnzpH5lyZ3ndn0PYmZadfsh7cSKeTFJFmFuC9XgIelVn
         eSo/z209CPmwG6FPJDV3iLgPavAhJByDCx8QLNTFIX1e8jbDUi/5qPufvWBRmi97Q/xS
         Dft53Iln3Ebu0SGUvya8KmS5OWGAq2J/rkYOjZWQ1nVj6frnDsGsshviGlGJgncCbA33
         agLhkTxytzuN3Xu7HnBqT/XziQ63TxUKzjaNxBh+xmpwlpbBvQ0nTJJ0f4hxE6hdk8gF
         uSlw==
X-Gm-Message-State: AJcUukckBY0MWP4yW4lID4dt/Q4+Z+v4XAJEquOtXocDzhCtL7nNtN9w
        8GoQAPZOHtoiYBFAdazLZJVRR4V0WNkBSA==
X-Google-Smtp-Source: ALg8bN7J7vKimaT/u5wIaPmmmpViEexj2oipDhJF/GLG65/lyByhh9vX03n44RCGA/+adhwUo3J9uA==
X-Received: by 2002:a19:280f:: with SMTP id o15mr16591330lfo.0.1548030051585;
        Sun, 20 Jan 2019 16:20:51 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id v19sm1959214lfe.69.2019.01.20.16.20.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jan 2019 16:20:50 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id e26so14239321lfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 16:20:50 -0800 (PST)
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr17728493lfg.117.1548030049631;
 Sun, 20 Jan 2019 16:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20190119151450.26879-1-Florian.LaRoche@googlemail.com>
In-Reply-To: <20190119151450.26879-1-Florian.LaRoche@googlemail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Jan 2019 13:20:33 +1300
X-Gmail-Original-Message-ID: <CAHk-=wjruxUdKWjn-PvZMOPn3pGO5yTcbc_J4hc4TrS0P15vaw@mail.gmail.com>
Message-ID: <CAHk-=wjruxUdKWjn-PvZMOPn3pGO5yTcbc_J4hc4TrS0P15vaw@mail.gmail.com>
Subject: Re: fix int_sqrt() for very large numbers
To:     Florian La Roche <florian.laroche@googlemail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Crt Mori <cmo@melexis.com>, Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 4:15 AM Florian La Roche
<florian.laroche@googlemail.com> wrote:
>
> @@ -52,7 +52,7 @@ u32 int_sqrt64(u64 x)
>         if (x <= ULONG_MAX)
>                 return int_sqrt((unsigned long) x);
>
> -       m = 1ULL << (fls64(x) & ~1ULL);
> +       m = 1ULL << ((fls64(x) - 1) & ~1ULL);

I've applied this part of the patch as commit fbfaf851902c ("fix
int_sqrt64() for very large numbers") with slightly edited commit
log.

I still think there are some oddities in here in the types. I
mentioned the caller that unnecessarily does the int_sqrt64() twice,
even though the outer one doesn't actually take a 64-bit value.

But in the very line above, there's another type oddity: the "& ~1ULL"
is entirely the wrong type. The shift *count* shouldn't be an unsigned
long long, so that type doesn't make much sense. It should be just a
~1, or even just "62".

But I didn't actually start micro-editing the patch, and just did that
one-liner off-by-one fix.

             Linus
