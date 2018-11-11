Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2DAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15109208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mrgd7zBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15109208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391345AbeKLI0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:26:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41784 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbeKLI0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:26:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id z80-v6so5935434ljb.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o37QHCT2bcmJcB1fPsCHs5bLPGlRQ1lGaYrsYwSVUGw=;
        b=Mrgd7zBnXQ9k7Bn8IEn6Y3oxFqAhYimBeZx1a6PzsEn+nCD9hcLGo0VVOrQaY3Vl0K
         AF2bTpw9PSnK3q+kDRUghDnkcj06ObrhjLVaUY1T81anoklWE6QVOH45rqQO6j6n8blr
         XfudqaC0L9KJJR4IqxcAS/QSbo2rGgOk247MQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o37QHCT2bcmJcB1fPsCHs5bLPGlRQ1lGaYrsYwSVUGw=;
        b=UrZkw/rFzS8tFbB+vBjqArFqFphJalaF4ePCI8+W3UXboljueeFn/qDaxJ7xL4WJh6
         vSHQrih4JQ2k5DwAddCHFWKYrBXvBLM/BlNXjjAATshIyMAFh2jz7pQJcU3RuZejZeHA
         6kcxtwxuGAiM/yK/YlqwwBWC4nkgY7SUFC/ASjW8wlZ+ApYHkNHLD9qcTMJWyFUhc3Tg
         892+iX8nY8RI65AsGOj/NGlwLtYAqUuSbKb7I5oPxV4pjHB7rrVsZm/MnjrgA5PRU3bP
         pJtmsNjOGWCFwsH5lHf60jeyXcIxfBdbPlI9stw3qA9WnGM1v9UaqvaI04KBXf89oJh4
         tVJQ==
X-Gm-Message-State: AGRZ1gKJHiN9O/yGQqzmFGqPal9EWpDlxqnrm2Vc2Q3sPMe/BdDr4/75
        +1ZzmHS3WKSWSWzMxqw7NMW0/nZcIWc=
X-Google-Smtp-Source: AJdET5fzpdGEA+73Epg0PHeSgvn/ZupQ3j/hljd02TEtH8HQai1vyoM9wvUM6sWuiob+uxqo9HnIJw==
X-Received: by 2002:a2e:b00a:: with SMTP id y10-v6mr10035378ljk.109.1541975791222;
        Sun, 11 Nov 2018 14:36:31 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id m10-v6sm2664105ljj.34.2018.11.11.14.36.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 14:36:30 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id f23so4841057lfc.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:36:29 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr10489051lfc.124.1541975789321;
 Sun, 11 Nov 2018 14:36:29 -0800 (PST)
MIME-Version: 1.0
References: <154192381794.5458.5498732290895334242.tglx@nanos.tec.linutronix.de>
 <154192381794.5458.16318183442023794568.tglx@nanos.tec.linutronix.de>
In-Reply-To: <154192381794.5458.16318183442023794568.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 11 Nov 2018 16:36:13 -0600
X-Gmail-Original-Message-ID: <CAHk-=wiv7ZKgcyAtpKGC8yYAWwtnD3f77_nMz72JQciDJ+JXsg@mail.gmail.com>
Message-ID: <CAHk-=wiv7ZKgcyAtpKGC8yYAWwtnD3f77_nMz72JQciDJ+JXsg@mail.gmail.com>
Subject: Re: [GIT pull] scheduler fixes for 4.20
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 2:11 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

Hmm. I get

   Already up to date.

with top commit being 993f0b0510da ("sched/topology: Fix off by one
bug") that I already merged earlier.

Did you forget to push out?

I did find the commits in the 'sched/urgent' branch, so I pulled that.

                Linus
