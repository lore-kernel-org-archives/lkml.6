Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4792FECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8B32124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFZmUxAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8B32124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbeGMIZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:25:16 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46808 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731885AbeGMIZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:25:16 -0400
Received: by mail-io0-f196.google.com with SMTP id i18-v6so14849854ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YbS+aB9DLTOtv2dOnN5BIV32Xl0tqAg7BjeAsGST8+4=;
        b=fFZmUxAihsNiuTGWbeyEcQ3bz/fobVH1j04hf7ctLdm4S6Vjr2+wad6B8AZDFhZhcG
         pskV3jKlArBc1z4wyANfhd492HiO3urcrgaRHvOBHaSS4ABfhbXj3xoqZdb+lTekyUVk
         tC30WBNHcmt3SIBIMQk1jmO2WzIQM1CDLbl4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YbS+aB9DLTOtv2dOnN5BIV32Xl0tqAg7BjeAsGST8+4=;
        b=JRuJD9O3Ng/DQEUT/D5UnsRl6M3NifffLmUsm7H1l0i3Oj4y4wNPMwbPh5ILGNkL0A
         LJ0j/I9ifD3/05UL5CY7R0ZhD6X+BWoscsX+62ESamf327ajvTpqxA6nt7UOJjLHS+Fa
         RiRDTUKqpgC52W5sQoTeJ5bqllN5yYix3hPl7TKzQQosKc3S1J+WKgmMtCIUIsSysYzA
         Y0PzpZNXahgsteDryTMuCxXPkQVi33XD1ZB8dYS6mO5ag1ZyTwUh1kykSTPJDsnHbU2w
         kL62fhM0ArwIDxEQYOSUbt/mSSPy4Wj+5umADTy7kQJ7R4tQ5AMEqXq2N5wUy/iPGZyP
         FOEw==
X-Gm-Message-State: AOUpUlEsoc4qz4afP3a1lmZTnx13+VMPbFfMhwqRdA28zilLo/FRWWom
        6HxW2fCi46o7uevXDXQgagp9I8gumLgA/p1FxrqRLg==
X-Google-Smtp-Source: AAOMgpf8DCfl+m8yXoWnbOYpz6uezO3W8j0g0lxrZM6enKejeG9dhRgCJ88SxNbs7sG574eWIIop1eAfAY6T6bYonbw=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr29434505iof.304.1531469503817;
 Fri, 13 Jul 2018 01:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <ddd18e427de47476722c945dc622571394192331.1531374468.git.sean.wang@mediatek.com>
In-Reply-To: <ddd18e427de47476722c945dc622571394192331.1531374468.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 10:11:31 +0200
Message-ID: <CACRpkdYGPw0Vaaa1_0-vmFf0wdB6Wi+NLv4jDqDxCwJF9o6G=A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mt7622: fix probe fail by misuse the selector
To:     Sean Wang <sean.wang@mediatek.com>,
        ext Tony Lindgren <tony@atomide.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 7:50 AM <sean.wang@mediatek.com> wrote:

> From: Sean Wang <sean.wang@mediatek.com>
>
> After the commit acf137951367 ("pinctrl: core: Return selector to the
> pinctrl driver") and the commit 47f1242d19c3 ("pinctrl: pinmux: Return
> selector to the pinctrl driver"), it's necessary to add the fixes
> needed for the pin controller drivers to use the appropriate returned
> selector for a negative error number returned in case of the fail at
> these functions. Otherwise, the driver would have a failed probe and
> that causes boot message cannot correctly output and devices fail
> to acquire their own pins.
>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Fixes: acf137951367 ("pinctrl: core: Return selector to the pinctrl driver")
> Fixes: 47f1242d19c3 ("pinctrl: pinmux: Return selector to the pinctrl driver")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Applied on top of Tony's patches on the fixes branch.

Now there are fixes piling on top of fixes and I am starting to feel
insecure of pushing this to v4.18 and I feel like letting these
fixes go to v4.19 (it can be picked to stable from there).

Tony: do you think there could be more fallout like this?

Yours,
Linus Walleij
