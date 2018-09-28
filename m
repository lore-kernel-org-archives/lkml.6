Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E442CC004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9B62073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoFEU6Cy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9B62073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbeI2ETy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbeI2ETx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:19:53 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA9F42082C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 21:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538171651;
        bh=uQt/H0Qsg9xfeMmMwXyE4p6FDKSju1tJwvqNR426emE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EoFEU6CyKSNIGfYXRda//0bb2mMLKRgfSDXdW9sL8ts87s+XEV/jzQuTy3UQx++ET
         EUnkujSo9uA/pyyl6TA9MV53H/H00nKP/iABf5C/cH2g59dViw5Afssrz/4XM57vTX
         415Ch5GQdojrahbDFZRJYMKIApLSWHEUNLw9Ka+Y=
Received: by mail-qk1-f169.google.com with SMTP id 204-v6so4144690qkd.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:54:11 -0700 (PDT)
X-Gm-Message-State: ABuFfoi9Q/DxhsrJtJjNJxbiNvV71e55a6IjaaWy5fzpsl9jxoUwCen1
        5Vg+v8hYhP88I5H/myMAjqIE3WUNJtGBHMlwGg==
X-Google-Smtp-Source: ACcGV60ng0ae5W7y9F7F45Q63DtO2VJg/EIcUrGvZUl9E6OPI7bVaUOlvNWA9pVmS0l8WLHNiCsB7Jwa0X2R+fn1WLA=
X-Received: by 2002:a37:12d1:: with SMTP id 78-v6mr395666qks.147.1538171650940;
 Fri, 28 Sep 2018 14:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-27-robh@kernel.org>
In-Reply-To: <20180828015252.28511-27-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 28 Sep 2018 16:54:00 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJH=s-JOH=OuwPv+pMHYJftVb-ODgL0P6ibDyETx+4W3A@mail.gmail.com>
Message-ID: <CAL_JsqJH=s-JOH=OuwPv+pMHYJftVb-ODgL0P6ibDyETx+4W3A@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Convert to using %pOFn instead of device_node.name
To:     Jassi Brar <jaswinder.singh@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 8:54 PM Rob Herring <robh@kernel.org> wrote:
>
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mailbox/ti-msgmgr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ping.

>
> diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
> index 5bceafbf6699..713d701b6568 100644
> --- a/drivers/mailbox/ti-msgmgr.c
> +++ b/drivers/mailbox/ti-msgmgr.c
> @@ -560,8 +560,8 @@ static struct mbox_chan *ti_msgmgr_of_xlate(struct mbox_controller *mbox,
>         }
>
>  err:
> -       dev_err(inst->dev, "Queue ID %d, Proxy ID %d is wrong on %s\n",
> -               req_qid, req_pid, p->np->name);
> +       dev_err(inst->dev, "Queue ID %d, Proxy ID %d is wrong on %pOFn\n",
> +               req_qid, req_pid, p->np);
>         return ERR_PTR(-ENOENT);
>  }
>
> --
> 2.17.1
>
