Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3C4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36B420851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 14:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DaNwBBQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36B420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbeKTAiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:38:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43980 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbeKTAiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:38:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id 83-v6so2888120ljf.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 06:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3GcNAesbYzt/DjPftzae5NWWeVX4MMv9QKmjCKn+Nw=;
        b=DaNwBBQzwhIczw2IVdfPHlNTNREen0lAVQfbfs0R4SX/ob19fJdk3+O5mEeL07Nqaq
         +mgM8EOHIZ6ygAR4nbmx4Xm3QmVCxMHgfP0zbVQxAuACUzPCA37xZgwK9bOX+J2xsyex
         prDZmR4QHt6rr3EhbWpAD5FPYf4Hxb0BfVPIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3GcNAesbYzt/DjPftzae5NWWeVX4MMv9QKmjCKn+Nw=;
        b=kmaHVBYWY310elDumjyyfjKsfpa2GBgSstIltsf64tAu8tsJLGezbVy6lFxHGRS7vo
         qDDD6BBA6n2agkLh57peqHCJQUIH4WqQ6EyZVb6tJs4/zTsi7aCdOVqm+NithT6suW40
         KtVzsFBQv9GPrcM2WOrtF6yBZrGXxrSJ1tROJaxyemFHXfiKoTbaXaKhivWDEM1ZubHC
         DbpH4qwGcJjQ+24vHNXJaJYq+BPnkLmYwFsdWKLGxPlFgciPC2SSMNEtJXQQNlXfO+VM
         rC0qnrBrI/fHEevpJ5fj3D9unfvGJHty3SrNZSWKin9+NIH1rC15QL8rnSv3QqK2LDws
         0xfA==
X-Gm-Message-State: AGRZ1gLWGh4SqBECaMLm7RDFbmr+D6+gSWpzUpkWYXMWxPnZ5yG2Hzi3
        VoSbW4Ws94EUtvDb5wpWSZw1RBTR3or9aUo3kgwrZQ==
X-Google-Smtp-Source: AJdET5e8z9yClMVWYQvP/2a/3XENephiEN0tFFih5mTAe3LnvutMhJ+vrRqqfrMETNM5DtZSKswc4din/c6uB8qeWzw=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr10710625ljj.9.1542636871397;
 Mon, 19 Nov 2018 06:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20181116220540.17222-1-robh@kernel.org> <20181116220540.17222-4-robh@kernel.org>
In-Reply-To: <20181116220540.17222-4-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 15:14:19 +0100
Message-ID: <CACRpkdZnS4BkUJN_rjjPcCQAMDd0_4KZ_LgmYYtmuuBuRg6jgw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: Convert to using %pOFn instead of device_node.name
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sean.wang@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 11:06 PM Rob Herring <robh@kernel.org> wrote:

> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Sean Wang <sean.wang@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied with Sean's ACK.

Yours,
Linus Walleij
