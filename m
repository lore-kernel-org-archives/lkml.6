Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8305AECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2B920779
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2B920779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbeGWI6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:58:43 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:43564 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387991AbeGWI6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:58:43 -0400
Received: by mail-ua0-f195.google.com with SMTP id x24-v6so11161596ual.10;
        Mon, 23 Jul 2018 00:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7l5XOdK80jU/5VgIe/luxqJ93Lr7SlF0hs5eH6TtRc=;
        b=lK3y5i/uGnqJilG1wP5AF2l/FDmZgWFlmhqTTqFjiMI+gEWmNUCToNTLm+/KZVZsS1
         7G1xDnTfG0qLCjOcoJtwD26JOXURQEe5fco72n8go1r5JgjQ/rljDy9bmNUxtFpZYGZa
         jtr3TkPWEIAIs2Sgt4jq1UV2hawsVoZTuZht9avclyQQeH8VoWrOyJdr6B0rkizhIO/c
         J4LRtal3cxRBlIV9DX/wCNg5mOVmLCNY/CfO/cIpuzYRUV0LEySfe/xZiRxn46jPJybS
         V+G9FpycHWPvz+yHkKNY2AoRJCL0tsh4+5lUmu9gGE0qFbqN4q2/yVLUHd2xqqrBkCNI
         lRIw==
X-Gm-Message-State: AOUpUlGlH7JQ4oL46coMvfGCBH6ZvCmHEqvlhUr+6AY8ypK0C4pAlEMa
        uArnCmmAjwB7pqT9xuK7fEb12haTozdI26qXwcs=
X-Google-Smtp-Source: AAOMgper8xAz/g3cCegoKqrOH80eZ5CCgREzlVhYnUKVtnlm7sV+rq6k7oBReft0vwtX2C3bRS5gNzH7YNKD/1TQjaQ=
X-Received: by 2002:ab0:80e:: with SMTP id a14-v6mr8551931uaf.114.1532332726152;
 Mon, 23 Jul 2018 00:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
In-Reply-To: <f96af3cd-3316-11a8-d563-dd269f1378a2@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 23 Jul 2018 09:58:33 +0200
Message-ID: <CAMuHMdV9yvjTkpao2SdnWObQpjeNV_g=cJwq-SCzDiXvq8jNdw@mail.gmail.com>
Subject: Re: [PATCH v2] hexagon: modify ffs() and fls() to return int
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 1:04 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
> printk format build warning.  This is due to hexagon's ffs() being
> coded as returning long instead of int.
>
> Fix the printk format warning by changing all of hexagon's ffs() and
> fls() functions to return int instead of long.  The variables that
> they return are already int instead of long.  This return type
> matches the return type in <asm-generic/bitops/>.
>
> ../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
> ../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]
>
> There are no ffs() or fls() allmodconfig build errors after making this
> change.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Richard Kuo <rkuo@codeaurora.org>
> Cc: linux-hexagon@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
