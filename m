Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E28C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7138B216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 09:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ek3c0imi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7138B216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeHUM5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 08:57:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46186 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeHUM5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 08:57:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so12616061wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 02:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7M4ayFm4nP/hcqkuO/2c6zn8cClN7eWqPOx4O+bxppA=;
        b=ek3c0imiqsaqFeQ2lceSGCsMZs886/riWR+UlO47543KVtV/t0reBN9NL0qpIhc+cL
         s45tFCjfAYqjack2bldkX4xkG9eImCiqY7uP1Kj0YAIcu5keN6KEHYw1dgGXfGKuJ7hA
         agA11/DNoslMmxiWRwt5qwkxZJgI9o8WThRLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7M4ayFm4nP/hcqkuO/2c6zn8cClN7eWqPOx4O+bxppA=;
        b=iMWDJDVOWrK75C8QYEDjCdiFFGxNLPNNGhjk7R7UkiXHnx/ww04rQcTTk0tj7SWIzM
         xI7Vy1IaHEgu/wQRcoyUtrw98BmkbM96fuGVN+XHflka4Rn2gi6pBKRJgosbmckW7/Tn
         X9O/qmEdWE4cVArfxPB9pOSGTCUiBVB3aMpOfxjpm2Z+1uoWs3WQospHHQVzI0zMxcHo
         ZDPmnfPLF6H4BXAE4krQM6afkPAiyhswUt2VPfrFGDp/+lWuGfHwoX+vKl96YvrbxmWv
         TTCv8A8xynGxBhqZquGpWZbn7OqdYsjgWHiJQbMIvI8NoL+B4TK3Ro4UtObFr+zHjTLX
         b/1g==
X-Gm-Message-State: APzg51BIzZi7DKGAo7xgpW7UKj9k4Q9t5L/uAE0iumKtm9l5fcmQ5i6W
        dWoY1I5raUxKYgFv/F4iWn6eeA==
X-Google-Smtp-Source: ANB0VdaNR+/lzyWT6LuacXP3H82AL9zjxrU2+qYO+sDftrRSsp0ukyEFfu/i9n67FRLczCSOrWxDNQ==
X-Received: by 2002:adf:b519:: with SMTP id a25-v6mr11472211wrd.273.1534844296284;
        Tue, 21 Aug 2018 02:38:16 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id s10-v6sm5025914wrw.35.2018.08.21.02.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 02:38:15 -0700 (PDT)
Subject: Re: [PATCH v2 06/29] mtd: Add support for reading MTD devices via the
 nvmem API
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Alban <albeu@free.fr>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Naren <naren.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Sven Van Asbroeck <svendev@arcx.com>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        David Lechner <david@lechnology.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-7-brgl@bgdev.pl> <20180817182720.6a6e5e8e@bbrezillon>
 <20180819133106.0420df5f@tock> <20180819184609.6dcdbb9a@bbrezillon>
 <20180821005327.0d312a85@tock> <20180821074404.23aaeb6b@bbrezillon>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <81407b4d-a02f-4085-f333-a96102bd96ce@linaro.org>
Date:   Tue, 21 Aug 2018 10:38:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180821074404.23aaeb6b@bbrezillon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris/Bartosz,

On 21/08/18 06:44, Boris Brezillon wrote:
>>> 4/ Add a ->of_xlate() hook that would be called if present by the
>>>     framework instead of using the default parsing we have right now.
>> That is a bit cleaner, but I don't think it would be worse the
>> complexity.
> But it's way more flexible than putting everything in the nvmem
> framework. BTW, did you notice that nvmem-cells parsing does not work
> with flashes bigger than 4GB, because the framework assumes
> #address-cells and #size-cells are always 1. That's probably something
> we'll have to fix for the MTD case.
> 

I have hacked up some thing on these lines to add a custom match 
function for nvmem provider and it looks like it can work for mtd case.

