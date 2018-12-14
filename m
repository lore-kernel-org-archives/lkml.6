Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEE8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581F120675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L0Vt38Vf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbeLNXCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:02:14 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40640 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbeLNXCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:02:14 -0500
Received: by mail-vs1-f65.google.com with SMTP id z3so4374146vsf.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 15:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ls7aozBV5PltLX4SJMOQ8ZWRffrHZSO3X5f7x+jd7fE=;
        b=L0Vt38VfRin/k1+oIgfpAa8RXKMBBU5PZs9j2m45TbBRLSKj47kAvRctKOoRnRE2Su
         8FVMzjBsTqvb+eosBXMdyF8imGC/CGZ5/RtTCXp31b1dkVr+3vWq4IeXD1uX9HSLh2sA
         NlJLCNpbjIh/OGEUWe4iFGaMG5Sw9fpndq11g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ls7aozBV5PltLX4SJMOQ8ZWRffrHZSO3X5f7x+jd7fE=;
        b=WytdmDczMfwY3SpMidh7eL5XNlPXzLsO7uLUrrBiPr2VXnu+Z2545xPgYYLEZNO9e/
         OdKlWpEYuy8pZp1sy3XjuU8pI9Z+UIObwSI8RTE/6M1DbYQJpwu1M8gtBIVOX2qd+IDk
         cDETGHavNG5+ZssWig48FFOKnCi8xUIECqAtS8Zm2VcZB3X5CFPjP2BdzEFZWP+t2w49
         gqmA6g4MYw0pN1UyGq+MhNigFTDLztcMANXjUuNWNzBmI8Q+mBbcRf1VMyibi6W5lqPF
         QDKUk5WkVXz5hFnm1qUXRIJBAa9qG2sTUWDuPxqOOPdySSWmH4IMGZr4c6rYZpHYxw/G
         FxtQ==
X-Gm-Message-State: AA+aEWZzJhPdHBDtWVJKrRdlmBzZjZ2XvjOIPvTkO2VR5+LKhxAuua1W
        z2k/fRL/oBaOI4eCt6UhJkLwElEJOFo=
X-Google-Smtp-Source: AFSGD/UKyIpdIU3LW+BmFxoY1aF1efgFPzUotGYJJf9gllZQp4jEr9CrDN9oqtSPwh9ZNfPmmxMNmA==
X-Received: by 2002:a67:d85:: with SMTP id 127mr2030888vsn.211.1544828532490;
        Fri, 14 Dec 2018 15:02:12 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id f88sm2314458vsa.7.2018.12.14.15.02.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 15:02:11 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id v205so4385822vsc.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 15:02:11 -0800 (PST)
X-Received: by 2002:a67:1505:: with SMTP id 5mr2069890vsv.20.1544828530333;
 Fri, 14 Dec 2018 15:02:10 -0800 (PST)
MIME-Version: 1.0
References: <20181015223910.197729-1-mka@chromium.org>
In-Reply-To: <20181015223910.197729-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 14 Dec 2018 15:01:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W78QXLzc3ptPZ8y8QA4PLfs--qgJOtDhQ8WW+mCGEqQA@mail.gmail.com>
Message-ID: <CAD=FV=W78QXLzc3ptPZ8y8QA4PLfs--qgJOtDhQ8WW+mCGEqQA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix locking in bt_accept_enqueue() for BH context
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        David Miller <davem@davemloft.net>, Dean_Jenkins@mentor.com,
        linux-bluetooth@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, khlebnikov@yandex-team.ru,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Dmitry Grinberg <dmitrygr@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 15, 2018 at 3:39 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> With commit e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket
> atomically") lock_sock[_nested]() is used to acquire the socket lock
> before manipulating the socket. lock_sock[_nested]() may block, which
> is problematic since bt_accept_enqueue() can be called in bottom half
> context (e.g. from rfcomm_connect_ind()).
>
> The socket API provides bh_lock_sock[_nested]() to acquire the socket
> lock in bottom half context. Check the context in bt_accept_enqueue()
> and use the appropriate locking mechanism for the context.

I wonder if it would help to put the stack crawl in the commit message
too?  I think this is what the BUG was reporting (though the stack
seems a bet shorter than I'd expect due to compiler inlining)

  __might_sleep+0x4c/0x80
  lock_sock_nested+0x24/0x58
  bt_accept_enqueue+0x48/0xd4 [bluetooth]
  rfcomm_connect_ind+0x190/0x218 [rfcomm]
  rfcomm_run+0xe3c/0x163c [rfcomm]


> Fixes: e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket atomically")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Not sure if this is the correct solution, it's certainly not elegant and
> checkpatch.pl complains that in_atomic() shouldn't be used outside of
> core kernel code. I'm open to other suggestions :)

I'm a total noob when it comes to Bluetooth, so I guess I'll try to
understand the callchains here.  As far as I can tell there are only 3
calls to bt_accept_enqueue, right?  I guess we can look at each of
them:

--

1. net/bluetooth/l2cap_sock.c:

Parent is locked with lock_sock().

--

2. net/bluetooth/rfcomm/sock.c:

Parent is locked with bh_lock_sock().  This is the case you were seeing.

--

3. net/bluetooth/sco.c

sco_conn_ready() => __sco_chan_add => bt_accept_enqueue()

...parent is locked with bh_lock_sock().

sco_connect() => sco_chan_add() => __sco_chan_add

...parent is NULL so we actually never call bt_accept_enqueue() in
this callchain.

So the net result is that the parent is locked with bh_lock_sock().

--

From looking at the above I guess it's pretty simple--if our parent
was locked with bh_lock_sock() then the child should be locked with
bh_lock_sock_nested().  If the parent was locked with lock_sock() then
the child should be locked with lock_sock_nested().

I wonder if a less controversial solution here (and one that wouldn't
upset checkpatch) is to just add a parameter to bt_accept_enqueue()
like "bh".  Then you'd pass true for "bh" in
"net/bluetooth/rfcomm/sock.c" and "net/bluetooth/sco.c" and false from
"net/bluetooth/l2cap_sock.c"

--

In any case the problem seems serious enough that I'd propose a Revert
of commit e16337622016 ("Bluetooth: Handle bt_accept_enqueue() socket
atomically") unless we can come up with an acceptable solution.


-Doug
