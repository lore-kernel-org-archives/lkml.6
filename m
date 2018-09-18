Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63940ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB1421471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHoXiAsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB1421471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbeISFJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:09:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34319 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbeISFJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:09:25 -0400
Received: by mail-io1-f67.google.com with SMTP id c22-v6so3025166iob.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 16:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8i7RszOo2Za0fsXGsmz6Nb0UYs4pWO8rjuXXY9KoP4=;
        b=FHoXiAsYkNpcmzjqTVr/KEkfaI9jkRzopXWj9X9xQ7op3OgWhNdURynt2hdoPrRgUO
         lJ3w6bn9599Gl785r0FyY+EXS7rQReRlj3r+xptRGMfsytUBA0e03CW2aDU5A3N4TXsZ
         O7+TxtNParlf67QhWZSvsfg46gwIyRax3hD90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8i7RszOo2Za0fsXGsmz6Nb0UYs4pWO8rjuXXY9KoP4=;
        b=LWQOYHK3eNbXHPAFzNQKVxU4VaWyoKDfwQgoOAq7YACAVG0Wpazj3LvJGptcN1ioL+
         34blTq4MO2wPBscPSIfsKsTjcods0dLvsHUaICI9EaV0uGrhRnaQeKyn9mOXyfAFjZ45
         uM8fo+UL7Yno1m4rXF2y3bmkAXYfwWiukZvZjsDzSkCtV3Sfoew/TvNHSVj+4Zu5YATB
         ofJDssWtBFXLPw8Sr+slEfgYp5nvNNHizVM6Lpb4+dwO2jHZ4NeysyuImfESrxuxiTlB
         yVD+BOoBws2+lF/QJdpyOJRxI6oyHA4Cwt43X/e8oV8AXvKEUMGFfhF4OY50uMRJNDjF
         N41w==
X-Gm-Message-State: APzg51ABOB+sV8yqoxNk3RetVuLMtU0VjNhWK9nQR2iu2e9PQGLnfcD2
        SLYkuIyDbXZxK36kpi42fQo7avynPIEKcN0fpZ7s+A==
X-Google-Smtp-Source: ANB0VdZWvvWOsO0VLO55hIwUIe2VaR5knrR8csZTXMhhK2392JZbjIz7BxMj9dh8V95NwGtbpblAJa0qvrOHbFKULRA=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr26694320iof.304.1537313668487;
 Tue, 18 Sep 2018 16:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180915211518.8155-1-s@sd.ai>
In-Reply-To: <20180915211518.8155-1-s@sd.ai>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 16:34:14 -0700
Message-ID: <CACRpkdZMFv6NLmLVOXTofx_SBtO0R4qvcSbHu6uZw+k_vmmSSQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: cannonlake: Fix gpio base for GPP-E
To:     s@sd.ai
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 2:16 PM Simon Detheridge <s@sd.ai> wrote:

> The gpio base for GPP-E was set incorrectly to 258 instead of 256,
> preventing the touchpad working on my Tong Fang GK5CN5Z laptop.
>
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=200787
> Signed-off-by: Simon Detheridge <s@sd.ai>

Patch applied for fixes.

It seems I should tag it for stable too.

Yours,
Linus Walleij
