Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624B2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A55C20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 08:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+po9oQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbfAKInA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 03:43:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38787 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfAKIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 03:42:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so12206509lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 00:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o//Z32yfmUnZW8JOdGl2j32GZ/bDiB8tTsQiF7aTMIc=;
        b=h+po9oQQ0pK6o3InRHLVh5C2MSBX5biPJSXdcl0267wTkCD4x+ksNfhXxUVPmc5tnw
         vLfnWYtO19aoE1aBFOTqn5QpiIQg0jtjRlY9tBcbWQ+x/H+YSP9AJrkgs1LOlM96L1HK
         +I52JZ9n4qIwOj2uKlFl4ursaxVSVLfD5s5GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o//Z32yfmUnZW8JOdGl2j32GZ/bDiB8tTsQiF7aTMIc=;
        b=XC/yE/x2hIglc6FofdtQPcJQJWEUvcQ/G5sSQPQwWx70pgY6BEozTmwGEFKE4r/dkj
         NaliWG+ntlW+uYAPdlecSBtJz9D3PFwbGxgsYPNn5QEB+qneDj2ki5iDWvKVHyUx4/39
         XB9jVLJoMtbg9W4Ag1h88Py51aQwIXuTqh2onyyBUa2dUVjxG1J1i+SoG9u7E2pd6w0b
         fcDw2L8utrfjt22n0aI/09hulFEhRifWjlQpJ+PnunGGOmnjyAmFUAjzopW1zlDTfWwp
         zEcPP2oXIOpkSsyWULbP2a38iNxgp0OJH0YQIQNXERw1WEs7bW6P1s73XH3Zy+tx6Era
         UaSQ==
X-Gm-Message-State: AJcUukcNR+3xLvZ4bMldHQp/XSBKn4RbLu+JBM4qI6dA6Oj8dy+t+bie
        X1FqQgghQkBFfB8VQrXph9ofJaH1aRi/YRFd7r7e2w==
X-Google-Smtp-Source: ALg8bN4CLZ8YGu9CEmIPX0T9HmHo8VqQOcehLhOJJNl23209qYCkFbFIxZ65tLjvU1TKNX7ZrQ3kgR4lcJ8+cYBUB/0=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr7890287ljc.66.1547196177541;
 Fri, 11 Jan 2019 00:42:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545198260.git.vilhelm.gray@gmail.com> <9fb3981cbcfbce3fb8b42bf419d734c0e5a44d0e.1545198260.git.vilhelm.gray@gmail.com>
In-Reply-To: <9fb3981cbcfbce3fb8b42bf419d734c0e5a44d0e.1545198260.git.vilhelm.gray@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 09:42:46 +0100
Message-ID: <CACRpkdaL3LY6esgBfpJcox7AzQ8RoreqV0_gzM-AmQ_mYQHueQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] bitops: Introduce the for_each_set_clump8 macro
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 7:00 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

I am still waiting for feedback from the core lib maintainers on this patch.
If I just get an ACK I can apply it to the GPIO tree, if noone else cares
I might just go in and apply it, but it feels slightly outside of my
jurisdiction.

Maybe people were just a bit stressed out around christmas?

What about looking at it now?

Yours,
Linus Walleij
