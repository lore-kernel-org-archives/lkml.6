Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2E5C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BCA20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BCA20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbeKHAcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:32:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42424 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeKHAb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:31:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id u68so21226148qkg.9;
        Wed, 07 Nov 2018 07:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrCgMd5aB29UDxkP4+Dhx2tcotNtUM5bvR43by0uZ9w=;
        b=kWh0HfmwhE18SxY6APeJtZtf6pxpigaosTg/I9dqvg6E4ddX1hWTfr/F5/vfW0IYND
         jrUWt+Ia4//xLzGCtUT3fY0oN6ledBEDfFqCOYUdq9wcP1Sn0RD9oPIpv3pizowFKdU1
         eBm9//skQ3XA73cAfc7IJV4qkCLoqvYMc6NJiGq7tc84+vp/ZZOWskU0eycvN2xQ56nW
         Nvw/9zU9p2Y3dU9hUgxKOOqJZRHThz2MRx/UL3iCxGmUNMGdUcmVTIy24DPXmkuv5lzv
         GDDA+8xj6CaLcEwfTdqfwYsFLPAZZxNJFayY3jNWKaSmnKgYGCH6X+DJ4Qw/csl8rwas
         bqeA==
X-Gm-Message-State: AGRZ1gIRb1Y/7D9CyMJakrI5KmQHYmAxJ1OuKzZHqlkH8vd4sPSaOcix
        wrbxSsuv5JiR9YGftgvVgAk/GWwLvIJ5bMtYoKQ=
X-Google-Smtp-Source: AJdET5fGtJreKrh6+Sg3ALXmbwOBxP4qwZQ1WVcARcjjl7YnJZpddJVaMEBeP7omKBn7pB9kZjPnI/B05WRhFyxfiqM=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr555617qte.212.1541602874338;
 Wed, 07 Nov 2018 07:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org> <20181107003250.5832-8-elder@linaro.org>
In-Reply-To: <20181107003250.5832-8-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 16:00:58 +0100
Message-ID: <CAK8P3a2FsgR=SYAWsgFURVni1ReiCugKs1iUAfQzZhPkbW8aOA@mail.gmail.com>
Subject: Re: [RFC PATCH 07/12] soc: qcom: ipa: IPA register abstraction
To:     Alex Elder <elder@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
> diff --git a/drivers/net/ipa/ipa_reg.c b/drivers/net/ipa/ipa_reg.c
> new file mode 100644
> index 000000000000..5e0aa6163235
> --- /dev/null
> +++ b/drivers/net/ipa/ipa_reg.c
> @@ -0,0 +1,972 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
> + * Copyright (C) 2018 Linaro Ltd.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/io.h>
> +#include <linux/bitfield.h>
> +
> +#include "ipa_reg.h"
> +
> +/* I/O remapped base address of IPA register space */
> +static void __iomem *ipa_reg_virt;

This should of course be part of the device structure.

> +/* struct ipa_reg_desc - descriptor for an abstracted hardware register
> + *
> + * @construct - fn to construct the register value from its field structure
> + * @parse - function to parse register field values into its field structure
> + * @offset - register offset relative to base address
> + * @n_ofst - size multiplier for "N-parameterized" registers
> + */
> +struct ipa_reg_desc {
> +       u32 (*construct)(enum ipa_reg reg, const void *fields);
> +       void (*parse)(enum ipa_reg reg, void *fields, u32 val);
> +       u32 offset;
> +       u16 n_ofst;
> +};

Indirect function pointers can be a bit expensive in the post-spectre
days. It's probably not overly important if these are always part of
an MMIO access function, but you should be careful about using
these in the data path.

How many different versions do we have to support in practice?

       Arnd
