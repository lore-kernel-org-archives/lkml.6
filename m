Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC014C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E24208DC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E24208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeH0M7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:59:18 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43510 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0M7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:59:18 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so26023248oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 02:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdyB5L5u+AgNWTGX8hrCvOghcobJpARjDStYBw7uhzI=;
        b=rUSzwk1jlU/4Khkr4/D9FvTumyZ8wE6oOLLp7mfjS9kDRcX9PBaXzW7qpnw6L/9Pzy
         tg778vJ7FYXaWWg4cl3Bov8s0cAXL6yemf64ueeBrX1Ol+nOUWK0IMk5+2i3ycDHdo07
         yd/17RjBbP0lSzKey+IdG4ZVyYuG7xkuoh09hVyw9wU4DwwacRRvscgHFyaOzBWzIZDY
         +URFHOXoYK+Hi/An71cV1dHwuyotH0Nu4WMmxBBiblsY4FkW/z6l1nKxFyXFot8wtn0e
         cnCAoVRxC7WqfRATTUZXWYmJHlNJIyW3HVahadsp1AzPws4fEwmuntC+LdQToEfSICA6
         WFLw==
X-Gm-Message-State: APzg51B/tLCB3kImDwHq8Yrcbt+5Zh7kh5aKXhxQW5XIah6f+DfYk5AE
        B9FV5GtZAK55ZeAWVl6UrsVYnDvQxhRY3e1zU4K4FQ==
X-Google-Smtp-Source: ANB0VdaxAJnh4HVyOQHJZCmNKVNkKXIevdor2oOi8An3LPXxr1y49H2jx9dq48oyZuubD7LqnI9tqnA/AToYSjeOaXE=
X-Received: by 2002:aca:7c2:: with SMTP id 185-v6mr11917504oih.31.1535361209229;
 Mon, 27 Aug 2018 02:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180824120001.20771-2-omosnace@redhat.com>
 <20180827075020.GL27091@localhost>
In-Reply-To: <20180827075020.GL27091@localhost>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 27 Aug 2018 11:13:17 +0200
Message-ID: <CAFqZXNvADB-E_fjEaQpUymSVvfP-vXQXtk3K+nJ9DqrScHL8bQ@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     Miroslav Lichvar <mlichvar@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 9:50 AM Miroslav Lichvar <mlichvar@redhat.com> wrote:
> On Fri, Aug 24, 2018 at 02:00:00PM +0200, Ondrej Mosnacek wrote:
> > This patch adds two auxiliary record types that will be used to annotate
> > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > been changed.
>
> It seems the "adjust" function intentionally logs also calls/modes
> that don't actually change anything. Can you please explain it a bit
> in the message?
>
> NTP/PTP daemons typically don't read the adjtimex values in a normal
> operation and overwrite them on each update, even if they don't
> change. If the audit function checked that oldval != newval, the
> number of messages would be reduced and it might be easier to follow.

We actually want to log any attempt to change a value, as even an
intention to set/change something could be a hint that the process is
trying to do something bad (see discussion at [1]). There are valid
arguments both for and against this choice, but we have to pick one in
the end... Anyway, I should explain the reasoning in the commit
message better, right now it just states the fact without explanation
(in the second patch), thank you for pointing my attention to it.

[1] https://www.redhat.com/archives/linux-audit/2018-July/msg00061.html

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
