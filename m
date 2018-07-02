Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0E7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E272A24923
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bjchgcrl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E272A24923
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeGBOPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:15:11 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53541 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeGBOPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:15:10 -0400
Received: by mail-it0-f65.google.com with SMTP id a195-v6so12333625itd.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/m29Ta5iLH/zZky/MqyYzPGKKwO9H6TQ6btY6btDMg=;
        b=BjchgcrlM2xDv8Ss/D9yr3Y+TzkzejycqJD33HpKfXCW1xYtBOHLwLuwGRd1b/RsM+
         M8tvAw3RSkumwp+ePVMH5sYiSlBXtZ+EGgnGFnjqib5XySx6xAkJ4Qd3XpT2GPf5mlqk
         6N5hwPWABdVNWYoh2MJRkpfr7J5k6Ydr98KG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/m29Ta5iLH/zZky/MqyYzPGKKwO9H6TQ6btY6btDMg=;
        b=FssdTq9dFJoHJpn+XEpX9y0z0BvXWrccYv4BenqpyRc5pd3N5UCKZkkUY4j8GCRnjG
         oQxwTq9TqBRBqfqpbgLbzJ7UfdvFS65nq/6JJUV7858WT9JRgRcH0+6W9eAI8n2EA0Of
         jwNFkN3s45jpFgTdlBnzbLI7sSSfFdLfAtyWNT4YWqGl8jEXbrk2dssFtq86QSlGncjJ
         YK4uLp72MQmPcwjb1hRb4oyJrVgpsmemRKq28Xp8a8Ih3w6gdSuE7aa/ocXVe4TEQxsp
         Ydyqc+ZOIx+JMRJSDZukAoT4b8Y3XrTZdAMS9efH1z5cLRc4z74BTySwIlvCgoEhXy3+
         6iVQ==
X-Gm-Message-State: APt69E2rOkwMVaKxV6pAAkYrMq0VtgdP4eoUwTxcXPLmVIF32r6CbarV
        xzdFQZZtOiUZmtpJbCL47WqJLFN0J/MEPiPrR03jLlG9
X-Google-Smtp-Source: AAOMgpcXyo83aYFw0y9kGehlgZV8+UQiGLewG2Jktqfw/ei14RSTwQ3GZuqqfoGzP5l1AKO3UfXad3HAKKtrbkTyx68=
X-Received: by 2002:a24:5004:: with SMTP id m4-v6mr8123899itb.38.1530540909597;
 Mon, 02 Jul 2018 07:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180629185107.GA37488@beast>
In-Reply-To: <20180629185107.GA37488@beast>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 Jul 2018 16:14:56 +0200
Message-ID: <CACRpkdbmd6ufb8MF9EtN3ftqTFEnXZfp4Ew=_viZ-8byOw-j1Q@mail.gmail.com>
Subject: Re: [PATCH] dma: ste_dma40: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, vkoul@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        dmaengine@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 8:51 PM Kees Cook <keescook@chromium.org> wrote:

> In the quest to remove all stack VLA usage from the kernel[1], this
> switches to using a pre-allocated scratch register space, set up with
> all other other allocations.
>
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
