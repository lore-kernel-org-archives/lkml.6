Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17B7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A62214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSAudj4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A62214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJJOd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:33:58 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:51094 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJJOd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:33:58 -0400
Received: by mail-it1-f194.google.com with SMTP id k206-v6so465461ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 00:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5OOztqssMVdu7XL6nnv4bDUAo1xUUxYBjbCtDMAg1F4=;
        b=MSAudj4NVccjSQzGseBLbcx9/GDf3k7lj2bP8Syv1iZT+Xsd9mvRoZuLKXWMGw3GKg
         0mOazz457V5Aok5iPHtHVQB2jpoKrHuNfc17+Em/EoGbtlEVaX6b7b4xZQPuiEnUkTNX
         NJvDPGQsdOBMji3wJsonyxjoLf0RUZDBe1xok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5OOztqssMVdu7XL6nnv4bDUAo1xUUxYBjbCtDMAg1F4=;
        b=pBGZC3VfR2JWocKZGahC3kdHtXxQyXcpamlWQR2kV8WWj5L7rd2jtLihEf5MN6bC6B
         X3SdBVBTrAxvD5OvjdaeiQMp5vYJqKpdaj1iEzWY34odqstZaYavWtk3PvayFS7L5JhW
         hHHlXMU7AUH2txm+b9UtgR6WtTBV9pOgyAfMxw98ptyaaTQg8evxq8Uhrw4NS9mPTu0L
         h1IvhUErbaYWlgwSBkKJtVRF8VpVc2BtSBIMCajgDIam2N0/0Nj5ucx1aOhyLrcd8kTW
         Dmy6rbCFP6gZmCBqA9G+3HsLm/EAKH2fBIMaHaYnTgoUuKvPDxDCpL8u7/9DyParGXa/
         4tnQ==
X-Gm-Message-State: ABuFfogUTfOohtvUQkL3XyzDBNf3j2iTW+1DJjgp1fMCkfGlTb7mEP7K
        2WDxmxmwAAUa9XTBldza4oisil7pWATxpAC0Bk1YJg==
X-Google-Smtp-Source: ACcGV62UDzXIjYfwCtPqdh2GpCldOXpsOkg2B7FkgJVBJLUlonYnRmvcIgSDYHcUU/zeKPAMkYGkzBX4UNzmgIokj3U=
X-Received: by 2002:a24:e0c8:: with SMTP id c191-v6mr3883115ith.156.1539155590797;
 Wed, 10 Oct 2018 00:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181008175530.864641368@linuxfoundation.org> <20181008175536.405502473@linuxfoundation.org>
 <20181009063338.GA22218@flashbox>
In-Reply-To: <20181009063338.GA22218@flashbox>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 09:12:58 +0200
Message-ID: <CACRpkdZVWMAQxrX7CS-JtA9sRYqeNE+8X39yqfCNtYLmN=XDHw@mail.gmail.com>
Subject: Re: [PATCH 4.4 093/113] pinctrl: msm: Really mask level interrupts to
 prevent latching
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 8:33 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Sigh, sorry, I caught this after I sent my initial all good email but
> this commit breaks NFC on my Pixel 2 XL (toggle becomes greyed out and
> apps that want to use it ask to enable it). I can't say why, I'm more
> than happy to debug but I'm assuming it's some voodoo that Qualcomm has
> done out of tree. I'll leave it up to you how to proceed given that I
> can't run mainline :(

Which NFC driver is this?
Just want to make sure it looks sane.

Yours,
Linus Walleij
