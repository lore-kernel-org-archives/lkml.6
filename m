Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55DCC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2762075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:52:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2762075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeIFN07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:26:59 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:39445 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbeIFN07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:26:59 -0400
Received: by mail-vk0-f67.google.com with SMTP id e139-v6so3758022vkf.6;
        Thu, 06 Sep 2018 01:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBQOFf6KeN4WBhgResietF3apeIcyWmqVBwqLGgDJ10=;
        b=OEvFgLmFAt3dAtMy3yVJnQOyC5zptbAujBXo03JbmUXCky8E7i0AJWl/WhDSp4p9JC
         bTZmrFXO99rFNrlyoo1vbZ1ycZRJZCkhZnI1RQQfjg/iWrg8v74ujFhO7+LNNa5K2S5R
         kXu/zw7wvp4eJbO2fRxB3VG/vmDPr75hnjhIMjlgPu6KpKGEC6GAtr0GHwTc88Wodmax
         sdWVSvbRM8duJvG66Ju0iUJf4zOpy1QSNJpZw/PJkgatW0iJdJMq1S/swSp+HAJCs2Gx
         trDnIi8XoYnsYtQW4QEEqZIvWdTZAiW4a9yyj8g7dS2Dc+QnU7Z2vk9TF7b/llAQyw8l
         jPgA==
X-Gm-Message-State: APzg51CYgLM4Pu5+L6Kj1KVOVcFQs/AiKT2EyJk/Al/XM7bxnL8Hfx3q
        O8+falkuzIBH5yRrpTZj832iQlWYmfjlHjS7wKs=
X-Google-Smtp-Source: ANB0VdZI3yjdIV7yl92369MiHWfHBoChvQAt+RYFChPxZvKQsDaLvGKEhBI3fbhvnPUes2u/p7MaD+O+QvI+n1D2Tuw=
X-Received: by 2002:a1f:dd47:: with SMTP id u68-v6mr503511vkg.137.1536223954843;
 Thu, 06 Sep 2018 01:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180905193738.19325-1-robh@kernel.org> <20180905193738.19325-6-robh@kernel.org>
In-Reply-To: <20180905193738.19325-6-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Sep 2018 10:52:23 +0200
Message-ID: <CAMuHMdVaxahVjR2NmfYmt8ELaaDoZdfL3WeDJ8oxS8JxOsjPxw@mail.gmail.com>
Subject: Re: [PATCH 05/21] ARM: shmobile: use for_each_of_cpu_node iterator
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 9:38 PM Rob Herring <robh@kernel.org> wrote:
> Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
> has the side effect of defaulting to iterating using "cpu" node names in
> preference to the deprecated (for FDT) device_type == "cpu".
>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
