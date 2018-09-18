Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6BFECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AAC20867
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AAC20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeIRMOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:14:09 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34673 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeIRMOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:14:08 -0400
Received: by mail-ua1-f66.google.com with SMTP id r15-v6so398063uao.1;
        Mon, 17 Sep 2018 23:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNoAjmhp2G0kbgnysrFXj9ugy+nKM9XMk6ayeODfdtk=;
        b=dIRrA4z62RaP6DT1OpTeUcczPc1LvREylCToEvvln7LWIpJFltAhnj0JYarFvWb8XO
         4vU/xqCf6KKFAOQgrlDFxxkxF/uwysm5FdERL+1N29CwfB5ViLANBreUyqSk2fTO3bfO
         I5f6rE+WgkjlPnb12IbF8jbSwTdIf2azFEakVvCnlKuS0cKQRxHuCYKdySasq551LCLF
         njNcnYll4XrrQQqWlsWrWX7V8MYMb/lT4CGDNAjbNpI5i+q0bXGfMhHVUWDoTmauCZFM
         ai6EPHsAIhpBtHgI6vbqAAZpiVNUnCpGTvXoaApbkpk4UL+RJIQ0GeO69viKp4ivp3TW
         c6cg==
X-Gm-Message-State: APzg51DzOTzN29BblrBO0SEPSmMT+kyEhX6KV9eczhRuO2XXhsSxXUyM
        RCuwnBJ+dKS7RFZT0xJ6iS+xawIhlUEf/pah9fJn0eC8
X-Google-Smtp-Source: ANB0VdaFuPfR0yXbQDvrBpdfMBgTHr50VuQOuuDQ3UETtHzwIN9lg5gNf1iwe9krj6uH277sNGGXYDiZD7I/jYzB5t8=
X-Received: by 2002:ab0:51ac:: with SMTP id g41-v6mr8710953uaa.155.1537252978630;
 Mon, 17 Sep 2018 23:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180917163955.19023-1-geert+renesas@glider.be> <20180917163955.19023-2-geert+renesas@glider.be>
In-Reply-To: <20180917163955.19023-2-geert+renesas@glider.be>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Sep 2018 08:42:46 +0200
Message-ID: <CAMuHMdXUsOuYwe0jbC1bCSHMp=Rcu-a_oYOz9f8q3LNxNiO1JQ@mail.gmail.com>
Subject: Re: [PATCH/RFC v4 1/2] reset: Add support for dedicated reset controls
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 6:40 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> In some SoCs multiple hardware blocks may share a reset control.
> The existing reset control API for shared resets will only assert such a
> reset when the drivers for all hardware blocks agree.
> The existing exclusive reset control API still allows to assert such a
> reset, but that impacts all other hardware blocks sharing the reset.
>
> Sometimes a driver needs to reset a specific hardware block, and be 100%
> sure it has no impact on other hardware blocks.  This is e.g. the case
> for virtualization with device pass-through, where the host wants to
> reset any exported device before and after exporting it for use by the
> guest, for isolation.
>
> Hence a new flag for dedicated resets is added to the internal methods,
> with a new public reset_control_get_dedicated() method, to obtain an
> exclusive handle to a reset that is dedicated to one specific hardware
> block.
>
> This supports both DT-based and lookup-based reset controls.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>   - New.
>
> Notes:
>   - Dedicated lookup-based reset controls were not tested,

And untested code is buggy...

> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c

> @@ -541,9 +575,25 @@ __reset_controller_by_name(const char *name)
>         return NULL;
>  }
>
> +static bool __reset_is_dedicated(const struct reset_control_lookup *lookup)
> +{
> +       const struct reset_control_lookup *lookup2;
> +
> +       list_for_each_entry(lookup, &reset_lookup_list, list) {

... as the list_for_each() should use "lookup2" instead of "lookup" (warning
reported by kbuild robot).

> +               if (lookup2 == lookup)
> +                       continue;
> +
> +               if (lookup2->provider == lookup->provider &&
> +                   lookup2->index == lookup->index)
> +                       return false;
> +       }
> +
> +       return true;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
