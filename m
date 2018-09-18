Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F2DECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CAA2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2yEJUyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CAA2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeISBAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 21:00:53 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51746 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeISBAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 21:00:53 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so4976531itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFfOPiT8oqrY99jPC3JOO34Vv94EwjCqtI8GqjM+GVk=;
        b=F2yEJUyr5HHdX5ZVu9C7FClIzCeAjgUnS/8256CZMydbX0tm9CADfDNQGUoNhVt2N3
         jY4GDWehfQCNmIyPWxK5S1UZQRj4/xqDWuBh5mzzyo7XsiTnttLVm512mDSp/eG9AMW1
         +WP4Ct8YuMLeLjVKfv1cLBTll0ZkUhZrNi1RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFfOPiT8oqrY99jPC3JOO34Vv94EwjCqtI8GqjM+GVk=;
        b=SgAIJLFKqFYmwvasfpoJEg3gQVQjLh6efwDAbjU5/vGElzwo8vhFFLXXjhNjZcjaPN
         vKZk8bHT2L9Lp/XxPSvx319RBKz3DM0NKphJSZgP+Vd2Gg6wIJWNjgVFxrmUBD1gbi3D
         wPoU0Iu6QbJKuaDznm4kOC4RHjGMC0N8civXSCg1gmvYaD7FDoTEvcmpKsICHsulJ6iO
         PBkd9i0A75kqF5HkMEnRLe6BtE4y/IpuLCkPT37GUcP56VVtZmduKFAj5nw6ggGVk628
         x/82tRYpAN0UZb6B67PieoXd3kCXH/DfNbq2FNoDT+NvT2rosm1q+QQO5AsM4Dipyf/D
         qzZA==
X-Gm-Message-State: APzg51CHQeY6bzG5EI9qrmLIYXSO4iH4bq+/TOKCPskcSli07IWA/h3/
        V81aYKRe+dHMcEHLv+BFLolMx4BxcA7Jtet25FynfA==
X-Google-Smtp-Source: ANB0VdaRbuvBpQrAaJh5YQi5jKuPbBEKkGXD15wFJnsAaixgGEgRyIVpmoWIprph7t6aoHQf0/SAMjaonkGipjgTL3c=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr27497480jab.113.1537298810870;
 Tue, 18 Sep 2018 12:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180831191326.25106-1-afd@ti.com> <20180831191326.25106-2-afd@ti.com>
In-Reply-To: <20180831191326.25106-2-afd@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 18 Sep 2018 12:26:37 -0700
Message-ID: <CACRpkdYmYHL1vrRFeyuO6immh9ZtVPeiOo+=ZB9T=CHe1yGTxg@mail.gmail.com>
Subject: Re: [PATCH 2/5] gpio: davinci: Use dev name for label and automatic
 base selection
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     "Nori, Sekhar" <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:13 PM Andrew F. Davis <afd@ti.com> wrote:

> Use dev_name to get a unique label and use -1 for a base to get our
> selection automatically. We pull in all GPIOs per chip now so this
> does not have the effect of out of order labels like before.
>
> We do these both together so we can drop all the static data in one
> patch. This also lets us normalize the return paths as we don't need
> any cleanup after this change.
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>

I have tentatively applied this patch set as we seem to have rough
consensus that it will be OK.

We can always pull it out or revert it if things break.

Yours,
Linus Walleij
