Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BB3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54E142082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 01:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J55+Hk4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E142082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbeJ2Jyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 05:54:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45785 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJ2Jyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 05:54:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id j4-v6so6130892ljc.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 18:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+idCyEDGJUsJlfdPpRfYHEn1iIEIQaBySi+75+40YaM=;
        b=J55+Hk4Oa3M0DDIDPce25DSFwtjTjpm647otTxrMNNQ2ahXhJGAKeS32S0VRWVkuCH
         oFTLfhZcQ6O+wiPQ6ovpDMsHeUDeIcPG5Pr2r10KeJt9s9UD05ciahrNjNsywGwlN8ga
         jr9D4KziD1v2seHyDMKyN7uVM/NweY/5u5zWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+idCyEDGJUsJlfdPpRfYHEn1iIEIQaBySi+75+40YaM=;
        b=IqiyPTWIA+6kgkVMBvxX236uu5ZUhwvQKWzWqA06Q6G8BuL1BxHUplBNSphIOv0RPQ
         D1TM0gVEXO11Wrj5KwJ1k3FJMScvPqJaFbYsCNhzgNveAurIsCtpSCfDKOQLwkN7BfvG
         mLXWZdeUW1Y9wmcATKX9qi+sdrVQXk55oze44ZGp8rL1d+aUwMfhuUvE6aPV060rTQRU
         4s/651NtnhpkYeHlRTiUSy2PbpahV49dIaCUNGAD/vSVYz+TwZsRnlUyjhxDyRBe4oY3
         C8YYhE6mr76I+b3KxAi9I3AnbqO6JNmEVL3l6ZOLbj7p2qXb+5ZaLWRedC/j5b8Hmd0/
         qSyA==
X-Gm-Message-State: AGRZ1gKEcI35PuQNQPPtdM/yEj4vJdnVVuxSsETjC0/wfZ7wRD57xxWy
        m3l4ViA4hIVaVkZ0CA1KmojoixA2Zw9ouw==
X-Google-Smtp-Source: AJdET5e/fuDx5ADRIf15Vg6Ld3vJjzpcaCXKwgBrbjGGzHRrNBqL4MZWQjpWigU/bb2RV0GFEvZU9A==
X-Received: by 2002:a2e:5b93:: with SMTP id m19-v6mr6619722lje.115.1540775297572;
        Sun, 28 Oct 2018 18:08:17 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1501804lfc.47.2018.10.28.18.08.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 18:08:16 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id m18-v6so4737912lfl.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 18:08:16 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr6642683lfi.138.1540775296160;
 Sun, 28 Oct 2018 18:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tw3SBUaueL2JGTybfkQo3f6qbQ291i3XTW-w32xdKsT-g@mail.gmail.com>
 <CAPM=9tzoxXgznLGhDt1CXwyrLw3ZUSetviPHEq5Fk=ojTNLZ3A@mail.gmail.com>
In-Reply-To: <CAPM=9tzoxXgznLGhDt1CXwyrLw3ZUSetviPHEq5Fk=ojTNLZ3A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 18:08:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9FxC4NMq3GZTsbqw0s5w7C088CooJSds4PtHEYh4dHw@mail.gmail.com>
Message-ID: <CAHk-=wg9FxC4NMq3GZTsbqw0s5w7C088CooJSds4PtHEYh4dHw@mail.gmail.com>
Subject: Re: [git pull] drm pull for 4.20-rc1
To:     airlied@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 4:47 PM Dave Airlie <airlied@gmail.com> wrote:
>
> This is the main drm pull request for 4.20-rc1.

.. pulled.

I'm not sure I love the new list helper, but it's not wrong.

I think it would probably have been cleaner to do this as a "cut out
first->last" followed by "splice to tail" pair (we already have the
latter), but it would probably have involved bigger changes to tweak
our current __list_splice() thing, so maybe it's just as well it was
done that way.

                     Linus
