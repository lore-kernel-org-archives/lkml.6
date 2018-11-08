Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2ADC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B331B20857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 23:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SAApAeUI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B331B20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeKIJ34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 04:29:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41786 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeKIJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 04:29:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id z80-v6so43911ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 15:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oepUEF1il+zHF0oysek/lMo7poBdd9dgwDfPiNeCjn8=;
        b=SAApAeUIdtFuyrad0x+q0iqhhtCuDF4xmP6AubtLeFbabA65/ipaJrt3P5H8WdP8pB
         lb8twoKgr+7aWm0ypfcXkQE1mMzL7YUGQNlXutky3qrFbYpiOSYiW39TyNeLMmKZCTOf
         qlmBivUy2SDbE39CYVlNDLo3EflJ3kXnTBdWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oepUEF1il+zHF0oysek/lMo7poBdd9dgwDfPiNeCjn8=;
        b=jsm/uXwgULKP1/AmK6X0VA1MPEX+/8/Yrg/XfaNbANJCCF6XUQ8lhVOJ8UnEEl5uj8
         mxPcXnXJFny38t8bZ+Ki+PEQZwAI/jqU4AgUOCbSLZKIP7d1jqp/9bhb1y8TNQaPEj5c
         CanK8A4bnY8bQgfNDr/bnOTCp+Due8hH9U/ESrDc687uEW8vgk6kts9GUuvrKUOBAEIt
         zulaPmoT04qfmCDVCQlybdQTnSVK5u5zSCIEXRljeXBYh3zdOvn6V4Y5r8Yrxa8Qi+4Q
         aHuVkN16C8aofDXNOKN1TYlSOU5gF3Qkl1IHA187U/cGEMGnEvJJmZIfbbc2zwYOxPLN
         XHhg==
X-Gm-Message-State: AGRZ1gKSM4LVRKhbmjQoZDK36UHya8jt/kwnH5eI6WkeVrJ0h00MWrn4
        1/9ZXTddNhXKgEjO8EobR7oHdIFQ1rI=
X-Google-Smtp-Source: AJdET5cwt3nN8HJpMJgVK/Yna2jGd6tQBdfJGHDnZfcXTh/AmmPjSGF796dTaPfch6YMtS978i+2xA==
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr4366638ljb.52.1541721116955;
        Thu, 08 Nov 2018 15:51:56 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id a18-v6sm900992ljk.86.2018.11.08.15.51.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 15:51:56 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id f3-v6so39160ljk.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 15:51:55 -0800 (PST)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr4518326ljj.6.1541721115128;
 Thu, 08 Nov 2018 15:51:55 -0800 (PST)
MIME-Version: 1.0
References: <1541705348-4615-1-git-send-email-jacek.anaszewski@gmail.com>
In-Reply-To: <1541705348-4615-1-git-send-email-jacek.anaszewski@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Nov 2018 17:51:39 -0600
X-Gmail-Original-Message-ID: <CAHk-=wg9cYHtZZ6_n0O0MdpOhTKUhQo5iqeM_xnRLrDkb8F3xA@mail.gmail.com>
Message-ID: <CAHk-=wg9cYHtZZ6_n0O0MdpOhTKUhQo5iqeM_xnRLrDkb8F3xA@mail.gmail.com>
Subject: Re: [GIT PULL] LED fixes for 4.20-rc2
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-leds@vger.kernel.org, baolin.wang@linaro.org,
        geert+renesas@glider.be, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 1:29 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
>
> All three fixes are related to the newly added pattern trigger:
>
> - remove mutex_lock() from timer callback, which would trigger problems
>   related to sleeping in atomic context, the removal is harmless since
>   mutex protection turned out to be redundant in this case
> - fix pattern parsing to properly handle intervals with brightness == 0
> - fix typos in the ABI documentation

Pulled,

                Linus
