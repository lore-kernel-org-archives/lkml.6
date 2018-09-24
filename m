Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA30AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACD720989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACD720989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbeIXNiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:38:06 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41370 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeIXNiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:38:06 -0400
Received: by mail-ua1-f68.google.com with SMTP id f11-v6so1176794uaq.8;
        Mon, 24 Sep 2018 00:37:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9T/Qii4NJ7hDLx7eHz3GcrREEc4/+zybi/6RVYeg4U=;
        b=kjQx9J6jvOO/bleN/AobrDdeQ12LMOE/cf2MrOFX7h49/Th+7A/jGnPX6G5g2IE2hn
         /QH48itnpO+n9ghWNKC6XfRoVW7zqUvqcyh7IaTEZ5tHJ0xaps0trsoAc7Dv/Mz9iFi+
         xvFoLvwRDPSZ4JBLho9nh+jgD4rNgltJP3o0Zt7hL7M4RX6BjqRanrTR6u7WyNWV4c/4
         ibxqYtw7KYdR+1Qhfkle+fyOt1Wr8WdLZ6wr6yG8KnnpRJRcw+EIkCpKzyM9PCRTI8ht
         NkT69mNOsN8YZuehYVGbThn6glPsdJG2S/tJWNParmyeHEzHjtOiqI3UWQMf+72C4tsl
         UHSg==
X-Gm-Message-State: ABuFfoin7+lmQFcLUh8HQjaU8UGjEygAovz0sJhflhR/Z9X03XLt+7Fy
        tQFXqjxJFTvxfC1baLklGruNRpVuhMx8N/GJvTQ=
X-Google-Smtp-Source: ACcGV63WjHDDBgJFurxom+dieTDiVDpcwLHmPiAf0LR2N+uG2GhybzISIIWx0LMYGyPX7mz9bHL9HHBbqfdflGsjPro=
X-Received: by 2002:ab0:1e46:: with SMTP id n6-v6mr855115uak.78.1537774640428;
 Mon, 24 Sep 2018 00:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
 <39e840d1f727fe6338ea14b882ca9bf831f53e32.1537443710.git.michal.simek@xilinx.com>
In-Reply-To: <39e840d1f727fe6338ea14b882ca9bf831f53e32.1537443710.git.michal.simek@xilinx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Sep 2018 09:37:08 +0200
Message-ID: <CAMuHMdWQcc+ZD238e13fBcVW77304u2nqq2K9A9-wsDVAPEa4A@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/2] serial: uartps: Change uart ID port allocation
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Thu, Sep 20, 2018 at 1:42 PM Michal Simek <michal.simek@xilinx.com> wrote:
> For IPs which have alias algorightm all the time using that alias and
> minor number. It means serial20 alias ends up as ttyPS20.
>
> If alias is not setup for probed IP instance the first unused position is
> used but that needs to be checked if it is really empty because another
> instance doesn't need to be probed at that time. of_alias_get_alias_list()
> fills alias bitmap which exactly shows which ID is free.
> If alias pointing to different not compatible IP, it is free to use.
>
> cdns_get_id() call is placed below structure allocation to simplify
> error path.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

JFTR, for sh-sci, I used a different approach, as all ports in the static DTB
can have an alias (if aliases are needed at all), and only DT overlays cannot
have them. Cfr. commit 7678f4c20fa7670f ("serial: sh-sci: Add support for
dynamic instances").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
