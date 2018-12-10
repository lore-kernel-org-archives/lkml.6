Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE35BC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920DF2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IWjAp9oH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920DF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbeLJRqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:46:33 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:45795 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeLJRqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:46:33 -0500
Received: by mail-lj1-f171.google.com with SMTP id s5-v6so10394782ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JDuuTr+LXh/Myy+W8qv1OQO8tLlRL2ZsrFWEn4snus4=;
        b=IWjAp9oHQRtC+4Ozvey8Xf1TeYaEcfaT6cs0EP8fCbF3weHF1EK6fae+ArKOBrhfOr
         YjPuRtcGz9i4T+THU+YPzKkx6Ku/gl90gh9VGBb8gaGWUoZoktPxuSpyE3oWLhCPkg+1
         K7GzhjnYP0mS8NEF3ANKqQXF+sTgZHARNyb0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JDuuTr+LXh/Myy+W8qv1OQO8tLlRL2ZsrFWEn4snus4=;
        b=KkIEH6MCGjkO3btY/+O/mhTLQ5U/QEr8NcCJ3nfXDTdWAEjICsItUofyFxJa7LhWSn
         blDdFSI2mUxsfR4+QTV1shpKU9YiSmTJi4+wFe53j3ACKzyHTmJTV/GNa35bUeFe3zmZ
         wai0YdpjsnkgzU3wsGr97bhdugylmnT2eIXRYyPFUtupx+zHGE16LEBIXlSl0VIKZV85
         3njS5t1hEKPhISqTaMbXNmChwLkxMwhlOYiHTygdWAgSFwZjkmh4Wnj/OG0gysXw3gWX
         5AarI5+kIla/OpdQY+SFx4GD4vaSchPVHfG0CG0N9lINm7FmxuhlDVBkbvDDxniQftt+
         Pjzg==
X-Gm-Message-State: AA+aEWY8RcDIJvSxZNKLP2TGKFMxyUS5z+CqwN5GvtlcAVUliT+o4uZ/
        qO74MzgdqFY9ODJ7VeWZ1/FnP4/nifE=
X-Google-Smtp-Source: AFSGD/W/1CAZtAkf99byOP2uvfzVJkfUNQsFjzHyEpu2TLnmL5A3yaIcOncB430KPtsfM7tlzyXTOg==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr7779223ljb.176.1544463990718;
        Mon, 10 Dec 2018 09:46:30 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id n8-v6sm2451351lji.90.2018.12.10.09.46.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:46:29 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id n18-v6so10437459lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:46:29 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr8922272ljk.80.1544463988959;
 Mon, 10 Dec 2018 09:46:28 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgHSX8x6mOB0xZibbg-xc3veqsQEnHZ1+3H2DbO5MU5Rw@mail.gmail.com>
 <CAHp75Vf6Au7yY4zdn5=qMjMvDKCi-LVAW45sjzB5f0C+m3VYHw@mail.gmail.com>
In-Reply-To: <CAHp75Vf6Au7yY4zdn5=qMjMvDKCi-LVAW45sjzB5f0C+m3VYHw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Dec 2018 09:46:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgO2U0rGtLf-3Ym6dUKgavhNPZxHP7Gg8LuG8GgFaxKFA@mail.gmail.com>
Message-ID: <CAHk-=wgO2U0rGtLf-3Ym6dUKgavhNPZxHP7Gg8LuG8GgFaxKFA@mail.gmail.com>
Subject: Re: Linux 4.20-rc6
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 1:52 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Linus, due to my vacation schedule and possibility that Darren might
> be also busy with some stuff, would be okay to send PR this week, for
> example?

Oh, absolutely.

And I want to make it clear that this is not something you ever need
to even ask about, or make some "special case". It is absolutely
always true that any submaintainer can send pull requests for the next
merge window early.

To avoid any confusion, I do ask for a couple of simple things if you
send a pull request before the merge window opens:

 - make it very clear and _explicit_ in the pull request that this is
for the next merge window.

   In other words, don't make me unnecessarily upset about "this is
much too late in the rc series to send something this big" by making
it a small note at the end.

   This could still be something lik [GIT PULL] in the subject line,
but on the very first line say "For the next merge window" or
something. Don't make it subtle or something I might not notice before
I start getting upset at how big a pull request you're sending me
during rc6+.

 - don't use it as an excuse to send two or more bigger merge window
pulls. An early pull is not an excuse to then have a second big pull
with other changes.

   Second (and third) pulls are obviously fine, but they should either
be starting the calming-down period, or be about other things entirely
(some groups send 5-10 pull requests that are independent).

   I don't want to get the feeling that there is a "this is partial
work, there will be more" pattern.

Anyway, people have done this in the past, and I don't mind it at all.
Send pull requests early if they are all done and ready.

You don't even need to have a vacation excuse, you can just say "I'm
done, this is already in linux-next and it's passed testing etc, it's
not some unbaked thing that I just want to get rid of early"

                  Linus
