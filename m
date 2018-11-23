Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C9FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9709520672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9709520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394465AbeKWWtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:49:00 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46926 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbeKWWtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:49:00 -0500
Received: by mail-vk1-f193.google.com with SMTP id j23so2606693vke.13;
        Fri, 23 Nov 2018 04:05:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRl0MrXj/wZtIcj8Tum9qxwMiS3cAuAQEao+mVKvwLg=;
        b=NUiAPwxkUBEi1ieEHbMBaHHsJrbc/FIe/fwc7dfmQja200zcrbwjYd7fG2ZaC9tGS5
         433MMwUa0wCqjSrhyPEGZs7AfnjmSEjUhRlrJjoNdOetJZJ7g6MszG4E2HH2iTnwkgo3
         cMnBoVuXUjNPePiitRD1nlc2GTvbq5t4p4YNOQQewR7vfGHRdV62gjTd3QyCmMw28KAb
         cbmq8ceeipQKzNiNM8/mMsxyKYr+rUkqvURMOIteoPSIdnZ0bCLjKzYJHnmzbMzl0dJH
         cow8ZTsnDaepd9GXkip8FZKeI+EG1v3+spBpF+ZM1H9m7LrXN6s5BhMBQqI0wxz1teI/
         zq3Q==
X-Gm-Message-State: AA+aEWbJkiml4gD/QnCwv1lFL+shbPEeMQ89E/EvI4NqsUulE2HK0vp9
        ux4UWF8hK+6XE6KatiCeOkS8vIme7lMFDx+cHMo=
X-Google-Smtp-Source: AFSGD/WgmxnlWylqbgtaW4ayNjGUx+rFusnpS3winiWG2TerZ7+fqldzgzsMI7mFiYI/Bv80nB1REG2eEuvN69Kl38I=
X-Received: by 2002:a1f:91cb:: with SMTP id t194mr6287654vkd.74.1542974701747;
 Fri, 23 Nov 2018 04:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20181123105428.13457-1-phil.edworthy@renesas.com>
In-Reply-To: <20181123105428.13457-1-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 23 Nov 2018 13:04:48 +0100
Message-ID: <CAMuHMdUNNvkwsFXizEm6-QSCc2JUJa+3rXuwBZdjypFdFcM7tg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: rzn1: Fix check for used MDIO bus
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 11:54 AM Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> This fixes the check for unused mdio bus setting and the following static
> checker warning:
>  drivers/pinctrl/pinctrl-rzn1.c:198 rzn1_pinctrl_mdio_select()
>  warn: always true condition '(ipctl->mdio_func[mdio] >= 0) => (0-u32max >= 0)'
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v3:
>  - Split fixing the return var when calling of_get_child_count() into
>    a separate patch.
> v2:
>  - Don't rely on rely on the implicit typecast from -1 to uint

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in sh-pfc-for-v4.21.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
