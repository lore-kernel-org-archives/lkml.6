Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C70C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EBC2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sl0wsuE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EBC2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeKBAbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:31:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37016 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKBAbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:31:38 -0400
Received: by mail-lj1-f193.google.com with SMTP id c4-v6so18415635lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYvjaGrtLS9bzB47Io/5BAc419z9dXk9u4C2fR6fr+Q=;
        b=Sl0wsuE5pjaNW9g28yLym/eJ5ZB8+Qip4b0+HZVXAHla77NP5qBwytc9HI6uOvfDcw
         /4ynvkWcr+EBnpPCCmXFG0On/zXQWzO7k7A17nBUtYR6+cpsfxmWaPjZxxaGGJTlc09L
         HZBZ35NKitbEpC3LisEMWAKMa/pjG7XWEi7MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYvjaGrtLS9bzB47Io/5BAc419z9dXk9u4C2fR6fr+Q=;
        b=SVRUTKcP2Rv2t3F1nkDCkSkyDcJOshtaqqKlt+MVsa2hWXW/DtBtjGVo97LyVWpfDC
         sPBISRPAm0uCQ/EexSQ2ykV291mI4u/WGsNSTze3E3r5ZALbEpk3sZdJtCx2y71yv+jZ
         X3CLWMLEEO7l+pKG2CzGPmTolFFGiUQqC4Ae0+d/m0iug9hxHHgEMGUixsQ4XhqqrUH/
         tADdr7XY+uPDyyyaQQusDsrlJtaGvbHhdw//jpAdgrTWn+6Hp/AfDkx3TLSSVgWw4S9B
         533QF4YKAJh1mL8ZxOAAFipe+HszzOjNnnyOgOD8QFVqzJDVVeqUzftB9jFQm2+QsUYp
         +xeg==
X-Gm-Message-State: AGRZ1gLe4fQJjdVNJVHVjWT5l3fC9fr2sj8JayplS4O3B7Vr7D4dc/9p
        liNaYc5rNJiejleOtP0GkFauYeuMP6056gBZob6RNCs7vZUiCA==
X-Google-Smtp-Source: AJdET5cxCqwMzmverXe2zJLIfdA2zwdtVO1LtJmuttuktj6DQVUiQCgxzIJN5Hzx4ztJnj85SVtecJ024sjqs+yvxC0=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr5147847ljp.12.1541086090756;
 Thu, 01 Nov 2018 08:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181101131250.41636-1-smuchun@gmail.com>
In-Reply-To: <20181101131250.41636-1-smuchun@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Nov 2018 16:27:58 +0100
Message-ID: <CACRpkdaURruTj6W=ozXpKEvLpxLa=6tLdDywac1uj61Hg8ZKpA@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Fix possible use after free on label
To:     smuchun@gmail.com, Nicolas Pitre <nico@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 2:13 PM Muchun Song <smuchun@gmail.com> wrote:

> gpiod_request_commit() copies the pointer to the label passed as
> an argument only to be used later. But there's a chance the caller
> could immediately free the passed string(e.g., local variable).
> This could trigger a use after free when we use gpio label(e.g.,
> gpiochip_unlock_as_irq(), gpiochip_is_requested()).
>
> To be on the safe side: duplicate the string with kstrdup_const()
> so that if an unaware user passes an address to a stack-allocated
> buffer, we won't get the arbitrary label.
>
> Also fix gpiod_set_consumer_name().
>
> Signed-off-by: Muchun Song <smuchun@gmail.com>

I am still a bit worried about the kstrdup_const() that this
introduces. The tinyfication people will not like that we now
copy every GPIO line name from the device tree into a
new reference copy.

What we *REALLY* want to do is:

const char *str;
const char *ref;

if (pointer_on_stack(str))
   ref = kstrdup_const(str);
else
   ref = str;

Isn't this possible to achieve somehow? If not, why not?
I suspect maybe there is no simple solution to this, but
what about a really complicated and hard solution?

I'm looping in Nico for advice.

Maybe I will end up applying it anyway but I'm not sure.
The patch looks good otherwise.

Yours,
Linus Walleij
