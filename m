Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46133C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C3522399
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOCfvh0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C3522399
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeHJXpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 19:45:16 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34273 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeHJXpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 19:45:16 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so8879796ioj.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khmANU8iDhx4r8vxpuS8hQodT9G7h2LbOa34r6pb+eM=;
        b=EOCfvh0hN+eLoJDFIxwRXOK46dG5Be978UTS+cozwISs2ilUmKly+ufP6iYbNzcK5V
         G7gHV1MwYk3uD5Yzq4B6cigWiudMe5wqm4xmQrZtJVxyGimuQmrU340NtxGbuNGbZgqr
         IBXPrLetcmpEDY/ItaU2i7HrSmi30Of/D7EYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khmANU8iDhx4r8vxpuS8hQodT9G7h2LbOa34r6pb+eM=;
        b=dKxe2KiTke2lbtYbq4UMZyJNqtK/wixs1C3RfHWMz9H+okZO/SXH4jkdlaWI3+33g9
         1iP8TFXLfINZKwZ8Jt2G/pZibN89gss0WkmBNez3LFRVzHqnyFDYw4zn7DSu/UXxOOHd
         RDkT14Ayq4LQNgkUSWk81uridrxERa9SGPdGTxuy9IUsmS3NljKN4r8I9eFmbq4jyaYT
         bxEJjT+fcKyF/vAK+TyuYY+3j40e8UxyITtioekYQDKBkd9yDNEEYqIw6JAR0BaW3GuN
         XXye0LbNuuQYNfuo01z3D1jIIVlvSPSPOns6oBKDDOA/Xnyiq9oUHKA23KuZ2wGBuDSM
         CT6g==
X-Gm-Message-State: AOUpUlGcGCiQM8qew23+wkudlwfZ3h2JvCMZFKkAbkMLM98zzNBwaX4W
        kwGIOUWx0YykXwsgYJ2ouD0uxp9Bae44dSZV1poZv+6S
X-Google-Smtp-Source: AA+uWPywwlMx6/gnEkanQjGHxrCDtxV4UAI0zBozuLrX2V92taK1705jr6stwnlY/XxfpgXh7iPRR4P7VbAOOcDanrE=
X-Received: by 2002:a6b:6306:: with SMTP id p6-v6mr6888501iog.175.1533935623355;
 Fri, 10 Aug 2018 14:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180806160635.9293-1-vasilyev@ispras.ru>
In-Reply-To: <20180806160635.9293-1-vasilyev@ispras.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 10 Aug 2018 23:13:31 +0200
Message-ID: <CACRpkdY1wtMN_bq+za=nhd_xYb-23g2zeA++ouwxVsJMxH5L9Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: axp209: Fix NULL pointer dereference after allocation
To:     vasilyev@ispras.ru
Cc:     Chen-Yu Tsai <wens@csie.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 6, 2018 at 6:07 PM Anton Vasilyev <vasilyev@ispras.ru> wrote:

> There is no check that allocation in axp20x_funcs_groups_from_mask
> is successful.
> The patch adds corresponding check and return values.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>

Patch applied with Chen-Yu's ACK.

Yours,
Linus Walleij
