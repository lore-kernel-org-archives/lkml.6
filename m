Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6B1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85C625DB3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYHi/NyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85C625DB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeGBNXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:23:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54974 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeGBNXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:23:20 -0400
Received: by mail-it0-f68.google.com with SMTP id s7-v6so1193103itb.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dNOaRtsYNH7Kpwa1tDvdcZQiVSGVbVoKdZqA6/Ail8=;
        b=LYHi/NyAVpXndDgO3TG2mmI0OjoT9i90B5FgD/4vAcQjZOPTVSbPqHZQ+pyInABaRO
         dSdnyY/4q0k5n8+cnfmwQ7FxhK0I6ocCfjdcHMlLTFT36hLzHPlYvwVj7dgSbGFasJ40
         qWS1zTYrs/boXGUs1J8vBjpMo/eT58p1WQ0KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dNOaRtsYNH7Kpwa1tDvdcZQiVSGVbVoKdZqA6/Ail8=;
        b=bQq1SLV6u/+ko8aXYWD9j/djoMDKLTfSssx6z/v4dfB0zAgGPYPHaE+MbroyPlHWOg
         P9tMXmvxq1wwTHeW64BuX50dYyymPVdqAEzHD2jTgJTlvvftEL1Hr2D11gnZUJvoTr8O
         9+HiQHv+mflFpzg4Oi6ED3AKo+s6h3Ab5aKN8oowOLWqF9AHqU1jcKiBmG5ZAIf2Yoty
         yDPPLHK/yUHsAEbKrfOcLSgZxvjZ/ZXwrB5+T6Tc2e2iA0zVh2DHPShxjGBrPnUnlSmn
         4vxlAC9p47IZu5FYvf9VAVNEBm0N8JXNddSFuLCNt+tSRKk2a7D5F6ZH9j1Lykwo6GIV
         F84A==
X-Gm-Message-State: APt69E350q2PbdOuFugf1YveyKCPetNgVG2bRhOCBr8Rfw2dJx5Qc8xv
        IGbm/7oMTuiznSABo2ryc1Ioc69tOskkm0yVn5O0YA==
X-Google-Smtp-Source: AAOMgpfSugOuCQY3fpUTjzGJ8lZO+wWJl7HflHDTtSjqz1bH23uRjJRsTSy59HT92TDy5WCFJLJM/XqDbTm+OhBK2oo=
X-Received: by 2002:a02:c007:: with SMTP id y7-v6mr3716053jai.87.1530537799607;
 Mon, 02 Jul 2018 06:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180628204344.13973-1-robh@kernel.org> <20180628204344.13973-4-robh@kernel.org>
In-Reply-To: <20180628204344.13973-4-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Jul 2018 15:23:08 +0200
Message-ID: <CACRpkdZU50xG-seDq8pZ0QLBXzn_Ygs-s1rJXGqzpfDJGbjDtA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] pinctrl: Support stopping deferred probe after initcalls
To:     Rob Herring <robh@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, boot-architecture@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 10:43 PM Rob Herring <robh@kernel.org> wrote:

> Pinctrl drivers are a common dependency which can prevent a system
> booting even if the default or bootloader configured settings can work.
> If a pinctrl node in DT indicates that the default pin setup can be used
> with the 'pinctrl-use-default' property, then only defer probe until
> initcalls are done. If the deferred probe timeout is enabled or loadable
> modules are disabled, then we'll stop deferring probe regardless of the
> DT property. This gives platforms the option to work without their
> pinctrl driver being enabled.
>
> Dropped the pinctrl specific deferring probe message as the driver core
> can print deferred probe related messages if needed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
> - Drop pinctrl deferred probe msg in favor of driver core messages
> - Move the handling of "pinctrl-use-default" option out of driver core
> - Stop deferring probe if modules are not enabled.
>
> Linus, I reworked this a bit, so didn't add your ack.

Looks even better now:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
