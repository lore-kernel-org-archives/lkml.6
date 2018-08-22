Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD41C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C51214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OGbmc/9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C51214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeHVRaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:30:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36184 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbeHVRaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:30:00 -0400
Received: by mail-it0-f65.google.com with SMTP id p81-v6so3069283itp.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gi9Qc5t5nAYzxLnctoqByn0x7/rsFuZYtwK7AC24xc=;
        b=OGbmc/9b5NrDUQXjDtTSYYk6jydgUgbkOoSsc6m6eG8YVLf5tTzLsOLARHpSJf7zFa
         Ohns8dg64c+xMPl+JI1YpNkKIFWp/M5h9lJ+r7pA2wMIMKeVaiITqg/KuSna4tYuz8hA
         VGx2mStY0mRtB2seXHT2+QKdhZktBvIJl80/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gi9Qc5t5nAYzxLnctoqByn0x7/rsFuZYtwK7AC24xc=;
        b=dhClRz+ycQ5BuUhpvdvNM7wmPQUEzk2WMksswDuEYjDhPrFBdOEClBBlyH3yVONSH1
         W2CEa1dwfxZZlaqdZvJc8GYQUPmyPZUzl05rbZvMwIwC2SypWAVDpMwCu5SKiCGS78Lv
         9RB3K0Lp4SlbDDoi9/VnyysiBZ4L6/I53YOFAlFARqUU1shYy5aoa1q0TotPkw8D52L6
         9dF9MBxr8MI0Xs0TYb15UoDl5jU3A8T4ZiiS1Ew1QufDjXkRX+O+hDlVrqOv1UDbggqS
         OdEy6PwmZm6IHPLo40FZaCAP5Of/f5tAZTN9MKR/25CK8EuzGZYWvaeBavwZEbCNSGBB
         cS7A==
X-Gm-Message-State: AOUpUlE2MlndpSlGfyKbpwfnmLIGzkzJ8fWLd2CtZVWopimvttp17c2Q
        xIsW6d+0FheIW0JQgoj9RlcauXb3t8fXXeH36Gc=
X-Google-Smtp-Source: AA+uWPyou3Dvno/3UJ41BhVLqqM9AXdUHhdyq7oh4Ju1Z7AFfc/UHax2LpjZEr+B/FmihcwlsEQUT3B0UamaGJoAfD8=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr48795572jaa.10.1534946692479;
 Wed, 22 Aug 2018 07:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <8736v8dp6u.wl-ysato@users.sourceforge.jp> <CA+55aFxDWrndr0ZxM4kTJYC5ps+Hno1dCX==4071soSqcEjUxw@mail.gmail.com>
 <871saqefeh.wl-ysato@users.sourceforge.jp> <CA+55aFwsupq-iEL+MbNDMbzdsGA6dcMyM2Hs8uHgBZ5r77qnHg@mail.gmail.com>
In-Reply-To: <CA+55aFwsupq-iEL+MbNDMbzdsGA6dcMyM2Hs8uHgBZ5r77qnHg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 07:04:41 -0700
Message-ID: <CA+55aFyxWR+hEavg+hVbqC89=pqxgzFN2oFZhmzKJxnhBQpUOw@mail.gmail.com>
Subject: Re: [GIT PULL] arch/h8300 update
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 6:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Aug 22, 2018 at 5:47 AM Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> >
> > I fixed it.
>
> Thanks.

Ugh. I notice that you also seem to have rebased all the commits.

Please don't do that without reason, and if you _had_ a reason, please
mention it to explain why the commits are all so new.

                 Linus
