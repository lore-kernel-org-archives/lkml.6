Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88ABC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51467206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AumPSO77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51467206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIJLhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:37:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35841 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeIJLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:37:24 -0400
Received: by mail-io1-f66.google.com with SMTP id q5-v6so6136097iop.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 23:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ZQsTl1pZ8feUmZh+T7DLuUmBLhi8FCBUg2HUTRjNpU=;
        b=AumPSO77d2/qanzm3GAFh56Bj1urKebQF4oPP8zpovrp0cEQtyZY7Pf7QaX61a2lcv
         FCVGGnGrVvtKTBY2/CMryFKvT1Wi+2vWkW8uju9UPfERCQAWljWrKsW5oY/kzBmnQqQY
         zv4ZfJOCJLrmNvp64UUc707yWiK0i+8wH00Oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ZQsTl1pZ8feUmZh+T7DLuUmBLhi8FCBUg2HUTRjNpU=;
        b=qW0BxDNAwWmnPhmedgFILpAy9mWETTvcsg67hpD1tTYIpSWBVfSsLT22YWQwdg7SmX
         sMERlTfhHGLwPqXYeDWCp8xJHPW19N06zaIhVG3qC7/lzcJd4uAWr1eyCLbC72Gfm3nM
         0niO8B+Ym5ecidL19SIx5veujtsnGB2FwwmE+w1LFsKaHi6byg6RgCmO+HLkwFbpR9/D
         JvctDF3wuur1gZZ4SE/uYvf3HYolz4XAmeh8xff48Dz6CISvSW2fO/AUs0wl6ErzB+Br
         UCy7WWC8pEX0D96h47PoHomeLugiZNLi6lHOYYKYAqZelBc1zwVrqa7+xbKM64a+QeLe
         K9hw==
X-Gm-Message-State: APzg51BFF3wqJUGE+O8cBkKa687wtgqSxoA9NYZd5saILxHZZ4La+s0Z
        talKI7AawLkXWhOjD0CpAbmDLVYZJExzfGgd91FCCw==
X-Google-Smtp-Source: ANB0VdZh5gu5QwR1mnloHL6Yj5YGAUcaH9q60rMc/YiBCIJQySWEH7p5nJGZCx0d7HUb60m+wvAp1LjHixbRZVQ/sho=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr15077322iog.175.1536561894449;
 Sun, 09 Sep 2018 23:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180909203848.3470-1-alexandre.belloni@bootlin.com> <20180909203848.3470-3-alexandre.belloni@bootlin.com>
In-Reply-To: <20180909203848.3470-3-alexandre.belloni@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 10 Sep 2018 08:44:42 +0200
Message-ID: <CACRpkdaVH7_eVGC+CRQqsA1Y1+oMkkVhVPJmpiE=k90qa23SQQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtc: pl031: switch to devm_rtc_allocate_device/rtc_register_device
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 9, 2018 at 10:38 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Switch to devm_rtc_allocate_device to simplify the erro and driver removal
> paths.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
