Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F2CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357882087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 357882087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeH1Pyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 11:54:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43110 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeH1Pyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 11:54:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id m84-v6so1157893lje.10;
        Tue, 28 Aug 2018 05:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4EgT/WMdYZcgWYmvvlWIFIfJFo9IvVRaDpJGKK7WU9k=;
        b=DE0ud3ZO2on1H2RVymmX2c8hpiul08bw08K4N6ZHTLX0JGvM5iZ96oX8IvhPV2SDMM
         gQIxBx05G6UQizPKjCm633T38X7f+zv9SVnfqMnOqmPaPQDyhq9q8JBMKem3ORL1MeTC
         DIWpOCaddLuYG4Mt0D1BaEooj+fhrRzyo5EOnSQH4AlJWDoE3Hx1jT0PL5BO1AD/K+T8
         w4dJo6qlAijkV9rrlYVUXDBdYry9FJauHIMQcO7wAAl4g9CTsuNlNOyYjPU3fjprlj52
         C82cRE57RDYxW/SmDWIRJEWZOgff+yJ1OQ7Poz0JJVaTOUWJbD2P3BZvFrflSOqU0FSv
         Sz2w==
X-Gm-Message-State: APzg51C4aT/iPFqHaq4MBkO2u8YH7sC2u4WtGkwHeoaejZ53cU4hUQy4
        pFKX3z2guif2D6Cu/ddxlzjuzOSfAkYZ97nTllM=
X-Google-Smtp-Source: ANB0VdYNMi9nQaVvYtfXdtQPqinuKJsCtsp+1NjHSEn884boVtbgebjx+FRoYWsPHWkGD5rXm98eQioZGPjUeXG9P8w=
X-Received: by 2002:a2e:3005:: with SMTP id w5-v6mr1078112ljw.20.1535457812141;
 Tue, 28 Aug 2018 05:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com> <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
In-Reply-To: <1535453838-12154-5-git-send-email-sunil.kovvuri@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Aug 2018 14:03:14 +0200
Message-ID: <CAK8P3a2fgAVB0+uns9f5MH+2OyZbwvReo9j-=u3=30QoK=2Ksw@mail.gmail.com>
Subject: Re: [PATCH 04/15] soc: octeontx2: Add mailbox support infra
To:     sunil.kovvuri@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, amakarov@marvell.com,
        sgoutham@marvell.com, lbartosik@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
>
> From: Aleksey Makarov <amakarov@marvell.com>
>
> This patch adds mailbox support infrastructure APIs.
> Each RVU device has a dedicated 64KB mailbox region
> shared with it's peer for communication. RVU AF has
> a separate mailbox region shared with each of RVU PFs
> and a RVU PF has a separate region shared with each of
> it's VF.
>
> These set of APIs are used by this driver (RVU AF) and
> other RVU PF/VF drivers eg netdev, crypto e.t.c.
>
> Signed-off-by: Aleksey Makarov <amakarov@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> Signed-off-by: Lukasz Bartosik <lbartosik@marvell.com>

Why does this driver not use the drivers/mailbox/ infrastructure?

       Arnd
