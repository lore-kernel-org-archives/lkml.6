Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353FAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27B920823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gFdpBV9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfBVGEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:04:23 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42774 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfBVGEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 01:04:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so1296117qtr.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 22:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vcj5TQMcSsyJZJCbz5AUMj6MPBG4OxfRpvXpAZkqqc=;
        b=gFdpBV9C4Mbd2JvBgbU8Y2aakbjO0gu8esadO4ez8gXH7Y5Sy1O1H0ZhpcDK7krSz1
         agGsV1YuujI3QZEQ/6wUsS4kTPCTmfnSql7iSx41yuBdqUrQr5xCehSIqIkeA/PFYL62
         XnGs+zE+vQ/FdiZUVmTNfA3mFkveehiGUMXCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vcj5TQMcSsyJZJCbz5AUMj6MPBG4OxfRpvXpAZkqqc=;
        b=h5v6dF10hQJvudmEw659JhfOoG37kdDuX6ulVGfHjUoi9N+dn68fyYWHTJOln/JTVS
         LJhYDEQdCeWfhIAJW6GvKOnAdFITCBwrO6LXe8LkRkD58Ib8z+gzDOIaKZb/6tUaGYIR
         Hr21AoSp+gkl5r3oQ9i6z6RogGfdp716usNdxcLmkZ6uNhfBnmPH1VNvz/Ezd2smbVeh
         4FXmh+QxAghXyGmKRdNxvravrLNjIU7PdKHSpRMX/mYeko5E1o0wWHRzkIfv36Sp1rKD
         Ml3pOOuWud4/gO2PAhdH3JsXS/chWIF25g12/SSZ1kk13wYJanqtclp2dR7V6Op+ruCY
         hrjw==
X-Gm-Message-State: AHQUAuaWGdXk7owSdG/yCWvCXkJC67xmQirkTRKO1EIOdjogLj/gAHMI
        ViJnWm0wmN8TFjK8Gp6rr0fz2zJ5Th68maDxDgNU3Q==
X-Google-Smtp-Source: AHgI3Iap6n9LK8B6/S8114PPRxStcC3fgbTuMGffb9kFKBSwbga6oCEbs6VF/0jkNvBwfmKJGV3lunzNookHZBtSlaI=
X-Received: by 2002:ac8:2922:: with SMTP id y31mr1756160qty.187.1550815462230;
 Thu, 21 Feb 2019 22:04:22 -0800 (PST)
MIME-Version: 1.0
References: <20190215090202.157100-1-hsinyi@chromium.org> <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
 <20190215092500.6q3hqnoufyowiqaz@ninjato> <20190215163657.fs6t7p3vqez53su3@ninjato>
In-Reply-To: <20190215163657.fs6t7p3vqez53su3@ninjato>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 22 Feb 2019 14:04:11 +0800
Message-ID: <CAJMQK-jzvMBD_AaB7XMJtMqNWiEin25bem4Zo9T5W86Z-U=Tww@mail.gmail.com>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to i2c_get_dma_safe_msg_buf()
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jun Gao <jun.gao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        qii.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the solution.
Previously we were testing if the driver can handle zero-length
transfer, but it turns out it will timeout. (Also checked this from
mtk's datasheet)
Adding original owner qii.wang to verify that. We'll apply this after
verification.

On Sat, Feb 16, 2019 at 12:36 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> >> > Ok, I can add a check in another patch. Should we return NULL pointer
> >> > if msg->len is 0 or print out some warnings? Thanks.
> >>
> >> No warning, msg->len == 0 is a valid setting. But interesting question:
> >> I was about to say NULL, but your driver would assume ENOMEM there and
> >> discard the message which is also not correct since msg->len == 0 is a
> >> valid setting. So, should we just return msg->buf then? Will this work
> >> with your driver? Can it handle zero-length transfers?
> >
> > dma_map_single(i2c->dev, msg->buf , msgs->len, DMA_TO_DEVICE); breaks
> > kernel if msgs->len is 0, so I think it doesn't handle zero-length transfer.
>
> Please don't drop the lists.
>
> Then, the correct solution is to forbid those transfer with this
> controller. Check I2C_AQ_NO_ZERO_LEN. Also, update the functionality
> like this .. (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK).
>
