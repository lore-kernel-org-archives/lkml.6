Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE5CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852CB2080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 20:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IhgezbIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 852CB2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeLAHvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:51:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39154 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLAHvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:51:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so6123200ljh.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 12:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TP0SiK6uNPYENU1IyWH6KmqgDS9+GlbVm+B8zt29RAc=;
        b=IhgezbIHZT3PMW1SB+WgT1x0Z780R8rwOVrPTIHDXFbUgUghH2CV7D3/RRloum2gG2
         yXnp/Wrwr/Wn4C6FD3dCDvc75X3K5bb7KEDtr+uIhKl+kXA8UDhMw2gRp+AfCTNk4znn
         QQVgD1OF4Vuum7Obp5Z5UlsE2p2dWSPIhvRJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TP0SiK6uNPYENU1IyWH6KmqgDS9+GlbVm+B8zt29RAc=;
        b=e1QrcDzAD4qf0yhCB8vUtl3BqPYtVAFPKR9dNoicdQlLO7LcnE4O8G9a97esuA8v0O
         w9zHO4rtbk2OEF+059fZvSJdT12ovDyAQ872J5iQuj/arusT6+UZJ/sVnngCdLSJX4H4
         Osp8fDoT6UzW8ulbVFUPlOM7oCaR2XpfAchnueuXMQ1LxPBt8dEaVDwIiLMOtYz5uY7k
         LXqzaYLo6xaMD+GIg79nOax0dmkX7zW0fpUbRyJ3najCy9HuxqnBdyJGN52lVS3cER4a
         M1Rx+bRfNqh+Kfx9iVWDT4zNsbwh3inWHifdeZ7WQx9e7PuTwvRPUtEMYpKb/G6Fkb0N
         AknQ==
X-Gm-Message-State: AA+aEWYlXBU7ehezl5O5GUSzFVXqoDtks+x5Qe6grTctZuC3umvn4DdR
        tzte2lI2Xo+cm3ldRneOwS9LDyqC7iA=
X-Google-Smtp-Source: AFSGD/U1UsFkW7Sn7wBK+UEeXK1XBb4kouhjDq3bOI5M0GsKjLLKT2QP8q2BOlSvtbKescsIbBlx/Q==
X-Received: by 2002:a2e:2909:: with SMTP id u9-v6mr4819841lje.28.1543610470598;
        Fri, 30 Nov 2018 12:41:10 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id b69sm999473lfl.28.2018.11.30.12.41.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 12:41:09 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id g11-v6so6143613ljk.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 12:41:09 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr5293893ljk.80.1543610468460;
 Fri, 30 Nov 2018 12:41:08 -0800 (PST)
MIME-Version: 1.0
References: <20181130160605.GA3000@kroah.com>
In-Reply-To: <20181130160605.GA3000@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Nov 2018 12:40:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj3Q7CkMQYwfZSsqUTqkEhNwVGrRbCwe7AVJ70S8i5sWw@mail.gmail.com>
Message-ID: <CAHk-=wj3Q7CkMQYwfZSsqUTqkEhNwVGrRbCwe7AVJ70S8i5sWw@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core fix for 4.20-rc5
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 8:06 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> It resolves an issue with the data alignment in 'struct devres' for the
> ARC platform.  The full details are in the commit changelog, but the
> short summary is the change is a single line:
>
> -       unsigned long long              data[]; /* guarantee ull alignment */
> +       u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];

Hmm.

Are you aware that this is up to 128 bytes? Including on common
architectures like ARM64?

I've done the pull, but honestly, that seems a bit excessive, when a
fair amount of devres users seem to have fairly small data (ie looking
at "size", I see things like

    p = devres_alloc(dmam_device_release, sizeof(void *), GFP_KERNEL);

or

    dr = devres_alloc(devm_gpio_release, sizeof(unsigned), GFP_KERNEL);

that have allocations of a couple of bytes, and the new model means
that those allocations will be aligned to 128-byte boundaries, and
then (because ARCH_KMALLOC_MINALIGN, again) you'll end up actually
wasting 256 bytes for a tiny structure on ARM64.

Maybe it doesn't matter. But it does seem somewhat excessive to do
things like this.

Yeah, on x86, the alignment isn't even noticeable, being just 8 bytes.

                   Linus