This addresses concern #1 "to ignore of_node from dev pointer passed to 
nvmem_config" also provides way to do some sanity checks on nvmem cell node.
In this patch I have just added a simple mtd_nvmem_match() example which 
will be always true, however we can add checks here to see if the np is 
actually a nvmem-cells node or something on those lines to enforce the 
bindings. Please fix and remove this from nvmem-core patch incase you 
plan to use/test this.

We still have one open issue of supporting #address-cells and 
#size-cells in nvmem, which I can look at if you are happy with this 
approach!

----------------------------------->cut<---------------------------------
Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date:   Tue Aug 21 10:07:24 2018 +0100

     nvmem: core: add custom match function support

     Some nvmem providers might not have a simple DT layout, nvmem cells
     could be part of the unpartioned space or with-in partition or
     even in sub partition of the provider.

     Current matching function is expecting that the provider should be
     immediate parent of the cell, which might not be true for the above
     cases. So allow a custom match function for such devices which can
     validate and match the cell as per the provider specific bindings.

     Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index a57302eaceb5..33541b18ac30 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -502,6 +502,19 @@ static int mtd_nvmem_reg_read(void *priv, unsigned 
int offset,
         return retlen == bytes ? 0 : -EIO;
  }

+static int mtd_nvmem_match(void *priv, struct device *dev,
+                          struct device_node *np)
+{
+       struct mtd_info *mtd = priv;
+
+       /*
+        * Add more checks to make sure device node is inline with
+        * binding if required
+        */
+
+       return &mtd->dev == dev->parent;
+}
+
  static int mtd_nvmem_add(struct mtd_info *mtd)
  {
         struct nvmem_config config = { };
@@ -516,6 +529,7 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
         config.read_only = true;
         config.root_only = true;
         config.priv = mtd;
+       config.match = mtd_nvmem_match;

         mtd->nvmem = devm_nvmem_register(&mtd->dev, &config);
         if (IS_ERR(mtd->nvmem)) {
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 3a8bf832243d..32bc4e70522c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -41,6 +41,7 @@ struct nvmem_device {
         struct device           *base_dev;
         nvmem_reg_read_t        reg_read;
         nvmem_reg_write_t       reg_write;
+       nvmem_match_t           match;
         void *priv;
  };

@@ -265,6 +266,11 @@ static struct bus_type nvmem_bus_type = {

  static int of_nvmem_match(struct device *dev, void *nvmem_np)
  {
+       struct nvmem_device *nvmem = to_nvmem_device(dev);
+
+       if (nvmem->match)
+               return nvmem->match(nvmem->priv, dev, nvmem_np);
+
         return dev->of_node == nvmem_np;
  }

@@ -482,7 +488,9 @@ struct nvmem_device *nvmem_register(const struct 
nvmem_config *config)
         nvmem->priv = config->priv;
         nvmem->reg_read = config->reg_read;
         nvmem->reg_write = config->reg_write;
-       nvmem->dev.of_node = config->dev->of_node;
+
+       if (!config->match)
+               nvmem->dev.of_node = config->dev->of_node;

         if (config->id == -1 && config->name) {
                 dev_set_name(&nvmem->dev, "%s", config->name);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 24def6ad09bb..b29059bb406e 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -14,6 +14,7 @@

  #include <linux/err.h>
  #include <linux/errno.h>
+#include <linux/of.h>

  struct nvmem_device;
  struct nvmem_cell_info;
@@ -21,6 +22,9 @@ typedef int (*nvmem_reg_read_t)(void *priv, unsigned 
int offset,
                                 void *val, size_t bytes);
  typedef int (*nvmem_reg_write_t)(void *priv, unsigned int offset,
                                  void *val, size_t bytes);
+typedef int (*nvmem_match_t)(void *priv, struct device *dev,
+                            struct device_node *np);
+

  /**
   * struct nvmem_config - NVMEM device configuration
@@ -58,6 +62,7 @@ struct nvmem_config {
         bool                    root_only;
         nvmem_reg_read_t        reg_read;
         nvmem_reg_write_t       reg_write;
+       nvmem_match_t           match;
         int     size;
         int     word_size;
         int     stride;

----------------------------------->cut<---------------------------------

thanks,
srini
