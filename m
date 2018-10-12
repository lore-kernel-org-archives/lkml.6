Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA80FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F102086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWHgSe5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F102086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeJLQka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:40:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36349 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbeJLQka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:40:30 -0400
Received: by mail-io1-f68.google.com with SMTP id p4-v6so8721900iom.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUzUwOaGtf3aXbq+RKvcYD5Ee7pzT5zqBQkaRUi0JAI=;
        b=QWHgSe5aeXveYsJy9hwsIlKniUkx30ScwEe3g2OxPl+1fzlR+Zj5IU/DhypSX2kPyU
         rmg30qSoFrK7m00oLsTEHf0TKkYwHoQ9VLNfz7OQUFL7wJ/1yGIQiMEaD6nHV+asOHMA
         OvOtoNxkaSNsO4SpPGYjw/mzRuFma6HL95i20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUzUwOaGtf3aXbq+RKvcYD5Ee7pzT5zqBQkaRUi0JAI=;
        b=kc1h+EqxF4RzLaKLz6s0hxjAeMBJcrX5QR+k8h6y/f0XmjeS4g192sQOTVoq5u0aOa
         9b/VIyHYR/IqJlhywIF5XyZdTDbyZHq1H/lcLTmLN3Z80HhZ+TO5VcEsgUBy8k902RHh
         X/mmbcTu7ZaJOnhbLGUkSjCTf/e8d0L4ZVYDCasWrFcycQJn6JhRQiAFkg1exNiHQShD
         5s7wyph7vexyghXGQ2bKQaczDlbq9rx7xgHqbhKTStH3PXAfltSX7o/ec/dC68z9yRvA
         wmM9+raMnQfRUGOowyTYJcO+tvRMlxPtCnrIsK+X+5pRzzvISXpUmahz1fa8SD4V7/tu
         F6kg==
X-Gm-Message-State: ABuFfogg2I7WT75i3dl6viICBv5uppyk0T/R2OBFZWC4nIYzPQcdi3ID
        XrAsN0nwvmENPDUUs90tdM+bV6yfrbdJnGMjeqy0xA==
X-Google-Smtp-Source: ACcGV63quvn5Dd+EpAAzOzjItaH/0uvw7cMiPVEWq3EU+NAIbzhn0JqQ1EGO1CGVnPaaWmbnGN29yMZXCGaraZ8mlv8=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr3375615ioa.277.1539335342548;
 Fri, 12 Oct 2018 02:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181005065300.22882-1-ricardo.ribalda@gmail.com>
 <20181005065300.22882-3-ricardo.ribalda@gmail.com> <1539334839.30485.9.camel@toradex.com>
In-Reply-To: <1539334839.30485.9.camel@toradex.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 12 Oct 2018 11:08:50 +0200
Message-ID: <CACRpkdY89b-hy_aoBiZXX6KqyJrZd0fX9-XCGcF9XjPBy6Lwrw@mail.gmail.com>
Subject: Re: REGRESSION: [PATCH v5 3/3] gpiolib: Show correct direction from
 the beginning
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     timur@kernel.org, Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        jhugo@codeaurora.org,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 11:00 AM Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:
> On Fri, 2018-10-05 at 08:53 +0200, Ricardo Ribalda Delgado wrote:
> > Current code assumes that the direction is input if direction_input
> > function is set.
> > This might not be the case on GPIOs with programmable direction.
>
> Unfortunately, this breaks at least Apalis T30 and Apalis TK1. Enabling
> earlycon reveals the following:

Does this (just applied) patch fix the issue?
https://marc.info/?l=linux-kernel&m=153932470412013&w=2

Yours,
Linus Walleij
