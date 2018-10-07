Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400A9C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25782086D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D8F2W07j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25782086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJHEMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:12:07 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38403 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeJHEMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:12:06 -0400
Received: by mail-it1-f196.google.com with SMTP id i76-v6so9379755ita.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvrFfuoUNDi7qj4rnHFmBEJS1sAyLTIEO2Ozt4HkCec=;
        b=D8F2W07jedMw0WjejvrDxc6UX/vFkHqNE0+k1dp08L6D5YkBfI7RgbVOeVAklDuMYV
         BBEef4cs4owIOeavrO7CUAptsG8DOawKlYccV3EBzsLOvZz19CQeKZpPF3o++22soUbp
         c7gtkKmK7CXJSNgmmjSlITNJcGO0VhAyElSfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvrFfuoUNDi7qj4rnHFmBEJS1sAyLTIEO2Ozt4HkCec=;
        b=h8+iYaM9c4D7fMeDTAy7rkGq/snwuZ0a7GIsVQTjg8h4Q7pu/9XvSKNaUn20fibiS2
         arx6qTtjrrqjb/nBcFuWi2yD/8RHSiyq2BLS0NZOyQnLCHWaEgO6/+SW2knsTVyVFVvH
         zkQEuhLlypH4LiDuhbvu63ELTvLfyBHBIMz0BaPQ+ks4s88bISWb9la32NUYKBzoKja6
         GKY8ppDTaskw2XnUJMDD9vYaRB+p8FT81WQsJDvCijx6BS2WgMDH2MeVEKjozZfem6Py
         VMos0HtU2/VbRSqjwVX25LvNMHL+HBpfJn+se3qcYRP1IGqOIySzvtUF10ma7JdJbTP5
         zwWw==
X-Gm-Message-State: ABuFfoi38eyoOl15gW0A3pdWXfzDMav6JiN4vkoHu97gHRZbMzwV3/BU
        14/dxHqUB87UJXR/OMkThaZarS6TM/rl4baj4ZpQXA==
X-Google-Smtp-Source: ACcGV62il1fk/MD0I9NnLoNsZEXETVCWShsoCnGLUjWi1WWa3SrEMXZmxQjMGoio5GbjantboUbDBn9nuykWg9BzoBQ=
X-Received: by 2002:a02:7789:: with SMTP id g131-v6mr16252652jac.66.1538946214954;
 Sun, 07 Oct 2018 14:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181003215350.3550926-1-taoren@fb.com>
In-Reply-To: <20181003215350.3550926-1-taoren@fb.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 7 Oct 2018 23:03:23 +0200
Message-ID: <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
Subject: Re: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
To:     taoren@fb.com
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Yu Lei <mine260309@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 11:54 PM Tao Ren <taoren@fb.com> wrote:

> TIMER_INTR_MASK register (Base Address of Timer + 0x38) is not designed
> for masking interrupts on ast2500 chips, and it's not even listed in
> ast2400 datasheet, so it's not safe to access TIMER_INTR_MASK on aspeed
> chips.
>
> Similarly, TIMER_INTR_STATE register (Base Address of Timer + 0x34) is
> not interrupt status register on ast2400 and ast2500 chips. Although
> there is no side effect to reset the register in fttmr010_common_init(),
> it's just misleading to do so.
>
> Besides, "count_down" is renamed to "is_aspeed" in "fttmr010" structure,
> and more comments are added so the code is more readble.
>
> Signed-off-by: Tao Ren <taoren@fb.com>
> ---
> Changes in v2:
>   - "count_down" is renamed to "is_aspeed" in "fttmr010" structure.
>   - more comments are added to make the code more readable.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
