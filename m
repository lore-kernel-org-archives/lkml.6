Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7CBC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7802196F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500639;
	bh=+MtcUgz+2BIO3VLimAln0nx98ZluIbYy8W2RGJ3o5qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bYuDgVX+q+JbedThxt2V0ASg5zAd+4vDFITliUOLQbXuAoI6lkefxWS6wVTOtR2JY
	 8ZsjVZuHNxyxh8tbuC5216TWqYJAlT8ijSRkTvQGghwxaJJ/CtNlWH4wnZ+4lLSQER
	 BUGO68u+wYOHPMRGs8B6mB3Zz9C7zTltR0ws+txs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbfBROgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:35736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387564AbfBRNzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:55:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5688217D9;
        Mon, 18 Feb 2019 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498139;
        bh=+MtcUgz+2BIO3VLimAln0nx98ZluIbYy8W2RGJ3o5qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3mr0ezVdueix98V7X7/tYZAoFQWeHuinU5hThQqFcUqKB0BDD5eh+3JuOzhoZHPh
         O/UxFx4ZjwO/C8u9gUkq1PpxNpTGRBiSRXXDMMbPWYkIArC9zr/ehloFTC+jifz+/7
         SY6fmhAY4vZpLfhj6bTvsiqX48hzPNYpBxazHnNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 36/62] gpio: pl061: handle failed allocations
Date:   Mon, 18 Feb 2019 14:43:42 +0100
Message-Id: <20190218133509.025046926@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit df209c43a0e8258e096fb722dfbdae4f0dd13fde ]

devm_kzalloc(), devm_kstrdup() and devm_kasprintf() all can
fail internal allocation and return NULL. Using any of the assigned
objects without checking is not safe. As this is early in the boot
phase and these allocations really should not fail, any failure here
is probably an indication of a more serious issue so it makes little
sense to try and rollback the previous allocated resources or try to
continue;  but rather the probe function is simply exited with -ENOMEM.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 684284b64aae ("ARM: integrator: add MMCI device to IM-PD1")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-integrator/impd1.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index a109f6482413..0f916c245a2e 100644
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
2.19.1



