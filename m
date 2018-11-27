Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E68C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2FA208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AOPno8yK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2FA208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbeK0N0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:26:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42708 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbeK0N0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:26:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so18628272lja.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRkoPjDP1r8qj3dgHHFxX4EKbP+69/IBT1wXwscFba4=;
        b=AOPno8yKKBdC0HLKA8oG4B42yoX6tERDuhAgrrXyCkFqHEuKwAsrMW3mMb6jpbuPJ9
         ErkSeFsHEObKY5GbC0GdWFWIXCJiGq1DPrFptMnlpcFDvve/iL5NAVcVgicpzPF4ixsm
         etcfqRiiXAMzhnuqJ8eiRpP9ZNkEIj35eUH5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRkoPjDP1r8qj3dgHHFxX4EKbP+69/IBT1wXwscFba4=;
        b=WwI82i9ozL1Psm+n/vWxsPHtMr2mv7eQ/zV3zi03wrJ3SzvvmrK97F55OEIZnMRBWW
         F24kLpOasozAYCdKFXe5uAPQoXaJEEYp0wvnh96CaFo87CFwxMxc6m+7EwWxFpMPDQ01
         lR6XSXb5S52tcwJ2szxR57VaX/wWd/tVvOb3hg9dbwD/c1R8Iyf1edwzkHPumFf8RSH/
         W6OW8KGkVAUUROjzgeSbBpkrFVCijDN16BgZba7sFkh4dwawdxJR0ctN8MLAxbTuM4EW
         ElkPvAGdNWtBwJKTIUNfnyfKyD1X5Hpu++5qh6RIL+Ae3cT1knWzM+i107WgzsH7YeQ+
         wHww==
X-Gm-Message-State: AA+aEWbudntEfU3fnNfOsRwzmHVP8OWxrEavw2JNfjE7cXwH4Wq0amWJ
        2jip3yQH1AnFUjpVVa6ncMJg6jcA23g=
X-Google-Smtp-Source: AFSGD/W+d1a6zIu3Y0yj5+FhKNhmIlCH5pMvQ6yQPZQaTUupSwzC9bgTyG8cINUULrmx0ubks1dPZw==
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr18415413ljk.4.1543285822824;
        Mon, 26 Nov 2018 18:30:22 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id p67sm329069lfe.14.2018.11.26.18.30.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 18:30:22 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id z13so15187472lfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 18:30:21 -0800 (PST)
X-Received: by 2002:a19:7013:: with SMTP id h19mr18781286lfc.147.1543285820843;
 Mon, 26 Nov 2018 18:30:20 -0800 (PST)
MIME-Version: 1.0
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
 <20181122063409.15816-5-peter.hutterer@who-t.net> <20181122232839.GA10747@jelly>
In-Reply-To: <20181122232839.GA10747@jelly>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Nov 2018 18:30:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=widz0eGFuV=bPdXenOEipZg-OTjhfownHUM7gwiZ=4tHw@mail.gmail.com>
Message-ID: <CAHk-=widz0eGFuV=bPdXenOEipZg-OTjhfownHUM7gwiZ=4tHw@mail.gmail.com>
Subject: Re: [PATCH 4/8] HID: input: use the Resolution Multiplier for
 high-resolution scrolling
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 3:28 PM Peter Hutterer <peter.hutterer@who-t.net> wrote:
>
> The device sends hi-res values of 4, so it should end up as REL_WHEEL_HI_RES
> 30. We are getting 28 instead which doesn't add up to a nice 120.

I think you're just doing the math in the wrong order.

Why don't you just do

    update = val * 120 / multiplier

which gives you the expected "30".

It seems you have done the "120 / multiplier" too early, and you force
that value into "wheel_factor". Don't. Do all the calculations
(including all the accumulated ones) in the original values, and only
do the "multiply by 120 and divide by multiplier" at the very end.

Hmm?

              Linus
