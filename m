Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CF9C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465DD20821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738244;
	bh=SsWOM4TxlNBJYVQEMZdIeNzVIdzHMnJtg990g1RHgZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LCOcjAiGiqHiLPbDyOU7t2iUQLi4fj1TBpGJv2QkxobQcOrb4yqnwOWeLFBDW3D1q
	 0dDrO25DwjeNW4I7rbQfjbLJTlujwaUZimXR5Yvnp6KosrNVfFBHa/roakPIJOLKZ8
	 GkA7DJQZHd5fkBlS5saIysxDWQ7XqAqtIH+OAXVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfBISum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:50:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbfBISuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:50:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C5BF21916;
        Sat,  9 Feb 2019 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738218;
        bh=SsWOM4TxlNBJYVQEMZdIeNzVIdzHMnJtg990g1RHgZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h+h/UCLhg4O1Jbjy2/OVJBBqLjHdOOMDddu6+8mRh+JbTnoFbr2878Mw8YeWeir8Z
         XyveNlB/rgh9RlEogxaYkdvo/Y6htR386W9KvfFh8tHG4HaTPs3H2T/orfrlQgSCXF
         vZxOPTUkRBL5oYzZ3SZT5/Q4aMCLNER3UeHU5Wpg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 3/4] gpio: pl061: handle failed allocations
Date:   Sat,  9 Feb 2019 13:50:13 -0500
Message-Id: <20190209185014.127264-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209185014.127264-1-sashal@kernel.org>
References: <20190209185014.127264-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

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
index 38b0da300dd5..423a88ff908c 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -394,7 +394,11 @@ static int __init_refok impd1_probe(struct lm_device *dev)
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

