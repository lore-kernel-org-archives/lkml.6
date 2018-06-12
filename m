Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B73D5C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FACF2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cws0QnOv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FACF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754396AbeFLRm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754223AbeFLRmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:42:55 -0400
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com [209.85.214.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ED2A2086D;
        Tue, 12 Jun 2018 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528825375;
        bh=jwpEHHWodfhDaq/Q5SEIu+/ICTj+5d7EouTDJCtG5+4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cws0QnOvmiyZjBKoeoAW+PwnV/zjrf4b8mfAvR4LdXaV3scJo2fpkc4j0lLHjtEG/
         +y3+IaWur5EHBHmXbxbklKDWdec7IEDLqsV3doK014CJVf9gj7R5LubD0hsZFBYOMi
         KzXSGJabJryM3x0zeKew9pcqL/LzE3Jdo728jgHc=
Received: by mail-it0-f51.google.com with SMTP id p185-v6so387547itp.4;
        Tue, 12 Jun 2018 10:42:55 -0700 (PDT)
X-Gm-Message-State: APt69E3a66D8BuwVES7lgfG0AOd+nKcwCYvFMBj20dRNLQ1a6LhZhvYe
        hfRDapWku5EANLRNcB4Uh3ALaz+OdeODJMQkZA==
X-Google-Smtp-Source: ADUXVKJFiK2lrt2ScmQx36xuBCtY7cbeQrJdDBboiMl4Ppo2NTWhdo2ori0nW8YDOhauQQCRttmEmG5Yv4vvwx6cTgo=
X-Received: by 2002:a24:ec44:: with SMTP id g65-v6mr1511411ith.18.1528825374558;
 Tue, 12 Jun 2018 10:42:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 10:42:34
 -0700 (PDT)
In-Reply-To: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Jun 2018 11:42:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+dHVN+Y7xczf_Oxcn=BiJ6N9WzovRbSujgLLTYHMEh0g@mail.gmail.com>
Message-ID: <CAL_Jsq+dHVN+Y7xczf_Oxcn=BiJ6N9WzovRbSujgLLTYHMEh0g@mail.gmail.com>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 6:01 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> There are still quite a few cases where a device might want to get to a
> different node of the device-tree, obtain the resources and map them.
>
> Drivers doing that currently open code the whole thing, which is error
> proe.
>
> We have of_iomap() and of_io_request_and_map() but they both have shortcomings,
> such as not returning the size of the resource found (which can be necessary)
> and not being "managed".
>
> This adds a devm_of_iomap() that provides all of these and should probably
> replace uses of the above in most drivers.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> I'm cooking a driver that uses this, if there's no objection I'd like
> to carry it in my pull request for that driver (it can also exist in
> the DT tree of course). Just let me know.

We generally only use of_iomap when there is no struct device for any
new driver. Why can't you use devm_ioremap_resource? Is this a
non-platform bus device?

>
>  drivers/of/address.c       | 35 +++++++++++++++++++++++++++++++++++
>  include/linux/of_address.h |  5 +++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index cf83c05f5650..b7d49ee7b690 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -807,6 +807,41 @@ void __iomem *of_io_request_and_map(struct device_node *np, int index,
>  }
>  EXPORT_SYMBOL(of_io_request_and_map);
>
> +/*
> + * devm_of_iomap - Requests a resource and maps the memory mapped IO
> + *                for a given device_node managed by a given device
> + *
> + * Checks that a resource is a valid memory region, requests the memory
> + * region and ioremaps it. All operations are managed and will be undone
> + * on driver detach of the device.
> + *
> + * This is to be used when a device requests/maps resources described
> + * by other device tree nodes (children or otherwise).
> + *
> + * @dev:       The device "managing" the resource
> + * @node:       The device-tree node where the resource resides
> + * @index:     index of the MMIO range in the "reg" property
> + * @size:      Returns the size of the resource (pass NULL if not needed)
> + * Returns a pointer to the requested and mapped memory or an ERR_PTR() encoded
> + * error code on failure. Usage example:
> + *
> + *     base = devm_of_iomap(&pdev->dev, node, 0, NULL);
> + *     if (IS_ERR(base))
> + *             return PTR_ERR(base);
> + */
> +void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
> +                           resource_size_t *size)

of/address.c generally doesn't depend on struct device. I'd like to
keep it that way.

Rob
