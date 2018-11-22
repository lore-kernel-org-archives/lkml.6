Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AA8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F331820818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 22:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1S+X2SK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F331820818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392548AbeKWJHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 04:07:22 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44186 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbeKWJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 04:07:21 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so7433922lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 14:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HxIYaTGqvQBVuSugUZbn7UqbBfMYjreMVHeSBj0RSKM=;
        b=d1S+X2SKTFfnr+NaQjUQVYnI04JMqqb1TviNCflm/PNgXHA2NAD2TYPvWdh01soj/w
         fPnBvA803hagD0EFi+ADY6zVWQaoqWQEBkJSqo8rXfB6GZnmbyEHNCpNvZPJbVQ3aw+7
         cc0pMdPBr6qHVrZ/JMxzrnU30DVW2bUstufGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxIYaTGqvQBVuSugUZbn7UqbBfMYjreMVHeSBj0RSKM=;
        b=UrN9YXnZRFUJPq3urTFdl/DSny6Mj88y7VQDv4KnmGMXKh3RCK4pdpUgbjL2+ilOYx
         GKm2t47lvWlxj6il67qmckAiFZKrramEdFfTsNzbriBVZHl1tXx6C4Kr+4MUEMyWBf0G
         qHGg64bfiXEVei8BhI5zRX7duqccPsRnert4a6p6MuW08DN/w4O04MKoR/kJauJi1lSX
         uXkJRI+9tSChdMokAh12ttekj7OBRgh5pheCjXeLCcamUUkNmcfglSsWCtVOcROKx9UM
         a+XRidZwvtL9W/wvdnu85H7kXm2k8aKny85hnyFvIG/YwynPb4FzGfxT+9NGhpOP4JrP
         4dYQ==
X-Gm-Message-State: AGRZ1gJknMs0RFN41hZ7d+yytfub5hPnf4mN/ClP51d227l7nkcrhaOh
        dOI8SLTJPBBmP632tDaodZEkd+AqnVOH274Y2n9npg==
X-Google-Smtp-Source: AJdET5ddTiBevyjp+73fEEoDYA4M+9p7oZxK/nDUhS12JSrQzQ3cmG9sBBtjeOM4b1GloHrKy+5iBYTQm5sV57gAT9Q=
X-Received: by 2002:a19:5154:: with SMTP id f81mr8068411lfb.96.1542925554312;
 Thu, 22 Nov 2018 14:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20181122173015.23905-1-ckeepax@opensource.cirrus.com> <20181122173015.23905-2-ckeepax@opensource.cirrus.com>
In-Reply-To: <20181122173015.23905-2-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 22 Nov 2018 23:25:42 +0100
Message-ID: <CACRpkdYVT1Qgr5TzL0AMBWft-5airB+vmKJ4DRJR7Fcznfm0Cw@mail.gmail.com>
Subject: Re: [PATCH 2/3] regulator: Only free GPIOs if the core requested them
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 6:30 PM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Currently, the regulator core will take ownership of any GPIO passed
> into it. Makes end driver code fairly error prone as the normal devm_
> patterns of allocation don't work. Update the regulator core to only
> free the GPIO if it requested it, this allows the drivers to manage the
> GPIO lifetime as they normally would.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This patch is slightly prettier than mine.

Thanks!
Linus Walleij
