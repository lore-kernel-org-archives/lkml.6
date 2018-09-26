Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F184C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C6D20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BCbJ5S1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C6D20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeIZOO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:14:28 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39865 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZOO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:14:27 -0400
Received: by mail-it1-f193.google.com with SMTP id w200-v6so1650509itc.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQXH6qJ+uLQh37Drbo130uk4muxCAwA7iDbSm3jOAAQ=;
        b=BCbJ5S1h2oTem3Ao0+PPdLYWqxQNh41FTA5YHgdP5SdXk4xEJM2Grfmv10/zJrKF7Z
         XPD70BLf+HSWsf3z0FoNyPVzOlw8fGAURzcdApUkiqIAMrog8I/FjHmTA6BwJrycLoTl
         GtLojnwfI+kzEFjRlXTK8MhHJvaIkdr6DVrHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQXH6qJ+uLQh37Drbo130uk4muxCAwA7iDbSm3jOAAQ=;
        b=XPKRGOat3nV471LGesGV1QOXCM6aJnGgZeRE0Cg/zGT0+H9scCoFwybh3sLA4BMq3S
         KycLQdFFSWRvTiFxEEsPAT5cRQfFuimtQiOaKgddMfielWt+betmkExrxhDC2/wI3l5g
         ITV2xegxSni5t7vurw0l0/sgMapqIq4Gma6WZNem4eQuQKabei5TUgtnpm+vJ0wl9VS2
         DikZcUjALpGRsAP9WITsF44fWvAfSmXZbZEUHPf00tCMnRg6oUaF17LZSPRE0gKhX+jb
         I+IxV6uUC1g4nGwopfkEqoW7U7sbSWFgpJGuggYSYXyconu/YKc8sy7SNTyqUqJ1Mxuk
         0Hhw==
X-Gm-Message-State: ABuFfoiasjwuVy1lA38YDMj7t0skpLC7XKqL/5rGXiWJoqSwZ13veUs9
        NPPfjw3dYVbEq6lazVSywYwGokrSy5cBCXIcInYCAQ==
X-Google-Smtp-Source: ACcGV63zoY+1nUbOvD5Z4L3X7VEfMREsIAyq2CxgRzsYWlQWFzuliT0HfHy79JuMywoSGNMTCLo3AedmrjCWMhGzwRg=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr4542472jab.87.1537948966731;
 Wed, 26 Sep 2018 01:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <b78ff03ecd251b63430f05b505e02b19e196364e.1537930252.git.baolin.wang@linaro.org>
In-Reply-To: <b78ff03ecd251b63430f05b505e02b19e196364e.1537930252.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 10:02:35 +0200
Message-ID: <CACRpkdaX7WPKaEqhv=mW1AMsbamNiX65V-1E_yigaY1g9irQKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] power: supply: core: Introduce properties to
 present the battery OCV table
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 5:00 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> Some battery driver will use the open circuit voltage (OCV) value to look
> up the corresponding battery capacity percent in one certain degree Celsius.
> Thus this patch provides some battery properties to present the OCV table
> temperatures and OCV capacity table values.
>
> Suggested-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - New patch in v2.

To the best of my knowledge this is a very good binding and core
functionality:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
