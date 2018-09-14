Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD666ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896FB20833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896FB20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeINVWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:22:08 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:41171 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeINVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:22:08 -0400
Received: by mail-qt0-f171.google.com with SMTP id t39-v6so9181549qtc.8;
        Fri, 14 Sep 2018 09:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIcik8OaY5BrTlyxVs1L1Rk8EuOQ9e9cx6sDq5X6jgs=;
        b=iUzlxx+hhmHxMAq85ps1BvyRpwop650WFDozJ2PpD+TVYPCeA+jtSfAFRkS5yR5ZwC
         eGuS3AE5gBI+xu6hr82hl4cLDZVC9MWNF7NDKsc9ehd7JKkt4SH4BMExIsDbT5CFSE8G
         O6xvqn7xTDibRbrTRHX79lieMEdyKi2PjUKeuf8KEoQRtV+ADA7cmXoAKV1J+rr1yJiR
         im+Udv1Wae4YvMQ5uXNq8Vcuf8OA4va6UnrMt2dMIPte/VV8RtVDqw8e60PRLOdOoPTg
         H4FR0aM5O5oAejnzNdki6FXWi7OtYSmLYdt1v5eYnM2wA1nRi6hGqWmpOktbmS2Dktxe
         FZWQ==
X-Gm-Message-State: APzg51CYCbVRzXUpNnaJJgtPYm55iT+s6nGAd31XOGhNQXjTkWK89WO0
        X+KVHNSXFKDOah4EJkr8YsnYv9SebWbm566griw=
X-Google-Smtp-Source: ANB0VdasYCOjmANSn6220UL6huENIXhamFunEOG8Zh5d4tUD7PIqTOK1WSZEZ3DzIciHzz/7Au6L8El1Jno/4wMwNH0=
X-Received: by 2002:a0c:c171:: with SMTP id i46-v6mr9444344qvh.40.1536941218856;
 Fri, 14 Sep 2018 09:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180901204721.13117-1-deepa.kernel@gmail.com>
In-Reply-To: <20180901204721.13117-1-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 18:06:42 +0200
Message-ID: <CAK8P3a3KLVEcCpPXWdEoOWgmP8zcDvLyj2LUn0Nw0+0yGO_MmA@mail.gmail.com>
Subject: Re: [PATCH 0/5] y2038: Make ppoll, io_pgetevents and pselect y2038 safe
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 1, 2018 at 10:48 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> The series transitions the ppoll, io_getevents, and pselect syscalls
> to be y2038 safe.
>
> This is part of the work proceeding for syscalls for y2038.
> It is based on the series [1] from Arnd Bergmann.
>
> The overview of the series is as below:
> 1. Refactor sigmask handling logic for the above syscalls.
> 2. Provide y2038 safe versions of syscalls for all ABIs.
>
> [1] https://lkml.org/lkml/2018/8/27/651

Hi Deepa,

This is a very nice series, sorry for taking way too long before
I had a good look at it.

The first two patches in particular are great. The third patch
looks like it has a small bug that I commented on, but given
how much more thought you have put into this than I did, it's
just as possible that I misunderstood it.

I've applied you series locally now, but have not pushed it out
yet for linux-next because of that one issue. I'll send a pull
request to Thomas for my other patches for now, and a
follow-up with these once we have clarified it.

        Arnd
