Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE60C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10ECD20858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 06:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10ECD20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeGVHZ2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 03:25:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57805 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbeGVHZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 03:25:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B54D2207B4; Sun, 22 Jul 2018 08:29:51 +0200 (CEST)
Received: from bbrezillon (unknown [37.173.105.99])
        by mail.bootlin.com (Postfix) with ESMTPSA id 034B02072F;
        Sun, 22 Jul 2018 08:29:40 +0200 (CEST)
Date:   Sun, 22 Jul 2018 08:29:39 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        miquel.raynal@bootlin.com, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] drivers/memory/Kconfig: Add CONFIG_OF dependency
Message-ID: <20180722082939.2de739f1@bbrezillon>
In-Reply-To: <a83ff193-be57-f566-cafb-132075025b56@infradead.org>
References: <20180721200049.7553-1-anders.roxell@linaro.org>
        <a83ff193-be57-f566-cafb-132075025b56@infradead.org>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Arnd, Rob and the DT ML.

On Sat, 21 Jul 2018 14:53:47 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 07/21/2018 01:00 PM, Anders Roxell wrote:
> > JZ4780_NEMC doesn't depend on OF, and if OF isn't enabled we get this
> > error:
> > drivers/memory/jz4780-nemc.c: In function ‘jz4780_nemc_num_banks’:
> > drivers/memory/jz4780-nemc.c:72:10: error: implicit declaration of
> >  function ‘of_read_number’; did you mean ‘down_read_nested’?
> >  [-Werror=implicit-function-declaration]
> >    bank = of_read_number(prop, 1);
> >           ^~~~~~~~~~~~~~
> >           down_read_nested

Looks like of.h defines stubs so that people can compile-test without
CONFIG_OF selected. Maybe we should move of_read_number() and
of_read_ulong() out of the #ifdef CONFIG_OF section.

Alternatively, we could patch jz4780-nemc.c to not use of_read_number
and instead rely on of_read_property_u32_index() +
of_property_count_elems_of_size() + of_n_{addr,size}_cells():

--->8---
diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
index bcf06adefc96..9ad7abc6983a 100644
--- a/drivers/memory/jz4780-nemc.c
+++ b/drivers/memory/jz4780-nemc.c
@@ -63,14 +63,21 @@ struct jz4780_nemc {
  */
 unsigned int jz4780_nemc_num_banks(struct device *dev)
 {
-       const __be32 *prop;
-       unsigned int bank, count = 0;
        unsigned long referenced = 0;
-       int i = 0;
-
-       while ((prop = of_get_address(dev->of_node, i++, NULL, NULL))) {
-               bank = of_read_number(prop, 1);
-               if (!(referenced & BIT(bank))) {
+       int nelems, elemsize, i = 0;
+       unsigned int count = 0;
+
+       /* #address-cells = 2 and #size-cells = 1, hence  */
+       elemsize = of_n_addr_cells(dev->of_node) +
+                  of_n_size_cells(dev->of_node);
+       nelems = of_property_count_elems_of_size(dev->of_node, "reg", elemsize);
+       for (i = 0; i < nelems; i++) {
+               u32 bank;
+
+               if (!of_property_read_u32_index(dev->of_node, "reg",
+                                               i * elemsize, &bank) &&
+                   bank >= 1 && bank < JZ4780_NEMC_NUM_BANKS &&
+                   !(referenced & BIT(bank))) {
                        referenced |= BIT(bank);
                        count++;
                }
@@ -269,10 +276,9 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
        struct jz4780_nemc *nemc;
        struct resource *res;
        struct device_node *child;
-       const __be32 *prop;
-       unsigned int bank;
        unsigned long referenced;
        int i, ret;
+       u32 bank;
 
        nemc = devm_kzalloc(dev, sizeof(*nemc), GFP_KERNEL);
        if (!nemc)
@@ -316,10 +322,27 @@ static int jz4780_nemc_probe(struct platform_device *pdev)
         * registered for it.
         */
        for_each_child_of_node(nemc->dev->of_node, child) {
+               int nelems, elemsize;
+
                referenced = 0;
                i = 0;
-               while ((prop = of_get_address(child, i++, NULL, NULL))) {
-                       bank = of_read_number(prop, 1);
+               elemsize = of_n_addr_cells(dev->of_node) +
+                          of_n_size_cells(dev->of_node);
+               nelems = of_property_count_elems_of_size(dev->of_node, "reg",
+                                                        elemsize);
+               for (i = 0; i < nelems; i++) {
+                       u32 bank;
+
+                       ret = of_property_read_u32_index(dev->of_node, "reg",
+                                                        i * elemsize, &bank);
+                       if (ret) {
+                               dev_err(nemc->dev,
+                                       "failed to read bank %d of %pOF (err = %d)\n",
+                                       i, child, ret);
+                               referenced = 0;
+                               break;
+                       }
+
                        if (bank < 1 || bank >= JZ4780_NEMC_NUM_BANKS) {
                                dev_err(nemc->dev,
                                        "%pOF requests invalid bank %u\n",
