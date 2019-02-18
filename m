Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AB3C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E62D21901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391911AbfBROMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:12:18 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39177 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391933AbfBROMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:12:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id x6so10023150qki.6;
        Mon, 18 Feb 2019 06:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YcwWgCDYkIMxHMLAtDpxk2/4cNQB/pa+rHrzjEqCqSM=;
        b=jZ4A0C2wNTcqK8PtVO+GggAg811rUqP31KeMLqhw7Xsw81KJ2aY+OFMrEgxQh7Co/w
         JX4atd+gYgI6jyxD8g4ecyPFHDFPvNi7fTwv4ybTsGImhGK1i52UVM3RPQPNpyczL/h8
         O3Ul+CzhNcUQMGhEFbPcYdrUy/WB48CnruWJsMbAP386U8S3lPK+qb+kxCo31izxGG2z
         gEAHpEn14XUSSDZyOQo6znBpWzCjjX6Yh7nEdBUmN+LdVrN1CwR+xvngAS3RwXClAwgb
         xm2MN8BZh1bjmf18bGNfSFjMdh5KHmDism8t423DBFRHIr+mwX+6PJd/jcL/relMVBPe
         PlbQ==
X-Gm-Message-State: AHQUAuaCfhJUQLqFGRAeINDFmHommhJt2wgQp2itn/zsmjFk6eOAJVXm
        5VvNprS2kl84JzDUtxZ0ZTE+eEDJzjyEHo5yA7+Osg==
X-Google-Smtp-Source: AHgI3IaUiXtFZDZqP5K42o9pFvVka4JSn65vfanJ7qygAQk1tJJZQWyyOrN0ijUwUjFDon8VSKG/4c6TcIh3p/NCB1c=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr16864037qkh.173.1550499131139;
 Mon, 18 Feb 2019 06:12:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550485787.git.hle@owl.eu.com>
In-Reply-To: <cover.1550485787.git.hle@owl.eu.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Feb 2019 15:11:54 +0100
Message-ID: <CAK8P3a3de3ti6B3A0Mgy_eVv8SmNyCLx7AvwYRK2k8rxtBG-3g@mail.gmail.com>
Subject: Re: [PATCH 0/4] iomap: fix multiple consistency issues, interface cleanup
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 11:53 AM Hugo Lefeuvre <hle@owl.eu.com> wrote:
>
> Hi,
>
> This patch cleans up the iomap interface.
>
> The first patch makes the include/asm-generic/iomap.h header compliant
> with the kernel style guidelines by adding missing function args
> identifier names.
>
> The second and fourth patches address multiple compilation warnings due
> to missing const qualifiers in mmio_ins* and ioread*/iowrite
> definitions in include/asm-generic/iomap.h and lib/iomap.c.
>
> The third patch modifies io*_rep definitions from asm-generic/io.h to
> take unsigned long count parameter instead of unsigned int which is
> inconsistent with other definitions in the kernel.

Nice cleanup! Applied to my asm-generic tree now.

I notice that you did not add a 'volatile' qualifier in addition to 'const'.
Is that something you considered doing? I think the traditional
readl/writel style accessors have them partly for historic reasons,
and partly to simply the trivial implementation that is based on
a volatile pointer dereference. Neither is needed here, and I don't
think we have any drivers that pass volatile pointers into ioread()/iowrite()
(which would cause a warning), so we can probably leave it at that,
but it's still a bit inconsistent.

    Arnd
