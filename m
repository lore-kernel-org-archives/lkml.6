Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A01C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DF4222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406776AbfBNKwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:52:53 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35289 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729852AbfBNKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:52:53 -0500
Received: by mail-vk1-f196.google.com with SMTP id l136so1288104vke.2;
        Thu, 14 Feb 2019 02:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a64e/Frl3TS8foASPDEwpnLzkU/nFm2nnLXf1OkqgoM=;
        b=BjU0Xx+EjUfurjAaTGa/A88HnSvGqt0xS8qIemZ403X4lJvcU+tRd02jtTnaVQXmtw
         0Zor+4+XE0V1j+42Cp+5LnEa0nPJKfXZ1mPfUPEn9RrKWsC/Y8BpaRvzKMhSTXRF8tFL
         RvMsgkodVstpuyPT1q7Gi47dAkGzhS4ZijAPdH/vrgTh7kC6y4k+CkptKBTrOMvo86S+
         kY+nXbTsn6tdExvuNvwhbMJMs7ck09NJx43Z6Fb8p8E82PM9vAS77XurGpq0lwy6O88P
         7oIEj/Su85Yw2fgWkUUdUAyjoVorCg0HwPAWtHRJHlPX+h4wlvjYCgO7QB0nPF7FFhCF
         1xjA==
X-Gm-Message-State: AHQUAuYMdc164lX7Y36bRrtCqgt1n1NESC3RrEVy7w7VHX2jkHG3BdO2
        R7t1CmitHf5E1hA/WoNLY4Z+LZUckhz4bCtJiIs=
X-Google-Smtp-Source: AHgI3IbVlE+20rHo06cRQ7RaPLMWLgp7FvRlv87ciXX9EfozxsYE929izmV+u0RRZEdIlYSIsunSi7ovbHHjIm/GHUc=
X-Received: by 2002:a1f:8e49:: with SMTP id q70mr1653639vkd.40.1550141571959;
 Thu, 14 Feb 2019 02:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-4-hch@lst.de>
In-Reply-To: <20190213174005.28785-4-hch@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Feb 2019 11:52:38 +0100
Message-ID: <CAMuHMdW4C1McxL-e7ZSiSOiiE5D=xbBK8FZOwuJ1w0kK3CR1Hg@mail.gmail.com>
Subject: Re: [PATCH 03/11] kernel/locks: consolidate RWSEM_GENERIC_* options
To:     Christoph Hellwig <hch@lst.de>, Waiman Long <longman@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:08 AM Christoph Hellwig <hch@lst.de> wrote:
> Introduce one central definition of RWSEM_XCHGADD_ALGORITHM and
> RWSEM_GENERIC_SPINLOCK in kernel/Kconfig.locks and let architectures
> select RWSEM_XCHGADD_ALGORITHM if they want it, otherwise default to
> the spinlock version.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Note that this conflicts with "[PATCH v4 2/3] locking/rwsem: Remove
rwsem-spinlock.c & use rwsem-xadd.c for all archs"
https://lore.kernel.org/lkml/1550095217-12047-3-git-send-email-longman@redhat.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
