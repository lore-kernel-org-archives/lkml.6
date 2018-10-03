Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ABAC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238C9206B2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 18:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aajN8PnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238C9206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbeJDBY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 21:24:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34711 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJDBY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 21:24:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id y10-v6so4903486lfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/QQfgeI7gMJ87qFDqYzQYt/IQk9532qxo7Ub3/wYao=;
        b=aajN8PnIIJNYZ/XWGwReUiarKTUHUx4mn0SCbiTgfLLFGfEAV+5Rn8k/rWbehPq0jz
         8BBFFdNH3M4TXEXTE4i78gd8Ua65a6sI5ZqV9dMZ4TzHagAp6Thcvc5feGZCvc5wT7i+
         k7z0G+9kJJe3abzaLjcGzEc9l9OfFxDRFHh+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/QQfgeI7gMJ87qFDqYzQYt/IQk9532qxo7Ub3/wYao=;
        b=MsV9mBjx35IdweZ7OdlyemULkt5LS3LLR963nI/LykdZ6UhpEskAtox7q0oclvP9hD
         1qZZg1yb8LKD7kYKF+UG9aHpss7sbr5nYzb1tEb74ZsoFwk8vXIFd1Imi+QedLkAOT/X
         F+3TVV8myx3pjUp7BaTQA8pzoEOfp8s8BOYT+ZCKrPv0bkXJEIeVK80ku7PO0Zdq9WeE
         1UVak+WmO4GrhhO1t/5GbmUohmy2Z0AccfcQYzkAq2F8mNPMjqmBpRFqVLO1pgiqPq1F
         FA5SUjaKUZEywzGd68bfn++hGRho+rL5WucZyXZewVQjVK3LALzZB271ZEnuSNKQmzYI
         JxUg==
X-Gm-Message-State: ABuFfoiLbEq8jZe9qXxY0aInxZF/CEC9470lAkhbYYAtx9FaFKZDRHS1
        pDP0+7/Uai3MAYJYc2cycSjrE6JIXbM=
X-Google-Smtp-Source: ACcGV60WKU+pkyJARAHTSMSm/j1nNVaC3w5MOk0BbBbaA7sIJ+eOqRyTic0GCyCJBluA+3zhmXlDNw==
X-Received: by 2002:a19:d8d1:: with SMTP id r78-v6mr1854708lfi.146.1538591720525;
        Wed, 03 Oct 2018 11:35:20 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id f81-v6sm531454lfi.50.2018.10.03.11.35.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 11:35:19 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id r8-v6so6031829ljc.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 11:35:19 -0700 (PDT)
X-Received: by 2002:a2e:9b88:: with SMTP id z8-v6mr1924135lji.112.1538591718944;
 Wed, 03 Oct 2018 11:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180302082346.8188-1-cang@codeaurora.org>
In-Reply-To: <20180302082346.8188-1-cang@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 3 Oct 2018 11:34:42 -0700
X-Gmail-Original-Message-ID: <CAE=gft6f9a2RoAvXR4+2tKZE-3chobb_HfbMDErfU1Q=_8uYwA@mail.gmail.com>
Message-ID: <CAE=gft6f9a2RoAvXR4+2tKZE-3chobb_HfbMDErfU1Q=_8uYwA@mail.gmail.com>
Subject: Re: [PATCH v1] scsi: ufs: add 2 lane support
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, venkatg@codeaurora.org,
        cang@codeaurora.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 3, 2018 at 11:19 AM Can Guo <cang@codeaurora.org> wrote:
>
> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>
> Qcom ufs controller v3.1.0 supports 2 lanes, add support
> to configure 2 lanes during phy initialization.

I'm reviving this old chestnut, sorry I missed it initially. This
description is a little terse, and I'm actually confused about it. The
description makes it sounds like this patch is adding support for
2-lane UFS controllers, but the patch itself appears to only make the
UFS controller tolerant of a missing lane (or more specifically, a
missing lane clock). Can you describe a little more about what's going
on here, and perhaps fix the description?

I notice that the global clock controller has clocks for TX symbol 0,
and RX symbol 1, but seems to be missing GCC_UFS_PHY_TX_SYMBOL_1_CLK.
Was that an oversight, or is it really not there?

>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufs-qcom.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index 2b38db2..51889ad 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -113,10 +113,10 @@ static void ufs_qcom_disable_lane_clks(struct ufs_qcom_host *host)
>         if (!host->is_lane_clks_enabled)
>                 return;
>
> -       if (host->hba->lanes_per_direction > 1)
> +       if (host->tx_l1_sync_clk)
>                 clk_disable_unprepare(host->tx_l1_sync_clk);
>         clk_disable_unprepare(host->tx_l0_sync_clk);
> -       if (host->hba->lanes_per_direction > 1)
> +       if (host->rx_l1_sync_clk)
>                 clk_disable_unprepare(host->rx_l1_sync_clk);
>         clk_disable_unprepare(host->rx_l0_sync_clk);
>
> @@ -147,18 +147,15 @@ static int ufs_qcom_enable_lane_clks(struct ufs_qcom_host *host)
>                 if (err)
>                         goto disable_tx_l0;
>
> -               err = ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
> -                       host->tx_l1_sync_clk);
> -               if (err)
> -                       goto disable_rx_l1;
> +               /* The tx lane1 clk could be muxed, hence keep this optional */

I'm confused by this comment. What do you mean the clock could be muxed?

> +               if (host->tx_l1_sync_clk)
> +                       ufs_qcom_host_clk_enable(dev, "tx_lane1_sync_clk",
> +                                                host->tx_l1_sync_clk);
>         }
>
>         host->is_lane_clks_enabled = true;
>         goto out;
>
> -disable_rx_l1:
> -       if (host->hba->lanes_per_direction > 1)
> -               clk_disable_unprepare(host->rx_l1_sync_clk);
>  disable_tx_l0:
>         clk_disable_unprepare(host->tx_l0_sync_clk);
>  disable_rx_l0:
> @@ -189,8 +186,9 @@ static int ufs_qcom_init_lane_clks(struct ufs_qcom_host *host)
>                 if (err)
>                         goto out;
>
> -               err = ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
> -                       &host->tx_l1_sync_clk);
> +               /* The tx lane1 clk could be muxed, hence keep this optional */
> +               ufs_qcom_host_clk_get(dev, "tx_lane1_sync_clk",
> +                                       &host->tx_l1_sync_clk);
>         }
>  out:
>         return err;
