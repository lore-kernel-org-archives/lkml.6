Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52260C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DC820844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DC820844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405424AbeHATHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:07:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404974AbeHATHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:07:10 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7667FD00;
        Wed,  1 Aug 2018 17:20:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Tobin C. Harding" <me@tobin.cc>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 174/246] mmc: pwrseq: Use kmalloc_array instead of stack VLA
Date:   Wed,  1 Aug 2018 18:51:24 +0200
Message-Id: <20180801165020.060774270@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Tobin C. Harding" <me@tobin.cc>

[ Upstream commit 486e6661367b40f927aadbed73237693396cbf94 ]

The use of stack Variable Length Arrays needs to be avoided, as they
can be a vector for stack exhaustion, which can be both a runtime bug
(kernel Oops) or a security flaw (overwriting memory beyond the
stack). Also, in general, as code evolves it is easy to lose track of
how big a VLA can get. Thus, we can end up having runtime failures
that are hard to debug. As part of the directive[1] to remove all VLAs
from the kernel, and build with -Wvla.

Currently driver is using a VLA declared using the number of descriptors.  This
array is used to store integer values and is later used as an argument to
`gpiod_set_array_value_cansleep()` This can be avoided by using
`kmalloc_array()` to allocate memory for the array of integer values.  Memory is
free'd before return from function.

>From the code it appears that it is safe to sleep so we can use GFP_KERNEL
(based _cansleep() suffix of function `gpiod_set_array_value_cansleep()`.

It can be expected that this patch will result in a small increase in overhead
due to the use of `kmalloc_array()`

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Tobin C. Harding <me@tobin.cc>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/pwrseq_simple.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -40,14 +40,18 @@ static void mmc_pwrseq_simple_set_gpios_
 	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
 
 	if (!IS_ERR(reset_gpios)) {
-		int i;
-		int values[reset_gpios->ndescs];
+		int i, *values;
+		int nvalues = reset_gpios->ndescs;
 
-		for (i = 0; i < reset_gpios->ndescs; i++)
+		values = kmalloc_array(nvalues, sizeof(int), GFP_KERNEL);
+		if (!values)
+			return;
+
+		for (i = 0; i < nvalues; i++)
 			values[i] = value;
 
-		gpiod_set_array_value_cansleep(
-			reset_gpios->ndescs, reset_gpios->desc, values);
+		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc, values);
+		kfree(values);
 	}
 }
 


