Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24799ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C972F208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLksaa9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C972F208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbeGMHZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:25:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:54229 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbeGMHZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:25:28 -0400
Received: by mail-it0-f65.google.com with SMTP id a195-v6so10267561itd.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Psn7iVUipjDOZnGxG/W6Pl3RtYM1GqekXOtc130HtMM=;
        b=dLksaa9nj8i+AvlCseMRblZ6AB4+aapc8vqEMI7tSkEPIZ86wfwghZPNQYSzxQ/BBc
         RPugL48f/BJZZY5NsNTFfFRYnUSyPDYfbylBOL/HoLHUeuz2x3DrAcXI+nc20Q5LN3FS
         BYzKol4H+XsXCx8cayJg2swJSXBjSZXmGMjKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Psn7iVUipjDOZnGxG/W6Pl3RtYM1GqekXOtc130HtMM=;
        b=DO1cz2/vzyVGO2wuhkve5QraU5oL5ZLtL7NLmBivSWynxNwFYWPjWbXCQE3cnj5o70
         PXeU8d/IaNQ+q2GbFzDnHMOGMIL6yTIO01HKPng7i936WBidCdnXpBS4vo08KmeNQTws
         n3fF6UUIxUpJRiM7sVptgFNoDvnSYuURIR0uwixffmDyG+cJcM2iaNyo2vk+b9D8JpOW
         mKwRMoABJBGNzF4v8BmwQygJ3D6NLgiPcqpAxrxst8fSjkb7wzpVhznKPIqj8RkSRK2H
         6ed0KuJMKI6HOWL4MZ0wumvCw3wUSGRVNg+G/lzFi7KcGcpHkNdaYsELEiIchxBMPqHy
         aaLg==
X-Gm-Message-State: AOUpUlG5kB9n3dzvobC1F1ZtwvkAGIyhhqv5k60lrTlrvFG7tbo5EWUZ
        eHbvRB41kR9YDmQ1iW0hTl6ed3BhImiNRfqaLkvviw==
X-Google-Smtp-Source: AAOMgpfwh3Z7oFyqff1t92ZCbYqI2PUEmezSZbL+HUeHMeQpzZ0GZwxFE/5oDZr2P9ebtxu25ZcGPUCD2yq/NMak5Do=
X-Received: by 2002:a02:597:: with SMTP id 23-v6mr4290222jal.112.1531465930640;
 Fri, 13 Jul 2018 00:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <1531208921-23342-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1531208921-23342-1-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 09:11:58 +0200
Message-ID: <CACRpkdaKQ_Lg=t3DLsvXQNLwi=BYugqNGyssEM9Hn2Ss5r-kQw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: add power management support
To:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 9:53 AM Anson Huang <Anson.Huang@nxp.com> wrote:

> GPIO registers could lose context on some i.MX SoCs,
> like on i.MX7D, when enter LPSR mode, the whole SoC
> will be powered off except LPSR domain, GPIO banks
> will lose context in this case, need to restore
> the context after resume from LPSR mode.
>
> This patch adds GPIO save/restore for those necessary
> registers, and put the save/restore operations in noirq
> suspend/resume phase, since GPIO is fundamental module
> which could be used by other peripherals' resume phase.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Hoping for some review on this before applying...
Fabio? Bartosz?

Yours,
Linus Walleij
