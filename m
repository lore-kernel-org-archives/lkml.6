Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD020ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EA62087A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EA62087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbeITNVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:21:15 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33216 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeITNVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:21:14 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so7533017oip.0;
        Thu, 20 Sep 2018 00:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8mO3mJk3c1sLmFf5+i5JHc6bnb6y7xmjW+dp4qPito=;
        b=QuBqNTKLVzdVrPUFuR6DyQIF9yz71tFFYSE+8UnWkqjjCAYndF4I6m7OxZZXy/w2HV
         GyCgFVoi0PXUw4P/X1xT6zN4e0RtUiXQ/N4HsTa1jo3Cr4ADGuZoR5bDsT2pnTvXchwB
         z3GuPU6Ov2lJpS6uMnpd9lZD80y7vQPMiqrF4GgkY+njpmkbScuHZFuCKlzmqHCbMf9j
         gfqUU3BtEgzV130GN270Gok9XHS0Di+VhxoOyGHNeoCaKfCWe/kO4l7jzUja+sUEN8Rh
         jtaa9+euhKtagCRl892Zqw9enPnhJlE82p7Ca8BvoDlyXK4uO5X4AzTaig77Trid5HEe
         Wtug==
X-Gm-Message-State: APzg51DTCc0VHwk6tpesC57nfSIu6qy30f6C4bNdH6alwnUOF2gB0wR9
        PVCs7Ypn3HdD0B0zAlCdKJ450PTomvi1w/sSOJM=
X-Google-Smtp-Source: ANB0VdZoAtFtC7umwr2ArIeFQxlItAa1R/LpQ9Qmmzpbw5gP6+5narDAJPeaeqnumWyWXCpcDo/We8//BSwIxCdOWDo=
X-Received: by 2002:aca:e6d4:: with SMTP id d203-v6mr811923oih.311.1537429147867;
 Thu, 20 Sep 2018 00:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180920010938.10315-1-bjorn.andersson@linaro.org>
In-Reply-To: <20180920010938.10315-1-bjorn.andersson@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Sep 2018 09:38:56 +0200
Message-ID: <CAJZ5v0jPiHMsXV5Rz-6K-qH067xYbmzGRY_hdYxS5uU88jMmew@mail.gmail.com>
Subject: Re: [PATCH] firmware: Always initialize the fw_priv list object
To:     bjorn.andersson@linaro.org
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 3:07 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> When freeing the fw_priv the item is taken off the list. This causes an
> oops in the FW_OPT_NOCACHE case as the list object is not initialized.
>
> Make sure to initialize the list object regardless of this flag.
>
> Fixes: 422b3db2a503 ("firmware: Fix security issue with request_firmware_into_buf()")
> Cc: stable@vger.kernel.org
> Cc: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/base/firmware_loader/main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index b3c0498ee433..8e9213b36e31 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -226,8 +226,11 @@ static int alloc_lookup_fw_priv(const char *fw_name,
>         }
>
>         tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size);
> -       if (tmp && !(opt_flags & FW_OPT_NOCACHE))
> -               list_add(&tmp->list, &fwc->head);
> +       if (tmp) {
> +               INIT_LIST_HEAD(&tmp->list);
> +               if (!(opt_flags & FW_OPT_NOCACHE))
> +                       list_add(&tmp->list, &fwc->head);
> +       }
>         spin_unlock(&fwc->lock);
>
>         *fw_priv = tmp;
> --

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
