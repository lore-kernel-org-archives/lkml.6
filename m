Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB8AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770C42081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 14:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770C42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeLKOU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 09:20:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41025 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeLKOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 09:20:58 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so16502611qto.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 06:20:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/cGzShs0MKCyLX0xYAlyd+tbubontrbVeKPl+mGAjA=;
        b=mHrp7Gzk2hYW+CBndQzJ2PXizlr9LMb89LYVzOU8KFNLsa0ywHFqE5jWzyVgF0zvD1
         7c/dumgMwZn3fnSzfMyJEkXqUbHETkAADLuiZNld7YTyxQnnsr3i12lvbSPsRHv1RihC
         PyewCW9Yj7GX1CD4FcTPxFjQ5l3YhR50kN+p9wH4bfhZyKkvueUTxAkFFbViY/t6KATO
         cyw7NxNmSBXRl62niglbj691V13Fp9dfTTheNlfmPOcKtqoRk1N/kGIAyCJLK/Npwcc6
         efqnJuf7nJp2Hs6wr9z09LNA373rkgg/Zxa0RhEai9V6GCTcw//h7Pdzs2gymij/sfcA
         ox4w==
X-Gm-Message-State: AA+aEWa3/Xca2yqtbZqBfCM3hOZ6LLuehxl/VPo1eCg5ARNPsk1aj40t
        RIHyt/ROr0+Xu7jhEM+QEl9aEvqOkcz//tkcCzM=
X-Google-Smtp-Source: AFSGD/XHzQ+nokHT6zDYSTsCA4Z2JQFzwrdpuBY1CCak+KYsDIkkD5/DjcYYCDMUuctEbIlgdD3374Ug/JIsISTrQk4=
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr15752166qvr.115.1544538057011;
 Tue, 11 Dec 2018 06:20:57 -0800 (PST)
MIME-Version: 1.0
References: <20181210211231.4084251-1-arnd@arndb.de> <c0348f29fc1bcc73b3f67b740cd3c5c6ad34d07b.camel@suse.de>
In-Reply-To: <c0348f29fc1bcc73b3f67b740cd3c5c6ad34d07b.camel@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Dec 2018 15:20:38 +0100
Message-ID: <CAK8P3a1f0hJhZBbj6yf1ZZS3znDOSFK0e7KHveW95zjB1x=+tQ@mail.gmail.com>
Subject: Re: [PATCH] staging: vchiq: rework remove_event handling
To:     nsaenzjulienne@suse.de
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        gregkh <gregkh@linuxfoundation.org>, tn@fastmail.net,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 1:36 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
> On Mon, 2018-12-10 at 22:11 +0100, Arnd Bergmann wrote:

> > @@ -447,26 +444,26 @@ remote_event_wait(VCHIQ_STATE_T *state,
> > REMOTE_EVENT_T *event)
> >  }
> >
> >  static inline void
> > -remote_event_signal_local(VCHIQ_STATE_T *state, REMOTE_EVENT_T
> > *event)
> > +remote_event_signal_local(wait_queue_head_t *wq, REMOTE_EVENT_T
> > *event)
> >  {
> >       event->armed = 0;
> > -     complete((struct completion *)((char *)state + event->event));
> > +     wake_up_all(wq);
>
> Shouldn't this just be "wake_up(wq)"?

I wasn't entirely sure if we could get with more than one thread waiting
for the wakeup. With the semaphore or completion that would already
be broken because we'd only wake up one of them, but I was hoping
to stay on the safe side with wake_up_all().

       Arnd
