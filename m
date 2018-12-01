Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD4EC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 12:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5D820867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 12:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5D820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeLAXRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 18:17:39 -0500
Received: from www.osadl.org ([62.245.132.105]:44000 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeLAXRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 18:17:39 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wB1C0Tuv022428;
        Sat, 1 Dec 2018 13:00:30 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [RFC PATCH] gpio: pl061: handle failed allocations
Date:   Sat,  1 Dec 2018 12:57:18 +0100
Message-Id: <1543665438-26756-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kzalloc(), devm_kstrdup() and devm_kasprintf() all can
fail internal allocation and return NULL. Using any of the assigned
objects without checking is not safe. As this is early in the boot
phase and these allocations really should not fail, any failure here
is probably an indication of a more serious issue so it makes little
sense to try and rollback the previous allocated resources or try to
continue;  but rather the probe function is simply exited with -ENOMEM.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 684284b64aae ("ARM: integrator: add MMCI device to IM-PD1")
---

devm_kstrdup() issue found by experimental coccinelle script, the rest during
review of the reported issue.

Q: Not sure if brute force returning here without rollback of previously
   allocated resources is acceptable - but I guess if any of those
   allocations failed the system is doomed anyway so trying a  continue;
   here does not seem sensible to me.

While at it switched the kasprintf to the managed API variant - or should
this be done in a separate patch ?

Patch was compile tested with: multi_v4t_defconfig (implies
INTEGRATOR_IMPD1=y)

Patch is against 4.20-rc4 (localversion-next is next-20181130)

 arch/arm/mach-integrator/impd1.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index a109f648..0f916c2 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -393,7 +393,11 @@ static int __ref impd1_probe(struct lm_device *dev)
 					      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
 					      GFP_KERNEL);
 			chipname = devm_kstrdup(&dev->dev, devname, GFP_KERNEL);
-			mmciname = kasprintf(GFP_KERNEL, "lm%x:00700", dev->id);
+			mmciname = devm_kasprintf(&dev->dev, GFP_KERNEL,
+						  "lm%x:00700", dev->id);
+			if (!lookup || !chipname || !mmciname)
+				return -ENOMEM;
+
 			lookup->dev_id = mmciname;
 			/*
 			 * Offsets on GPIO block 1:
-- 
2.1.4

