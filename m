Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 22FA5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91E8208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91E8208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755809AbeFOGUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:20:32 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:37420 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755620AbeFOGUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:20:30 -0400
Received: by mail-ua0-f193.google.com with SMTP id l14-v6so2305262uao.4;
        Thu, 14 Jun 2018 23:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=330vow/q0CgZ0H82WEtLv/ksxDaS7IcwPH8Cd1GjKL8=;
        b=mFJxZXj6XaWY3r6h4YT3C1lKZvYsl7SzpEUvGdXCMF+J4fSrhg1ZLAt4EVYXnjFcPr
         RLbX4FJ5TcyLZ5B26HctB/+XuV7Sc6tF9ihaN0J2FXR63KAzo6OgZXA/ZBHTgqTZHxHs
         UUBs9/7VfuTVc4aO0nZ+NhHjTZmOn39ztfPrKfNQ9iym1VMzZdqj6d4x0/Y3jblayvfF
         mPG1aj0XXUKUSxu30HvrHBB0drDpU1SbStuL/V6ShiRaBZzHwq4we6W0oABlGmmd/lgH
         aoIQPxLphWAIYTVlpCC7AU9BnHsHkoKRvZsivRNocW8rJaWJKlGn+d9BHmEv6BMFnyUk
         Tomw==
X-Gm-Message-State: APt69E3P228DrsYzFf1ZhHx90fuYHG0NuiqhqYDwl+ITRdSd5UuvDLOS
        eXPv8/L7AeTcv2taa7CF3pL2tJd8cOXRtAKsecY=
X-Google-Smtp-Source: ADUXVKL5SRZK6QeTNFwmLy3dFHt4S2xYjTSwHE0gr7XRxQGbEx0WersyAbfqEIEj5EvDtJ9SPA89MDhmI3evRDx3LkE=
X-Received: by 2002:ab0:5105:: with SMTP id e5-v6mr238433uaa.33.1529043629158;
 Thu, 14 Jun 2018 23:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <87lgbgswl5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lgbgswl5.wl%kuninori.morimoto.gx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Jun 2018 08:20:17 +0200
Message-ID: <CAMuHMdU_csJSYQ==Z+MOMGMi1LJ07_ZOojYADyUwaDcFLTT9dA@mail.gmail.com>
Subject: Re: [PATCH v3] dmaengine: rcar-dmac: don't use DMAC error interrupt
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran@ksquared.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Morimoto-san,

On Fri, Jun 15, 2018 at 2:53 AM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> rcar-dmac has 2 types of interrupt, 1) error IRQ (for all),
> 2) IRQ for each channels.
> If error happens on some channels, the error IRQ will be handled
> by 1), and "all" channels will be restarted.
> But in this design, error handling itself will be problem for
> non error channel users.
> This patch removes 1) handler, and handles error IRQ on 2)

Thank you, that explains the rationale!

BTW, how can you trigger an error, for testing?

Thanks again!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
