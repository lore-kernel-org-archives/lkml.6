Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9A9C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27712214C5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:20:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27712214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJIRgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:36:55 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38496 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeJIRgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:36:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id u197-v6so784897oif.5;
        Tue, 09 Oct 2018 03:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kQ8+G7lzVojEZC6UdfkP2AJtnzgX7U5Kd5SOmdf5xs=;
        b=YoGwOwR9TbJmk+7BTys9zFGOyyhDskrGtyI5yLi4oOE9J95SKPIHC0nKUMXKOXFuZC
         rx/Jcm97T7CW2g/elvHkJHJxFyYH46cV8Dt5Ur2eJ3Nv/AVqDzxtpep+xB0Ww48qQX5y
         I5KPUOW3toRxb5CndCQPSyCrZrTW7Orr8wFfSvybq4r+H1CbXRXLDSgq9PiwyN48CEuF
         wW3rBCLJaeTtTV15qmeEwV30q+OkCanwTY7rk4QyzLIy5EueZDviKPk8mpo7RoGB5hWf
         rZyaApV1NLCvIRw3b57fN06kv5Mp8Byh+pD7xNllbq/TBYuxI2vcWPioN1VRYUCbldwO
         eaqg==
X-Gm-Message-State: ABuFfoilmljtTnf2VDqvTnBAZ9Abg1X/3BNVdeZJhxq3ioTAg6RBngSW
        KNCPYlZZczX43Y7aq4TWhiUXzqAwc5qwoQBpyx8=
X-Google-Smtp-Source: ACcGV62ZdFsVQyuOECR8oraKvAjnldzwCS4sQ4sFb5OMN72U8Ape8JnTBWu3wNyFBtqnVDOabUacNbRd2B7Cui/vwwk=
X-Received: by 2002:aca:c2c3:: with SMTP id s186-v6mr6141797oif.193.1539080440586;
 Tue, 09 Oct 2018 03:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
In-Reply-To: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Oct 2018 12:20:29 +0200
Message-ID: <CAJZ5v0joQi-N=-6TUMUQXQbxYtvS2AOLJD3KUqUAL-w9hJTQeg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
To:     svellattu@mvista.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-rdma@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>, oulijun@huawei.com,
        xavier.huwei@huawei.com, yisen.zhuang@huawei.com,
        salil.mehta@huawei.com, srinivas.kandagatla@linaro.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 9, 2018 at 12:18 PM Silesh C V <svellattu@mvista.com> wrote:
>
> Some drivers need to find the device on a bus having a specific firmware
> node. Currently, such drivers have their own implementations to do this.
> Provide a helper similar to bus_find_device_by_name so that each driver
> does not have to reinvent this.
>
> Signed-off-by: Silesh C V <svellattu@mvista.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes since v2:
>         - make use of dev_fwnode in match_fwnode.
>
>  drivers/base/bus.c     | 20 ++++++++++++++++++++
>  include/linux/device.h |  3 +++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 8bfd27e..a2f39db 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -17,6 +17,7 @@
>  #include <linux/string.h>
>  #include <linux/mutex.h>
>  #include <linux/sysfs.h>
> +#include <linux/property.h>
>  #include "base.h"
>  #include "power/power.h"
>
> @@ -373,6 +374,25 @@ struct device *bus_find_device_by_name(struct bus_type *bus,
>  }
>  EXPORT_SYMBOL_GPL(bus_find_device_by_name);
>
> +static int match_fwnode(struct device *dev, void *fwnode)
> +{
> +       return dev_fwnode(dev) == fwnode;
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
