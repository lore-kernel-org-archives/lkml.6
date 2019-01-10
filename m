Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2BFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2E8214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cQx/mxKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfAJMzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:55:05 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34453 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfAJMzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:55:05 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so15372878itd.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 04:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3THPlnqCfHqKQrDSd/etb5bV4/UayvSKLU77BgpSN0=;
        b=cQx/mxKURO9NPcAVDLTfFyMKKV5XioNUpDEaCCFwfyXHSz4ZeJ39ngdJ3ei4jLpulU
         uKp8qp/Ifz7Rc20XV8PPhvLugcH5nVSRnQ2c/rkrBzA7TAblrpBl3M8NDKXMKyYv0B6i
         kv8iCZTuXXdYzacA+7gnP0oSORCdjUm5/PQhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3THPlnqCfHqKQrDSd/etb5bV4/UayvSKLU77BgpSN0=;
        b=jJEb5byN48gTkv1G8mqLKlimo2ra32AdV87wkDtKvnAsTwPvSYCxqPKLFe4d6FsV8v
         mp6yw5igb6NGfauA/z2HylPDVcr9bdJbkjBG7A0QM1FlfBTkPuOUQHWLOlWp6STnrT9j
         1qgB8dH+fS9Gf7sEBDHDsQ+mm/RFmLx8ODlaNwxQrDgZVGeEsX5XTuZabYxZnebqp2/U
         DpMNFi266AptmmeTRGLmJoPYliSgSoiZQw8V/VaM5UZe7jAAU811tAvBQvjmV4Gk/Nw2
         fh1+CRXQzW6BdP2l7TvzUNv1IwRuW1ZCUWg6WcDHFM0kZZpv42qk5Ug56ByyDZx/qwqI
         5e5Q==
X-Gm-Message-State: AJcUukdJweSIptOCIa7iYlitEz1ASv5M/QSdBN608dWDvmmchqKMd6HY
        II8ekp5DmOFXHXypgXNoIp0pKQJkyMKbXW/Cx81qsUiTv4U=
X-Google-Smtp-Source: ALg8bN7j1mII0fZx8rHd4ljC0hECGocBdL5+h8bPHkwfR5CbgeM/3fGiCAutPJiei/xBZQUknUY7ETWuTarI/rOE9FM=
X-Received: by 2002:a24:7596:: with SMTP id y144mr7479744itc.68.1547124904306;
 Thu, 10 Jan 2019 04:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20190110101232.9398-1-o.rempel@pengutronix.de> <20190110101232.9398-4-o.rempel@pengutronix.de>
In-Reply-To: <20190110101232.9398-4-o.rempel@pengutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jan 2019 04:54:53 -0800
Message-ID: <CAADWXX_G7X6QkNuqnpMyr+MGP+nUhqPaifJrfC=m57mhJu2jdg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drivers/tty: increase priority for tty_buffer_worker
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 2:12 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> sched_priority = 1 is enough to dramatically reduce latency
> on have system load produced by tasks with default user space prio.

.. and is this perhaps a way for a user to then make the system spend
inordinate amounts of time in the tty layer, and hurting other people?
I'm thinking threads using pty's etc as a way to make the system
unresponsive.

We have *never* had good results with random priority modifications.
People used to do this for the X server, and it helped in very
specific cases, and hurt enormously in others.

Why would anybody use a tty interface with a l;oopback adapter and
care about latency?

I can kind of see why you want to do this from a theoretical point,
but from a *practical* point of view it seems pointless. Why not use
more appropriate models like networking or pipes etc. IOW, I think you
should describe what you *really* are doing much more.

"hackbench with a loopback serial adapter" really doesn't sound like
something that should worry a lot of people.

My gut feel is that if somebody still cares deeply about serial line
latency, they should look at trying to see if they can do some of the
work directly without the bounce to the workqueue. We use workqueues
for a reason, but it's possible that some of it could be avoided at
least in special cases... And yours sounds like a special case.

                Linus
