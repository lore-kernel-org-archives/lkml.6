Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743D0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA7120898
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjHby0ZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA7120898
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbeH2Lhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:37:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40502 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeH2Lhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:37:51 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so6010806ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bw4J5C+4dljYOjiVtoqxsnDzeVqB8xqjZmBgThgK4W4=;
        b=fjHby0ZHMYwLALvh1YzUTc6aUQavBWWIo1lOCFy6kY4XviT8cgWb3hQEe3I+cS9k0C
         35Kj63hr/VjQO4/emXhzAN5UaRFRsR+TTP6mvWdffOq3vP6MFynVT/f31M0lKP0My0W0
         63D/1Pg0S9VStEmW8Cun8aBJrLA6icXqVDrxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bw4J5C+4dljYOjiVtoqxsnDzeVqB8xqjZmBgThgK4W4=;
        b=dPaEIBS5K6/SAH6wXX98A1uVfCNOZ1j/j/HGlDk1dD6MdDx/d1KQ2bmMuKLs1b0QXe
         kSf2I1bF9hFKdwFQvyhX2aiEJasrujqnsudOCvbMC2XyTxik68ovErVwBvHwzyI0CrHF
         voOwYuARbClZYKcXXvbe99/95pDzhAXAXa5+cN7kzkJvb1E2MBTYARtDEoHOlQBTtqsE
         vjk0NwbM25wkFl0qlG/AAaiO9snC39UiKBa2LlW+ZDMktkIvcEiE1n6NlhUC2ohFl5Cl
         1CLPEwvgFrembMcmbPyqkk3282qT1d9N/2xsZ7Q8W5MyWY6+pDaFDJDO+jSEqxC4cWw1
         SVKg==
X-Gm-Message-State: APzg51ASzmOH3cqZ2IqA7aGxG9G1bD2ja7nM9Mtni7Gy6Hq/XAjVtqpT
        sP+oMqYUdbTJb9KmqWzpd8liFld/5fon8UxFX5MNFg==
X-Google-Smtp-Source: ANB0Vdb4/owKb5V33mY+JJ3FFqhiT7ZtKlJ5R7Ez50fxSzoO1prLZ7PHqh3MXzOhxmNf7Y4atXmwgGldHasEopvyOB4=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr4413550jab.87.1535528537586;
 Wed, 29 Aug 2018 00:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180816200648.90458-1-swboyd@chromium.org> <20180816200648.90458-3-swboyd@chromium.org>
In-Reply-To: <20180816200648.90458-3-swboyd@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Aug 2018 09:42:05 +0200
Message-ID: <CACRpkdaPRo1G1qmRvC61UPht=wqUJyA7djVfysMd_NAxeEtR+A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pinctrl: msm: Mux out gpio function with gpio_request()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 10:06 PM Stephen Boyd <swboyd@chromium.org> wrote:

> We rely on devices to use pinmuxing configurations in DT to select the
> GPIO function (function 0) if they're going to use the gpio in GPIO
> mode. Let's simplify things for driver authors by implementing
> gpio_request_enable() for this pinctrl driver to mux out the GPIO
> function when the gpio is use from gpiolib.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Patch applied for v4.20 with Bjorn's ACK.

Yours,
Linus Walleij
