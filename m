Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77513C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A5621479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PJyXkk0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A5621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeJJApd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:45:33 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55765 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJJApc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:45:32 -0400
Received: by mail-it1-f194.google.com with SMTP id c23-v6so3861410itd.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CBUvyjdfNt8v+6r756Ok0xkk3Et2fKvkHvZY3OXylrM=;
        b=PJyXkk0V54wPWcTBPgGAv3TInvo0+20NsDRrn8azScVl6UDD39DROgR7eaB7yF2uXz
         sxk1zfpyCmRmGKXvWdslclVcd5UxbGesp4ePX6xfrjZKci89lDmIMtqMnbbyC7UP7MN4
         E7QU1nOmkqQJ+JZOf6sgm6VOLoIikbUhjPMD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CBUvyjdfNt8v+6r756Ok0xkk3Et2fKvkHvZY3OXylrM=;
        b=dbnhAYmvVeVQd+myG5t1TUd6NxH2gzfipMQa7qEaKIenU+uCEIzgaQ8/yBuggX2l82
         fFvo94VkhKVm/17QDONFYzmviSMsQiGE471KsIfF+bigdQ8ElsTzRdeUr1qyiOPzpBc4
         ORI9XujDMQX4D8MM3XrxqCBN5wuOT8HIys967tof6ESln0qb8g7JnJVNqBtx41BzTDir
         wbKAbztnfp44EBaGgCJrMWdG86u51rExJhzHhzPJaMy3chdqruAj3I+iqWfppGxXwh7A
         61/Lt0JS2EK3mGHpU93/4mOWJ+VvwrjZTsMG2Jmj3asMRqQPvlABBGjWa09ZdUDsOH23
         jCJw==
X-Gm-Message-State: ABuFfohRGiAcWLbF+Oyr/eSQTMe8AZ6iXTNZ6NXXBBTCFTPmSeg1b/tH
        w7Bv8IEglMET/Uw3gijbL/luQw==
X-Google-Smtp-Source: ACcGV63zc6NtSw6H8573aJWIUyzBQx+hKV2eOCk4ZJWhRXVFqR9r5OimU9vmgVDQi6eF3vZhZG+zlQ==
X-Received: by 2002:a02:9d28:: with SMTP id n37-v6mr23908668jak.80.1539106051379;
        Tue, 09 Oct 2018 10:27:31 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z11-v6sm11412307itz.26.2018.10.09.10.27.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 10:27:30 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:27:26 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Silesh C V <svellattu@mvista.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
Message-ID: <20181009172726.GA2182@xps15>
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Silesh,

On Tue, Oct 09, 2018 at 03:47:24PM +0530, Silesh C V wrote:
> Some drivers need to find the device on a bus having a specific firmware
> node. Currently, such drivers have their own implementations to do this.
> Provide a helper similar to bus_find_device_by_name so that each driver
> does not have to reinvent this.
> 
> Signed-off-by: Silesh C V <svellattu@mvista.com>
> ---
> Changes since v2: 
> 	- make use of dev_fwnode in match_fwnode.
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
> +	return dev_fwnode(dev) == fwnode;
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
> +					struct fwnode_handle *fwnode)

I get the following when running checkpatch on your set:

mpoirier@xps15:~/work/linaro/coresight/kernel-maint$ ./scripts/checkpatch.pl
0001-Driver-core-add-bus_find_device_by_fwnode.patch
WARNING: line over 80 characters
#45: FILE: drivers/base/bus.c:389:
+struct device *bus_find_device_by_fwnode(struct bus_type *bus, struct device
*start,

total: 0 errors, 1 warnings, 41 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0001-Driver-core-add-bus_find_device_by_fwnode.patch has style problems, please
review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

Regards,
Mathieu

> +{
> +	return bus_find_device(bus, start, (void *)fwnode, match_fwnode);
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
>  				       struct device *start,
>  				       const char *name);
> +struct device *bus_find_device_by_fwnode(struct bus_type *bus,
> +				       struct device *start,
> +				       struct fwnode_handle *fwnode);
>  struct device *subsys_find_device_by_id(struct bus_type *bus, unsigned int id,
>  					struct device *hint);
>  int bus_for_each_drv(struct bus_type *bus, struct device_driver *start,
> -- 
> 1.9.1
> 
