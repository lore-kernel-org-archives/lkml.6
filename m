Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2AEC43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E0220871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E0220871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbeKLFsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49464 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729906AbeKLFsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:05 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0000l4-Bm; Sun, 11 Nov 2018 19:58:34 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001Ni-UB; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Michael Schmitz" <schmitzmic@gmail.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Michael Karcher" <kernel@mkarcher.dialup.fu-berlin.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.184709373@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 021/366] net-next: ax88796: Do not free IRQ in
 ax_remove() (already freed in ax_close()).
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>

commit 9144c3795c2636351d553e4d0fc5297201182de2 upstream.

This complements the fix in 82533ad9a1c ("net: ethernet: ax88796:
don't call free_irq without request_irq first") that removed the
free_irq call in the error path of probe, to also not call free_irq
when remove is called to revert the effects of probe.

Fixes: 82533ad9a1c (net: ethernet: ax88796: don't call free_irq without request_irq first)
Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/8390/ax88796.c | 1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/ethernet/8390/ax88796.c
+++ b/drivers/net/ethernet/8390/ax88796.c
@@ -812,7 +812,6 @@ static int ax_remove(struct platform_dev
 	struct resource *mem;
 
 	unregister_netdev(dev);
-	free_irq(dev->irq, dev);
 
 	iounmap(ei_local->mem);
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);

