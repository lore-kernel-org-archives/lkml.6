Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C93C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AC72087C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AC72087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbeJHPX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:23:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46764 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeJHPXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:23:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id k64-v6so15069439oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 01:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PznUbTrfR6qUTimaak66NhD6E9qcxnwJqTLfRp98mb0=;
        b=PaIcSm9u7WJLPFK5Td/bQmVU1iyrWjBmJryqOt3EdXM4A7NaAu875USFcjAp1ooSF4
         U3VtC1oa0wWbKQS6LhPP78mdM9ybv/BVhn5ydsBpdJV7EHh/+zLs3Kj0jBHuHxgCXpet
         9tbGH2BvuYMlLyC1lVlY3CXVued2dAtarz9OMSoOJkkewLr/0J9zjPlnAqDzWVTsyUZp
         ETHaL1zzpS0PTdum4Q3ZKrRDNl17+xiL+M7OpQFu+xIMnbYWPO/s+CIAe4YfkTeGpxnx
         YKBC3DECMa/uFyrjeUWcOI+DMFJZYv/LdXmOj6zkTDSQoa32akk7Q2t/UJ3WhVG02k9B
         djHg==
X-Gm-Message-State: ABuFfoifykI19RZoDvxUWpGRqwrLwDMEZUWqktO0gN6uugYmpBt6UqPL
        FFljuCGUGYUfFuUZ2gxE2QxpxLgPL8q6mLgLlvE=
X-Google-Smtp-Source: ACcGV61LY4yQjChlrFtjSwFZHqm5EsEPEKUwggPghXNvOcmE7NAABzxMqgQ/TkYfzclT55jYD0QbpnyzXieGw2VsFQs=
X-Received: by 2002:aca:1314:: with SMTP id e20-v6mr4383032oii.216.1538986405551;
 Mon, 08 Oct 2018 01:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <1537853328-1282-1-git-send-email-svellattu@mvista.com>
In-Reply-To: <1537853328-1282-1-git-send-email-svellattu@mvista.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Oct 2018 10:13:14 +0200
Message-ID: <CAJZ5v0gvn=bipyTXEyVUbxJJbOmH5B40K=adaPVxoeX17M+M_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Driver core: add bus_find_device_by_fwnode
To:     svellattu@mvista.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 7:29 AM Silesh C V <svellattu@mvista.com> wrote:
>
> Some drivers need to find the device on a bus having a specific firmware
> node. Currently, such drivers have their own implementations to do this.
> Provide a helper similar to bus_find_device_by_name so that each driver
> does not have to reinvent this.
>
> Signed-off-by: Silesh C V <svellattu@mvista.com>
>
> ---
>  drivers/base/bus.c     | 26 ++++++++++++++++++++++++++
>  include/linux/device.h |  3 +++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 8bfd27e..148b198 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -17,6 +17,7 @@
>  #include <linux/string.h>
>  #include <linux/mutex.h>
>  #include <linux/sysfs.h>
> +#include <linux/of.h>
>  #include "base.h"
>  #include "power/power.h"
>
> @@ -373,6 +374,31 @@ struct device *bus_find_device_by_name(struct bus_type *bus,
>  }
>  EXPORT_SYMBOL_GPL(bus_find_device_by_name);
>
> +static int match_fwnode(struct device *dev, void *data)
> +{
> +       struct fwnode_handle *fwnode = data;
> +       struct device_node *of_node = to_of_node(fwnode);
> +
> +       if (of_node)
> +               return dev->of_node == of_node;
> +       else
> +               return dev->fwnode == fwnode;

Why don't you use dev_fwnode() here?

> +}
> +
> +/**
> + * bus_find_device_by_fwnode - device iterator for locating a particular device
> + * having a specific firmware node
> + * @bus: bus type
> + * @start: Device to begin with
> + * @fwnode: firmware node of the device to match
> + */
> +struct device *bus_find_device_by_fwnode(struct bus_type *bus, struct device *start,
> +                                       struct fwnode_handle *fwnode)
> +{
> +       return bus_find_device(bus, start, (void *)fwnode, match_fwnode);
> +}
> +EXPORT_SYMBOL_GPL(bus_find_device_by_fwnode);
> +
>  /**
>   * subsys_find_device_by_id - find a device with a specific enumeration number
>   * @subsys: subsystem
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 8f88254..09384f6 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -171,6 +171,9 @@ struct device *bus_find_device(struct bus_type *bus, struct device *start,
>  struct device *bus_find_device_by_name(struct bus_type *bus,
>                                        struct device *start,
>                                        const char *name);
> +struct device *bus_find_device_by_fwnode(struct bus_type *bus,
> +                                      struct device *start,
> +                                      struct fwnode_handle *fwnode);
>  struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
>                                         struct device *hint);
>  int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
> --
> 1.9.1
>
