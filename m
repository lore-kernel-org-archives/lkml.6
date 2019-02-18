Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7151C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875D321901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499688;
	bh=6rPC7+17S/IeFKx++5Ot66kC/7QEHJPZ6p5jsoRoZB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bUVskewcB04tIv3oVCmrSoFWPJU9doRyK4PSuD75Prg7REhVmR+k6swto9SDzwqSi
	 IUqpBtGBNOIMZ9JHoMlULbCxPzp76iAOtGgGD8vVAIzewzx4g/HWSPJSj9VDe63QIm
	 wvz6GDlOw6A5gxe2pN0ZdmYGReW7V4O6otCZ+NH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390435AbfBROGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:06:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389899AbfBROGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:06:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F5F21916;
        Mon, 18 Feb 2019 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498793;
        bh=6rPC7+17S/IeFKx++5Ot66kC/7QEHJPZ6p5jsoRoZB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xPvHgYofhLznBaq365BJCW50iXDSFPii9bxFHd2dgru+Z8j/1Hh7G9BvEPUeDjmkT
         SMUNcemKwjWPcXJuL6aUt4gC6k+loSfAaDE0Q9K5Zc57FkseJtApblu77UumDAnlEq
         0kKsy3Y8cgRzPMLeHp2lM6+KXTIs2yRFPNRgtGbo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 122/143] gpio: pl061: handle failed allocations
Date:   Mon, 18 Feb 2019 14:44:10 +0100
Message-Id: <20190218133533.459749509@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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



