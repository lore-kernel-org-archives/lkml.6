Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1532C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9705C20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9705C20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbeKFH2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:28:25 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:36772 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFH2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:28:24 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-96-200-nat.elisa-mobile.fi [85.76.96.200])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 958314009A;
        Tue,  6 Nov 2018 00:06:32 +0200 (EET)
Date:   Tue, 6 Nov 2018 00:06:32 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Rob Herring <robh@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] OCTEON MMC driver failure with v4.19
Message-ID: <20181105220632.GA5083@darkstar.musicnaut.iki.fi>
References: <20181026205423.GD3792@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026205423.GD3792@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 26, 2018 at 11:54:23PM +0300, Aaro Koskinen wrote:
> OCTEON (MIPS64) MMC driver probe fails with v4.19, because with
> 
> commit 6c2fb2ea76361da9b420a8e23a2a19e7842cbdda
> Author: Robin Murphy <robin.murphy@arm.com>
> Date:   Mon Jul 23 23:16:09 2018 +0100
> 
>     of/device: Set bus DMA mask as appropriate
> 
> we now get a default 32-bit bus DMA mask, and the device itself has
> 64-bit mask, so it gets rejected.
> 
> With the current mainline, the driver is again working (probably
> because of b4ebe6063204 ("dma-direct: implement complete bus_dma_mask
> handling")). But I think this is just because I happen to have < 4 GB RAM,
> and it probably could still fail on bigger systems..?

With the below change, the MMC card probe seems to with v4.19. But it
feels a bit hackish, don't you think... Is there some obvious simple
fix that I'm missing? Any comments?

diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index 807cadaf554e..31fab09fadcc 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -1067,8 +1067,29 @@ int __init octeon_prune_device_tree(void)
 	return 0;
 }
 
+static int octeon_device_notifier_call(struct notifier_block *nb,
+				       unsigned long event, void *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	if (event != BUS_NOTIFY_ADD_DEVICE ||
+	    !pdev || !pdev->dev.dma_mask || !pdev->dev.of_node)
+		return NOTIFY_DONE;
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				     "cavium,octeon-6130-mmc"))
+		*pdev->dev.dma_mask = DMA_BIT_MASK(64);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block platform_nb = {
+	.notifier_call = octeon_device_notifier_call,
+};
+
 static int __init octeon_publish_devices(void)
 {
+	bus_register_notifier(&platform_bus_type, &platform_nb);
 	return of_platform_populate(NULL, octeon_ids, NULL, NULL);
 }
 arch_initcall(octeon_publish_devices);

A.
