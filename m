Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D909C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1112820892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VQdX9N5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1112820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbeG2WL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:11:27 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39336 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbeG2WL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:11:27 -0400
Received: by mail-io0-f195.google.com with SMTP id o22-v6so8224344ioh.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GerR1hyrdLw92k8CKsPowicDQRFY/PN4FqMVw5jSDwM=;
        b=VQdX9N5f/NPOP5t2YiRsso5oWWW8Ol6Wnyyd1XQhFatepAtMOYq0fM1RDzdvodSIRI
         3FLeRCwpvb5No1HbB4hxU2uQUQ6y0zjRd8W/4NFZAuptaKanU1aBJInDMWok0jZJ8GoS
         3kTaXwSUw6SVkI2WmqKd+25M+EraF4tcdUEe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GerR1hyrdLw92k8CKsPowicDQRFY/PN4FqMVw5jSDwM=;
        b=opOkeaYm6ezDli5cZfNIZvQquGzR8uuJevVZ4I44hAtPoqjNnoMJNyZFGEtoprUyXo
         4fxdH2zUgpqfyJ0VJqIhEHM6jTicDNK/CSim64JvnKmV/GWDO1dOxHtaDOme+qwLTSi7
         GLBcGbYZDxmk+tQQJrrziQz2G5d3go/DDQzvK6ifIxGMA35IxHXZxfWy7XvoNv24X+V/
         5L4fiV2yZ8Nq87dck8tsaJuyzPbrGd8moHzkU8zU/PCrRkuWZoA0Sl77qYwrR6DRKuHW
         YbDGVuFeXDVLZcvp3HlHgRJTUZcmH4rcZSpY2L7o69ovH73R6yU+uiNUbxX+2puRq8+m
         ppqA==
X-Gm-Message-State: AOUpUlGvQSlB5SoGjDrHGE7fmjo/PLbXpEVwHUjAmRjYWAmO3bAsIRa/
        p7eF2lAJ62KlYZtcWTGzOi9mgJiw5+6M97dMyEfsYg==
X-Google-Smtp-Source: AAOMgpfoapxiadTZ+sJeXeYrXvXBvlo3+eCuCp3jCPO/ycP7VIMpXHK8W1v4cxdfDDFCNbsNjJqOWBxFd6m4juiGlQw=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr11462559iof.304.1532896782082;
 Sun, 29 Jul 2018 13:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180717161038.21500-1-digetx@gmail.com>
In-Reply-To: <20180717161038.21500-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:39:30 +0200
Message-ID: <CACRpkdbx1Zj8G0H9pKsF-+JfXBruE4_Rx3ZD5j8q3ycsNS+YOQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: tegra: Fix tegra_gpio_irq_set_type()
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 6:12 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> Commit 36b312792b97 ("gpiolib: Respect error code of ->get_direction()")
> broke tegra_gpio_irq_set_type() because requesting of GPIO direction must
> be done after enabling GPIO function for a pin.
>
> This patch fixes drivers probe failure like this:
>
>  gpio gpiochip0: (tegra-gpio): gpiochip_lock_as_irq: cannot get GPIO direction
>  tegra-gpio 6000d000.gpio: unable to lock Tegra GPIO 144 as IRQ
>
> Fixes: 36b312792b97 ("gpiolib: Respect error code of ->get_direction()")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Patch applied with Jon's tags.

Yours,
Linus Walleij
