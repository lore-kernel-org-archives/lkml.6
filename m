Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B60C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D52C20899
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfkNS8qR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D52C20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966337AbeF2JPA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:15:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53140 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935450AbeF2JO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:14:59 -0400
Received: by mail-it0-f65.google.com with SMTP id p4-v6so1945132itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 02:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0u8pOeiXOTCrPjIEN0/G8B2FoRAzc7uON2Lb0bNng9c=;
        b=ZfkNS8qRmel2kNInLI4kJPiTvG81DgElQKZYYyJCW685P/iQE8uJTBxt+F/ixpxszj
         BwlMr6BVxGrhKz5iNqTzRYlmy9nSyHamDZUEbMxMm2Ir63svgtcFyCcEvRz9Ua7P+iey
         gIfRwLyUz8TDe8SQn41rvV59tplucpBE8SEzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0u8pOeiXOTCrPjIEN0/G8B2FoRAzc7uON2Lb0bNng9c=;
        b=HY+ar7tzX81X9IOZZ1GnNeOeqHJ8YtCqvU2cvSZQmvUZR+9syv+rONrf6Gnupbnb2C
         fLRNS5+FAW58h80g1zd24/Jqo5TZ1lrjzMctN9eg6BSWUhdhqvi/2kgMyOtpiErUlVpp
         7cIIGtrXRIQ9fqppthqFUdPynKrpNEvg5vbwqLw4L2Sq5HwheXxePO68pca8JNbpyT77
         qBB/sBxZcJ9xMGHhgr72W2h5Nxc5qvUg7nIgZws4CIh9ZVu/YhiYHr/jiUNkmvsWLJSA
         mPxh/3JfgIqTLyw+v+6L/mXpNfAgKLCcJjxbNVtSAdzo29xFtdvp5jqdFMtXuwR25+to
         E7mw==
X-Gm-Message-State: APt69E37etZDaybPwXpf2NwnM4Cf3zJUiWbqvoBevjAi6tBHa7u9/63k
        lXtgfCbzHLPfL6jxUeSRefxp80gml4xoOaGSz3C+xg==
X-Google-Smtp-Source: AAOMgpdvK+fpb7wjBzP3043BNHZ+jhfQPXqT4NvXXeLY3i4LXvwcFYd3uDckbZxY4O+2Up12wMv7N4CVp6yKGCJiCvw=
X-Received: by 2002:a02:597:: with SMTP id 23-v6mr10870244jal.112.1530263698455;
 Fri, 29 Jun 2018 02:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180622043134.18238-1-benh@kernel.crashing.org> <20180622043134.18238-2-benh@kernel.crashing.org>
In-Reply-To: <20180622043134.18238-2-benh@kernel.crashing.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Jun 2018 11:14:47 +0200
Message-ID: <CACRpkdbhxjahYaVnQN0xqD0NLPouO8VCW8w-GZD0sbLFtFtY5g@mail.gmail.com>
Subject: Re: [RFC PATCH 01/14] devres: Add devm_of_iomap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-aspeed@lists.ozlabs.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 6:31 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> There are still quite a few cases where a device might want
> to get to a different node of the device-tree, obtain the
> resources and map them.
>
> We have of_iomap() and of_io_request_and_map() but they both
> have shortcomings, such as not returning the size of the
> resource found (which can be useful) and not being "managed".
>
> This adds a devm_of_iomap() that provides all of these and
> should probably replace uses of the above in most drivers.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Ugh I just feel I have seen homecooked solutions to this problem
a few times :/

I wonder if it is easy to find these cases and replace them with
this neat function...

Thanks for doing this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
