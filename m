Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3893C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31AE218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550090128;
	bh=vJl1Joo64Dau64ywN3FJfljvd3WCBm9SZFDxrHhZGjM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eSpN/2XXGywvJACLcvSVkR7wEejNVPpm0oi/4K06urfqFQxNlPoBIEgzsOvytrkbS
	 KpnuVXOc3pxCJveQ2trfkkRuQn2Nq1EbjPVwoUJKVE3hp56jewe4bmmLAQ1oyK/u8+
	 0Gnn50PJwOhiqhNgBEv61oDv7wjggm9F8xNv9mR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbfBMUf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfBMUf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:35:26 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C41E218D3;
        Wed, 13 Feb 2019 20:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550090126;
        bh=vJl1Joo64Dau64ywN3FJfljvd3WCBm9SZFDxrHhZGjM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WRrAU1cvDozUzcSx1Z86vTycbHcKKfF2XDJURxHgAINDskdOwOjCR+qBYKaLmH+Gq
         2AMj8jxaZSouo90NeAwwcCVVtgGaP+NRM7reF2Dr7q3SVWq/c+ch5oLdBp4q+orKYx
         8SCqy7BODra86TeQFLLfafe4txRkqPl5DYalGqMg=
Received: by mail-qt1-f176.google.com with SMTP id a48so4288495qtb.4;
        Wed, 13 Feb 2019 12:35:26 -0800 (PST)
X-Gm-Message-State: AHQUAuaKJIwzjzkJypfyEdEZdK8C90G1cCXo8sIHfSGFXJwG/9TepP0i
        rJM5fGxZWeIl7k+312lerw+nBhSiY9AgwGb9vw==
X-Google-Smtp-Source: AHgI3Ia8us5g4Zw8L9oUoJhmksk3G6guZqNsn+V/1nY0zKjYqLW61ig8zrWEx8UwE8mMPbgLdFu+E7djoHiSrOzfNpw=
X-Received: by 2002:aed:2a2f:: with SMTP id c44mr38234qtd.144.1550090125239;
 Wed, 13 Feb 2019 12:35:25 -0800 (PST)
MIME-Version: 1.0
References: <1548245116-6360-1-git-send-email-liaoweixiong@allwinnertech.com> <CAGXu5jLE8dr4+G6fFmwcbm8YAs=RB+OiupyPCX6COhVu6av__w@mail.gmail.com>
In-Reply-To: <CAGXu5jLE8dr4+G6fFmwcbm8YAs=RB+OiupyPCX6COhVu6av__w@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 13 Feb 2019 14:35:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKqytWzdE1R6t+=U8Qtg2Q4PnjZYU_N9aarq4Mo5L5wLg@mail.gmail.com>
Message-ID: <CAL_JsqKqytWzdE1R6t+=U8Qtg2Q4PnjZYU_N9aarq4Mo5L5wLg@mail.gmail.com>
Subject: Re: [RFC v7 0/5] pstore/block: new support logger for block devices
To:     Kees Cook <keescook@chromium.org>
Cc:     liaoweixiong <liaoweixiong@allwinnertech.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 2:54 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jan 23, 2019 at 4:06 AM liaoweixiong
> <liaoweixiong@allwinnertech.com> wrote:
> >
> > Why should we need pstore_block?
> > 1. Most embedded intelligent equipment have no persistent ram, which
> > increases costs. We perfer to cheaper solutions, like block devices.
> > In fast, there is already a sample for block device logger in driver
> > MTD (drivers/mtd/mtdoops.c).
> > 2. Do not any equipment have battery, which means that it lost all data
> > on general ram if power failure. Pstore has little to do for these
> > equipments.
> >
> > [PATCH v7]
> > On patch 1:
> > 1. Fix line over 80 characters.
> > On patch 2:
> > 1. Insert a separate patch for DT bindings.
>
> This is looking good. Can you address the DT bindings review concerns,
> and send a v8?

If it was not clear, the DT concerns are this shouldn't be using DT.
There are already industry standard ways to locate a specific region
on block devices. Use those. Then this will work on my PC.

Rob
