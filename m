Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6796C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E702081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jp50yxUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E702081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeJ3WID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:08:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45288 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbeJ3WID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:08:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id c24-v6so8796138lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vl0HyFr3dq0xQVM/zfnWXgc5CNEk/3xLwfWTWcjCfpM=;
        b=jp50yxUyrSf6yYtMGdnnzdA/jphw7p+D1856F5d2iH6+qZGOmquj2dBwRRhBSNutDQ
         viPMnK5hR3wRCn9B82zY3/WkIgPojylUlQun/WM4SEiDrIoS9CkLn3AmTaOkcVpYGaSH
         ymeQ4U23wubico9wJCEUoq9ym/Drz4ScObj1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vl0HyFr3dq0xQVM/zfnWXgc5CNEk/3xLwfWTWcjCfpM=;
        b=Dg3uSpYYbGW1eVf6RHqSdpYcn6plVyZS2HmBP2lx7E4es7Ji+43AW3xdawswQiMkfs
         34ic1tV/ioDuqmQz/q+lkitMIWBMyJiPlay2aV+S80AGVOZecntHGDo83btAYWx7ZyXG
         GsxEdOwdwxCK/uAOazPv/e9h3dEuRpUoTLa1WD/Kkq6Om/DOvshSS7iltW7bNU1cSLox
         eHVpEWDETz/tiEalrfCD30QKtoqD5tbhIhcviQUU0q4ZhZdX5mOaIbMNrPeI9v4HJ/da
         gFdSoB9LnxzHNs6jgyt0bjQMZ+GhXlfvhAazYbvalB1tQb8sVlJRlv89OY7VPreU4ZE5
         kuuQ==
X-Gm-Message-State: AGRZ1gK0qKdmaH9Es3vk8szVPdFxOvPain33HXSxx1Em+TZhnL76nUvY
        5Rl8pGUECojj6YvsiKluHrBo0/kn+HJwSTLGKYUpiFEasxk=
X-Google-Smtp-Source: AJdET5cm3bdHt3REhuu9HJe+MAMfc12f9Il7T40TvnYMeTdzlSaoAt4V+V8aB6MeGAMgTqeUQXMEHjBl6v59vkRFbj0=
X-Received: by 2002:a19:5154:: with SMTP id f81mr1967726lfb.96.1540905277666;
 Tue, 30 Oct 2018 06:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181021200002.1472-1-wsa+renesas@sang-engineering.com> <20181021200002.1472-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181021200002.1472-3-wsa+renesas@sang-engineering.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 14:14:25 +0100
Message-ID: <CACRpkdZB+WMBuuqOENFduBHFQvGrxN--nPxF2dr6Ov4i904L7A@mail.gmail.com>
Subject: Re: [PATCH 2/6] gpio: gpio-lynxpoint: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:00 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch applied for v4.21.

Yours,
Linus Walleij
