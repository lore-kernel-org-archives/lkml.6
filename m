Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F87C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E7B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HsGc6i85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E7B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbeK1CQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:16:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53148 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbeK1CQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:16:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wARFHPIt049866;
        Tue, 27 Nov 2018 09:17:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543331845;
        bh=X1sNA9JAPSWRg+RJdZrLgBqJ6j66KV4FRwPqAcKAYas=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=HsGc6i85rPP7r/tJ86lCmO9w35Xa89dMHxS6ze9jwVz+6abyr5I9yTY/8NckrHgU5
         K5G2U/yN6pbvlr+GgOi2jYPij1m7lTsPEv3aVjYWibal/3oYvK4G0kO54A/sCeOFrT
         JGNWv29ju+ba503abdlxNmpHkjl43m+ybioSJcHA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wARFHPqK063320
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 09:17:25 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 27
 Nov 2018 09:17:21 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 27 Nov 2018 09:17:21 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wARFHHg5017258;
        Tue, 27 Nov 2018 09:17:17 -0600
Subject: Re: [PATCH 06/17] soc: ti: pruss: Add a platform driver for PRUSS in
 TI SoCs
To:     David Lechner <david@lechnology.com>, <tony@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-7-git-send-email-rogerq@ti.com>
 <1608af03-35b5-79ce-4995-84e85e740687@lechnology.com>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BFD5FFD.9010807@ti.com>
Date:   Tue, 27 Nov 2018 17:17:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1608af03-35b5-79ce-4995-84e85e740687@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/18 23:15, David Lechner wrote:
> On 11/22/18 5:39 AM, Roger Quadros wrote:
>> From: Suman Anna <s-anna@ti.com>
>>
>> The PRUSS platform driver deals with the overall PRUSS and is
>> used for managing the subsystem level resources like various
>> memories. It is responsible for the creation and deletion of
>> the platform devices for the child PRU devices and other child
>> devices (Interrupt Controller or MDIO node or some syscon nodes)
>> so that they can be managed by specific platform drivers.
>>
>> This design provides flexibility in representing the different
>> modules of PRUSS accordingly, and at the same time allowing the
>> PRUSS driver to add some instance specific configuration within
>> an SoC.
>>
>> The driver currently supports the AM335x SoC.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/soc/ti/Makefile |   2 +-
>>   drivers/soc/ti/pruss.c  | 116 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/soc/ti/pruss.h  |  44 ++++++++++++++++++
>>   3 files changed, 161 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/soc/ti/pruss.c
>>   create mode 100644 drivers/soc/ti/pruss.h
>>
> 
> ...
> 
>> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
>> new file mode 100644
>> index 0000000..0840b59
>> --- /dev/null
>> +++ b/drivers/soc/ti/pruss.c
>> @@ -0,0 +1,116 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PRU-ICSS platform driver for various TI SoCs
>> + *
>> + * Copyright (C) 2014-2018 Texas Instruments Incorporated - http://www.ti.com/
>> + *    Suman Anna <s-anna@ti.com>
>> + *    Andrew F. Davis <afd@ti.com>
>> + */
>> +
>> +#include <linux/dma-mapping.h>
>> +#include <linux/module.h>
> 
> alphabetical order?

ok.

> 
>> +#include <linux/io.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +
>> +#include "pruss.h"
>> +
>> +static int pruss_probe(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct device_node *node = dev->of_node;
>> +    struct device_node *np;
>> +    struct pruss *pruss;
>> +    struct resource res;
>> +    int ret, i, index;
>> +    const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
>> +
>> +    if (!node) {
>> +        dev_err(dev, "Non-DT platform device not supported\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>> +    if (ret) {
>> +        dev_err(dev, "dma_set_coherent_mask: %d\n", ret);
>> +        return ret;
>> +    }
>> +
>> +    pruss = devm_kzalloc(dev, sizeof(*pruss), GFP_KERNEL);
>> +    if (!pruss)
>> +        return -ENOMEM;
>> +
>> +    pruss->dev = dev;
>> +
>> +    np = of_get_child_by_name(node, "memories");
>> +    if (!np)
> 
> error message?

Yes.
> 
>> +        return -ENODEV;
>> +
>> +    for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
>> +        index = of_property_match_string(np, "reg-names", mem_names[i]);
>> +        if (index < 0) {
>> +            of_node_put(np);
>> +            return index;
>> +        }
>> +
>> +        if (of_address_to_resource(np, index, &res)) {
>> +            of_node_put(np);
>> +            return -EINVAL;
>> +        }
>> +
>> +        pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
>> +                            resource_size(&res));
>> +        if (!pruss->mem_regions[i].va) {
>> +            dev_err(dev, "failed to parse and map memory resource %d %s\n",
>> +                i, mem_names[i]);
>> +            of_node_put(np);
>> +            return -ENOMEM;
>> +        }
>> +        pruss->mem_regions[i].pa = res.start;
>> +        pruss->mem_regions[i].size = resource_size(&res);
>> +
>> +        dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %p\n",
>> +            mem_names[i], &pruss->mem_regions[i].pa,
>> +            pruss->mem_regions[i].size, pruss->mem_regions[i].va);
>> +    }
>> +    of_node_put(np);
>> +
>> +    platform_set_drvdata(pdev, pruss);
>> +
>> +    dev_info(&pdev->dev, "creating PRU cores and other child platform devices\n");
> 
> Is this really needed? Or dev_dbg instead?
> 
>> +    ret = of_platform_populate(node, NULL, NULL, &pdev->dev);
>> +    if (ret)
>> +        dev_err(dev, "of_platform_populate failed\n");
>> +
>> +    return ret;
>> +}
>> +
>> +static int pruss_remove(struct platform_device *pdev)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +
>> +    dev_info(dev, "remove PRU cores and other child platform devices\n");
> 
> same here... looks like debug message

Yes for both.
> 
>> +    of_platform_depopulate(dev);
>> +
>> +    return 0;
>> +}
>> +

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
