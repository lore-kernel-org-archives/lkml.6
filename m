Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675F2C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197062085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UtSy9Sbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197062085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbeJ1E7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 00:59:32 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:46339 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJ1E7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 00:59:32 -0400
Received: by mail-lj1-f172.google.com with SMTP id x3-v6so4196571lji.13
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CYyDE4F0EuFW4AVaLYBQS/tk4P6nO6mzBrDy3UOfK6c=;
        b=UtSy9SbgQFsdrX4fbZ/M6knP5BllErq5MZbEY0vP48UlOpjnm7K/yivOkRiVzXwF+k
         ThbeSK4GMZ/imyCtZjb7gOTxVkSIwL9cRQ2nh725vnd+wzpzPrab6rgcmH75a5CycKCo
         EezFZSlONCsmEBTPgcd1NPoZHxHk3YSaWT++g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CYyDE4F0EuFW4AVaLYBQS/tk4P6nO6mzBrDy3UOfK6c=;
        b=rtuQl7gnwKY+e6zklf4gOhlQp24+Cv89rMJos1y3zdwbN2mhIQio6ivSL2/fC6XGvp
         7tkpg/jRM4tQCY3mwknB6PKmhhiGY4uqu+X5kIcaku/2t929dOwIYUVc9MEKCvMGgglc
         w6u5vkZWQyQVA/DhcTqVxbJeiQZY2GGmimBjp3sIwpx+7Asaz4andobq8LABDxrOY8Lv
         MdhCxHw+HKGCvXc6Qpx1dzrp2Bh81mLy9GyrzbX5CE0zYJcL74mKC7g2yBSyu46+dqq1
         g97XjTDutlRuBn872tKuQ/HB7sXV/CU71ZYSbvNB3qecFfbSn6ZDoapujPgwCVDzwEbk
         0dZw==
X-Gm-Message-State: AGRZ1gJ8JwxIVcZ8JTbpilXBR2tJ5qqqNzGCsrYH7iCdKVfM4T0Aa7e1
        rT5SG5u6B/RF/l045aMxgldoonGspXgm1A==
X-Google-Smtp-Source: AJdET5cgDfqChsXurEShkGrnwXx9/NvTzvRfTHTAQLS5FzJVafcsgnMYdaS5HmKGFQpOQ9J5KH6sXQ==
X-Received: by 2002:a2e:8347:: with SMTP id l7-v6mr5489676ljh.140.1540671443214;
        Sat, 27 Oct 2018 13:17:23 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id n195-v6sm2398907lfb.26.2018.10.27.13.17.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 13:17:22 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id z21-v6so4233045ljz.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 13:17:21 -0700 (PDT)
X-Received: by 2002:a2e:9584:: with SMTP id w4-v6mr5619448ljh.118.1540671441350;
 Sat, 27 Oct 2018 13:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com>
 <c6b7e5b26883c53db35454e9b0ffb44898517228.camel@perches.com>
In-Reply-To: <c6b7e5b26883c53db35454e9b0ffb44898517228.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Oct 2018 13:17:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTMd_orbgEmjtKdpPJdnFcho_-66_R3PBr7joxFOxqsw@mail.gmail.com>
Message-ID: <CAHk-=wgTMd_orbgEmjtKdpPJdnFcho_-66_R3PBr7joxFOxqsw@mail.gmail.com>
Subject: Re: Another HID problem this merge window..
To:     joe@perches.com
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 12:36 PM Joe Perches <joe@perches.com> wrote:
>
> In fairness, it seems many of the HID drivers do exactly that
> and this could have been a "copy from example" addition.

Interesting, and I think you're right.

I wonder why I haven't noticed this before. Some of those might be
hidden by other dependencies - what I do is to just check how "make
oldconfig" changes my normal fairly minimal configuration, and then
complain when I notice that somebody enables some odd new hardware.

Anyway, those other "!EXPERT" defaults look pretty questionable too.
HID itself beind default y and the HID_GENERIC driver defaulting on
seems eminently sane. And HID_LOGITECH might fall under both "very
common" and "enables other config options".

But even then, the !EXPERT seems an odd choice. Why not just 'y' for
the truly common cases?

I wonder if there is some truly old historical legacy there, ie the
old PC keyboard support would have been configurable out only for
expert users to avoid errors, and maybe the HID Kconfig file started
getting ideas from that...

                Linus
