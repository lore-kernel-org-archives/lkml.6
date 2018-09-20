Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCF0ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEB221523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEB221523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbeITMam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:30:42 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42080 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeITMam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:30:42 -0400
Received: by mail-vs1-f68.google.com with SMTP id s188-v6so2609104vss.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 23:48:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqgmhIqBxWdnEfNOmK9xhyTdL7vRqnbim7L3WcibdEg=;
        b=NT6veyCwCdoCA9bmcVw36+Y14M8e7jDNXdsEIh1vt3FpbVoRHjkM2OP6My+LgVnHPM
         qw/S9HNWd4UwEbQ+iQAclORxYxhp64XtA8ifXcaNhbmo4xsFaDzK0JNJ5dQ+my+s3bbq
         Rur6RbDmiieYqivQg/cqZCElLJx07kFdQtRUPBUCy/DrckaXMkJFW88wbxSRGFHFyCln
         C+LCPCQql9QpMCnc0jnSoP/YYjj4S958lf0rdfNONQP/QAJmUScAQIs1wLIBbGLFAhr4
         WQgL0rcca8Tjc/lKdElJaFE+ExDK5WX/G8/Lw6oij8dJhNTdBkSRVGaw2epLm3sZvV9U
         ms6g==
X-Gm-Message-State: APzg51BY7a8XHrmMyCInzvpQOJP+cQQb2wSvYnKK4hW+2nG2qy6MBKQ9
        Rx/SZjLnLT9E+6y+ZfdUUfGRHfLN+/7HT+dztro=
X-Google-Smtp-Source: ANB0VdbA3B99SvkiiejQ5LMN4DkaRuLTM3vZbemo1ZRlNsHxR7g1NT2ANOBGZaDyj9qC3WitmudD8rfeDhfoagPrjWE=
X-Received: by 2002:a67:cd07:: with SMTP id u7-v6mr11734798vsl.78.1537426127631;
 Wed, 19 Sep 2018 23:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180919234721.16042-1-tpiepho@impinj.com>
In-Reply-To: <20180919234721.16042-1-tpiepho@impinj.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Sep 2018 08:48:36 +0200
Message-ID: <CAMuHMdVMbjkvEXex_Z8ELPUo8hVZucFBCd2Wy4ENpiqEaLES_w@mail.gmail.com>
Subject: Re: [PATCH] ARM: amba: Fix leak of driver_override attribute value
To:     Trent Piepho <tpiepho@impinj.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Todd Kjos <tkjos@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 1:48 AM Trent Piepho <tpiepho@impinj.com> wrote:
> If driver_override was set when a device was released the string would
> not be kfree'ed in amba_device_release and thus leaked when the amba
> device was freed.
>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device
binding path 'driver_override'")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
