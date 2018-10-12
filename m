Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62ADC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871422086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871422086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeJLQro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:47:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44378 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeJLQrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:47:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A31A72083D; Fri, 12 Oct 2018 11:16:12 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-7-245.w90-88.abo.wanadoo.fr [90.88.129.245])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5EBCF20703;
        Fri, 12 Oct 2018 11:16:02 +0200 (CEST)
Date:   Fri, 12 Oct 2018 11:16:03 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: sa1100: avoid VLA in sa1100_setup_mtd
Message-ID: <20181012111603.0d03e043@bbrezillon>
In-Reply-To: <20181010184533.691620-1-arnd@arndb.de>
References: <20181010184533.691620-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, 10 Oct 2018 20:44:50 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> Enabling -Wvla found another variable-length array with randconfig
> testing:
> 
> drivers/mtd/maps/sa1100-flash.c: In function 'sa1100_setup_mtd':
> drivers/mtd/maps/sa1100-flash.c:224:10: error: ISO C90 forbids variable length array 'cdev' [-Werror=vla]
> 
> As far as I can tell, there is an upper bound on the number of resources
> that can be passed, based on the number of CS lines on the bus.
> In practice, all boards we support have either one or two resources,
> but using six to be on the safe side has no extra cost.

Why not dynamically allocate cdev instead? That removes any kind of
guessing on the max value, and it shouldn't hurt much since this code is
in the probe path.

--->8---
diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
index 784c6e1a0391..fd5fe12d7461 100644
--- a/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -221,7 +221,14 @@ static struct sa_info *sa1100_setup_mtd(struct platform_device *pdev,
                info->mtd = info->subdev[0].mtd;
                ret = 0;
        } else if (info->num_subdev > 1) {
-               struct mtd_info *cdev[nr];
+               struct mtd_info **cdev;
+
+               cdev = kmalloc_array(nr, sizeof(*cdev), GFP_KERNEL);
+               if (!cdev) {
+                       ret = -ENOMEM;
+                       goto err;
+               }
+
                /*
                 * We detected multiple devices.  Concatenate them together.
                 */
@@ -230,6 +237,7 @@ static struct sa_info *sa1100_setup_mtd(struct platform_device *pdev,
 
                info->mtd = mtd_concat_create(cdev, info->num_subdev,
                                              plat->name);
+               kfree(cdev);
                if (info->mtd == NULL) {
                        ret = -ENXIO;
                        goto err;
