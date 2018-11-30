Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02C2C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7EE20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QtErVXrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7EE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeLAGGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:06:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41293 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLAGGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:06:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id z80-v6so5885185ljb.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tW1KeOB3WCHKglRDPCIJKwaSB9KGRIdhKOnPdm5dFGs=;
        b=QtErVXrZU4f4gp6ENPlO0lpq+B/LSnW4qHlhtBfK6joBTTnxqNKTU6CqNluMgQjahH
         xVrFvtAE9gZyrRgs41eG7zgGknywFf/yEJLxxWdk1trYDZFLT/BSsyhUUts6+G0cGLkZ
         uzDVJ1CW8FPgRemPakWsaKCoQl1IVkFffL9S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tW1KeOB3WCHKglRDPCIJKwaSB9KGRIdhKOnPdm5dFGs=;
        b=qgnqkLLThuWLxhQBBpIIeOj6U1dZwJhblu9lv3D0RZkkeqY8QlEu24XuGXLRwWXEkU
         5Bkwgdv4W1Py5iP+0qsAKlpVIbs+4cymara+wyHXR2GdlxXn+bgZp72crE+lm6A62uP+
         OWk2GNHBe/ErciZge0/5xSbJgV5zmqlGtrKFajMpvYF9cHLAi+xMDn7wxvtJx1VQ0oXZ
         XXi4EPbZk7GZdEh3BRw1mcVoTnQ0NWnlvcZ8kG7LTfRbw67WrkZ1RaXN1R9snMAcPknf
         ey0mO8ypvtV80tYLIN+nDZgZevW2JXiXg3n/OZeriyIyzuK9kj2AASW6IajsOTc4UHX2
         eplw==
X-Gm-Message-State: AA+aEWYCrhjhWThpPwW7WrYjPKtWJ1hzG2j7Xgm6YPQkjdLxwABULUQ5
        mR2Xux+52ZpERew124rl/bp+3u5m4Sg=
X-Google-Smtp-Source: AFSGD/UPe3d4kTWzjLMyLGRQNd8M6Qc+8/rtq3Iuwi0YNI6jhHWhcnnDWEzYMlWaLrQpTm8BY62osg==
X-Received: by 2002:a2e:9f0b:: with SMTP id u11-v6mr4028949ljk.99.1543604184281;
        Fri, 30 Nov 2018 10:56:24 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id k3-v6sm921844lja.8.2018.11.30.10.56.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 10:56:23 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id e26so4880448lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:56:22 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr4505052lfa.135.1543604182216;
 Fri, 30 Nov 2018 10:56:22 -0800 (PST)
MIME-Version: 1.0
References: <20181130031829.268422593@goodmis.org> <CAHk-=wgVQNNB6XhJQMwyQdc1B5Qh3nMXhixK5uzbdeOOnwOmdw@mail.gmail.com>
In-Reply-To: <CAHk-=wgVQNNB6XhJQMwyQdc1B5Qh3nMXhixK5uzbdeOOnwOmdw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Nov 2018 10:56:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJErbyjbAy=cFHUcT7STP7taGtTBX5sfAgkTX6Yq6Skg@mail.gmail.com>
Message-ID: <CAHk-=wgJErbyjbAy=cFHUcT7STP7taGtTBX5sfAgkTX6Yq6Skg@mail.gmail.com>
Subject: Re: [PATCH 0/2] [GIT PULL] tracing: More fixes for 4.20
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 9:41 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I went back and merged things [..]

Note that I did this as two merges, even if one would have done (since
the second pull request was just adding new commits on top of the
first).

This way I got the matching diffstat from your pull requests, but more
importantly also the independent merge messages.

The history looks slightly odd this way (with two adjacent merges of
continuous history), but I thought I'd explain the reason.

                   Linus
