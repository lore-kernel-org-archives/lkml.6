Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB713C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8306F20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvKrU2mr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8306F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeLFWDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:03:34 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36159 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLFWDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:03:34 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so1557770lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 14:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIVn1IANWXQA5i6a6TSAERV9VhpsMsPWC04vE2MleWU=;
        b=bvKrU2mr+3sRGHREOdPQcAuDLSNkyu8hih2dUQRLQRqzRmoLvd40U2oq5yraQv7uHD
         wswgJGVmtlsBdlPJ58CFW8w8eGluyz5VBPtzxagMp7yIdIhiDUy+yWuyqMWFulABIqoO
         xSoButaovYJIMCF428wwMhPPzOapqAF3D/ZzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIVn1IANWXQA5i6a6TSAERV9VhpsMsPWC04vE2MleWU=;
        b=geDk34DXmCN/hcr6zxgw73rlh/LiLyI0Q12eEKM/UHIIsT0V5KrDiTyLWwhCCSc8rC
         SkyAcGJPspB1NVLVgKA1E83cB+XkGtK9aWILQ/C8uOcSMT4kbTUvcEfpw/99FDXA2BZ4
         JBunjEMWvYNOS8SpoHUpfk+TIbLs26uAFWcuv20IOSKKPRlwbdBrp75KB/11DEOS3B8M
         /ONbZsXghNGacbttMrko8S37CCm5yTikScLI2oynMCqfQmDHJUqurtuet26r7CnELgkE
         vMVc6Pl2/a92acKZMayo4Ed9TyinDxrcDdnse5z1l+a3i+cF6LuJknoQTTHk6uTheJv+
         XrpQ==
X-Gm-Message-State: AA+aEWZP8p1amJ4/30BHNGHMoxDoSFWPRtQ5f7MvfR17SRwH058gcJ9H
        TF7ZQKxcAxMRkILfPB4fnwGTA9mKSawni2NTU6kczQ==
X-Google-Smtp-Source: AFSGD/Xf+QXl6BKq/IG/hxCeoUvPyGIDXH0BdyMXT9TfLY11cWOQM/WZRCHIXPM6BofaMo3UaW/2PbplLi+LptSWQYA=
X-Received: by 2002:a19:5154:: with SMTP id f81mr18901095lfb.96.1544133811837;
 Thu, 06 Dec 2018 14:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20181206215858.3880-1-sboyd@kernel.org> <20181206215858.3880-7-sboyd@kernel.org>
In-Reply-To: <20181206215858.3880-7-sboyd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 Dec 2018 23:03:19 +0100
Message-ID: <CACRpkdbNs81HKTdtmVpo6swQj8Nc1dSutbyaDeJ1GsuDWzQToA@mail.gmail.com>
Subject: Re: [PATCH 6/8] clk: versatile: sp810: Remove usage of CLK_IS_BASIC
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 10:59 PM Stephen Boyd <sboyd@kernel.org> wrote:

> This flag doesn't look to be used by any code, just set in the clk init
> structure and then never tested again. Remove it from this driver as it
> doesn't provide any benefit.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Can't help but wonder what semantic it was supposed to have.
It seems a bit vague now.

Yours,
Linus Walleij
