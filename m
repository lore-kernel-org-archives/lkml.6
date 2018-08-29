Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE025C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F07120867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VgUAh9w+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F07120867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbeH2PlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:41:03 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36574 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbeH2PlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:41:03 -0400
Received: by mail-it0-f67.google.com with SMTP id u13-v6so6814491iti.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+mhCh7Yk3jj00hgT4skmtSA0mkKqWTgWYNIrdFxM5E=;
        b=VgUAh9w+soHChMBHhDwSdpDaUfAB7qv6mZjdIZdWz+5G3JF7wjjh992fNeZq3n/Lgw
         JlmtKoGSNGwzBpgENYOVSd6NqwysosG51x0lDcz52YYws0ubMkGHu3ZpNj99WepABLtQ
         6QLdqp4V1KNJskaSg3ffqkgI6YyNgVq5xqDDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+mhCh7Yk3jj00hgT4skmtSA0mkKqWTgWYNIrdFxM5E=;
        b=Pm7tROB9ADhRUBrBxApCC4Xl8fIM7sgJqyQ84OXb3SJSFTw/WF65WJkVsXjw2pn/ro
         oPYmlxssw/aboQU3zQcGh2j2MKFpXoxCE5TpZNebRPKZWLYKvNmRCC96KmDqSyW5HWIN
         IgL1Pxyk4tMSi7KXAvCFkhBFg+gmO3bqoWiSL0/kNj6uHZjn6f5hwYe3YuWXkSJSh3HL
         rPUWFO7jd7WyaRyY0Gj1t9t1fpr24txuPuEw5DeqPy1inLoT1LtJv06B26zcnzeFpao0
         rgvRI10G3PXEA/puFGVfaCIMwJmzhGcjuATlqtIUdzI87JUp86ZgK4agHqArHMv8owVK
         zFvg==
X-Gm-Message-State: APzg51DXLrYsbj5HkEyTuozwRG88YDar5N29FmE4Q2onPevy7sEM+q7+
        wv4qkd5dUqgNTu/orHCZYCzZXyvHD1oHbXeBZpDrvQvy+xo=
X-Google-Smtp-Source: ANB0VdYLhj9YIN6lhgEImZonX2QKmmwJGFk+vhVo56zYtpHfrLQauQogORTq8pQEdIHbKukw+a6w5go/UuY2Bvf95lE=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr5000454jab.87.1535543071369;
 Wed, 29 Aug 2018 04:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180825175328.16687-1-paul.burton@mips.com>
In-Reply-To: <20180825175328.16687-1-paul.burton@mips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 13:44:19 +0200
Message-ID: <CACRpkdYHZUxoTdkxUyUXi3hSo1-cyo7xVk7fcZFY5nLcC6pdxw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ingenic: Fix group & function error checking
To:     paul.burton@mips.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        ext Tony Lindgren <tony@atomide.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 7:54 PM Paul Burton <paul.burton@mips.com> wrote:

> Commit a203728ac6bb ("pinctrl: core: Return selector to the pinctrl
> driver") and commit f913cfce4ee4 ("pinctrl: pinmux: Return selector to
> the pinctrl driver") modified the return values of
> pinctrl_generic_add_group() and pinmux_generic_add_function()
> respectively, but did so without updating their callers. This broke the
> pinctrl-ingenic driver, which treats non-zero return values from these
> functions as errors & fails to probe. For example on a MIPS Ci20:
>
>   pinctrl-ingenic 10010000.pin-controller: Failed to register group uart0-hwflow
>   pinctrl-ingenic: probe of 10010000.pin-controller failed with error 1
>
> Without the pinctrl driver probed, other drivers go on to fail to probe
> too & the system is unusable.
>
> Fix this by modifying the error checks to treat only negative values as
> errors, matching the commits that introduced the breakage & similar
> changes made to other drivers.
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Fixes: a203728ac6bb ("pinctrl: core: Return selector to the pinctrl driver")
> Fixes: f913cfce4ee4 ("pinctrl: pinmux: Return selector to the pinctrl driver")
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Patch applied for fixes.

Yours,
Linus Walleij
