Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AAFC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71D920989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEe/SNiC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71D920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbeLEVzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:55:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33411 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbeLEVzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:55:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so19808947ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 13:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMl1ejEDM5uINVzfAnsG/7CdXHc2a7TIllWLS/zsn00=;
        b=jEe/SNiC0E+lJKZaYkmC/VgUVahjzl7RHmRPTfD05OBVz5JAVJaqJQpvttGZ+a3ki/
         2WAnQX+SCrTKCBZS9mVyxNY06MNnqVReTogSKlzWVTR84vASefWVGP1Hq7HY3iXawvFf
         bpG6AwJzNpZn69T0yY14OHooDCEtSQ2dqwAFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMl1ejEDM5uINVzfAnsG/7CdXHc2a7TIllWLS/zsn00=;
        b=KoMqq3S7Srh31Y8HCR03zaQOMo5EqvfDoMNzrR+khdSeQJyIdPIcgMheMONBuPHgcB
         53+DgxLEIieP9S6o8rxjT1oGJf5Fqre8NxzKyovsWGXg3DXo4+hADNi/0G6R4IdnwJmF
         /zlAtqqxrtCagAI4A5kTheyQzJWIXVjJeqt/MSBbc4126qxlEH3aNJIIvDKomgDFTUtt
         RrwVI7D9MuBlnJRSC5SOnYMljBsOqxtnk0CSRHYv7BpaZytADH2QguVfJjRIp3q78im8
         oPD8uqcC8zOZWcZey19qivyyUiNMHrIpaQU6SLcoAgpgJfYk9eC3P+KNCPLzRkX3FiJe
         9oXg==
X-Gm-Message-State: AA+aEWboMhTlN1qm8HHFEVrm1UY+HP2iswlz43KWSQXFsKiAwhSVHfJs
        z2J/yqOMvtzV1gUcTWTCKPworF2WGZuVFCaTdTH1T40tlMc=
X-Google-Smtp-Source: AFSGD/UxItVBbkhOoXYO95u4RSfQgt1eYpUTADzkjN/ykb7o4fyYjZI6CfOsVpZryWlCAj1G2lRCcdIa1GaD2pWQ5rY=
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr16711079ljc.97.1544046951271;
 Wed, 05 Dec 2018 13:55:51 -0800 (PST)
MIME-Version: 1.0
References: <1542989578-21200-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542989578-21200-1-git-send-email-hofrat@osadl.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 5 Dec 2018 22:55:39 +0100
Message-ID: <CACRpkdZPs0C-14itiR9xM+WPegNHBo9MgyHL5fPBxdZ8V3fUaw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nuvoton: check for devm_kasprintf() failure
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 5:18 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:

> devm_kasprintf() may return NULL on failure of internal allocation thus
> the assignment to  .label  is not safe if not checked. On error
> npcm7xx_gpio_of() returns negative values so -ENOMEM in the
> (unlikely) failure case of devm_kasprintf() should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 3b588e43ee5c ("pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver")

Patch applied.

Yours,
Linus Walleij
