Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE43C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BCC2404A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D340NmQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BCC2404A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbeGCUHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:07:38 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46945 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbeGCUGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:06:12 -0400
Received: by mail-vk0-f66.google.com with SMTP id b14-v6so1818690vke.13;
        Tue, 03 Jul 2018 13:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oBd4iTVDmb2L0ztAc3qSgr15NkccT6o2hOCxKUuXgis=;
        b=D340NmQuAMq1MWXNBUJpXI32kz/tp+uMrkL88/dAqziOEpcdaO1VwE0mjwgIChnebp
         xNFq9H7bJPSXaApWSdgcfU11BjQEfC3zjXOsul95KaWk1ZLFWJIAbrgThLfOnIjymwkz
         TE14SuI8x8xCvQ8LclfDW4LsYVTW2if7wkTJk6bANvDjFnFLmk1JO3+Pw0R3mkkOlQou
         9nWjx6SC8T07Rsbygyhdyndq/d6PzZecEo7F6NraaWDUp4p4+b/kQ509KDqJEP+kQj1f
         TBk008cJ1hAoQg4hM/h0SltBN8FKd77+kYbyLD0OBKBvOk77TV642cvP+6boYmM4X78e
         KzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oBd4iTVDmb2L0ztAc3qSgr15NkccT6o2hOCxKUuXgis=;
        b=epxQliy/XK+7aY+RqnSpwO5jQZrYkE9MYVyZO0lsAQta5SpF/2mEiu0CQKsTrM027M
         2tkvlU0iSNueU7Iy/zg3aURLPdTyDOYOjptjxyf3fr14dGyB4xRrUdxDiiLyiG3ogOOa
         3/RHfOFBvziXJfAGVaW0naTMGB9k+Hzw/6+oBHN+iuTiuPkwr5KR6kgUGB4THih4tb/g
         /B/g2NfnBpTd7PbKc+sEkHqTVtwJOs8+osIx9ZYj4GEDHF2tR8yohkUnokPZ2Rmurtnx
         XpLObDFkdZtDPTLytWGviyDdunKQZoC5fvbleLOMbpRLQ49S72sxNliAUjfXdjO5PhD3
         KAFw==
X-Gm-Message-State: APt69E011mqq73JvwaNTr/eMCzqbLb+/si49quvSq9z9lorJlpQz3+0C
        thY8RFST1W0OpBboF/r8SR7pAuMZTVa0scuo76Y=
X-Google-Smtp-Source: AAOMgpe3iWzevOkpZ0/jGROnubug3fL23p32Z4pMY8ByL6o10kj/5L6UGkiFXtLTeIhXDp7abPKYK0ltNsguioHGihY=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr19438719vkd.161.1530648371789;
 Tue, 03 Jul 2018 13:06:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 13:06:11 -0700 (PDT)
In-Reply-To: <20180703172635.32508-1-jmkrzyszt@gmail.com>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Jul 2018 23:06:11 +0300
Message-ID: <CAHp75Vf5XC=RNiid12WXYtiT-SSPoH45VpakRrNV=T0qQCecdg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 8:26 PM, Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> Avoid replication of error code conversion in non-DT GPIO consumers'
> code by returning -EPROBE_DEFER from gpiod_find() in case a chip
> identified by its label in a registered lookup table is not ready.
>
> See https://lkml.org/lkml/2018/5/30/176 for example case.

> +                       /*
> +                        * As the lookup table indicates a chip with
> +                        * p->chip_label should exist, assume it may
> +                        * still appear latar and let the interested

latar -> later

> +                        * consumer be probed again or let the Deferred
> +                        * Probe infrastructure handle the error.
> +                        */
> +                       dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
> +                                p->chip_label);
> +                       return ERR_PTR(-EPROBE_DEFER);
>                 }

-- 
With Best Regards,
Andy Shevchenko
