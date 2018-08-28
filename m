Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86C4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6DD2064E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C6DD2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeH1QAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:00:34 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39059 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH1QAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:00:34 -0400
Received: by mail-qt0-f196.google.com with SMTP id o15-v6so1315704qtk.6;
        Tue, 28 Aug 2018 05:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckIfaYZi9suVxMnf1HWGxk4F65f6zsS0FyNjtpE65Xo=;
        b=tLMciLVw/olDiVp1CZ8MH2SPb4Hre+sf2/t5N1l5XwHjZu1RlqKX4zirD9wMq+cxBW
         yjLMTaVR9+xHjEdHpOXdZZfzMH5y0Vy0YE0v3NO0Yt7i7hdOfNKZBGlI0hJsZtaZa0DC
         ccFmTIRGscb/WfvkkXD/ImZqZRksqSC2IkRDn9F6Jb3biKmll/mHnJQ3k90isL9GLJJJ
         Cofeumj+pG0bh/5bwi5sQibYZkHvoJbfWbbrR5y0D7im8carUvVZALKSIQB13oZcaMmc
         E1zdVmrzvOg57eYFJwg3IKNEQytEjx8nEW9NtqKw08stCCQ7HPoNh6wDpzK2UUusk5N8
         6WwQ==
X-Gm-Message-State: APzg51C3bST5mMYThofUQuugCSAdWV1CXqN+7rGUcMKJ3UybxTn54ddG
        mjcELQLnkCdvZWZLB965ZQwN+0mYS+7l1ru4p/A=
X-Google-Smtp-Source: ANB0VdaxXIQDeYLU1jXqUA+eATGdc1XOdC7jhmvNMCnQf0OJ6lr7tajfbRU6oVfDGyhyBijOkQ9JQ4qrMDgc6xIhNfY=
X-Received: by 2002:aed:3f22:: with SMTP id p31-v6mr1192687qtf.185.1535458152212;
 Tue, 28 Aug 2018 05:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com> <1535453838-12154-11-git-send-email-sunil.kovvuri@gmail.com>
In-Reply-To: <1535453838-12154-11-git-send-email-sunil.kovvuri@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Aug 2018 14:08:55 +0200
Message-ID: <CAK8P3a1Vdy-VsLWJMer-Z96E4Trhi0WJXJ3fTzyOGny2Mn6RAA@mail.gmail.com>
Subject: Re: [PATCH 10/15] soc: octeontx2: Reconfig MSIX base with IOVA
To:     sunil.kovvuri@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, gakula@marvell.com,
        sgoutham@marvell.com, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
>
> From: Geetha sowjanya <gakula@marvell.com>
>
> HW interprets RVU_AF_MSIXTR_BASE address as an IOVA, hence
> create a IOMMU mapping for the physcial address configured by
> firmware and reconfig RVU_AF_MSIXTR_BASE with IOVA.
>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>

I think this needs some more explanation. What is the difference between
the MSI-X support in this driver and every other one? Are you working
around a hardware bug, or is there something odd in the implementation
of your irqchip driver? Do you use a GIC to handle the MSI interrupts
or something else?

       Arnd
