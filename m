Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27686ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66DF20837
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WsJd5qEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66DF20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbeGPOI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:08:27 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53399 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeGPOI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:08:26 -0400
Received: by mail-it0-f68.google.com with SMTP id 72-v6so4706477itw.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pP54agDAT4EFv3ZYJ0+Ct3WArTjufuXUpC2V3rBYNwc=;
        b=WsJd5qENZgwrf47W5Ou4ySoe0k5qFGETtv4IHAWaEfH1e5Kt9cMdALd3/RyiGBPvQd
         lPoF24Ae4yF1Q8vT1FZ2BEX69FlkXHQ337wjWD1aPfeZqJmIjcMM24x9rxfolMMAJsTw
         okPmLtMzwhDRENA6dUVpdHND4IRwp8JMhqSR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pP54agDAT4EFv3ZYJ0+Ct3WArTjufuXUpC2V3rBYNwc=;
        b=IqlS/RGmF55T87CcZdO5ARTyVVjt2j032gyOrhCxwtHn6qKgve5Uio3fH4GFOK0/Xn
         x+MwAjxGQynRulHestiqWUMZq3Et3E7927bvVsppCiNywBIF/o8pD5eIg76Jb+ha118H
         E7r5ZvG10xL09u0OSADmru2IV0032tSMRdDC33fikl6D75C+hLGtaTRS4tL5zFRLMFrF
         jnZomw7vdSyq1BQvozwZq/Y80yxhlMa6VgX4pzTxd6zKKq9LxDeFw+t8s39O8bLhA6Uu
         7P9qG74bargDOviOch0hRnAnzAT1Jth2nnuN+rhGhbmgExNszg3kyplBtqHwzQFOW6rL
         ew3Q==
X-Gm-Message-State: AOUpUlH10IQ24cAIhwd/IePEWDo7695b1QrlF1Rq52ndLRSA+tk8Ymd+
        jsd0EyzWWV+wOv5EPlHttPKoikCWoI7uIqj3lMgTE0FIawI=
X-Google-Smtp-Source: AAOMgpd2wxnie7xbZ0MVKAHyJzY/NLnkolPo6UYXnPpKwjaiPmWgNpUZcpUthTwREQATXl9m8OaViS8JCqrZs5j/I6A=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr12483953itb.38.1531748456092;
 Mon, 16 Jul 2018 06:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180716083424.11157-1-brgl@bgdev.pl> <20180716083424.11157-2-brgl@bgdev.pl>
In-Reply-To: <20180716083424.11157-2-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jul 2018 15:40:44 +0200
Message-ID: <CACRpkdaWGwhJ1D683R+7TV0JsUg-pNYZ2xm_0+16O2NgnBo+4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpiolib: don't allow userspace to set values of input lines
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 10:34 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> User space can currently both read and set values of input lines using
> the character device. This was not allowed by the old sysfs interface
> nor is it a correct behavior.
>
> Check the first descriptor in the set for the OUT flag when asked to
> set values and return -EPERM if the line is input.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>

Patch applied! Thanks for fixing this.

>         } else if (cmd == GPIOHANDLE_SET_LINE_VALUES_IOCTL) {
> -               /* TODO: check if descriptors are really output */

I wonder what kind of lazy coder leaves this kind of garbage
behind for others to fix up...

d7c51b47ac11e (Linus Walleij           2016-04-26 10:35:29 +0200  451)
 } else if (cmd == GPIOHANDLE_SET_LINE_VALUES_IOCTL) {
d7c51b47ac11e (Linus Walleij           2016-04-26 10:35:29 +0200  452)
         /* TODO: check if descriptors are really output */
d7c51b47ac11e (Linus Walleij           2016-04-26 10:35:29 +0200  453)
         if (copy_from_user(&ghd, ip, sizeof(ghd)))

Oh that guy.

Yours,
Linus Walleij
