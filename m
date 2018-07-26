Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F26DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D5F20883
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYSTlGSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D5F20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeG0Alg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:41:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46124 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730610AbeG0Alf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:41:35 -0400
Received: by mail-lf1-f67.google.com with SMTP id l16-v6so2319946lfc.13;
        Thu, 26 Jul 2018 16:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O+e/im9YZ70ju1A0neTQHuRteCq93hPLVv7chPKaQl4=;
        b=GYSTlGStsfO6u4BW3It+2ufAu0sofqFlN0hIoZczNqvzwqXWYDxq+20VmXlEWcut9n
         GsdgdRLdd23ns7uXhr1bFXG0mDeoRTVd2h14CrvtK81k8RGyMQGRRUG8aTLcaF5pKuSc
         3rOlL0IM788wIugFJS28KUd8vY/1IdIWn1pr95vlWzSomhL6+2bQhLFZUKrdXxC79VAf
         XEa3yKdy3BA2KP5j7ojV2Xen85dY5XJyiH2pk+Mf1Jp8Xhv/oEM86IJ6fb1xlOMtx6se
         Jrbjd2QJpnxP0Vl0ieJWJDXxKPGyoJZT804sUxK/aBH6+m6HkZdOFkhhX2BFKfOcj3Qe
         oQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O+e/im9YZ70ju1A0neTQHuRteCq93hPLVv7chPKaQl4=;
        b=hwFejf5RJTqUoBinbLxYLN2j/co3oQ53VDwW7YBaHICKDGvwwPDPGFd4n2lz22Y6CA
         t3nuyI5T5rNDNaqk6nuXsq+9MTrObFWDUFiZvtf5cKS3cb/ualDQ4lYTZzGJPLGIVxeU
         Bu+DoKAhbRLgex8Q9VBIMuqYeFZ4w+hEeaPjVybtxR71Cd0i823qaKiZf8OHHjsyeOCc
         ZjaZar2d7gr5Ap5LQulHvXsiAhYOcEcIHKzNYf/EXnM0vEE+t4KA+dgWvCnj7dHjUyVc
         dlp8aH8Clpp7gsio1zMZwVKhTI5dN5Icb7ddvxvMErXJYzpaxnOIoUz/VYAb/ybf9gC5
         hVxA==
X-Gm-Message-State: AOUpUlF+yynOTKDF67EBzxY45J4MDAjDXuMlrC66+LNXFGkeZFr5+8nU
        VTd/4w0FjTgKvxZRdZkI9Mo=
X-Google-Smtp-Source: AAOMgpd7uptmuOgsvdEPcDNF4IVTY06fwQllp60hnf+Dybs7iMhg02K5qeaQ33WLchf2Rb1Tqsod+w==
X-Received: by 2002:a19:4ecd:: with SMTP id u74-v6mr2410628lfk.57.1532647352254;
        Thu, 26 Jul 2018 16:22:32 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id q15-v6sm411541ljg.62.2018.07.26.16.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 16:22:31 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     devicetree@vger.kernel.org, nouveau@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/6] of/device: Don't back devices DMA with IOMMU if that's undesired by driver
Date:   Fri, 27 Jul 2018 02:16:20 +0300
Message-Id: <20180726231624.21084-3-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726231624.21084-1-digetx@gmail.com>
References: <20180726231624.21084-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Respect device driver requirement for device DMA not to be implicitly
backed with IOMMU by skipping the backing setup for drivers that do not
want that.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/of/device.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 33d85511d790..e70b7a886875 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -163,6 +163,13 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	dev_dbg(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
+	/*
+	 * Respect device driver requirement for device DMA not to be
+	 * implicitly backed with IOMMU.
+	 */
+	if (iommu && dev->driver->no_implicit_iommu)
+		iommu = NULL;
+
 	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
 
 	return 0;
-- 
2.18.0

