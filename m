Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D599C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8542089B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:23:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8542089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeH1QOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:14:46 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34956 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeH1QOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:14:46 -0400
Received: by mail-qt0-f194.google.com with SMTP id j7-v6so1380394qtp.2;
        Tue, 28 Aug 2018 05:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xMg9ce79d1E413VsXHxHA9Y6xAQwPV+OITyJvWM1yOw=;
        b=S10H5bMve/OwPsxHMjE5pmRKB7iLcRvZTMD8qCPf1F7dxQoS5u3u3P7C+zuNaLKTLW
         5kOdX+5TwubDNJIRDEalhgoyXKUHJhKEtMPRZ8rJnLAg8bg4q+Cj5MSLQ2qDkDLRrmP0
         u6FoySjljgBN01NWf+dufC9/SOvfRriXWz3UxkkO9gAol551CYUsBaapuekO/e8xLYYg
         CmoU+vnyvu4+ICCbLALLPTu+79ClJiOPVFsQC97n56M1FyULHKsiXweDdfjYfUKAvAfp
         4GsLR3RJ1JUaVDl2uJIbTrxO8HovyR9osjjweFwcmc5OQMYrodgUxbxyUgXoYDAhGu3r
         7WYA==
X-Gm-Message-State: APzg51D3SwRW0IcMSjlO5NHw6/TSwFYPEk/udXs5muXJjCnBhWNFjyPc
        EPzYPrHw+tp2ENFktiLDI8FziQGyU+Vx9Q0uWC4=
X-Google-Smtp-Source: ANB0VdbX1ShKI6iyMLxsZdVueEgeQkA4LZAWJvUfOOnL0QrDEIPAoPOD2hRM8SsL1oWTNKs6I3H3uUrpcE4Vo85eBdg=
X-Received: by 2002:ac8:6959:: with SMTP id n25-v6mr1342898qtr.9.1535459000970;
 Tue, 28 Aug 2018 05:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
In-Reply-To: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Aug 2018 14:23:04 +0200
Message-ID: <CAK8P3a1xC6XjwDAmocpE5TZO7j6uVGtvBtWLPVcYwKqN6Z+seQ@mail.gmail.com>
Subject: Re: [PATCH 00/15] soc: octeontx2: Add RVU admin function driver
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, sgoutham@marvell.com,
        Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:57 PM <sunil.kovvuri@gmail.com> wrote:
>
> From: Sunil Goutham <sgoutham@marvell.com>
>
> Resource virtualization unit (RVU) on Marvell's OcteonTX2 SOC supports
> multiple PCIe SRIOV physical functions (PFs) and virtual functions (VFs).
> PF0 is called administrative / admin function (AF) and has privilege access
> to registers to provision different RVU functional blocks to each of
> PF/VF.
>
> This admin function (AF) driver acts as a configuration / administrative
> software which provisions functional blocks to a PF/VF on demand for them
> to work as one of the following
>  - A basic network controller (i.e NIC).
>  - NIC with packet filtering, shaping and scheduling capabilities.
>  - A crypto device.
>  - A combination of above etc.
>
> PF/VFs communicate with admin function via a shared memory region.
> This patch series adds logic for the following
>  - RVU AF driver with functional blocks provisioning support
>  - Mailbox infrastructure for communication between AF and PFs.
>  - CGX driver which provides information about physcial network
>    interfaces which AF processes and forwards required info to
>    PF/VF drivers.
>
> This is the first set of patches out of 70 odd patches.
>
> Note: This driver neither receives any data nor processes it i.e no I/O,
>       just does the hardware configuration.

Hi Sunil,

Thanks for posting this first series, I'm glad we're seeing support for this
chip family making some progress.

My feeling overall is that we need a review from the network driver
folks more than the arm-soc team etc, and that maybe the driver
as a whole should go into drivers/net/ethernet.

We support some couple of similar hardware already that has
both support for virtual functions and for crypto offload, including
the Chelsio cxgb4, Mellanox mlx5, NXP DPAA and probably others,
and we need to ensure that the exposed interfaces are all
compatible, and that you use the correct subsystems and
in-kernel abstractions for thing that are common.

      Arnd
